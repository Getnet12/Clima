//
//  WeatherManager.swift
//  Clima
//
//  Created by Getnet Mekuriyaw on 1/9/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManger{
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=aa79077f43896452ae50a7a942b97492&units=metric"
    
    func fetchWeather(cityName: String ){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
        
    }
    
    func performRequest(urlString: String){
        //1. Create a URL
        if let url = URL(string: urlString){
            //2. Create a URL Session
            let session = URLSession(configuration: .default)
            //3. Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    print(error!)
                    return
                }
                
                if let safeData = data {
//                    let dataString = String(data: safeData, encoding: .utf8)
//                    print(dataString)
                    // always use self when calling method inside the closure
                    self.parseJson(weatherData: safeData)
                }
            }
            //4. Start the task
            task.resume()
        }
    }
    func parseJson(weatherData: Data){
        
        let decoder = JSONDecoder()
        do {
        let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.weather[0].description)
        } catch {
            print(error)
        }
    }
    
}
