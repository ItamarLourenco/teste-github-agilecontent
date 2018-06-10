//
//  SearchUIViewController.swift
//  GitHub Viewer
//
//  Created by Itamar Lourenço on 09/06/2018.
//  Copyright © 2018 Ilourenco. All rights reserved.
//

import Foundation
import UIKit

class SearchUIViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var textViewGitUsername: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textViewGitUsername.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let customNavigationBar = self.navigationController!.navigationBar as? CustomNavigationBar{
            customNavigationBar.resize = false
            customNavigationBar.layoutSubviews()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if(textViewGitUsername.text == ""){
            let alert = UIAlertController(title: "Ocorreu um erro", message: "Por favor, digite um Username.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return false
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let listRepositoriesUiTableViewController = segue.destination as? ListRepositoriesUiTableViewController {
            listRepositoriesUiTableViewController.username = textViewGitUsername.text!
        }
    }
}
