//
//  AddBillsViewController.swift
//  SplitRoomBill
//
//  Created by girishbodhe on 15/10/18.
//  Copyright © 2018 girishbodhe. All rights reserved.
//

import UIKit
import Firebase
import SkyFloatingLabelTextField
import RxSwift
import RxCocoa

class AddBillsViewController: UIViewController {

    @IBOutlet weak var addBillsViewControllerBillName: SkyFloatingLabelTextField!
    @IBOutlet weak var addBillsViewControllerBillAmount: SkyFloatingLabelTextField!
    @IBOutlet weak var addBillsViewControllerBillPaidName: SkyFloatingLabelTextField!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var LabelText: UITextField!
    
    var ref: DatabaseReference!
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        
//        addBillsViewControllerBillName.rx.text.bindTo(LabelText.rx.text)
        
//        addBillsViewControllerBillName.rx.text.map { "Hello \($0!)" }
//            .bind(to: LabelText.rx.text)
//
       
        
        
        saveButton.rx.tap.subscribe { onNext in
            
            var bill = Bill()
            bill.billItemName = self.addBillsViewControllerBillName.text!
            bill.billTotalAmount = Float(self.addBillsViewControllerBillAmount.text!)
            bill.billPaidBy = self.addBillsViewControllerBillPaidName.text!
            
            self.saveNewBillData(bill: bill)
            
            }.disposed(by: disposeBag)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func AddBillsViewControllerSaveBill(_ sender: Any) {
        var bill = Bill()
        bill.billItemName = self.addBillsViewControllerBillName.text!
        bill.billTotalAmount = Float(self.addBillsViewControllerBillAmount.text!)
        bill.billPaidBy = self.addBillsViewControllerBillPaidName.text!
        
        saveNewBillData(bill: bill)
    }
    func saveNewBillData(bill:Bill)  {
        
        var valueDic = Dictionary<String, Any>()
        valueDic["item"] = bill.billItemName
        valueDic["amount"] = bill.billTotalAmount
        valueDic["paidBy"] = bill.billPaidBy
        valueDic["created_at"] = Date().toMillis()
        valueDic["updated_at"] = Date().toMillis()
        
        
        
        
        self.ref.child("Bills").childByAutoId().setValue(valueDic) { (error, refrence) in
            
            
            if (error != nil){
                
                
                
            }else{
                
                // Other View Controller
                self.dismiss(animated: true)
            }
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension Date {
    func toMillis() -> Int64! {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
