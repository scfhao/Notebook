## 简单值

多行字符串使用三个双引号（`"""`）。只要每行引语开头的缩进与结束引号的缩进一致，这些缩进就会被移除。例如：

```swift
let quotation = """
        Even though there's whitespace to the left,
        the actual lines aren't indented.
            Except for this line.
        Double quotes (") can appear without being escaped.

        I still have \(apples + oranges) pieces of fruit.
        """
```

使用方括号（`[]`）创建数组和字典，并通过在方括号中写入索引或键来访问它们的元素。最后一个元素后面可以加逗号。

你也可以使用括号来编写空数组或字典。对于数组，可写成`[]`；对于字典，可写成`[:]`。如果你要将空数组或字典赋值给新变量，或者赋值到其他没有任何类型信息的地方，就需要指定类型。

```swift
let emptyArray: [String] = []
let emptyDictionary : [String: Float] = [:]
```

## 控制流

你可以在赋值语句的等号（`=`）后面或return后面写上if或switch，以便根据条件选择一个值。

```swift
let scoreDecoration = if teamScore > 10 {
    "🎉"
} else {
    ""
}
print("Score:", teamScore, scoreDecoration)
// Prints "Score: 11 🎉"
```

处理可选值的另一种方法是使用??运算符提供默认值。如果可选值缺失，则会使用默认值。

```swift
let nickname: String? = nil
let fullName: String = "John Appleseed"
let informalGreeting = "Hi \(nickname ?? fullName)"
```

你可以使用更简短的拼写来解包一个值，并为该解包后的值使用相同的名称。

```swift
if let nickname {
    print("Hey, \(nickname)")
}
// Doesn't print anything, because nickname is nil.
```

`Switch`支持任何类型的数据和各种各样的比较操作——它们不仅限于整数和相等性测试。

```swift 
let vegetable = "red pepper"
switch vegetable {
case "celery":
    print("Add some raisins and make ants on a log.")
case "cucumber", "watercress":
    print("That would make a good tea sandwich.")
case let x where x.hasSuffix("pepper"):
    print("Is it a spicy \(x)?")
default:
    print("Everything tastes good in soup.")
}
// Prints "Is it a spicy red pepper?"
```

你可以使用for-in通过提供一对名称来迭代字典中的项，这对名称用于表示每个键值对。字典是无序集合，因此其键和值会以不确定顺序被迭代。

```swift
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
print("The largest number is \(largest).")
// Prints "The largest number is 25."
```

使用while来重复执行一段代码，直到条件发生变化。循环的条件也可以放在末尾，这样可以确保循环至少执行一次。

```swift
var n = 2
while n < 100 {
    n *= 2
}
print(n)
// Prints "128"


var m = 2
repeat {
    m *= 2
} while m < 100
print(m)
// Prints "128"
```

你可以通过使用`..<`创建索引范围，在循环中保留索引。

```swift
for i in 0..<5 {
    print(i)
}
// Prints "0 1 2 3 4"
```

使用..<创建一个不包含上限值的范围，使用...创建一个包含两个值的范围。

## 函数和闭包

默认情况下，函数会将其参数名称用作参数的标签。在参数名称前编写自定义参数标签，或者使用“_”来不使用参数标签。

```swift
func greet(_ person: String, on day: String) -> String {
    return "Hello \(person), today is \(day)."
}
greet("John", on: "Wednesday")
```

使用元组来创建复合值，例如从函数中返回多个值。元组的元素既可以通过名称也可以通过编号来引用。

```swift
func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) {
    var min = scores[0]
    var max = scores[0]
    var sum = 0

    for score in scores {
        if score < min {
            min = score
        }
        if score > max {
            max = score
        }
        sum += score
    }
    return (min, max, sum)
}
let statistics = calculateStatistics(scores: [5, 3, 100, 3, 9])
print(statistics.sum)
// Prints "120"
print(statistics.2)
// Prints "120"
```

函数可以嵌套。嵌套函数可以访问在外部函数中声明的变量。你可以使用嵌套函数来组织较长或较复杂的函数中的代码。

