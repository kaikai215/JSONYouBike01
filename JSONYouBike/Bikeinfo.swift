//
//  Bikeinfo.swift
//  JSONYouBike
//
//  Created by Ryan on 2024/4/21.
//

import Foundation

struct SearchBike: Codable {
    let sna: String//地點
    let sarea: String//行政區
    let total: Int//場站總停車格
    let availableRentBikes: Int//場站目前車輛數量
    let availableReturnBikes: Int//空位數量
    let updateTime: String//即時更新時間
    let latitude: Double
    let longitude: Double
}
