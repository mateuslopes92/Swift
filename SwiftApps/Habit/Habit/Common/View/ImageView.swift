//
//  ImageView.swift
//  Habit
//
//  Created by Mateus Lopes on 14/04/25.
//

import Foundation
import SwiftUI
import Combine

struct ImageView: View {
    
    @State var image: UIImage = UIImage()
    var loader = ImageLoader()
    var url: String
    
    init(url: String){
        self.url = url
    }
    
    var body: some View {
        Image(uiImage: UIImage(data: loader.data) ?? image)
            .resizable()
            .onReceive(loader.didChange, perform: { data in
                self.image = UIImage(data: data) ?? UIImage()
            })
            .onAppear {
                if image.cgImage == nil {
                    loader.load(url: url)
                }
            }
    }
}

class ImageLoader: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()
    
    var data = Data(){
        didSet {
            didChange.send(data)
        }
    }
    
    func load(url: String){
        guard let url = URL(string: url) else { return }
        let task = URLSession.shared.dataTask(with: url){ data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self){
            VStack {
                ImageView(url: "https://cdn.tiagoaguiar.co/habit_plus/1237/1744674840.461972-1744674840.461699.jpeg").padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .preferredColorScheme($0)
        }
    }
}