```swift
func returnFifteen() -> Int {
    var y = 10
    func add() {
        y += 5
    }
    add()
    return y
}
returnFifteen()
```

函数是一种一等类型。这意味着一个函数可以返回另一个函数作为其值。

```swift
func makeIncrementer() -> ((Int) -> Int) {
    func addOne(number: Int) -> Int {
        return 1 + number
    }
    return addOne
}
var increment = makeIncrementer()
increment(7)
```

函数也可以作为另一个函数的参数。

函数实际上是闭包的一种特殊情况：闭包是可以在之后被调用的代码块。闭包中的代码能够访问在创建闭包的作用域中可用的变量和函数等内容，即便闭包在执行时处于不同的作用域中——你已经在嵌套函数中见过这样的例子了。你可以通过用花括号（{}）包裹代码来编写一个没有名称的闭包。使用in来将参数和返回类型与函数体分隔开。

```swift
numbers.map({ (number: Int) -> Int in
    let result = 3 * number
    return result
})
```

在更简洁地编写闭包方面，你有多种选择。当闭包的类型已知时（例如作为委托的回调），你可以省略其参数类型、返回类型，或者两者都省略。单语句闭包会隐式返回其唯一语句的值。

```swift
let mappedNumbers = numbers.map({ number in 3 * number })
print(mappedNumbers)
// Prints "[60, 57, 21, 36]"
```

你可以通过编号而非名称来引用参数——这种方法在极短的闭包中尤其有用。作为函数最后一个参数传入的闭包可以直接出现在括号之后。当闭包是函数的唯一参数时，你可以完全省略括号。

```swift
let sortedNumbers = numbers.sorted { $0 > $1 }
print(sortedNumbers)
// Prints "[60, 57, 36, 21]"
```

## 对象和类

```swift
class NamedShape {
    var numberOfSides: Int = 0
    var name: String

    // 构造方法样式
    init(name: String) {
       self.name = name
    }

    func simpleDescription() -> String {
       return "A shape with \(numberOfSides) sides."
    }
}
```

创建类的实例时，初始化器的参数会像函数调用一样被传递。每个属性都需要被赋值——要么在其声明中（如numberOfSides），要么在初始化器中（如name）。

如果需要在对象被释放前执行一些清理操作，可以使用`deinit`来创建析构函数。

子类中重写超类实现的方法会用`override`标记——如果意外重写了某个方法却没有使用`override`，编译器会将其检测为错误。编译器还会检测带有`override`但实际上并未重写超类中任何方法的情况。

除了存储的简单属性外，属性还可以有一个获取器和一个设置器。

```swift
class EquilateralTriangle: NamedShape {
    var sideLength: Double = 0.0

    /**
     初始化器有三个不同的步骤：
     1. 设置子类声明的属性值。
     2. 调用超类的初始化器。
     3. 更改超类定义的属性值。此时也可以完成任何使用方法、获取器或设置器的额外设置工作。
     */
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
        return "An equilateral triangle with sides of length \(sideLength)."
    }
}
var triangle = EquilateralTriangle(sideLength: 3.1, name: "a triangle")
print(triangle.perimeter)
// Prints "9.3"
triangle.perimeter = 9.9
print(triangle.sideLength)
// Prints "3.3000000000000003"
```

在`perimeter`的设置器中，新值有一个隐式名称`newValue`。你可以在`set`后面的括号中提供一个显式名称。

如果你不需要计算属性，但仍需要提供在设置新值前后运行的代码，请使用willSet和didSet。你提供的代码会在值在初始化器外部发生任何变化时运行。例如，下面的类确保其三角形的边长始终与其正方形的边长相同。

## 枚举和结构体

使用enum来创建一个枚举类型。与类和所有其他命名类型一样，枚举类型可以有与之关联的方法。

```swift
enum Rank: Int {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king

    func simpleDescription() -> String {
        switch self {
        case .ace:
            return "ace"
        case .jack:
            return "jack"
        case .queen:
            return "queen"
        case .king:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}
let ace = Rank.ace
let aceRawValue = ace.rawValue
```

