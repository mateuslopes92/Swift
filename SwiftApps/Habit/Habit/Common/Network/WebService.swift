//
//  WebService.swift
//  Habit
//
//  Created by Mateus Lopes on 21/11/24.
//
import Foundation

enum WebService {
    enum Endpoint: String {
        case base = "https://habitplus-api.tiagoaguiar.co"
        case postUser = "/users"
        case signIn = "/auth/login"
        case refreshToken = "/auth/refresh-token"
        case habits = "/users/me/habits"
        case habitValues = "/users/me/habits/%d/values"
        case fetchUser = "/users/me"
        case updateUser = "/users/%d"
    }
    
    enum ContentType: String {
        case json = "application/json"
        case formUrlEncoded = "application/x-www-form-urlencoded"
    }
    
    enum Method: String {
        case get
        case post
        case put
        case delete
    }
    
    enum NetworkError: Error {
        case badRequest
        case notFound
        case unauthorized
        case internalServerError
    }
    
    enum Result {
        case success(Data)
        case failure(NetworkError, Data?)
    }
    
    private static func completeUrl(path: String) -> URLRequest? {
        guard let url = URL(string: "\(Endpoint.base.rawValue)\(path)") else { return nil }
        return URLRequest(url: url)
    }
    
    private static func call(
        path: String,
        method: Method,
        contentType: ContentType,
        data: Data?,
        completion: @escaping (Result) -> Void
    ){
        guard var urlRequest = completeUrl(path: path) else { return }
        
        _ = LocalDataSource.shared.getUserAuth()
            .sink { userAuth in
                if let userAuth = userAuth {
                    urlRequest.setValue("\(userAuth.TokenType) \(userAuth.idToken)", forHTTPHeaderField: "Authorization")
                }
                
                urlRequest.httpMethod = method.rawValue
                urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
                urlRequest.setValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
                urlRequest.httpBody = data
                
                let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                    // running in background
                    guard let data = data, error == nil else {
                        print("error: \(error?.localizedDescription ?? "Unknown error")")
                        completion(.failure(.internalServerError, nil))
                        return
                    }
                    
                    // Debug the raw response
                     if let jsonString = String(data: data, encoding: .utf8) {
                         print("Raw response: \(jsonString)")
                     }
                    
                    if let r = response as? HTTPURLResponse {
                        switch r.statusCode {
                        case 400:
                            completion(.failure(.badRequest, data))
                            break
                        case 401:
                            completion(.failure(.unauthorized, data))
                            break
                        case 200:
                            completion(.success(data))
                            break
                        default:
                            break
                        }
                    }
                    
                    
                    print(String(data: data, encoding: .utf8))
                    print("response\n")
                    print(response)
                   
                }
                task.resume()
            }
    }
    
    public static func call(path: Endpoint,
                                          method: Method = .get,
                                          completion: @escaping (Result) -> Void) {
        call(path: path.rawValue, method: method, contentType: .json, data: nil, completion: completion)
    }
    
    public static func call<T: Encodable>(path: String,
                                          method: Method = .get,
                                          body: T,
                                          completion: @escaping (Result) -> Void) {
        guard let jsonData = try? JSONEncoder().encode(body) else { return }
           
        call(path: path, method: method, contentType: .json, data: jsonData, completion: completion)
    }
    
    public static func call(path: String,
                            method: Method = .get,
                            completion: @escaping (Result) -> Void) {
           
        call(path: path, method: method, contentType: .json, data: nil, completion: completion)
    }
    
    public static func call<T: Encodable>(path: Endpoint,
                                          method: Method = .get,
                                          body: T,
                                          completion: @escaping (Result) -> Void) {
        guard let jsonData = try? JSONEncoder().encode(body) else { return }
           
        call(path: path.rawValue, method: method, contentType: .json, data: jsonData, completion: completion)
    }
    
    public static func call(path: Endpoint,
                            method: Method = .post,
                            params: [URLQueryItem],
                            completion: @escaping (Result) -> Void) {
        guard let urlRequest = completeUrl(path: path.rawValue) else { return }
        
        guard let absoluteUrl = urlRequest.url?.absoluteString else { return }
        var components = URLComponents(string: absoluteUrl)
        components?.queryItems = params
           
        call(path: path.rawValue, method: method, contentType: .formUrlEncoded, data: components?.query?.data(using: .utf8), completion: completion)
    }
}
