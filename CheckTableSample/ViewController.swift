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
    
    // リスト追加用のTextField
    @IBOutlet var listTextField: UITextField!
    
    var sampleData = [SampleData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
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
        var trueCount = 0
        for data in sampleData {
            print("==========")
            print(data.selected)
            if data.selected == true {
                trueCount = trueCount + 1
            }
        }
        
        
        trueCount = trueCount * 25
        
        let alert = UIAlertController(title: "あなたの健康度", message: "あなたの健康危険度は\(trueCount)%です！", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    // 追加用のメソッドを追加
    @IBAction func addList() {
        // 入力用のtextFieldの文字を取得
        let inputText = listTextField.text
        
        // inputTextが空(なにも入力されていないときは追加できないので、if-let文で入力されているか判定
        if let inputText = inputText {
            //
            if inputText.count > 0 {
                let newData = SampleData(title: inputText, selected: false)
                sampleData.append(newData)
                checkTableView.reloadData()
                
                // 入力を削除
                listTextField.text = ""
            } else {
                print("文字が入力されていません")
            }
        } else {
            print("文字が入力されていません")
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            sampleData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
        }
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
