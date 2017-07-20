//
//  testViewController.swift
//  Collection apps
//
//  Created by Mac on 2017/7/15.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit
private let reuseIdentifier = "Cell"

class diarymenuViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate, UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet weak var calendar: UICollectionView!
    let classfication = ["工作記事", "心情扎記"]
    var year = [String]()
    var month = [String]()
    var yearused = 2000
    var monthused = 1
    var classselected = 0
    var week = Int()
    var monthref = Int()
    var yearref = Int()
    var dateref = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*calendar.register(dateCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)*/
        
        for i in 2000...2017 {
            
            year.append(String(i))
            
        }
        for i in 1...12 {
            month.append(String(i))
        }

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
            monthused = 13
            yearused -= 1
        case 2:
            monthused = 14
            yearused -= 1
        default:
            print(1)
            //print(monthused)
        }
        week = ((yearused%100) + ((yearused%100)/4) + (20/4) - 2 * 20 + (26*(monthused+1)/10)+1-1)%7
        print(week)
        if indexPath.row < week {
            
            cell.title.text = ""
        }else {
            
            switch monthused {
                
            case 3,5,7,8,10,12,13:
                numberofday = 31
            case 14:
                if (yearused%4 == 0 && yearused%100 != 0) || yearused%400 == 0 {
                    
                    numberofday = 29
                    
                }else {
                    
                    numberofday = 28
                }
                
                
            default:
                
                numberofday = 30
                
            }
            
            if indexPath.row - week < numberofday {
                cell.title.text = "\(indexPath.row + 2 - week)"
            }else {
                cell.title.text = ""
            }
            
        }
        
        
        
        
        
        
        return cell
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component{
        case 0:
            return year.count
        case 1:
            return month.count
        default:
            return classfication.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return year[row]
        case 1:
            return month[row]
        default:
            return classfication[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            yearused = Int(year[row])!
            print(year[row])
        case 1:
            if monthused == 13 || monthused == 14 {
                yearused += 1
            }
            monthused = Int(month[row])!
            
        default:
            classselected = Int(classfication[row])!
        }
        
        //print(yearused)
        //print(monthused)
        self.calendar.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        dateref = indexPath.row - week + 2
        if monthused == 13 || monthused == 14{
            yearref = yearused + 1
            switch monthused {
            case 13:
                monthref = 1
            default:
                monthref = 2
                
            }
        }else {
            yearref = yearused
            monthref = monthused
        }
        
        self.performSegue(withIdentifier: "Diaryediting", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Diaryediting"{
            
            
            let NextVC = segue.destination as! submitnewdiaryViewController
            NextVC.currentyear = yearref
            NextVC.currentmonth = monthref
            NextVC.currentdate = dateref
            print(NextVC.currentyear)
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
