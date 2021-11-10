//
//  UsersViewController.swift
//  CoreDataDemo
//
//  Created by Mahendra Vishwakarma on 30/10/21.
//

import UIKit
import RxSwift
import RxRelay

class UsersViewController: UIViewController {

    var disposeBag = DisposeBag()
    var viewModel:UsersViewModel?
    @IBOutlet weak var userListTableView: UITableView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    @IBOutlet weak var segment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViewModel()
    }
    
    
   private func bindViewModel() {
        let input = viewModel?.inputs
        let outputs = viewModel?.outputs
    
        outputs?.baseStateObservable.asObservable()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [unowned self](state) in
            switch state {
            case .notLoad, .loading:
                self.activity.startAnimating()
            break
            case .finished:
                DispatchQueue.main.async{
                    self.activity.stopAnimating()
                    self.userListTableView.reloadData()
                }
            case .failed:
                self.activity.stopAnimating()
                //show error
            break
            }
        }).disposed(by: disposeBag)
        
        input?.fetchUsersAPI.execute()
    }
        
    private func setupViewModel() {
       
        userListTableView.register(UINib(nibName: "UsersTableViewCell", bundle: nil), forCellReuseIdentifier: "UsersTableViewCell")
        userListTableView.dataSource = self
        self.activity.startAnimating()
        if(viewModel?.selectedGender == .male) {
            segment.selectedSegmentIndex = 0
        }else {
            segment.selectedSegmentIndex = 1
        }
       bindViewModel()
    }
    @IBAction func genderToggle(_ sender: UISegmentedControl) {
        self.activity.startAnimating()
        switch sender.selectedSegmentIndex {
        case 0 :
            viewModel?.selectedGender = .male
            viewModel?.inputs.fetchUsersAPI.execute()
            
        case 1:
            viewModel?.selectedGender = .female
            viewModel?.inputs.fetchUsersAPI.execute()
        default:
            viewModel?.selectedGender = .male
            viewModel?.inputs.fetchUsersAPI.execute()
        }
    }
    
}

//MARK: UITableViewDataSource, UITableViewDelegate
extension UsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.userList?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UsersTableViewCell", for: indexPath) as? UsersTableViewCell else{
            return UITableViewCell()
        }
        if let user = viewModel?.userList?[indexPath.row] {
            let userObs: BehaviorRelay<UsersListData> = BehaviorRelay(value: user)
            cell.setData(user:userObs)
        }
        
        
        return cell
    }
}

