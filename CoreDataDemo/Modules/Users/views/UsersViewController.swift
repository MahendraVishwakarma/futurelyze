//
//  UsersViewController.swift
//  CoreDataDemo
//
//  Created by Mahendra Vishwakarma on 30/10/21.
//

import UIKit

class UsersViewController: UIViewController {

    var viewModel:UsersViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViewModel()
    }
    
    private func setupViewModel() {
        viewModel = UsersViewModel()
        
    }
    @IBAction func genderToggle(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0 :
            break
        case 1:
            break
        default:
            break
        }
    }
    
}
