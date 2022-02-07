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
        let api = ApiManager()
        
        api.getPost(urlString: placeholder, model: posts) { [self] post in
            self.posts = post as! [Placeholder]
            
            for post in posts{
                print(post.id)
                print(post.title)
            }
        }
    }
}

