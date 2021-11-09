//
//  HomeViewController.swift
//  CoreDataDemo
//
//  Created by Madhuri on 25/10/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    var viewModel:HomeViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialTableViewSetup()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    fileprivate func initialTableViewSetup() {
        viewModel = HomeViewModel()
        viewModel?.delegate = self
       
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        self.activity.startAnimating()
        viewModel?.fetchData()
    }
    
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let user = viewModel?.userList[indexPath.row] {
            let obj = UsersViewController()
            obj.viewModel = UsersViewModel()
            if user.gender == "male" {
                obj.viewModel?.selectedGender = .male
            }else {
                obj.viewModel?.selectedGender = .female
            }
          
            self.navigationController?.pushViewController(obj, animated: true)
        }
            
    }
    
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.userList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HomeTableViewCell.self), for: indexPath) as! HomeTableViewCell
        if let user =  viewModel?.userList[indexPath.row] {
            cell.configure(with: user)
        }
       
        
        return cell
    }
    
    
}

extension HomeViewController: UserUpdateDelegate {
    func updateList(status:Int) {
        DispatchQueue.main.async{
            self.activity.stopAnimating()
            self.tableView.reloadData()
        }
    }
}
