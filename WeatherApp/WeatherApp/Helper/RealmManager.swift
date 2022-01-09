//
//  RealmManager.swift
//  WeatherApp
//
//  Created by Christian Adiputra on 09/01/22.
//

import Foundation
import RealmSwift

class RealmManager: ObservableObject {
    
    @Published var weather: [WeatherDB] = []
    
    private(set) var localRealm: Realm?
    
    init() {
        openRealm()
        getData()
    }
    
    func openRealm() {
        do {
            let config = Realm.Configuration(schemaVersion: 1, migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion > 1 {
                    // 
                }
            })

            Realm.Configuration.defaultConfiguration = config

            localRealm = try Realm()
        } catch {
            print("Error opening Realm", error)
        }
    }
    
    func getData() {
        if let localRealm = localRealm {
            let allWeather = localRealm.objects(WeatherDB.self)
            allWeather.forEach { data in
                weather.append(data)
            }
        }
    }
    
    func addData(weather: Weather) {
        DispatchQueue.main.async {
            if let localRealm = self.localRealm {
                do {
                    try localRealm.write {
                        let newData = WeatherDB()
                        newData.city = weather.city
                        newData.status = weather.status
                        newData.temp = weather.temp
                        newData.temp_min = weather.temp_min
                        newData.temp_max = weather.temp_max
                        newData.pressure = weather.pressure
                        newData.humidity = weather.humidity
                        newData.country = weather.country
                        newData.sunset = weather.sunset
                        newData.sunrise = weather.sunrise
                        newData.wind = weather.wind

                        localRealm.add(newData)
                        self.weather.append(newData)
                        print(newData)
                        print(weather)
                        print("Added data to Realm!")
                    }
                } catch {
                    print("Error adding data to Realm", error)
                }
            }
        }
    }
}
