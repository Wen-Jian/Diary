//
//  submitnewdiaryViewController.swift
//  Collection apps
//
//  Created by Mac on 2017/7/20.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit
import CoreData

class submitnewdiaryViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    var currentyear = Int()
    var currentmonth = Int()
    var currentdate = Int()
    var time = Date()
    @IBOutlet weak var monthtextfield: UITextField!
    @IBOutlet weak var yeartextfield: UITextField!
    
    @IBOutlet weak var datetextfield: UITextField!
    
    
    @IBOutlet weak var memeryImage: UIImageView!
    var datecomponent = NSDateComponents()
    var calendar = NSCalendar.current
    
    @IBOutlet weak var Content: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        yeartextfield.text = "\(currentyear)"
        monthtextfield.text = String(currentmonth)
        datetextfield.text = String(currentdate)
        /*datecomponent.day = currentdate
        datecomponent.month = currentmonth
        datecomponent.year = currentyear*/
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.contentfinishediting))
        
        tap.cancelsTouchesInView = false
        
        self.view.addGestureRecognizer(tap)
        
        
        

        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dateconvert () -> Date {
        
        let timestring = "\(currentdate), \(currentmonth), \(currentyear)"
        let formatter = DateFormatter()
        formatter.dateFormat = "dd, MM, yyyy"
        time = formatter.date(from: timestring)!
        
        return time
       
    }
    
    @IBAction func submit(_ sender: UIButton) {
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        let newDiary = NSEntityDescription.insertNewObject(forEntityName: "Diary", into: context)
        
        if Content.text != "" {
            
            
            newDiary.setValue(Content.text, forKey: "content")
            
            newDiary.setValue(dateconvert(), forKey: "date")
            if let imagerecord = UIImagePNGRepresentation(memeryImage.image!) as? NSData {
                
                newDiary.setValue(imagerecord, forKey: "image")
            }
            
        }
        
        do {
            
            try context.save()
            print("成功提交")
            self.performSegue(withIdentifier: "backtocalendar", sender: nil)
            
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
    
    func contentfinishediting(){
        
        if Content.text == "" && Content.text != "今天發生什麼事情？"{
            
            Content.text = "今天發生什麼事情？"
        }
        self.view.endEditing(true)
        
    }
    
    @IBAction func imagefromlibry(_ sender: UIButton) {
        
        let imagepicker = UIImagePickerController()
        imagepicker.delegate = self
        imagepicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(imagepicker, animated: true, completion: nil)
        
    }
    
    @IBAction func imagefromcamera(_ sender: UIButton) {
        let imagepicker = UIImagePickerController()
        imagepicker.delegate = self
        imagepicker.sourceType = .camera
        self.present(imagepicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info [UIImagePickerControllerOriginalImage] as? UIImage {
            
            memeryImage.image = image
            
            self.dismiss(animated: true, completion: nil)
            
        }
        
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
