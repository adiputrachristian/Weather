//
//  Weather.swift
//  WeatherApp
//
//  Created by Christian Adiputra on 08/01/22.
//

import Foundation

public struct Weather {
    var city: String
    var status: String
    var temp: String
    var temp_min: String
    var temp_max: String
    var pressure: String
    var humidity: String
    var country: String
    var sunset: String
    var sunrise: String
    var wind: String
    
    init(response: APIResponse) {
        city = response.name
        status = response.weather[0].main
        temp = "\(Int(response.main.temp))"
        temp_min = "\(Int(response.main.temp_min))"
        temp_max = "\(Int(response.main.temp_max))"
        pressure = "\(response.main.pressure)"
        humidity = "\(response.main.humidity)"
        country = "\(response.sys.country)"
        
        let epochsunsetTime = TimeInterval(response.sys.sunset) / 1000
        let epochsunsetTimeformatter = DateFormatter()
        epochsunsetTimeformatter.timeStyle = .short
        sunset = epochsunsetTimeformatter.string(from: Date(timeIntervalSince1970: epochsunsetTime))
        
        let epochsunriseTime = TimeInterval(response.sys.sunrise) / 1000
        let epochsunriseTimeformatter = DateFormatter()
        epochsunriseTimeformatter.timeStyle = .short
        sunrise = epochsunriseTimeformatter.string(from: Date(timeIntervalSince1970: epochsunriseTime))
        
        wind = "\(Int(response.wind.speed))"
    }
}

struct APIWeather: Decodable {
    var main: String
}

struct APIMain: Decodable {
    var temp: Double
    var temp_min: Double
    var temp_max: Double
    var pressure: Int
    var humidity: Int
}

struct APISys: Decodable {
    var country: String
    var sunrise: Double
    var sunset: Double
}

struct APIWind: Decodable {
    var speed: Double
}

struct APIResponse: Decodable {
    var name: String
    var main: APIMain
    var weather: [APIWeather]
    var sys: APISys
    var wind: APIWind
}



