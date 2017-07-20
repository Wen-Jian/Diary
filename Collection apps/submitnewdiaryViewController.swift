//
//  submitnewdiaryViewController.swift
//  Collection apps
//
//  Created by Mac on 2017/7/20.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class submitnewdiaryViewController: UIViewController {

    var currentyear = Int()
    var currentmonth = Int()
    var currentdate = Int()
    @IBOutlet weak var monthtextfield: UITextField!
    @IBOutlet weak var yeartextfield: UITextField!
    
    @IBOutlet weak var datetextfield: UITextField!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        yeartextfield.text = String(currentyear)
        monthtextfield.text = String(currentmonth)
        datetextfield.text = String(currentdate)
        print(yeartextfield.text!)

        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
