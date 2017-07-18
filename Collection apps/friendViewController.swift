//
//  testViewController.swift
//  Collection apps
//
//  Created by Mac on 2017/7/10.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit
import CoreData

class friendViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    var currentUser = String()
    var friendlist = ["test"]
    override func viewDidLoad() {
        super.viewDidLoad()
        print(currentUser)
    

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friidcell")
        cell?.textLabel?.text = "test"
        return cell!
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
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
