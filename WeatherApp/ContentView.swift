//
//  ContentView.swift
//  WeatherApp
//
//  Created by Rutuja on 2024-10-07.
//

import SwiftUI

struct ContentView: View {
    @State private var weatherData: WeatherResponse? // Holds fetched weather data
    @State private var expanded: Bool = false // Track card expansion
    @State private var weatherCondition: String = "Clear" // Weather condition for background

    var body: some View {
        ZStack {
            // Dynamic Background
            dynamicBackground(for: weatherCondition)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                if let weather = weatherData {
                    // Main Weather View
                    mainWeatherView(city: weather.name, temp: weather.main.temp, description: weather.weather.first?.description ?? "")
                    
                    Spacer()
                    
                    // Additional Weather Info (Wind, UV Index, etc.)
                    additionalWeatherInfoView()

                    // Expandable Hourly Forecast
                    ScrollView {
                        VStack(spacing: 20) {
                            Text("Hourly Forecast")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(.white)
                                .padding(.bottom, 10)

                            hourlyForecastView()
                                .onTapGesture {
                                    // Expand or collapse the hourly forecast view
                                    withAnimation {
                                        expanded.toggle()
                                    }
                                }

                            if expanded {
                                expandedHourlyForecastView()
                            }
                        }
                        .padding(.horizontal)
                    }

                    Spacer()
                    
                    // Tomorrow Forecast
                    futureForecastView()
                        .padding(.bottom, 30)
                } else {
                    Text("Loading...")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                }
            }
            .padding()
        }
        .onAppear {
            fetchWeatherData(city: "London")
        }
    }

    // MARK: Dynamic Background based on weather condition
    func dynamicBackground(for condition: String) -> some View {
        switch condition {
        case "Clear":
            return AnyView(
                Image("clearBackground")
                    .resizable()
                    .scaledToFill()
            )
        case "Clouds":
            return AnyView(
                Image("cloudyBackground")
                    .resizable()
                    .scaledToFill()
            )
        case "Rain":
            return AnyView(
                Image("rainyBackground")
                    .resizable()
                    .scaledToFill()
            )
        default:
            return AnyView(
                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom)
            )
        }
    }

    // MARK: Main Weather View
    func mainWeatherView(city: String, temp: Double, description: String) -> some View {
        VStack(spacing: 8) {
            Text(city)
                .font(.system(size: 30, weight: .medium))
                .foregroundColor(.white)

            Text("\(String(format: "%.1f", temp))°C")
                .font(.system(size: 80, weight: .bold))
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.2), radius: 4, x: 2, y: 2)

            Text(description)
                .font(.system(size: 22, weight: .regular))
                .foregroundColor(.white)
        }
    }

    // MARK: Additional Weather Info View
    func additionalWeatherInfoView() -> some View {
        HStack(spacing: 20) {
            VStack {
                Image(systemName: "wind")
                    .foregroundColor(.white)
                Text("14 km/h")
                    .foregroundColor(.white)
            }

            VStack {
                Image(systemName: "sun.max.fill")
                    .foregroundColor(.white)
                Text("UV 2")
                    .foregroundColor(.white)
            }

            VStack {
                Image(systemName: "cloud.rain.fill")
                    .foregroundColor(.white)
                Text("Precipitation 0.9mm")
                    .foregroundColor(.white)
            }
        }
        .padding()
        .background(Color.white.opacity(0.2))
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
    }

    // MARK: Hourly Forecast View
    func hourlyForecastView() -> some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color.white.opacity(0.2))
            .frame(height: 150)
            .overlay(
                HStack(spacing: 20) {
                    HourlyForecastCell(time: "05:00 AM", icon: "sun.max.fill", temperature: "23")
                    HourlyForecastCell(time: "06:00 AM", icon: "cloud.fill", temperature: "20")
                    HourlyForecastCell(time: "07:00 AM", icon: "cloud.rain.fill", temperature: "17")
                }
            )
            .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
    }

    // MARK: Expanded Hourly Forecast View
    func expandedHourlyForecastView() -> some View {
        VStack(spacing: 20) {
            ForEach(8..<12, id: \.self) { hour in
                HourlyForecastCell(time: "\(hour):00 AM", icon: "cloud.rain.fill", temperature: "\(15 + hour)")
            }
        }
        .transition(.slide)
    }

    // MARK: Tomorrow Forecast View
    func futureForecastView() -> some View {
        VStack(alignment: .leading) {
            Text("Tomorrow")
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(.white)
                .padding(.bottom, 10)

            HStack(spacing: 20) {
                WeatherDetailCell(title: "Wind", value: "14 km/h", icon: "wind")
                WeatherDetailCell(title: "UV Index", value: "2", icon: "sun.max.fill")
                WeatherDetailCell(title: "Precipitation", value: "0.9mm", icon: "cloud.rain.fill")
            }
        }
        .padding()
        .background(Color.white.opacity(0.2))
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
    }

    // MARK: Fetch Weather Data
    func fetchWeatherData(city: String) {
        let apiKey = "678e5c43eea895a3b2a5720619a31af9"
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"

        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data) {
                    DispatchQueue.main.async {
                        self.weatherData = decodedResponse
                        self.weatherCondition = decodedResponse.weather.first?.main ?? "Clear"
                    }
                }
            }
        }.resume()
    }
}

// MARK: Hourly Forecast Cell View
struct HourlyForecastCell: View {
    var time: String
    var icon: String
    var temperature: String

    var body: some View {
        VStack {
            Text(time)
                .foregroundColor(.white)
                .font(.system(size: 18, weight: .medium))
            Image(systemName: icon)
                .foregroundColor(.white)
                .font(.title2)
            Text("\(temperature)°C")
                .foregroundColor(.white)
                .font(.system(size: 18, weight: .regular))
        }
    }
}

// MARK: Weather Detail Cell View
struct WeatherDetailCell: View {
    var title: String
    var value: String
    var icon: String

    var body: some View {
        VStack {
            Image(systemName: icon)
                .foregroundColor(.white)
                .font(.title2)
            Text(title)
                .foregroundColor(.white)
                .font(.caption)
            Text(value)
                .foregroundColor(.white)
                .font(.title3)
        }
    }
}


