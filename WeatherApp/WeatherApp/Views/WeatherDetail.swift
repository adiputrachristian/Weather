//
//  WeatherDetail.swift
//  WeatherApp
//
//  Created by Christian Adiputra on 08/01/22.
//

import SwiftUI

struct WeatherDetail: View {
    
    @ObservedObject var weatherVM: WeatherViewModel
    
    var body: some View {
        VStack {
            HStack {
                WeatherCard(iconname: "sunrise.fill", title: "Sunrise", desc: weatherVM.sunrise)
                WeatherCard(iconname: "sunset.fill", title: "Sunset", desc: weatherVM.sunset)
                WeatherCard(iconname: "wind", title: "Wind", desc: weatherVM.wind)
            }
            HStack {
                WeatherCard(iconname: "digitalcrown.press.fill", title: "Pressure", desc: weatherVM.pressure)
                WeatherCard(iconname: "humidity.fill", title: "Humidity", desc: weatherVM.humidity)
                WeatherCard(iconname: "info.circle", title: "Created by", desc: "Christian")
            }
        }
    }
}

struct WeatherDetail_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDetail(weatherVM: WeatherViewModel(weatherService: WeatherService()))
    }
}
