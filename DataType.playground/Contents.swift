import UIKit

var isChecked: Bool = false
isChecked = true

var temperature: Int = -100

var cakes:UInt = 100

var pi:Float = 3.14

var p12:Double = 3.14

var sampleCharacter: Character = "A"

var sampleString:String = "안녕하세요"

//데이터타입을 선언하지 않아도 된다
var test = 100
type(of: test)

//Any: 모든 타입을 지칭하는 키워드
var sampleAny: Any = "any"
sampleAny = 10000
sampleAny = 3.14

//nil: 없음, 존재하지 않음
var sampleInt: Int? = nil //옵셔널로 선언해주어야한다.
type(of: sampleInt)

var sampleString: String? = nil
type(of: sampleString)
