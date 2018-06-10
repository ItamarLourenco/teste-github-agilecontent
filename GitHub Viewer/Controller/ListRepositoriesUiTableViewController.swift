//
//  ListRepositoriesUiTableViewController.swift
//  GitHub Viewer
//
//  Created by Itamar Lourenço on 09/06/2018.
//  Copyright © 2018 Ilourenco. All rights reserved.
//

import Foundation
import UIKit

class ListRepositoriesUiTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var repos = [Repos]();
    var username:String = ""
    var imageViewNavBar:UIImageView = UIImageView(image: #imageLiteral(resourceName: "no_user"))
    let labelNavBar = UILabel();
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        self.handleCustomNavBar()
        self.getRepos()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func alert(_ title:String, message:String, actionButtonText:String = "OK"){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionButtonText, style: .default, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true)
    }
    
    func showTableView(show:Bool = true){
        self.tableView.isHidden = !show
        self.indicatorView.isHidden = show
    }
    
    func getRepos(){
        self.showTableView(show: false)
        Api.getRepos(username, completionHandler: {(repos, response, err) in
            if(err != nil){
                self.alert("Ocorreu um erro de rede.", message: "Verifique sua conexão com a Internet e tente novamente mais tarde.")
                return;
            }
            
            if((response as! HTTPURLResponse).statusCode != Api.HTTP_CODE_SUCCESS){
                self.alert("Usuário não encontrado.", message: "Favor inserir outro nome.")
                return;
            }
            
            if(repos != nil){
                self.repos = repos!;
                
                DispatchQueue.main.async { [unowned self] in
                    self.populateView();
                }
            }else{
                self.alert("Ocorreu um erro de rede.", message: "Verifique sua conexão com a Internet e tente novamente mais tarde.")
            }
        });
    }
    
    func populateView(){
        self.showTableView()
        self.tableView.reloadData()
        if(self.repos.count > 0){
            let repo:Repos = self.repos[0];
            self.labelNavBar.text! = repo.owner?.login ?? self.username
            
            let url = URL(string: (repo.owner?.avatar_url)!)
            if let data = try? Data(contentsOf: url!){
                self.imageViewNavBar.image = UIImage(data: data)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repos.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cellUiTableView = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CellUITableViewCell{
            let repo:Repos = repos[indexPath.row];
            
            cellUiTableView.title.text = repo.name ?? "Não definido"
            cellUiTableView.language.text = repo.language ?? "Não definido"
            
            return cellUiTableView;
        }
        return UITableViewCell();
    }
    
    func handleCustomNavBar() {
        if let customNavigationBar = self.navigationController!.navigationBar as? CustomNavigationBar{
            customNavigationBar.resize = true
            customNavigationBar.layoutSubviews()
        }
        
        let titleView = UIView(frame: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 100, height: 100)))
        
        imageViewNavBar.layer.cornerRadius = titleView.frame.height / 2
        imageViewNavBar.clipsToBounds = true
        imageViewNavBar.layer.masksToBounds = true
        imageViewNavBar.frame = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: titleView.frame.width, height: titleView.frame.height))
        
        labelNavBar.text = username
        labelNavBar.textAlignment = NSTextAlignment.center
        labelNavBar.font = labelNavBar.font.withSize(14)
        labelNavBar.frame = CGRect(origin: CGPoint(x: 0,y :titleView.frame.height + 10), size: CGSize(width: titleView.frame.width+10, height: 20))
        
        titleView.addSubview(imageViewNavBar)
        titleView.addSubview(labelNavBar)
        navigationItem.titleView = titleView
    }
}
