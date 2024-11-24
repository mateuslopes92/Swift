//
//  WebService.swift
//  Habit
//
//  Created by Mateus Lopes on 21/11/24.
//
import Foundation

enum WebService {
    enum Endpoint: String {
        case base = "https://habitplus-api.tiagoaguiar.com"
        case postUser = "/users"
    }
    
    private static func completeUrl(path: Endpoint) -> URLRequest? {
        guard let url = URL(string: "\(Endpoint.base)\(path.rawValue)") else { return nil }
        return URLRequest(url: url)
    }
    
    static func postUser(fullName: String,
                         email: String,
                         document: String,
                         phone: String,
                         gender: Int,
                         birthday: String,
                         password: String)
    {
        let json: [String: Any] = [
            "fullName": fullName,
            "email": email,
            "document": document,
            "phone": phone,
            "gender": gender,
            "birthday": birthday,
            "password": password
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        guard var urlRequest = completeUrl(path: .postUser) else { return }
        
        urlRequest.setValue("application/json",forHTTPHeaderField: "accept")
        urlRequest.setValue("application/json",forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                print("error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            print(String(data: data, encoding: .utf8))
           
            if let r = response as? HTTPURLResponse {
                print("response: \(r.statusCode)")
            }
        }
        task.resume()
    }
}
