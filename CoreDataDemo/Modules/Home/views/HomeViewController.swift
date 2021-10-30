//
//  HomeViewController.swift
//  CoreDataDemo
//
//  Created by Madhuri on 25/10/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var userList: [UserModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        initialTableViewSetup()
        fetchUsers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    fileprivate func initialTableViewSetup() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    fileprivate func fetchUsers() {
        UserCoreDataAction.shared.fetchUsers { result in
            switch result {
            case .success(let users):
                self.userList = users
                self.reloadTableView()
                break
            case .failure(let error):
                self.showAlert(with: error.localizedDescription)
                break
            }
        }
    }
    
    fileprivate func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    fileprivate func showAlert(with message: String) {
        
        let alert = UIAlertController(title: "Core Data Demo", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let user = userList[indexPath.row]
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

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HomeTableViewCell.self), for: indexPath) as! HomeTableViewCell
        
        cell.configure(with: userList[indexPath.row])
        
        return cell
    }
    
    
}
