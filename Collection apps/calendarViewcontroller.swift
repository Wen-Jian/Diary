//
//  testViewController.swift
//  Collection apps
//
//  Created by Mac on 2017/7/15.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit
import CoreData
private let reuseIdentifier = "Cell"

class caleadarViewcontroller: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate, UIPickerViewDelegate,UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var monthlabel: UILabel!
    @IBOutlet weak var yearlabel: UILabel!
    @IBOutlet weak var calendar: UICollectionView!
    let classfication = ["工作記事", "心情扎記"]
    var year = [String]()
    var month = [String]()
    var yearused = 2014
    var monthused = 1
    var classselected = 0
    var week = Int()
    var monthref = Int()
    var yearref = Int()
    var dateref = Int()
    var result = [NSManagedObject]()
    var datearray = [Any]()
    var record = false
    var recordarray = [Bool]()
    var somethingsaved = false
    var yearchoice: UITableView!
    var monthchoice: UITableView!
    var yearbuttonpushed = false
    var monthbuttonpushed = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*calendar.register(dateCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)*/
        
        yearlabel.text = String(yearused)
        monthlabel.text = String(monthused)
        
        if somethingsaved == true {
            
            yearlabel.text = String(yearused)
            monthlabel.text = String(monthused)
            
        }else {
            yearlabel.text = "請選擇"
            monthlabel.text = "請選擇"
            
        }
        for i in 2014...2017 {
            
            year.append(String(i))
            
        }
        for i in 1...12 {
            month.append(String(i))
        }
         result = self.Diaryfetch()
        datearray = self.dateconvert(result: result)
        
        for i in datearray {
            
            let ref = i as! NSDictionary
            
            
        }
        yearchoice = UITableView()
        yearchoice.tag = 1
        yearchoice.frame = CGRect(x: yearlabel.bounds.origin.x, y: yearlabel.bounds.origin.y + yearlabel.bounds.height, width: yearlabel.bounds.width, height: 30)
        yearchoice.numberOfRows(inSection: year.count)
        yearchoice.register(UITableViewCell.self, forCellReuseIdentifier: "yeartable")
        yearchoice.delegate = self
        

        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 42
    }
   
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var numberofday = 0
    
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! dateCollectionViewCell
        switch monthused {
        case 1:
            monthref = 13
            
        case 2:
            monthref = 14
            
        default:
            monthref = monthused
        }
        
        
        if monthref == 13 || monthref == 14 {
            
            yearref = yearused - 1
            
            
        }else {
            
            yearref = yearused
            
            
        }
        
        week = (yearref - 1 + (yearref-1)/4 - (yearref-1)/100 + (yearref-1)/400 + 13*(monthref+1)/5 + 1) % 7
        
        if indexPath.row < week {
            
            cell.title.text = ""
        }else {
            
            switch monthref {
                
            case 3,5,7,8,10,12,13:
                numberofday = 31
            case 14:
                if (yearused % 4 == 0 && yearused % 100 != 0) || yearused%400 == 0 {
                    
                    numberofday = 29
                    
                }else {
                    
                    numberofday = 28
                }
                
                
            default:
                
                numberofday = 30
                
            }
            
            if indexPath.row - week < numberofday {
                cell.title.text = "\(indexPath.row + 1 - week)"
            }else {
                cell.title.text = ""
            }
            
        }
        
        recordarray = []
        for i in datearray {
            
            let ref = i as! NSDictionary
            if Int(ref["YY"] as! String) == yearused {
                
                if Int(ref["MM"] as! String) == monthused {
                    
                    
                    
                    if Int(ref["DD"] as! String) == indexPath.row - week + 1 {
                    
                        record = true
                    }else {
                        record = false
                    }
                }else {
                    record = false
                }
                
            }else {
                record = false
            }
            
            recordarray.append(record)
            
            
        }
        
        record = false
        for i in recordarray {
            
            if i == true{
                
                record = true
                
            }
            
            
        }
        switch record {
        case true:
            cell.recordspot.backgroundColor = .red
        default:
            cell.recordspot.backgroundColor = .white
        }
        
        
        
        
        
        
        
        
        return cell
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component{
        case 0:
            return year.count
        default:
            return month.count
        
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return year[row]
        default:
            return month[row]
        
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            yearused = Int(year[row])!
            
        default:
            
            monthused = Int(month[row])!
            
       
        }
       
        self.calendar.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row >= week {
            
            dateref = indexPath.row - week + 1
            
        }
        
        
        
        self.performSegue(withIdentifier: "showdiary", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showdiary"{
            
            
            let NextVC = segue.destination as! DiaryViewController
            NextVC.yearref = yearused
            NextVC.monthref = monthused
            NextVC.dateref = dateref
            
            
        }
    }
    func Diaryfetch() -> [NSManagedObject] {
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
            
        }
        
        return datearray

    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(tableView.tag)
        switch tableView.tag {
        
        case 1:
            return year.count
            
        case 2:
            return month.count
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView.tag {
        case 1:
            
            
            let cell = yearchoice.dequeueReusableCell(withIdentifier: "yeartable")
            cell?.textLabel?.text = year[indexPath.row]
            cell?.backgroundColor = .gray
            return cell!

        default:
            
            let cell = monthchoice.dequeueReusableCell(withIdentifier: "monthtable")
            cell?.textLabel?.text = month[indexPath.row]
            return cell!
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView.tag {
        case 1:
            yearlabel.text = year[indexPath.row]
            yearchoice.removeFromSuperview()
            yearused = Int(yearlabel.text!)!
            self.calendar.reloadData()
        default:
            monthlabel.text = month[indexPath.row]
            monthchoice.removeFromSuperview()
            monthused = Int(monthlabel.text!)!
            self.calendar.reloadData()
        }
    }
    @IBAction func yearselectionbutton(_ sender: UIButton) {
        
        
        if yearbuttonpushed == false{
            
            yearchoice = UITableView()
            yearchoice.tag = 1
            yearchoice.frame = CGRect(x: 65, y: 125, width: 78, height: 150)
            
            
            yearchoice.register(UITableViewCell.self, forCellReuseIdentifier: "yeartable")
            yearchoice.delegate = self
            yearchoice.dataSource = self
            
            
            
            self.view.addSubview(yearchoice)
            yearbuttonpushed = true

        }else {
            yearbuttonpushed = false
            yearchoice.removeFromSuperview()
            
        }
        
        
        
        
    }
    
    @IBAction func monthselectionbutton(_ sender: UIButton) {
        
        
        if monthbuttonpushed == false{
            
            monthchoice = UITableView()
            monthchoice.tag = 2
            monthchoice.frame = CGRect(x: 230, y: 125, width: 78, height: 150)
            
            
            yearchoice.register(UITableViewCell.self, forCellReuseIdentifier: "yeartable")
            monthchoice.register(UITableViewCell.self, forCellReuseIdentifier: "monthtable")
            monthchoice.delegate = self
            monthchoice.dataSource = self
            
            
            
            self.view.addSubview(monthchoice)
            monthbuttonpushed = true
            
        }else {
            monthbuttonpushed = false
            monthchoice.removeFromSuperview()
            
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
