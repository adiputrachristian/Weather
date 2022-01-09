//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Christian Adiputra on 08/01/22.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    var body: some Scene {
        WindowGroup  {
            let weatherservice =  WeatherService()
            let weatherviewmodel =  WeatherViewModel(weatherService: weatherservice)
            MainView(weatherVM: weatherviewmodel)
        }
    }
}
