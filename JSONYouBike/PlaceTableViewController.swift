//
//  PlaceTableViewController.swift
//  JSONYouBike
//
//  Created by Ryan on 2024/4/26.
//

import UIKit

class PlaceTableViewController: UITableViewController {
    
    var items = [SearchBike]()
    var selectedDistrict: String? // 接收所選的行政區
    var placeLots = [String]() //儲存場地
    
    override func viewDidLoad() {
        super.viewDidLoad()
       fetchItems()
        
    }
    @IBSegueAction func showInfo(_ coder: NSCoder) -> InfoViewController? {
        if let row = tableView.indexPathForSelectedRow?.row{
            let controller =  InfoViewController(coder: coder)
            controller?.item = items[row]
            return controller
        }else{
            return nil
        }
        
    }
    
    func fetchItems() {
        guard let selectedDistrict = selectedDistrict else { return }
        
        let urlStr = "https://tcgbusfs.blob.core.windows.net/dotapp/youbike/v2/youbike_immediate.json"
        if let url = URL(string: urlStr){
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data  {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    do{
                        let searchResponse = try decoder.decode([SearchBike].self, from: data)
                        //過濾 searchResponse 陣列，只保留那些 sarea 屬性等於 selectedDistrict 的 SearchBike 物件。這樣，items 陣列將只包含選定區域的站點。
                        self.items = searchResponse.filter({ searchBike in
                            return searchBike.sarea == self.selectedDistrict
                        })
                        self.placeLots = self.items.map({ searchBike in
                            return searchBike.sna.replacingOccurrences(of: "YouBike2.0_", with: "")
                        })
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        
                    }catch{
                        //show error
                    }
                }
            }.resume()
        }
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return placeLots.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceTableViewCell", for: indexPath) as! PlaceTableViewCell
        
        cell.PlaceLabel.text = placeLots[indexPath.row]
        

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
