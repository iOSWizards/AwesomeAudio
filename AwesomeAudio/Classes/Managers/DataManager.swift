//
//  DataManager.swift
//  AwesomeAudio
//
//  Created by Evandro Harrison on 12/04/2019.
//

import Foundation

struct DataManager {
    
    static func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
}

extension UIImageView {
    func load(from url: URL) {
        DataManager.getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                self.image = UIImage(data: data)
            }
        }
    }
}

extension UIImage {
    static func load(from url: URL, completion: @escaping (UIImage?) -> Void) {
        DataManager.getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                completion(UIImage(data: data))
            }
        }
    }
}
