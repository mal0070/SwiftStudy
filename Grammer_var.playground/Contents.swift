import UIKit

/*변수
 var 변수명: 데이터타입 = 값
 */
var name: String = "Atlas"
var age: Int = 20

name
name = "아틀라스"

/*상수
 let 상수명: 데이터타입 = 값*/
let one: Int = 1
let two: Int = 2


/*함수
 func 함수명(파라미터이름: 데이터타입)-> 반환타입{
    //코드
    return 반환값
 }
 */

func sayHello(name: String)->String{
    return "Nice to meet you, \(name)"
}

sayHello(name: "아틀라스")


func introduce(name:String, age:Int)->String{
    return "Hi, my name is \(name), I'm \(age)"
}

introduce(name: name, age: age)


func add(a:Int, b:Int)->Int{
    return a+b
}

add(a:2,b:3)
