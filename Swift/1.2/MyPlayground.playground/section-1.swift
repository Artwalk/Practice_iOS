// Playground - noun: a place where people can play

import UIKit

var myVariable = 42
myVariable = 50

let myConstant = 43

let implicitInteger = 70
let implicitDouble = 70.0

let explicitDouble:Double = 70

let label = "The width is"
let width = 94
let widthLabel = label + " " + String( 94)

let apples = 3
let oranges = 5
let appleSummary = "I have \(apples + oranges)."

var shoppingList = ["catfish", "water", "tulips", "blue paint"]
shoppingList[1] = "bottle of water"

var occupations = ["Malcolm":"Captain", "Kaylee":"Mechanic"]
occupations["Jayne"] = "Public Relations"
occupations["Captain"]

let emptyArray = [String]()
let emptyDict = Dictionary<String, Float>()

shoppingList = []
occupations = [:]

let individualScores = [75, 43, 103, 87, 12]
var teamScore = 0
for score in individualScores {
    if score > 50 {
        teamScore += 3
    } else {
        teamScore += 1
    }
}
teamScore

var optionalString: String? = "Hello"
optionalString = nil

if let string = optionalString {
    optionalString = "Hello, \(string)"
}

// switch
let vegetable = "red pepper"
switch vegetable {
    case "celery":
    "hehe"
case let x where x.hasPrefix("rea"):
    "OK"
default:
    "end"
}

// forin
let interestingNumbers = [
    "Prime": [2, 3, 5, 7, 11, 13],
    "Fibonacci": [1, 1, 2, 3, 5, 8],
    "Square": [1, 4, 9, 16, 25],
]
var largest = 0
for (kind, numbers) in interestingNumbers {
    for number in numbers {
        if number > largest {
            largest = number
        }
    }
}
largest

// while
var n = 2
while n < 100 {
    n = n * 2
}
n

var m = 2
do {
m = m * 2
} while m < 100
m


var firstForLoop = 0
for i in 0...1 {
    firstForLoop += i
}
firstForLoop

// func
func greet(name:String, day:String) -> String {
    return "Hello \(name), today is \(day)"
}
greet("Art", "Sunday")

func getGasPrices() -> (Double, Double, Double) {
    return (3.32, 3124.32, 32.34)
}
getGasPrices()

func sumOf( numbers:Int...) -> Int {
    var sum = 0
    for number in numbers {
        sum += number
    }
    return sum
}

sumOf()
sumOf(23,43125,31513)

func returnFifteen () -> Int {
    var y = 10
    func add () {
        y += 5
    }
    
    add()
    return y
}
returnFifteen()

func makeIncrementer () -> (Int -> Int) {
    func addOne(number: Int) -> Int {
        return 1+number
    }
    
    return addOne
}
var increment = makeIncrementer()
increment(8)

func hasAnyMatches(list: [Int], condition:Int -> Bool) -> Bool {
    for item in list {
        if condition (item) {
            return true
        }
    }
    return false
}
func lessThanTen(number: Int) -> Bool {
    return number < 10
}
var numbers = [10, 345, 1, 134, -2]
hasAnyMatches(numbers, lessThanTen)

numbers.map({
    (number:Int) -> Int in
    let result = 3 * number
    return result
})

sort(&numbers) {$0 > $1}
numbers


// class
class Shape {
    var numberOfSides = 0
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}

var shape = Shape()
shape.numberOfSides = 7
shape.simpleDescription()

class NamedShape {
    var numberOfSides: Int = 0
    var name: String
    
    init(name:String) {
        self.name = name
    }
    
    func simpleDescription() -> String {
        return "A \(self.name) with \(numberOfSides) sides."
    }
}

var namedShape = NamedShape(name: "hehe")
namedShape.simpleDescription()

class Square:NamedShape {
    var sideLength: Double
    
    init(sideLength: Double, name:String) {
        self.sideLength = sideLength
        super.init(name:name)
        numberOfSides = 4
    }
    
    func area() -> Double {
        return sideLength * sideLength
    }
    
    override func simpleDescription() -> String {
        return "A square with sides of length \(sideLength)."
    }
}
let test = Square(sideLength: 5.2, name: "my test square")
test.area()
test.simpleDescription()

class EquilateralTriangle:NamedShape {
    var sideLength:Double = 0.0
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 3
    }
    
    var perimeter: Double {
        get {
            return 3.0 * sideLength
        }
        set {
            sideLength = newValue / 3.0
        }
    }
    
    override func simpleDescription() -> String {
        return "An equilateral triagle with sides of length \(sideLength)."
    }
    
}
var triangle = EquilateralTriangle(sideLength: 3.1, name: "a triangle")
triangle.perimeter
triangle.perimeter = 9.9
triangle.sideLength