使用`init?(rawValue:)`初始化器从原始值创建枚举的实例。它会返回与原始值匹配的枚举情况，或者如果没有匹配的`Rank`，则返回nil。

```swift
if let convertedRank = Rank(rawValue: 3) {
    let threeDescription = convertedRank.simpleDescription()
}
```

如果枚举具有原始值，这些值在声明时就已确定，这意味着特定枚举情况的每个实例始终具有相同的原始值。枚举情况的另一种选择是让情况关联值——这些值在创建实例时确定，并且对于枚举情况的每个实例而言可能各不相同。你可以将关联值视为类似于枚举情况实例的存储属性。例如，考虑从服务器请求日出和日落时间的情况。服务器要么返回请求的信息，要么返回错误原因的描述。

```swift
enum ServerResponse {
    case result(String, String)
    case failure(String)
}

let success = ServerResponse.result("6:00 am", "8:09 pm")
let failure = ServerResponse.failure("Out of cheese.")

switch success {
case let .result(sunrise, sunset):
    print("Sunrise is at \(sunrise) and sunset is at \(sunset).")
case let .failure(message):
    print("Failure...  \(message)")
}
// Prints "Sunrise is at 6:00 am and sunset is at 8:09 pm."
```

## 并发

使用async标记异步运行的函数。

```swift
func fetchUserID(from server: String) async -> Int {
    if server == "primary" {
        return 97
    }
    return 501
}
```

你可以通过在异步函数调用前加上await来标记它。

```swift
func fetchUsername(from server: String) async -> String {
    let userID = await fetchUserID(from: server)
    if userID == 501 {
        return "John Appleseed"
    }
    return "Guest"
}
```

使用`async let`调用异步函数，使其与其他异步代码并行运行。当你使用它返回的值时，请编写`await`。

```swift
func connectUser(to server: String) async {
    async let userID = fetchUserID(from: server)
    async let username = fetchUsername(from: server)
    let greeting = await "Hello \(username), user ID \(userID)"
    print(greeting)
}
```

使用Task从同步代码中调用异步函数，无需等待它们返回。

```swift
Task {
    await connectUser(to: "primary")
}
```

使用`TaskGroup`来构建并发代码。

```swift
let userIDs = await withTaskGroup(of: Int.self) { group in
    for server in ["primary", "secondary", "development"] {
        group.addTask {
            return await fetchUserID(from: server)
        }
    }

    var results: [Int] = []
    for await result in group {
        results.append(result)
    }
    return results
}
```

actors类似于类，不同之处在于它们确保不同的异步函数可以同时安全地与同一个actor的实例进行交互。

```swift
actor ServerConnection {
    var server: String = "primary"
    private var activeUsers: [Int] = []
    func connect() async -> Int {
        let userID = await fetchUserID(from: server)
        // ... communicate with server ...
        activeUsers.append(userID)
        return userID
    }
}
```

当你在一个参与者上调用方法或访问其某个属性时，需要用`await`标记该代码，以表明它可能需要等待该参与者上已在运行的其他代码完成。

```swift
let server = ServerConnection()
let userID = await server.connect()
```

## 协议与扩展

类、枚举和结构体都可以遵循协议。

```swift
class SimpleClass: ExampleProtocol {
     var simpleDescription: String = "A very simple class."
     var anotherProperty: Int = 69105
     func adjust() {
          simpleDescription += "  Now 100% adjusted."
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
```

注意在SimpleStructure的声明中使用了mutating关键字，以标记会修改该结构体的方法。SimpleClass的声明则不需要将其任何方法标记为mutating，因为类的方法始终可以修改类。

使用extension为现有类型添加功能，例如新方法和计算属性。你可以使用扩展为在其他地方声明的类型，甚至是从库或框架中导入的类型添加协议一致性。

当你处理类型为装箱协议类型的值时，协议定义之外的方法是不可用的。

```swift
let protocolValue: any ExampleProtocol = a
print(protocolValue.simpleDescription)
// Prints "A very simple class.  Now 100% adjusted."
// print(protocolValue.anotherProperty)  // Uncomment to see the error
```

