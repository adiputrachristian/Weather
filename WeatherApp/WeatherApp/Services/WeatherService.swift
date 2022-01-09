//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Christian Adiputra on 08/01/22.
//

import Foundation
import CoreLocation

public final class WeatherService: NSObject {
    
    private let locationManager = CLLocationManager()
    private let API_KEY = "3beb3c1b6e249d846b5db93b2cb248a2"
    private var completionHandler: ((Weather, Error?) -> Void)?
    
    var realManager = RealmManager()
    
    
    
    public override init() {
        super.init()
        locationManager.delegate = self
    }
    
    public func loadWeatherData(_ completionHandler: @escaping((Weather, Error?) -> Void)) {
        self.completionHandler = completionHandler
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    // api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
    private func makeDataRequest(forCoordinates coordinates: CLLocationCoordinate2D) {
        guard let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(API_KEY)&units=metric".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let url = URL(string: urlString) else  { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data else {
                print("error mas")
//                if let response = try? JSONDecoder().decode(APIResponse.self, from: data!) {
//                    var weather = Weather(response: response)
//                    weather.city = self.realManager.weather.last?.city ?? ""
//                    weather.status = self.realManager.weather.last?.status ?? ""
//                    weather.temp = self.realManager.weather.last?.temp ?? ""
//                    weather.temp_min = self.realManager.weather.last?.temp_min ?? ""
//                    weather.temp_max = self.realManager.weather.last?.temp_max ?? ""
//                    weather.pressure = self.realManager.weather.last?.pressure ?? ""
//                    weather.humidity = self.realManager.weather.last?.humidity ?? ""
//                    weather.country = self.realManager.weather.last?.pressure ?? ""
//                    self.completionHandler?(weather, error)
//                }
                return
            }
            if let response = try? JSONDecoder().decode(APIResponse.self, from: data) {
                print("ini data om \(data)")
                self.completionHandler?(Weather(response: response), error)
                self.realManager.addData(weather: Weather(response: response))
            }
        }.resume()
        
    }
}

extension WeatherService: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        makeDataRequest(forCoordinates: location.coordinate)
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Something went wrong:: \(error.localizedDescription)")
    }
    
    
}
