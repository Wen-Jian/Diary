//
//  testViewController.swift
//  Collection apps
//
//  Created by Mac on 2017/7/10.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit
import CoreData

class DiaryViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    

        // Do any additional setup after loading the view.
    var diaryfetch = false
    var diaryfetchresult = [NSManagedObject]()
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiaryList") as! DiaryListTableViewCell
        
        if diaryfetch == false {
            let fullscreen = UIScreen.main.bounds
            let remindstring = UILabel()
            remindstring.bounds = CGRect(x: 0, y: 0, width: fullscreen.width , height: 50)
            remindstring.text = "無紀錄"
            self.view.addSubview(remindstring)
        }else {
            
            if diaryfetchresult.count > 0 {
                
                for i in diaryfetchresult{
                    
                    if let imagedata = i.value(forKey: "image") as? Data {
                        cell.diaryimage.image = UIImage(data: imagedata)
                        
                    }
                    cell.diarytext.text = i.value(forKey: "content") as! String
                    
                    
                }
            }
            
        }
        
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var number: Int
        if diaryfetch == false {
            
            number = 0
            
        }else{
            
            number = diaryfetchresult.count
            
        }
        
        
        return number
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
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
