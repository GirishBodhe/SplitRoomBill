//
//  TotalSpendingsViewController.swift
//  SplitRoomBill
//
//  Created by girishbodhe on 15/10/18.
//  Copyright © 2018 girishbodhe. All rights reserved.
//

import UIKit
import Firebase


class TotalSpendingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var totalSpendingBillLabel: UILabel!
    
    @IBOutlet weak var totalSpendingRecentSpendingLebel: UILabel!
    @IBOutlet weak var totalSpendingImageView: UIImageView!
    @IBOutlet weak var totalSpendingsTableView: UITableView!
    
    var totalAmounat : Float = 0.00
    
    var billArray = [Bill]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.networkCall()
        // Do any additional setup after loading the view.
    }
    
}
extension TotalSpendingsViewController{
    func numberOfSections(in tableView: UITableView) -> Int {
        return  billArray.count

    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:RecentSpendingsTableViewCell = (self.totalSpendingsTableView.dequeueReusableCell(withIdentifier: "cell") as! RecentSpendingsTableViewCell)
        
        let billObject = self.billArray[indexPath.section]
        cell.rescentSpendingsName.text = billObject.billItemName
        cell.rescentSpendingsDate.text = billObject.billPaidBy
        cell.rescentSpendingsAmount.text = Constants.rupeeSymbol + String(billObject.billTotalAmount!)
        cell.rescentSpendingsStatus.text = "In Process"

        
        return cell
        
    }
    
}
extension TotalSpendingsViewController{

    
    
    func networkCall() {
        var ref: DatabaseReference!
        ref = Database.database().reference().child("Bills")
        ref.observe(.value) { (snapshot) in
            
            //clearing the list
            self.billArray.removeAll()
            self.totalAmounat = 0
            
            for billtDictValue in snapshot.children.allObjects as! [DataSnapshot] {
                let billObject = billtDictValue.value as? [String: AnyObject]
                var bill = Bill()
                bill.billItemName = billObject?["item"] as? String
                bill.billTotalAmount = billObject?["amount"] as? Float
                bill.billPaidBy = billObject?["paidBy"] as? String
                bill.billCreatedAt = billObject?["created_at"] as? Int64
                bill.billUpdatedAt =  billObject?["updated_at"] as? Int64
                self.totalAmounat = ((billObject?["amount"] as? Float)! + self.totalAmounat)
                self.billArray.append(bill)
            }
            self.totalSpendingBillLabel.text = Constants.rupeeSymbol + String(self.totalAmounat)
            self.totalSpendingsTableView.reloadData()
            }
        }
    
}
