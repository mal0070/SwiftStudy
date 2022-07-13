import UIKit

//저장 프로퍼티
/*struct Student {
    var name: String
    var age: Int
}

var atlas = Student(name: "아틀라스", age: 20)
print(atlas)

*/


//연산 프로퍼티
struct WeeklySalary{
    var hourlyWage: Double
    var workingHours: Double
    
    var wage: Double{
        get{
            return hourlyWage * workingHours
        }
        set{
            workingHours = newValue / hourlyWage //newValue:매개변수
        }
    }
}

var myWeeklySalary = WeeklySalary(hourlyWage: 10000, workingHours: 4) //instance 생성
print(myWeeklySalary)
print(myWeeklySalary.wage)
myWeeklySalary.wage = 50000
print(myWeeklySalary.workingHours)


//프로퍼티 옵저버
struct Student {
    var name: String {
        willSet {
            print("\(name) -> \(newValue)로 변경예정입니다.")
        }
        didSet {
            print("\(oldValue) -> \(name)로 변경되었습니다.") //The special variable newValue only works within willSet, while oldValue only works within didSet.
        }
    }
}


//타입 프로퍼티
struct SomeStruct{
    static var storedTypeProperty = "some value" //(저장프로퍼티)
    static var computedTypeProperty: Int {
        return 1 //(연산프로퍼티)
    }
}

SomeStruct.storedTypeProperty
SomeStruct.computedTypeProperty

print("\(SomeStruct.storedTypeProperty)")
print("\(SomeStruct.computedTypeProperty)")


