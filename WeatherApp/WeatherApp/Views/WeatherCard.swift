//
//  WeatherCard.swift
//  WeatherApp
//
//  Created by Christian Adiputra on 08/01/22.
//

import SwiftUI

struct WeatherCard: View {
    
    var iconname: String
    var title: String
    var desc: String
    
    var body: some View {
        VStack {
            Image(systemName: iconname)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundColor(Color.white)
            Text(title)
                .font(.caption)
                .foregroundColor(Color.white)
            Text(desc)
                .font(.caption)
                .foregroundColor(Color.white)
        }
        .padding(10)
        .frame(width: 90, height: 90)
        .background(Color.white.opacity(0.4))
    }
}

struct WeatherCard_Previews: PreviewProvider {
    static var previews: some View {
        WeatherCard(iconname: "sun.and.horizon.fill", title: "Sunrise", desc: "06:015 AM")
    }
}
