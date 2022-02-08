//
//  ApiManager.swift
//  URLSessions
//
//  Created by Владимир Свиридов on 07.02.2022.
//

import Foundation

/*protocol ApiManagerProtocol{
 func getRequest()
 func postRequest()
 }
 */

final class ApiManager {
    
    func getPost<T: Decodable>(urlString: String, model: T, completion: @escaping (Result<Any?, Error>) -> () ){
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url){ (data, response, error) in
            guard let data = data else { return }
            
            if let error = error {
                completion(.failure(error))
                return
            }
            do{
                let posts = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(posts))
                }
            }
            catch{
                completion(.failure(error))
            }
        }.resume()
    }
}




