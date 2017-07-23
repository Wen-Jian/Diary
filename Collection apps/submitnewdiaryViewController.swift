//
//  submitnewdiaryViewController.swift
//  Collection apps
//
//  Created by Mac on 2017/7/20.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit
import CoreData

class submitnewdiaryViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    var currentyear = Int()
    var currentmonth = Int()
    var currentdate = Int()
    @IBOutlet weak var monthtextfield: UITextField!
    @IBOutlet weak var yeartextfield: UITextField!
    
    @IBOutlet weak var datetextfield: UITextField!
    
    @IBOutlet weak var Content: UITextField!
    
    @IBOutlet weak var memeryImage: UIImageView!
    var datecomponent = NSDateComponents()
    var calendar = NSCalendar.current
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        yeartextfield.text = "\(currentyear)"
        monthtextfield.text = String(currentmonth)
        datetextfield.text = String(currentdate)
        
        
        
        
        datecomponent.day = Int(datetextfield.text!)!
        datecomponent.month = Int(monthtextfield.text!)!
        datecomponent.year = Int(yeartextfield.text!)!
        
        

        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dateconvert (datecomponent:NSDateComponents) -> Date {
        
        let timestring = "\(datecomponent.day), \(datecomponent.month), \(datecomponent.year)"
        let formatter = DateFormatter()
        formatter.dateFormat = "dd, MM, yyyy"
        var time = formatter.date(from: timestring)
        
        return time!
       
    }
    
    @IBAction func submit(_ sender: UIButton) {
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        let newDiary = NSEntityDescription.insertNewObject(forEntityName: "Diary", into: context)
        
        if Content.text != "" {
            
            
            newDiary.setValue(Content.text, forKey: "content")
            let dateforrecord =
            newDiary.setValue(dateconvert(datecomponent: datecomponent), forKey: "date")
            if let imagerecord = memeryImage.image {
                
                newDiary.setValue(imagerecord, forKey: "image")
            }
            
        }
        
        do {
            try context.save()
        }catch{
            print("save failed")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if yeartextfield.text == "" || Int(yeartextfield.text!) == nil{
            yeartextfield.text = String(currentyear)
        }else if Int(yeartextfield.text!)! < 2001 || Int(yeartextfield.text!)!>2017{
            
            yeartextfield.text = String(currentyear)
            
        }else {
            
            datecomponent.year = Int(yeartextfield.text!)!
            
        }
        if monthtextfield.text == "" {
            monthtextfield.text = String(currentmonth)
        }else if Int(monthtextfield.text!)! < 1 || Int(monthtextfield.text!)!>12{
            
            monthtextfield.text = String(currentmonth)
            
        }else {
            
            datecomponent.month = Int(monthtextfield.text!)!
            
        }
        if datetextfield.text == "" {
           datetextfield.text = String(currentdate)
        }else if Int(datetextfield.text!)! < 1 || Int(datetextfield.text!)!>31{
            
            datetextfield.text = String(currentdate)
            
        }else {
            
            datecomponent.day = Int(datetextfield.text!)!
            
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
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
