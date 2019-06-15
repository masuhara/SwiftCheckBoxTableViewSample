//
//  ViewController.swift
//  CheckTableSample
//
//  Created by Masuhara on 2019/06/15.
//  Copyright © 2019 Ylab Inc. All rights reserved.
//

import UIKit
import BEMCheckBox

class ViewController: UIViewController {
    
    @IBOutlet var checkTableView: UITableView!
    
    var sampleData = [SampleData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSampleData()
        configureTableView()
    }
    
    func setSampleData() {
        let data1 = SampleData(title: "朝寝坊しがちだ", selected: false)
        let data2 = SampleData(title: "夢をよくみる", selected: false)
        let data3 = SampleData(title: "腹痛になりがちだ", selected: false)
        let data4 = SampleData(title: "スポーツは苦手だ", selected: false)
        sampleData.append(data1)
        sampleData.append(data2)
        sampleData.append(data3)
        sampleData.append(data4)
    }
    
    func configureTableView() {
        checkTableView.dataSource = self
        checkTableView.delegate = self
        
        checkTableView.tableFooterView = UIView()
        
        let nib = UINib(nibName: "CheckTableViewCell", bundle: Bundle.main)
        checkTableView.register(nib, forCellReuseIdentifier: "CheckTableViewCell")
    }

    @IBAction func finish() {
        // データがどうなったか表示してみる
        for data in sampleData {
            print("==========")
            print(data.selected)
        }
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckTableViewCell") as! CheckTableViewCell
        
        // label
        cell.sampleLabel.text = sampleData[indexPath.row].title
        
        // checkBox
        cell.checkBox.tag = indexPath.row
        cell.checkBox.delegate = self
        if sampleData[indexPath.row].selected == true {
            cell.checkBox.on = true
        } else {
            cell.checkBox.on = false
        }
        
        return cell
    }
}

extension ViewController: BEMCheckBoxDelegate {
    func didTap(_ checkBox: BEMCheckBox) {
        if checkBox.on == true {
            sampleData[checkBox.tag].selected = true
        } else {
            sampleData[checkBox.tag].selected = false
        }
    }
}
