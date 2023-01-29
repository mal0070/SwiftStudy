//
//  StationDetailViewController.swift
//  SubwayStation
//
//  Created by 이민아 on 2023/01/28.
//
import Alamofire
import SnapKit
import UIKit

final class StationDetailViewController: UIViewController {
    
    private let station: Station
    private var realtimeArrivalList: [StationArrivalModel.RealTimeArrival] = []
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(fetchData), for: .valueChanged) //리프레시->값이 바뀌었을 때 추가
        return refreshControl
    }()
    
    @objc private func fetchData() {
        //print("refresh")
        //refreshControl.endRefreshing()
        
       // let stationName = "서울역"
        let stationName = station.stationName
        
        //let urlString = "http://swopenapi.seoul.go.kr/api/subway/sample/json/realtimeStationArrival/0/5/왕십리"
        let urlString = "http://swopenapi.seoul.go.kr/api/subway/sample/json/realtimeStationArrival/0/5/\(stationName.replacingOccurrences(of: "역", with: ""))" //"역" 글자를 떼서 인식하게
        
        AF.request(urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
            .responseDecodable(of: StationArrivalModel.self) { [weak self]response in //weak: 클로저-> 메모리이슈
                
                self?.refreshControl.endRefreshing() //서버연결 성공, 실패와 상관없이 새로고침 끝내야하니까
                guard case .success(let data) = response.result else { return }//success 일때만 결과 리턴
                
                //print(data.realtimeArrivalList)
                self?.realtimeArrivalList = data.realtimeArrivalList
                self?.collectionView.reloadData()
            }
            .resume()
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(
            width: view.frame.width - 32.0, height: 100.0)
        layout.sectionInset = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(StationDetailCollectionViewCell.self, forCellWithReuseIdentifier: "StationDetailCollectionViewCell")
        collectionView.dataSource = self
        
        collectionView.refreshControl = refreshControl
        
        return collectionView
    }()
    
    init(station: Station){
        self.station = station
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // navigationItem.title = "왕십리"
        navigationItem.title = station.stationName
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints{ $0.edges.equalToSuperview() }
        
        fetchData()
    }

}

extension StationDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //3
        return realtimeArrivalList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StationDetailCollectionViewCell", for: indexPath) as? StationDetailCollectionViewCell
        
        let realTimeArrival = realtimeArrivalList[indexPath.row]
        cell?.setup(with: realTimeArrival)
        
        return cell ?? UICollectionViewCell()
    }
    
    
}
