//
//  ViewController.swift
//  Collection apps
//
//  Created by Mac on 2017/6/23.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var AccountLogin: UIButton!
    @IBOutlet weak var Account: UITextField!
    @IBOutlet weak var Password: UITextField!
    var currentUser = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.isNavigationBarHidden = false
        AccountLogin.layer.cornerRadius = 30
        AccountLogin.clipsToBounds = true
        /*let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.predicate = NSPredicate(format: "account = %@", "Wen")
        do {
            let result = try context.fetch(request) as! [NSManagedObject]
            for i in result {
                context.delete(i)
                try context.save()
            }
        }catch {
            
        }*/
      
        
        
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBAction func AccountLogin(_ sender: UIButton) {
        if Account.text! == "" || Password.text == "" {
            print("請輸入帳號或密碼")
        }else {
            
            accountFetch(username: Account.text!){ (isExist, userdic, result) in
                if isExist {
                    self.currentUser = userdic[0]["username"] as! String
                    if self.Password.text! == (userdic[0]["password"] as! String)/*無法重複登入*/ {
                        print("登入成功")
                        self.Account.text = ""
                        self.Password.text = ""
                        self.performSegue(withIdentifier: "Loginsuccess", sender: nil)
                        
                        
                            
                        
                            
                            
                        
                        
                    }else {
                        print("密碼錯誤")
                        self.Account.text = ""
                        self.Password.text = ""
                        
                    }
                    
                }else {
                    let alertcontrol = UIAlertController(title: "帳號不存在", message: "您所輸入的帳號不存在,請建立一個新帳號", preferredStyle: .alert)
                    let creat = UIAlertAction(title: "確認", style: .default, handler: { (creat) in
                        self.creatAccount()
                    })
                    let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                    alertcontrol.addAction(cancel)
                    alertcontrol.addAction(creat)
                    self.present(alertcontrol, animated: true, completion: nil)
                    self.Account.text = ""
                    self.Password.text = ""
                }
            }
            
        }
      
    }

    func deleteaccount(isExist:Bool, result:[NSManagedObject]){
        
        let appdelegate = UIApplication.shared.delegate as!AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        
        if isExist {
            
            context.delete(result[0])
            do {
                try context.save()
            }catch{
                print("儲存失敗")
            }
        }

    
       
        
    }

    func accountFetch (username:String,completionhandler:@escaping(Bool, [NSDictionary], [NSManagedObject])->()){
        var isExist:Bool = false
        var userdic = [NSDictionary]()
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.predicate = NSPredicate(format: "account = %@", username)
        do {
            let result = try context.fetch(request) as! [NSManagedObject]
            if result.count > 0 {
                isExist = true
                for i in result {
                    let accountfound = i.value(forKey: "account") as! String
                    let passwordfound = i.value(forKey: "password") as! String
                    userdic.append(["username":accountfound, "password":passwordfound])
                }
        
            }else {
                isExist = false
            }
            completionhandler(isExist, userdic, result)

        }catch {
            print("搜尋失敗")
        }
            
        
    
    }
    
    @IBAction func Register(_ sender: UIButton) {
        
        creatAccount()
        
    }
    func creatAccount(){
        


        let alertcontroller = UIAlertController(title: "創建帳號", message: "請輸入欲創建的帳號及密碼", preferredStyle: .alert)
        alertcontroller.addTextField { (textField) in
            textField.placeholder = "帳號"
        }
        alertcontroller.addTextField { (textField) in
            textField.placeholder = "密碼"
        }
        let cancel = UIAlertAction(title: "取消", style: .cancel) { (cancel) in
            self.dismiss(animated: true, completion: nil)
        }
        let submit = UIAlertAction(title: "Submit", style: .default) { (submit) in
            
            if alertcontroller.textFields?[0].text == "" || alertcontroller.textFields?[1].text == "" {
                let alertcotroler2 = UIAlertController(title: "錯誤", message: "請輸入帳號密碼並重新操作", preferredStyle: .alert)
                let confirm = UIAlertAction(title: "確認", style: .default, handler: nil)
                alertcotroler2.addAction(confirm)
                self.present(alertcotroler2, animated: true, completion: nil)
                
            }else {
                let account = alertcontroller.textFields![0].text
                let password = alertcontroller.textFields![1].text
                self.register(account: account!, password: password!)

            }
        }
        alertcontroller.addAction(submit)
        alertcontroller.addAction(cancel)
        self.present(alertcontroller, animated: true, completion: nil)
        
        
    }
    func register (account:String, password:String) {
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        let newuser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
        newuser.setValue(account, forKey: "account")
        newuser.setValue(password, forKey: "password")
        do {
            try context.save()
            print("帳號建立成功")
        }catch {
            print("帳號建立儲存失敗")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Loginsuccess" {
            
            let test = segue.destination as! UITabBarController
            let nextVC = test.viewControllers![0] as! friendViewController
            nextVC.currentUser = self.currentUser
            
        }
        
    }
    //func fetchAccount (username:String)->(Bool, Array<Any>){
        
    //}
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

