//
//  UsersTableViewCell.swift
//  CoreDataDemo
//
//  Created by Mahendra Vishwakarma on 30/10/21.
//

import UIKit

class UsersTableViewCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var company: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(user:UsersListData?) {
        userName.text = user?.name?.capitalized
        genderLabel.text = user?.gender?.capitalized
        company.text = user?.company
        addressLabel.text = user?.address
    }
    
}
