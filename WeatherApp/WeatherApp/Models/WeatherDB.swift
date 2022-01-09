//
//  WeatherDB.swift
//  WeatherApp
//
//  Created by Christian Adiputra on 09/01/22.
//

import Foundation
import RealmSwift

class WeatherDB: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var city = ""
    @objc dynamic var status = ""
    @objc dynamic var temp = ""
    @objc dynamic var temp_min = ""
    @objc dynamic var temp_max = ""
    @objc dynamic var pressure = ""
    @objc dynamic var humidity = ""
    @objc dynamic var country = ""
    @objc dynamic var sunset = ""
    @objc dynamic var sunrise = ""
    @objc dynamic var wind = ""
    
}
