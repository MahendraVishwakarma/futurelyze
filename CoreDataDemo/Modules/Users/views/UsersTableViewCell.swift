//
//  UsersTableViewCell.swift
//  CoreDataDemo
//
//  Created by Mahendra Vishwakarma on 30/10/21.
//

import UIKit
import RxCocoa
import RxSwift

class UsersTableViewCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var company: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
   // var user:PublishSubject<UsersListData>?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(user:BehaviorRelay<UsersListData>?) {
        user?.map({$0.name?.capitalized}).bind(to: userName.rx.text).dispose()
        user?.map({"⚥ "+($0.gender?.capitalized ?? "")}).bind(to: genderLabel.rx.text).dispose()
        user?.map({"🏠 "+($0.company?.capitalized ?? "")}).bind(to: company.rx.text).dispose()
        user?.map({$0.address?.capitalized}).bind(to: addressLabel.rx.text).dispose()
      
    }
    
    public var user : UsersListData! {
        didSet {
            userName.text = user.name
            genderLabel.text = user.gender
            company.text = user.company
            addressLabel.text = user.address
            
            //self.trackImage.clipsToBounds = true
            //self.trackImage.layer.cornerRadius = 3
           // self.trackImage.loadImage(fromURL: cellTrack.trackArtWork)
           // self.trackTitle.text = cellTrack.name
           // self.trackArtist.text = cellTrack.artist
        }
    }
    
}
