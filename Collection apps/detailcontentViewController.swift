//
//  detailcontentViewController.swift
//  Collection apps
//
//  Created by Mac on 2017/7/30.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit
import CoreData

class detailcontentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var contentfetch = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 24
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Listcell") as! detailTableViewCell
        for _ in indexPath {
            
            cell.time.text = "\(indexPath.row)"
            if contentfetch == false {
                cell.list.text = ""
            }
            
            
        }
        
        return cell
    }
    
    /*func Diaryfetch() -> [NSManagedObject] {
        var result = [NSManagedObject]()
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Diary")
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        
        do {
            result = try context.fetch(request) as! [NSManagedObject]
        }catch {
            print("fetch failed")
        }
        
        return result
        
        
    }
    
    func dateconvert (result:[NSManagedObject]) -> [Any] {
        
        var datedictionary = [String:String]()
        var datechararry = [Character]()
        var datearray = [Any]()
        for i in result {
            var month = [Character]()
            var date = [Character]()
            var year = [Character]()
            datedictionary = [:]
            datechararry = []
            let datefomater = DateFormatter()
            datefomater.dateStyle = .short
            var time = datefomater.string(from: i.value(forKey: "date") as! Date)
            var count = 0
            
            for char in time.characters {
                
                datechararry.append(char)
                
                count = 0
                
            }
            print(datechararry)
            for a in 0...datechararry.count-1 {
                
                
                if a < datechararry.count-1 {
                    
                    if datechararry[a] != "/" {
                        
                        switch count {
                        case 0:
                            month.append(datechararry[a])
                        case 1:
                            date.append(datechararry[a])
                        default:
                            year.append(datechararry[a])
                            
                        }
                        
                        
                    }else {
                        count += 1
                        switch count {
                        case 1:
                            datedictionary["MM"] = String (month)
                        default:
                            datedictionary["DD"] = String (date)
                        }
                        
                    }
                }else {
                    year.append(datechararry[a])
                    datedictionary["YY"] = "20" + String(year)
                    
                    
                    
                }
                
                
                
                
            }
            
            datearray.append(datedictionary)
            print(datearray)
        }
        
        return datearray
        //重複append，找出原因
    }
    
    
    @IBAction func fetchtest(_ sender: UIButton) {
        
        
        let result = self.Diaryfetch()
        let datearray = self.dateconvert(result: result)
    
        
    }*/


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
