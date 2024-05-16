//
//  InfoViewController.swift
//  JSONYouBike
//
//  Created by Ryan on 2024/4/27.
//

import UIKit
import MapKit

class InfoViewController: UIViewController {
    
    var item: SearchBike?
    
    @IBOutlet weak var showMap: MKMapView!
    @IBOutlet weak var totLabel: UILabel! //總停車格
    @IBOutlet weak var sbiLabel: UILabel! //目前車輛數量
    @IBOutlet weak var bempLabel: UILabel!//空位數量
    @IBOutlet weak var updateTimeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        showMapView()
        showLabel()
    }
    
    func showLabel(){
        if let item {
            totLabel.font = UIFont(name: "Iansui-Regular", size: 30)
            sbiLabel.font = UIFont(name: "Iansui-Regular", size: 30)
            bempLabel.font = UIFont(name: "Iansui-Regular", size: 30)
            updateTimeLabel.font = UIFont(name: "Iansui-Regular", size: 20)
            
            totLabel.text = "總停車格：\(item.total)"
            sbiLabel.text = "可借的腳踏車數量：\(item.availableRentBikes)"
            bempLabel.text = "可還的空位數量：\(item.availableReturnBikes)"
            updateTimeLabel.text = "更新日期：" + item.updateTime
        }
    }
    
    func showMapView(){
        guard let item = item else{ return }
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude)
        annotation.title = item.sna
        
        showMap.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        showMap.setRegion(region, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
