//
//  ViewController.swift
//  URLSessions
//
//  Created by Владимир Свиридов on 07.02.2022.
//

import UIKit

class ViewController: UIViewController {
    let placeholder = "https://jsonplaceholder.typicode.com/posts"
    var posts: [Placeholder] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let networkManager = NetworkManager()
        
        networkManager.getRequest(urlString: placeholder, model: posts) { [weak self] result in
                guard let self = self else { return }
                switch result{
                case .success(let post):
                    self.posts = post as! [Placeholder]
                    for post in self.posts{
                        print(post.id)
                        print(post.title)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
          

        networkManager.postRequest(urlString: placeholder, body: ["Check":"Checking", "Post":"Posting"], model: posts) { [weak self] result in
            guard let self = self else { return }

            switch result{
            case .success(_):
                //self.posts = post as! [Placeholder]
                for post in self.posts{
                    print(post.id)
                    print(post.title)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

