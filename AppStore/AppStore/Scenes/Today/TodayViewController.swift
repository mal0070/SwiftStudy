//
//  TodayViewController.swift
//  AppStore
//
//  Created by 이민아 on 2022/11/30.
//
import SnapKit
import UIKit

final class TodayViewController: UIViewController {
    
    //today data 가져오기
    private var todayList: [Today] = [] //텅 빈 배열
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout() //collectionview 는 반드시 layout이 필요하다. 일단 이걸로 초기화 ㅅㅂFlowLayout
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout) //나중에 () 삭제 - snapkit으로 할거니까
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(TodayCollectionViewCell.self, forCellWithReuseIdentifier: "todayCell")
        collectionView.register(TodayCollectionHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "TodayCollectionHeaderView")//collection View Header에 등록
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        fetchData()
    }
}

extension TodayViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return 5
        return todayList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "todayCell", for: indexPath) as? TodayCollectionViewCell
        let today = todayList[indexPath.item] //위치에 맞는 today 표시
        cell?.setup(today: today)
        return cell ?? UICollectionViewCell()
    }
    
    //reusable view(header,footer) 리턴해주는 메소드
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //header 일때만
        guard
            kind == UICollectionView.elementKindSectionHeader,
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "TodayCollectionHeaderView",
                for: indexPath
            ) as? TodayCollectionHeaderView
        else { return UICollectionReusableView()}
        
        header.setupViews()
        return header
                
    }
    
}

extension TodayViewController: UICollectionViewDelegateFlowLayout { //cell의 레이아웃 조정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 32.0 //frame.width: collectionView 전체의 width
        return CGSize(width: width, height: width) //collectionView의 cellSize
    }
    
    //header size 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.frame.width - 32.0, height: 100.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let value: CGFloat = 16.0
        return UIEdgeInsets(top: value, left: value, bottom: value, right: value) //header와 collectionview 사이의 틈 지정
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) { //cell을 선택했을 때
        let today = todayList[indexPath.item] //위치에 맞는 아이템
        let vc = AppDetailViewController(today: today)
        present(vc,animated: true)
    }
}

private extension TodayViewController {
    //plist data 가져오는 코드
    func fetchData(){
        guard let url = Bundle.main.url(forResource: "Today", withExtension: "plist")
        else { return }
        do {
            let data = try Data(contentsOf: url)
            let result = try PropertyListDecoder().decode([Today].self, from: data) //변환
            todayList = result //변수 주입
        }   catch { }
    }
}
//빈번하게 업데이트 될 때 : viewWillAppear에서 이 함수를 부름. 여기서는 그냥 가져오는거니까 레이아웃 설정 완료되면 부르게 코드 씀.
//cell에서 이제 가져온 데이터를 업데이트 해야하므로 -> cell 파일에 가서 cell.setup(today: Today)
