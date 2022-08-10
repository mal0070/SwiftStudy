//
//  ViewController.swift
//  Weather
//
//  Created by 이민아 on 2022/08/11.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var weatherStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func tapFetchWeatherButton(_ sender: Any) {
        if let cityName = self.cityNameTextField.text {
            self.getCurrentWeather(cityName: cityName)
            self.view.endEditing(true) //버튼이 눌리면 키보드가 사라지도록
        }
    }
    
    func configureView(weatherInformation: WeatherInformation){
        self.cityNameLabel.text = weatherInformation.name
        if let weather = weatherInformation.weather.first { //배열의 첫번째 요소부터 넣기 위해
            self.weatherDescriptionLabel.text = weather.description
        }
        self.tempLabel.text = "\(Int(weatherInformation.temp.temp - 273.15))℃"
        self.minTempLabel.text = "최저: \(Int(weatherInformation.temp.minTemp - 273.15)) ℃"
        self.maxTempLabel.text = "최고: \(Int(weatherInformation.temp.minTemp - 273.15)) ℃"
    }
    
    func getCurrentWeather(cityName: String){
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=3bb7f416a0be629ff6bf6abae119e4c1") else { return }
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { [weak self] data, response, error in //weak self: 순환참조 해결
            guard let data = data, error == nil else { return }
            let decoder = JSONDecoder() //json 객체에서 데이터로!
            guard let weatherInformation = try? decoder.decode(WeatherInformation.self, from: data) else {return} //try? -> decoding에 실패하면 error
            //debugPrint(weatherInformation)
            
            //네트워크 작업은 별도의 스레드에서 진행된다. 따라서 메인스레드에서 작업가능하도록
            DispatchQueue.main.async {
                self?.weatherStackView.isHidden = false
                self?.configureView(weatherInformation: weatherInformation)
            }
            }.resume() //작업실행
    }

}

