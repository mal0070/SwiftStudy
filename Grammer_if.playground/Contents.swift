import UIKit

//if
var isChecked = true

if isChecked{
    print("체크되어 있습니다.")
}else{
    print("체크되어 있지않습니다")
}


var time = 10

if time == 9 {
    print("아침식사 시간입니다.")
}else if time == 12{
    print("점심식사 시간입니다.")
}else{
    print("자유시간입니다")
}

//switch

//guard
func getName(name: String?) -> String{
    guard let uname = name else{
        return "이름값이 존재하지 않습니다"
    }
    
    return uname
}

getName(name: "아틀라스")
getName(name: nil)