## 错误处理

你可以使用任何遵循`Error`协议的类型来表示错误。

```swift
enum PrinterError: Error {
    case outOfPaper
    case noToner
    case onFire
}
```

使用throw抛出错误，使用throws标记可能抛出错误的函数。如果在函数中抛出错误，该函数会立即返回，由调用该函数的代码来处理这个错误。

```swift
func send(job: Int, toPrinter printerName: String) throws -> String {
    if printerName == "Never Has Toner" {
        throw PrinterError.noToner
    }
    return "Job sent"
}
```

处理错误有多种方法。一种方法是使用`do-catch`。在`do`块内部，你可以在可能抛出错误的代码前加上`try`来标记它。在`catch`块内部，错误会自动被命名为`error`，除非你给它指定一个不同的名称。

```swift
do {
    let printerResponse = try send(job: 1040, toPrinter: "Bi Sheng")
    print(printerResponse)
} catch {
    print(error)
}
// Prints "Job sent"
```

你可以提供多个`catch`块来处理特定错误。就像在`switch`语句中的`case`后面那样，你要在`catch`后面写一个模式。

```swift
do {
    let printerResponse = try send(job: 1040, toPrinter: "Bi Sheng")
    print(printerResponse)
} catch PrinterError.onFire {
    print("I'll just put this over here, with the rest of the fire.")
} catch let printerError as PrinterError {
    print("Printer error: \(printerError).")
} catch {
    print(error)
}
// Prints "Job sent"
```

处理错误的另一种方法是使用`try?`将结果转换为可选类型。如果函数抛出错误，具体的错误会被丢弃，结果为 nil。否则，结果是一个包含该函数返回值的可选类型。

```swift
let printerSuccess = try? send(job: 1884, toPrinter: "Mergenthaler")
let printerFailure = try? send(job: 1885, toPrinter: "Never Has Toner")
```

使用`defer`来编写一块代码，它会在函数中所有其他代码执行完毕后、函数返回之前执行。无论函数是否抛出错误，这段代码都会执行。你可以使用`defer`将设置代码和清理代码写在一起，即便它们需要在不同的时间执行。

```swift
var fridgeIsOpen = false
let fridgeContent = ["milk", "eggs", "leftovers"]

func fridgeContains(_ food: String) -> Bool {
    fridgeIsOpen = true
    defer {
        fridgeIsOpen = false
    }

    let result = fridgeContent.contains(food)
    return result
}
if fridgeContains("banana") {
    print("Found a banana")
}
print(fridgeIsOpen)
// Prints "false"
```

## 泛型

在尖括号内写入一个名称，以创建泛型函数或类型。

```swift
func makeArray<Item>(repeating item: Item, numberOfTimes: Int) -> [Item] {
    var result :[Item] = []
    for _ in 0..<numberOfTimes {
        result.append(item)
    }
    return result
}
makeArray(repeating: "knock", numberOfTimes: 4)
// Returns ["knock", "knock", "knock", "knock"]
```

你可以创建函数、方法以及类、枚举和结构的泛型形式。

```swift
// Reimplement the Swift standard library's optional type
enum OptionalValue<Wrapped> {
    case none
    case some(Wrapped)
}
var possibleInteger: OptionalValue<Int> = .none
possibleInteger = .some(100)
```

在主体前使用`where`来指定一系列要求——例如，要求某个类型实现某个协议、要求两种类型相同，或者要求某个类具有特定的超类。

```swift
func anyCommonElements<T: Sequence, U: Sequence>(_ lhs: T, _ rhs: U) -> Bool
    where T.Element: Equatable, U.Element == T.Element
{
    for lhsItem in lhs {
        for rhsItem in rhs {
            if lhsItem == rhsItem {
                return true
            }
        }
    }
    return false
}
print(anyCommonElements([1, 2, 3], [3]))
// Prints "true"
```

编写`<T: Equatable>`与编写`<T> ... where T: Equatable`是一样的。
