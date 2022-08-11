//
//  ViewController.swift
//  COVID19
//
//  Created by 이민아 on 2022/08/11.
//

import UIKit
import Charts
import Alamofire

class ViewController: UIViewController {

   
    @IBOutlet weak var totalCaseLabel: UILabel!
    @IBOutlet weak var newCaseLabel: UILabel!
    @IBOutlet weak var pieChartView: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchCovidOverView(completionHandler: { [weak self] result in
            guard let self = self else {return}
            switch result{
            case let .success(result):
                //debugPrint("success \(result)")
                self.configureStackView(koreaCovidOverview: result.korea)
                let covidOverviewList = self.makeCovidOverviewList(cityCovidOverview: result)
                self.configureChartView(covidOverviewList: covidOverviewList)
            case let .failure(error):
                debugPrint("error \(error)")
            }
        })
    }
    
    func makeCovidOverviewList(cityCovidOverview: CityCovidOverView) -> [CovidOverView] {
        return [
            cityCovidOverview.seoul,
            cityCovidOverview.busan,
            cityCovidOverview.daegu,
            cityCovidOverview.incheon,
            cityCovidOverview.gwangju,
            cityCovidOverview.daejeon,
            cityCovidOverview.ulsan,
            cityCovidOverview.sejong,
            cityCovidOverview.gyeonggi,
            cityCovidOverview.chungbuk,
            cityCovidOverview.chungnam,
            cityCovidOverview.gyeongbuk,
            cityCovidOverview.gyeongnam,
            cityCovidOverview.gangwon,
            cityCovidOverview.jeju
            ]
    }
    
    func configureChartView(covidOverviewList: [CovidOverView]){
        let entries = covidOverviewList.compactMap{ [weak self] overview -> PieChartDataEntry? in //json 을 pieChart 객체로 바꾸는 작업
            guard let self = self else { return nil }
            return PieChartDataEntry(value: self.removeFormatString(string: overview.newCase), label: overview.countryName, data: overview) //value 는 double만 가능.
        }
        let dataSet = PieChartDataSet(entries: entries, label: "코로나 발생 현황")
        self.pieChartView.data = PieChartData(dataSet: dataSet)

    }
    
    //string -> double
    func removeFormatString(string: String) -> Double {
        let fomatter = NumberFormatter()
        fomatter.numberStyle = .decimal //세자리 마다 ,
        return fomatter.number(from: string)?.doubleValue ?? 0 //nil이면 0이 되게
        
    }
    
    
    
    
    
    func configureStackView(koreaCovidOverview: CovidOverView){
        self.totalCaseLabel.text = "\(koreaCovidOverview.totalCase) 명"
        self.newCaseLabel.text = "\(koreaCovidOverview.newCase) 명"
    }
    
    func fetchCovidOverView(completionHandler: @escaping (Result<CityCovidOverView, Error>) -> Void){ //api 호출 성공시 CityCovidOverView 전달, 실패시 Error (alamofire)
        let url = "https://api.corona-19.kr/korea/country/new/"
        let param = [
            "serviceKey": "qhWxG7Z4NISwPUzc2X3vftjF6MOs5rkDu" //발급받은 api키 (딕셔너리 형태로 정의)
        ]
        
        AF.request(url, method: .get, parameters: param) //데이터요청
            .responseData(completionHandler: { response in
                switch response.result{ //응답결과가 여기에 저장됨
                case let .success(data): //요청성공
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(CityCovidOverView.self, from: data)
                        completionHandler(.success(result))
                    } catch{ //json데이터가 cityCovidOverView로 mapping 실패했을 때
                        completionHandler(.failure(error))
                    }
                case let .failure(error): //요청 실패
                    completionHandler(.failure(error))
                }
            })
    }

}

