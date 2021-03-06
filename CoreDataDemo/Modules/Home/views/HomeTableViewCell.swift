//
//  HomeTableViewCell.swift
//  CoreDataDemo
//
//  Created by Mahendra Vishwakarma on 30/10/21.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        userImageView.layer.cornerRadius = 30
        userImageView.contentMode = .scaleToFill
        userImageView.clipsToBounds = true
    }
    
    func configure(with model: UserModel) {
        userImageView.image = model.image
        nameLabel.text = (model.firstName + " " + model.lastName).capitalized
        emailLabel.text = model.email
        genderLabel.text = model.gender.capitalized
        addressLabel.text = model.address
        dobLabel.text = model.dateOfBirth
    }
    
}
