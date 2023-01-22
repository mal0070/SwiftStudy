//
//  CardListViewController.swift
//  CreditCardList
//
//  Created by 이민아 on 2022/08/18.
//

import UIKit
import Kingfisher
import FirebaseDatabase

class CardListViewController: UITableViewController{
    //delegate 기본으로 가지고 있어서 따로 연결 안해도 됨. 루트뷰- 테이블뷰
    var ref: DatabaseReference! //firebase realtime database
    
    var creditCardList : [CreditCard] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UITableView Cell Register
        let nibName = UINib(nibName: "CardListCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "CardListCell")
        
        ref = Database.database().reference()
        
        ref.observe(.value) { [weak self] snapshot in //reference가 snapshot 객체로
            guard let value = snapshot.value as? [String: [String: Any]] else { return }
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: value)
                let cardData = try JSONDecoder().decode([String: CreditCard].self, from: jsonData)
                let cardList = Array(cardData.values)
                self?.creditCardList = cardList.sorted{ $0.rank < $1.rank } //1위부터
                
                //메인 스레드에 데이터 넣어주기
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
            
            } catch let error {
                print("ERROR JSON parsing \(error.localizedDescription)")
            }
        }
    }
    //행 개수 -> 데이터 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creditCardList.count
    }
    //데이터 지정
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CardListCell", for: indexPath) as? CardListCell else {return UITableViewCell()}
        
        cell.rankLabel.text = "\(creditCardList[indexPath.row].rank)위"
        cell.promotionLabel.text = "\(creditCardList[indexPath.row].promotionDetail.amount)만원 증정"
        cell.cardNameLabel.text = "\(creditCardList[indexPath.row].name)"
        
        let imageURL = URL(string: creditCardList[indexPath.row].cardImgURL)
        cell.cardImageView.kf.setImage(with: imageURL)
        
        return cell
    }
    //높이
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    //각 셀을 클릭했을 때, 상세화면 전달
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let detailViewController = storyboard.instantiateViewController(withIdentifier: "CardDetailViewController") as? CardDataViewController else {return }
        
        detailViewController.promotionDetail = creditCardList[indexPath.row].promotionDetail
        self.show(detailViewController, sender: nil)
    }
}
