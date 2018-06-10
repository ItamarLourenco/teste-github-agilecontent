//
//  Repos.swift
//  GitHub Viewer
//
//  Created by Itamar Lourenço on 10/06/2018.
//  Copyright © 2018 Ilourenco. All rights reserved.
//

import Foundation
struct Repos: Decodable {
    let name: String?
    let language: String?
    let owner: Owner?
}
