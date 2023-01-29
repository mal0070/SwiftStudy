//
//  ViewController.swift
//  SubwayStation
//
//  Created by 이민아 on 2023/01/28.
//
import Alamofire
import UIKit
import SnapKit

class StationSearchViewController: UIViewController {
    //private var numberOfCell: Int = 0 //tableview cell 개수 초기화를 해야 search bar가 뜸
    private var stations: [Station] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItems()
        setTableViewLayout()
        
        //requestStationName()
    }
    
    private func setNavigationItems(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "지하철 도착 정보"
        
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "지하철 역을 입력해주세요."
        searchController.obscuresBackgroundDuringPresentation = false //true -> 회색
        searchController.searchBar.delegate =  self
        
        navigationItem.searchController = searchController
    }
    
    private func setTableViewLayout(){
        view.addSubview(tableView)
        tableView.snp.makeConstraints{ $0.edges.equalToSuperview() }
    }
    
    
    //네트워크
    private func requestStationName(from stationName: String) {
        //let urlString = "http://openapi.seoul.go.kr:8088/sample/json/SearchInfoBySubwayNameService/1/5/서울역" //한글 -> 깨짐 -> addingPercentEncoding
        let urlString = "http://openapi.seoul.go.kr:8088/sample/json/SearchInfoBySubwayNameService/1/5/\(stationName)"
        AF.request(urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "").responseDecodable(of: StationResponseModel.self) { [weak self] response in //weak -> optional
            guard
                let self = self, //옵셔널 체이닝
                case .success(let data) = response.result else { return }
            
            //print(data.stations)
            
            self.stations = data.stations
            self.tableView.reloadData() //closure 안에 self를 사용할 땐 꼭 weak self -> 안하면 앱이 죽을 수 있음
        } //비동기처리: 통신+print 동시에
        .resume() //통신 개시
    }
}

//서치바에 입력할 때만 테이블 뷰 표시되게
extension StationSearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        //numberOfCell = 10
        tableView.reloadData() //데이터를 꼭 다시 불러와야함
        tableView.isHidden = false
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
       //numberOfCell = 0
        tableView.isHidden = true
        stations = [] //이전에 검색했던 역 남아있음 -> 삭제
    }
    
    //서치바에 실시간으로 한글자씩 입력할 때마다 동작
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        requestStationName(from: searchText)
    }
}

extension StationSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let station = stations[indexPath.row]
        let vc = StationDetailViewController(station: station)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension StationSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return numberOfCell
        return stations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        let station = stations[indexPath.row]
        cell.textLabel?.text = station.stationName
        cell.detailTextLabel?.text = station.lineName
       
        //cell.textLabel?.text = "\(indexPath.item)"
        return cell
    }
    
    
}