class TriangleAndSquare {
    var triangle: EquilateralTriangle {
        willSet {
                square.sideLength = newValue.sideLength
            }
    }
    var square: Square {
        willSet {
            triangle.sideLength = newValue.sideLength
        }
    }
    
    init(size: Double, name:String) {
        square = Square(sideLength: size, name: name)
        triangle = EquilateralTriangle(sideLength: size, name: name)
    }
}
var triangleAndSquare = TriangleAndSquare(size: 10, name: "another test shape")
triangleAndSquare.square.sideLength
triangleAndSquare.triangle.sideLength
triangleAndSquare.square = Square(sideLength: 50, name: "larger square")
triangleAndSquare.triangle.sideLength

class Counter {
    var count: Int = 0
    func incrementBy (amount: Int, numberOfTime times:Int) {
        count += amount * times
    }
}
var counter = Counter()
counter.incrementBy(2, numberOfTime: 7)

var optionalSquare:Square? = Square(sideLength: 2.5, name: "optional square")
optionalSquare? = Square(sideLength: 11.5, name: "optional square")
let sideLength = optionalSquare?.sideLength

// enum
enum Rank: Int {
    case Ace = 1
    case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
    case Jack, Queen, King
    func simpleDescription () -> String {
        switch self {
        case .Ace:
            return "ace"
        case .Jack:
            return "jack"
        case .Queen:
            return "queen"
        case .King:
            return "king"
        default:
            return String(self.toRaw())
        }
    }
}

let ace = Rank.Ace
let aceRawValue = ace.toRaw()

if let converteRank = Rank.fromRaw(3) {
    converteRank
    let threeDescription = converteRank.simpleDescription()
}

enum Suit {
    case Spades, Hearts, Diamonds, Clubs
    func simpleDescription() -> String {
        switch self {
        case .Spades:
            return "spades"
        case .Hearts:
            return "hearts"
        case .Diamonds:
            return "diamonds"
        case .Clubs:
            return "clubs"
        }
    }
}

let hearts = Suit.Hearts
let heartsDescription = hearts.simpleDescription()

// struct
struct Card {
    var rank: Rank
    var suit: Suit
    func simpleDescription() -> String {
        return "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
    }
}
let threeOfSpades = Card(rank: .Three, suit: .Spades)
let threeOfSpadesDescription = threeOfSpades.simpleDescription()

enum ServerResponse {
    case Result(String, String)
    case Error(String)
}

let success = ServerResponse.Result("6:00 am", "8:09 pm")
let failure = ServerResponse.Error("Out of cheese.")

switch failure {
case let .Result(sunrise, sunset):
    let serverResponse = "Sunrise is at \(sunrise) and sunset is at \(sunset)."
case let .Error(error):
    let serverResponse = "Failure... \(error)"
}

// protocol
protocol ExampleProtocol {
    var simpleDescription: String { get }
    mutating func adjust()
}

class SimpleClass: ExampleProtocol {
    var simpleDescription: String = "A very simple class."
    var anotherProperty: Int = 68432
    func adjust() {
        simpleDescription += " Now 100% adjusted."
    }
}
var a = SimpleClass()
a.adjust()

let aDescription = a.simpleDescription

struct SimpleStructure: ExampleProtocol {
    var simpleDescription: String = "A simple structure"
    mutating func adjust() {
        simpleDescription += " (adjusted)"
    }
}
var b = SimpleStructure()
b.adjust()
let bDescription = b.simpleDescription


extension Int: ExampleProtocol {
    var simpleDescription: String {
        return "The number \(self)"
    }
    mutating func adjust() {
        self += 42
    }
}
7.simpleDescription

let protocolValue: ExampleProtocol = a
protocolValue.simpleDescription


// <>
func repeat<ItemType> (item:ItemType, times:Int) -> [ItemType] {
    var result = [ItemType]()
    for i in 0..<times {
        result.append(item)
    }
    return result
}
repeat("knock", 4)

enum OptionalValue<T> {
    case None
    case Some(T)
}
var possibleInteger: OptionalValue<Int> = .None
possibleInteger = .Some(100)

func anyCommonElements <T, U where T: SequenceType, U: SequenceType, T.Generator.Element: Equatable, T.Generator.Element == U.Generator.Element> (lhs: T, rhs: U) -> Bool {
    for lhsItem in lhs {
        for rhsItem in rhs {
            if lhsItem == rhsItem {
                return true
            }
        }
    }
    return false
}

anyCommonElements([1, 2 , 5], [4 , 6])