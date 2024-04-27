//
//  ViewController.swift
//  JSONYouBike
//
//  Created by Ryan on 2024/4/21.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var LogoLabel: UILabel!
    
    @IBOutlet weak var entetLabel: UIButton!
    
    var item = [SearchBike]()
    var taipeiDistricts = [String] () //儲存台北市的行政區
    var selectedDistrict: String? //用於儲存所選的行政區

    
    
    
    @IBOutlet weak var districtPickerView: UIPickerView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LogoLabel.font = UIFont(name: "Iansui-Regular", size: 30)
        entetLabel.titleLabel?.font = UIFont(name: "Iansui-Regular", size: 50)
        
        districtPickerView.dataSource = self
        districtPickerView.delegate = self
        fetchItems()


    }
    @IBSegueAction func showPlace(_ coder: NSCoder) -> PlaceTableViewController? {
        let controller = PlaceTableViewController(coder: coder)
        let selectedRow = districtPickerView.selectedRow(inComponent: 0)
        if selectedRow != -1 {
            selectedDistrict = taipeiDistricts[selectedRow]
            controller?.selectedDistrict = selectedDistrict
        }
        
        return controller
    }
    
    //抓資料
    func fetchItems() {
        let urlStr = "https://tcgbusfs.blob.core.windows.net/dotapp/youbike/v2/youbike_immediate.json"
        if let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url) { data, respons, error in
                if let data {
                    let decoder = JSONDecoder()
                    do{
                        let searchResponse = try decoder.decode([SearchBike].self, from: data)
                        self.item = searchResponse
                        
                        // 在成功解析 JSON 後，更新 Set 中的行政區資料
                        var uniqueDistricts = Set<String>()
                        for item in self.item {
                            uniqueDistricts.insert(item.sarea)
                        }
                        // 將 Set 轉換為陣列，並按照字母順序排序
                        self.taipeiDistricts = Array(uniqueDistricts).sorted()
                        
                        DispatchQueue.main.async {
                            self.districtPickerView.reloadAllComponents()
                        }
                        
                    }catch{
                        print(error)
                    }
                }else if let error {
                    print(error)
                }
            }.resume()
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return taipeiDistricts.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return taipeiDistricts[row]
    }
    
}

