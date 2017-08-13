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
    var diaryfetch = true
    var dateref = Int()
    var yearref = Int()
    var monthref = Int()
    var diaryfound = [NSManagedObject]()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        diaryfound = self.Diaryfetch()
        
        if diaryfetch == false {
            let fullscreen = UIScreen.main.bounds
            let remindstring = UILabel()
            remindstring.bounds = CGRect(x: 0, y: 0, width: fullscreen.width , height: 50)
            remindstring.text = "無紀錄"
            self.view.addSubview(remindstring)
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        
        
        // Dispose of any resources that can be recreated.
    }
    func dateconvert () -> Date {
        let datestring = "\(dateref), \(monthref), \(yearref)"
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = "dd, MM, yyyy"
        let time = formatter.date(from: datestring)!
        
        return time
    }
    func Diaryfetch() -> [NSManagedObject]{
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Diary")
        request.sortDescriptors = [NSSortDescriptor.init(key: "date", ascending: true)]
        let time = self.dateconvert()
        var results = [NSManagedObject]()
        var dictionary = [String:Any]()
        var result = [NSManagedObject]()
        
        
        do {
            results = try context.fetch(request) as! [NSManagedObject]
            
            
            
            
        }catch {
            print("fetch failed")
        }
        for i in results {
            
            
            if time == i.value(forKey: "date") as! Date {
                diaryfetch = true
                print("date match")
                result.append(i)
            }
            
            
            
        }
        
        return result
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return diaryfound.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiaryList") as! DiarycontentTableViewCell
        
        cell.diarycontent.text = diaryfound[indexPath.row].value(forKey: "content") as! String
        cell.diaryimage.image = UIImage(data: diaryfound[indexPath.row].value(forKey: "image") as! Data)
        
        
        /*if diaryfetch == true {
            cell.diarycontent.text = diaryfound[indexPath.row].value(forKey: "content") as! String
            if let imagedata = diaryfound[indexPath.row].value(forKey: "image") as? Data {
                cell.diaryimage.image = UIImage(data: imagedata)
            }
        }*/
        
        
        return cell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @IBAction func Addnewdiary(_ sender: UIButton) {
        
        
            
        
        //self.performSegue(withIdentifier: "addnew", sender: nil)
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
