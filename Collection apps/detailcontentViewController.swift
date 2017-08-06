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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
