//
//  MainView.swift
//  WeatherApp
//
//  Created by Christian Adiputra on 08/01/22.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var weatherVM: WeatherViewModel
    @StateObject var realmManager: RealmManager = RealmManager()
    @State var lastupdated = Date().timeIntervalSinceReferenceDate // Feb 2, 1997, 10:26 AM
    
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.black, Color.indigo, Color.blue], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
            VStack {
                VStack(alignment: .center) {
                    Text("\(weatherVM.city), \(weatherVM.country)")
                        .bold()
                        .foregroundColor(Color.white)
                    Text("Updated at: \(getcurrentdate())")
                        .foregroundColor(Color.white)
                }.padding(.top,25)
                Spacer()
                VStack {
                    Text(weatherVM.weatherstatus)
                        .bold()
                    Text("\(weatherVM.temp)°C")
                        .fontWeight(.thin)
                        .font(.system(size: 100))
                    HStack {
                        Text("Min temp: \(weatherVM.temp_min)°C")
                        Spacer()
                        Text("Max temp: \(weatherVM.temp_max)°C")
                    }
                    .padding(.horizontal,70)
                }
                .foregroundColor(Color.white)
                Spacer()
                WeatherDetail(weatherVM: weatherVM)
                    .padding()
            }
        }
        .onAppear {
            weatherVM.refresh()
        }
        .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                            .onEnded({ value in
                                if value.translation.height > 0 {
                                    weatherVM.refresh()
                                }
                            }))
        
    }
    
    func getcurrentdate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(weatherVM: WeatherViewModel(weatherService: WeatherService()))
    }
}
