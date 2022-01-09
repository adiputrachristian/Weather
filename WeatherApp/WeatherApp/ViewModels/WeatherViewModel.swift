//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Christian Adiputra on 08/01/22.
//

import Foundation

public class WeatherViewModel: ObservableObject {
    @Published var city: String = ""
    @Published var weatherstatus: String = ""
    @Published var temp: String = ""
    @Published var temp_min: String = ""
    @Published var temp_max: String = ""
    @Published var pressure: String = ""
    @Published var humidity: String = ""
    @Published var country: String = ""
    @Published var wind: String = ""
    @Published var sunset: String = ""
    @Published var sunrise: String = ""
    @Published var weather: [WeatherDB] = []
    
    public let weatherService: WeatherService
    
    var realmManager: RealmManager = RealmManager()
    
    public init(weatherService: WeatherService){
        self.weatherService = weatherService
    }
    
    public func refresh() {
        weatherService.loadWeatherData { weather, error in
            if error == nil {
                DispatchQueue.main.async {
                    self.city = weather.city
                    self.weatherstatus = weather.status
                    self.temp = weather.temp
                    self.temp_min = weather.temp_min
                    self.temp_max = weather.temp_max
                    self.pressure = weather.pressure
                    self.humidity = weather.humidity
                    self.country = weather.country
                    self.wind = weather.wind
                    self.sunset = weather.sunset
                    self.sunrise = weather.sunrise
                }
            } else {
                DispatchQueue.main.async {
                    self.city = self.realmManager.weather.last?.city ?? "-"
                    self.weatherstatus = self.realmManager.weather.last?.status ?? "-"
                    self.temp = self.realmManager.weather.last?.temp ?? "-"
                    self.temp_min = self.realmManager.weather.last?.temp_min ?? "-"
                    self.temp_max = self.realmManager.weather.last?.temp_max ?? "-"
                    self.pressure = self.realmManager.weather.last?.pressure ?? "-"
                    self.humidity = self.realmManager.weather.last?.humidity ?? "-"
                    self.country = self.realmManager.weather.last?.country ?? "-"
                    self.wind = self.realmManager.weather.last?.wind ?? "-"
                    self.sunset = self.realmManager.weather.last?.sunset ?? "-"
                    self.sunrise = self.realmManager.weather.last?.sunrise ?? "-"
                }
            }
        }
    }
}
