//
//  Api.swift
//  GitHub Viewer
//
//  Created by Itamar Lourenço on 10/06/2018.
//  Copyright © 2018 Ilourenco. All rights reserved.
//

import Foundation
class Api{
    static let HTTP_CODE_SUCCESS = 200
    
    static func getUrl() -> String{
        return "https://api.github.com/users/"
    }
    
    static func getRepos(_ username:String, completionHandler: @escaping ([Repos]?, URLResponse?, Error?) -> Swift.Void){
        guard let url = URL(string: "\(Api.getUrl())\(username)/repos") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            do {
                if data != nil {
                    let repos = try JSONDecoder().decode([Repos].self, from: data!)
                    completionHandler(repos, response, err);
                    return
                }
            } catch let jsonErr {
                print("JSON com sintaxe erro:", jsonErr)
            }
            completionHandler(nil, response, err);
        }.resume()
    }
}
