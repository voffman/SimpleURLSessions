//
//  NetworkManager.swift
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

final class NetworkManager {
    // параметры я могу вписать в urlString
    func getRequest<T: Decodable>(urlString: String, model: T, completion: @escaping (Result<Any?, Error>) -> () ){
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession.shared
        
        session.dataTask(with: url){ (data, response, error) in
            guard let data = data else { return }
            guard let response = response else { return }
            print("Ответ: \(response)")
            
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
    
    func postRequest<T: Decodable>(urlString: String, body: [String: Any], model: T, completion: @escaping (Result<Any?, Error>) -> ()){
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: body, options: []) else {return}
        request.httpBody = httpBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        
        session.dataTask(with: request) { (data, response, error) in
            guard let response = response, let data = data else {return}
            print("Ответ: \(response)")
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do{
                //let posts = try JSONDecoder().decode(T.self, from: data)
                let posts = try JSONSerialization.jsonObject(with: data, options: [])
                print("Данные: \(posts)")
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




