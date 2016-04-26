import UIKit

/*
SOLID это аббревиатура пяти основных принципов проектирования классов в объектно-ориентированном программировании — Single responsibility, Open-closed, Liskov substitution, Interface segregation и Dependency inversion.
*/

/*
Single responsibility principle - Принцип единственной обязанности
На каждый класс должна быть возложена одна-единственная обязанность.
*/

protocol CanBeOn {
    func on()
}

protocol CanBeOff {
    func off()
}

class Switch: CanBeOff, CanBeOn {
    private var stateOn = false
    
    func on() {
        stateOn = true
    }
    
    func off() {
        stateOn = false
    }
}

class SwitchOn {
    let switcher: CanBeOn
    
    init(switcher: CanBeOn) {
        self.switcher = switcher
    }
    
    func execute() {
        switcher.on()
    }
}

class SwitchOff {
    let switcher: CanBeOff
    
    init(switcher: CanBeOff) {
        self.switcher = switcher
    }
    
    func execute() {
        switcher.off()
    }
}

let switcher = Switch()
switcher.stateOn

let switchOn = SwitchOn(switcher: switcher)
switchOn.execute()

switcher.stateOn


/*
Open/closed principle - Принцип открытости/закрытости
Программные сущности должны быть открыты для расширения, но закрыты для изменения.
*/

protocol CanWriteCode {
    func programming() -> String
}

class SwiftDeveloper: CanWriteCode {
    func programming() -> String {
        return "Swift"
    }
}

class ObjCDeveloper: CanWriteCode {
    func programming() -> String {
        return "Objective C"
    }
}

class WebDeveloper: CanWriteCode {
    func programming() -> String {
        return "PHP"
    }
}

class Team {
    let team: [CanWriteCode]
    
    init(team: [CanWriteCode]) {
        self.team = team
    }
    
    func programming() -> [String] {
        return team.map { $0.programming() }
    }
}

let swiftDev = SwiftDeveloper()
let objcDev = ObjCDeveloper()
let webDev = WebDeveloper()

let team = Team(team: [swiftDev, objcDev, webDev])
team.programming()


/*
Liskov substitution principle - Принцип подстановки Барбары Лисков
Функции, которые используют базовый тип, должны иметь возможность использовать подтипы базового типа, не зная об этом.
Подклассы не могут замещать поведения базовых классов. Подтипы должны дополнять базовые типы.
*/

protocol CanFly {
    var flySpeed: Double {get set}
}

protocol CanSwim {
    var swimSpeed: Double {get set}
}

class Bird {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

class Eagle: Bird, CanFly {
    var flySpeed: Double
    
    init(flySpeed: Double, name: String) {
        self.flySpeed = flySpeed
        super.init(name: name)
    }
}

class Penguin: Bird, CanSwim {
    var swimSpeed: Double
    
    init(name: String, swimSpeed: Double) {
        self.swimSpeed = swimSpeed
        super.init(name: name)
    }
}


/*
Interface segregation principle - Принцип разделения интерфейса
Много специализированных интерфейсов лучше, чем один универсальный.
*/

protocol IosSkills {
    var swift: Bool {get set}
    var objc: Bool {get set}
}

protocol FrontSkills {
    var html: Bool {get set}
    var css: Bool {get set}
}

protocol BackSkills {
    var ruby: Bool {get set}
    var php: Bool {get set}
}

class IosVacancy: IosSkills {
    var swift: Bool
    var objc: Bool
    
    init(swift: Bool, objc: Bool) {
        self.swift = swift
        self.objc = objc
    }
}

class FrontEndVacancy: FrontSkills {
    var html: Bool
    var css: Bool
    
    init(html: Bool, css: Bool) {
        self.html = html
        self.css = css
    }
}

class BackEndVacancy: BackSkills {
    var ruby: Bool
    var php: Bool
    
    init(ruby: Bool, php: Bool) {
        self.ruby = ruby
        self.php = php
    }
}


/*
Dependency inversion principle - Принцип инверсии зависимостей
Зависимости внутри системы строятся на основе абстракций. Модули верхнего уровня не зависят от модулей нижнего уровня. Абстракции не должны зависеть от деталей. Детали должны зависеть от абстракций.
*/

protocol Wife {
    func getFood() -> String
}

class Man {
    var wife: Wife
    var food: String {
        return wife.getFood()
    }
    
    init(wife: Wife) {
        self.wife = wife
    }
}

class FirstWife: Wife {
    func getFood() -> String {
        return "Vegeterian food"
    }
}

class SecondWife: Wife {
    func getFood() -> String {
        return "Fast food"
    }
}

let man = Man(wife: SecondWife())
man.food

man.wife = FirstWife()
man.food

// проблема такого кода в том что еда мужчины зависима от жены

protocol GetFood {
    func getFood() -> String
}

class ThirdWife: GetFood {
    func getFood() -> String {
        return "Fast food"
    }
}

class Mother: GetFood {
    func getFood() -> String {
        return "Tasty food"
    }
}

class Sister: GetFood {
    func getFood() -> String {
        return "Classic food"
    }
}

class HappyMan {
    var foodProvider: GetFood
    var food: String {
        return foodProvider.getFood()
    }
    
    init(foodProvider: GetFood) {
        self.foodProvider = foodProvider
    }
}

let happyMan = HappyMan(foodProvider: Mother())
happyMan.food


/*---------------------------------Паттерны проектирования----------------------------------*/
/* 
Структурные паттерны - помогают внести порядок и научить разные объекты более правильно взаимодействовать друг с другом
*/
/*
Адаптер (англ. Adapter) — структурный шаблон проектирования, предназначенный для организации использования функций объекта, недоступного для модификации, через специально созданный интерфейс.
*/

protocol Celsius {
    var celsius: Double {get}
}

class CelsiusThermometer: Celsius {
    var celsius: Double
    
    init(celsius: Double) {
        self.celsius = celsius
    }
}

class Temperature {
    var thermometer: Celsius
    
    func weather() -> String {
        switch thermometer.celsius {
        case -100 ..< -5.0: return "\(thermometer.celsius) - Cold"
        case -5.0 ..< 5.0: return "\(thermometer.celsius) - Normal"
        case 5.0 ... 20.0: return "\(thermometer.celsius) - Warm"
        default: return "\(thermometer.celsius) - Hot"
        }
    }
    
    init(thermometer: Celsius) {
        self.thermometer = thermometer
    }
}

class FahrenheitThermometer {
    var fahrenheit: Double
    
    init(fahrenheit: Double) {
        self.fahrenheit = fahrenheit
    }
}

class Adapter: Celsius {
    private let target: FahrenheitThermometer
    var celsius: Double {
        return (target.fahrenheit - 32) / 1.8
    }
    
    init(target: FahrenheitThermometer) {
        self.target = target
    }
}

let celsiusThermometer = CelsiusThermometer(celsius: -15)
let celsiusTemperature = Temperature(thermometer: celsiusThermometer)
celsiusTemperature.weather()

let fahrenheitThermometer = FahrenheitThermometer(fahrenheit: 50)
let fahrenheitTemperature = Temperature(thermometer: Adapter(target: fahrenheitThermometer))
fahrenheitTemperature.weather()


/*
Мост (англ. Bridge) — структурный шаблон проектирования, используемый в проектировании программного обеспечения чтобы «разделять абстракцию и реализацию так, чтобы они могли изменяться независимо». Шаблон мост использует инкапсуляцию, агрегирование и может использовать наследование для того, чтобы разделить ответственность между классами.
*/

// Абстракция

protocol Car {
    var breakPedal: Bool {get set}
    var gasPedal: Bool {get set}
    var steeringWheel: Bool {get set}
}

class Truck: Car {
    var breakPedal: Bool
    var gasPedal: Bool
    var steeringWheel: Bool
    
    init(breakPedal: Bool, gasPedal: Bool, steeringWheel: Bool) {
        self.breakPedal = breakPedal
        self.gasPedal = gasPedal
        self.steeringWheel = steeringWheel
    }
}

class Passanger: Car {
    var breakPedal: Bool
    var gasPedal: Bool
    var steeringWheel: Bool
    
    init(breakPedal: Bool, gasPedal: Bool, steeringWheel: Bool) {
        self.breakPedal = breakPedal
        self.gasPedal = gasPedal
        self.steeringWheel = steeringWheel
    }
}

class Bus: Car {
    var breakPedal: Bool
    var gasPedal: Bool
    var steeringWheel: Bool
    
    init(breakPedal: Bool, gasPedal: Bool, steeringWheel: Bool) {
        self.breakPedal = breakPedal
        self.gasPedal = gasPedal
        self.steeringWheel = steeringWheel
    }
}

// Реализация

protocol Price {
    var car: Car {get set}
    var price: Double {get set}
}

class BMW: Price {
    var car: Car
    var price: Double
    
    init(car: Car, price: Double) {
        self.car = car
        self.price = price
    }
}

class Mercedes: Price {
    var car: Car
    var price: Double
    
    init(car: Car, price: Double) {
        self.car = car
        self.price = price
    }
}

class Volkswagen: Price {
    var car: Car
    var price: Double
    
    init(car: Car, price: Double) {
        self.car = car
        self.price = price
    }
}

let bmw = BMW(car: Passanger(breakPedal: true, gasPedal: true, steeringWheel: true), price: 50000)


/*
Компоновщик (англ. Composite pattern) — структурный шаблон проектирования, объединяющий объекты в древовидную структуру для представления иерархии от частного к целому. Компоновщик позволяет клиентам обращаться к отдельным объектам и к группам объектов одинаково.
*/

protocol Unit {
    func getStrength() -> Int
}

class Archer: Unit {
    func getStrength() -> Int {
        return 3
    }
}

class Infantryman: Unit {
    func getStrength() -> Int {
        return 2
    }
}

class InfantrymanStrong: Infantryman {
    override func getStrength() -> Int {
        return 3
    }
}

class InfantrymanWeak: Infantryman {
    override func getStrength() -> Int {
        return 1
    }
}

class Horseman: Unit {
    func getStrength() -> Int {
        return 5
    }
}

// Компоновщик

class Army: Unit {
    var units = [Unit]()
    
    init(units: [Unit]) {
        self.units = units
    }
    
    func getStrength() -> Int {
        var totalStrength = 0
        
        for unit in units {
            totalStrength += unit.getStrength()
        }
        
        return totalStrength
    }
}

let horsemans: [Unit] = Array(count: 300, repeatedValue: Horseman())
let archers: [Unit] = Array(count: 500, repeatedValue: Archer())

let army = Army(units: horsemans + archers)
army.getStrength()

let infantrymanStrong: [Unit] = Array(count: 500, repeatedValue: InfantrymanStrong())
let infantrymanWeak: [Unit] = Array(count: 800, repeatedValue: InfantrymanWeak())

let enemy = Army(units: infantrymanStrong + infantrymanWeak)

if army.getStrength() > enemy.getStrength() {
    print("win")
} else {
    print("lose")
}


/*
Декоратор (англ. Decorator) — структурный шаблон проектирования, предназначенный для динамического подключения дополнительного поведения к объекту. Шаблон Декоратор предоставляет гибкую альтернативу практике создания подклассов с целью расширения функциональности.
*/

protocol IceCream {
    func getCost() -> Double
    func getIngredients() -> String
}

class SimpleIceCream: IceCream {
    func getCost() -> Double {
        return 10.0
    }
    
    func getIngredients() -> String {
        return "IceCream"
    }
}

class IceCreamDecorator: IceCream {
    private let decoratedIceCream: IceCream
    private let ingredientSeparator = ", "
    
    required init(decoratedIceCream: IceCream) {
        self.decoratedIceCream = decoratedIceCream
    }
    
    func getCost() -> Double {
        return decoratedIceCream.getCost()
    }
    
    func getIngredients() -> String {
        return decoratedIceCream.getIngredients()
    }
}

class Bananas: IceCreamDecorator {
    required init(decoratedIceCream: IceCream) {
        super.init(decoratedIceCream: decoratedIceCream)
    }
    
    override func getCost() -> Double {
        return super.getCost() + 3.5
    }
    
    override func getIngredients() -> String {
        return super.getIngredients() + ingredientSeparator + "Bananas"
    }
}

class Сhocolate: IceCreamDecorator {
    required init(decoratedIceCream: IceCream) {
        super.init(decoratedIceCream: decoratedIceCream)
    }
    
    override func getCost() -> Double {
        return super.getCost() + 5.0
    }
    
    override func getIngredients() -> String {
        return super.getIngredients() + ingredientSeparator + "Сhocolate"
    }
}

var iceCream: IceCream = SimpleIceCream()
iceCream.getCost()

iceCream = Сhocolate(decoratedIceCream: iceCream)
iceCream.getCost()

iceCream = Bananas(decoratedIceCream: iceCream)
iceCream.getCost()
iceCream.getIngredients()


/*
Фасад (англ. Facade) — структурный шаблон проектирования, позволяющий скрыть сложность системы путем сведения всех возможных внешних вызовов к одному объекту, делегирующему их соответствующим объектам системы.
*/

class DiscountDepartment {
    func getDiscount(count: Int) -> Double {
        switch count {
        case 1: return 0
        case 2...5: return 10
        default: return 20
        }
    }
}

class OrderDepartment {
    func getPrice(count: Int) -> Double {
        return Double(count * 50)
    }
}

class DeliveryDepartment {
    func getDeliveryTime(address: String) -> Int {
        if address == "Moscow" {
            return 40
        } else {
            return 120
        }
    }
}

class PizzaServices {
    let discount: DiscountDepartment
    let order: OrderDepartment
    let delivery: DeliveryDepartment
    
    init(discount: DiscountDepartment, order: OrderDepartment, delivery: DeliveryDepartment) {
        self.discount = discount
        self.order = order
        self.delivery = delivery
    }
    
    func getInfo(count: Int, address: String) -> (Double, Int) {
        let regularPrice = order.getPrice(count)
        let discountPrice = discount.getDiscount(count)
        let price = regularPrice - regularPrice * discountPrice / 100
        let timeDelivery = delivery.getDeliveryTime(address)
        
        return (price, timeDelivery)
    }
}

let callCenter = PizzaServices(discount: DiscountDepartment(), order: OrderDepartment(), delivery: DeliveryDepartment())

let client1 = callCenter.getInfo(5, address: "Moscow")
let client2 = callCenter.getInfo(9, address: "Tomsk")


/*
Приспособленец (англ. Flyweight, "легковесный (элемент)") — структурный шаблон проектирования, при котором объект, представляющий себя как уникальный экземпляр в разных местах программы, по факту не является таковым. Для оптимизации памяти путем предотвращения создания экземпляров элементов имеющих общую сущность (в данном случае MikeMayers)
*/

class MikeMayers {
    let name: String
    let skills: Int
    
    var role: String?
    var age: Int?
    
    init() {
        self.name = "Mike Mayers"
        self.skills = 80
        print("Created object")
    }
    
    func getInfo() -> String {
        if let role = role, let age = age {
            return "Role - \(role), age - \(age)"
        } else {
            return "No role"
        }
    }
}

let mike = MikeMayers()
mike.getInfo()

mike.role = "Dr. Evil"
mike.age = 55
mike.getInfo()

mike.role = "Austin Powers"
mike.age = 25
mike.getInfo()

mike.role = "Fat Man"
mike.age = 50
mike.getInfo()


/*
Заместитель (англ. Proxy) — структурный шаблон проектирования, который предоставляет объект, который контролирует доступ к другому объекту, перехватывая все вызовы (выполняет функцию контейнера).
*/

protocol Human {
    func move() -> String
    func getName() -> String
}

class Player: Human {
    func move() -> String {
        return "run"
    }
    func getName() -> String {
        return "Ronaldo"
    }
}

class Proxy: Human {
    let owner: Human
    
    init(owner: Human) {
        self.owner = owner
    }
    
    func move() -> String {
        return owner.move()
    }
    func getName() -> String {
        return owner.getName()
    }
}

let player = Player()
player.move()

let player1 = Proxy(owner: player)
player1.move()


// ----------------------------------Паттерны поведения-------------------------------------
// Позволяют структурировать подходы обработки поведения и взаимодействия объектов
/*
Цепочка обязанностей (англ. Chain of responsibility) — поведенческий шаблон проектирования, предназначенный для организации в системе уровней ответственности. Позволяет избежать привязки отправителя запроса к его получателю, давая шанс обработать запрос нескольким получателям.
*/

class MoneyPacket {
    let value: Int // номинал купюры 100, 50, 20, 10
    var quantity: Int // количество купюр
    var nextPacket: MoneyPacket?
    
    init(value: Int, quantity: Int, nextPacket: MoneyPacket?) {
        self.value = value
        self.quantity = quantity
        self.nextPacket = nextPacket
    }
    
    func canWithdraw(var v: Int) -> Bool {
        func canTakeSameBill(want: Int) -> Bool {
            return (want / self.value) > 0
        }
        
        var q = self.quantity
        
        while canTakeSameBill(v) {
            if q == 0 {  // купюры закончились
                break
            }
            
            v -= self.value
            q -= 1
        }
        
        // банкомат выдал всю сумму
        if v == 0 {
            return true
        } else if let next = self.nextPacket {
            return next.canWithdraw(v)
        }
        
        return false
    }
}

class ATM {
    private var hundred: MoneyPacket
    private var fifty: MoneyPacket
    private var twenty: MoneyPacket
    private var ten: MoneyPacket
    
    private var startPacket: MoneyPacket {
        return self.hundred
    }
    
    init(hundred: MoneyPacket, fifty: MoneyPacket, twenty: MoneyPacket, ten: MoneyPacket) {
        self.hundred = hundred
        self.fifty = fifty
        self.twenty = twenty
        self.ten = ten
    }
    
    func canWithdraw(value: Int) -> String {
        return "Can withdraw: \(self.startPacket.canWithdraw(value))"
    }
}

// Получатели - пачки с купюрами денег
// по цепочке может ходить только один запрос
let ten = MoneyPacket(value: 10, quantity: 100, nextPacket: nil)
let twenty = MoneyPacket(value: 20, quantity: 100, nextPacket: ten)
let fifty = MoneyPacket(value: 50, quantity: 100, nextPacket: twenty)
let hundred = MoneyPacket(value: 100, quantity: 100, nextPacket: fifty)

let atm = ATM(hundred: hundred, fifty: fifty, twenty: twenty, ten: ten)

// Отправитель это клиент
atm.canWithdraw(20000)
atm.canWithdraw(10000)


/*
Команда (англ. Command) — поведенческий шаблон проектирования, используемый при объектно-ориентированном программировании, представляющий действие. Объект команды заключает в себе само действие и его параметры.
*/

protocol Command {
    func execute() -> String
}

class OnCommand: Command {
    let devices: String
    
    init(devices: String) {
        self.devices = devices
    }
    
    func execute() -> String {
        return "On \(devices)"
    }
}

class OffCommand: Command {
    let devices: String
    
    init(devices: String) {
        self.devices = devices
    }
    
    func execute() -> String {
        return "Off \(devices)"
    }
}

class Devices {
    let onCommand: Command
    let offComand: Command
    
    init(devices: String) {
        self.onCommand = OnCommand(devices: devices)
        self.offComand = OffCommand(devices: devices)
    }
    
    func on() -> String {
        return onCommand.execute()
    }
    
    func off() -> String {
        return offComand.execute()
    }
}

let tv = Devices(devices: "Samsung")
tv.on()
tv.off()


/*
Интерпретатор (англ. Interpreter) — поведенческий шаблон проектирования, решающий часто встречающуюся, но подверженную изменениям, задачу. Определяет грамматическое представление для языка и интерпретатор для интерпретации грамматики.
*/

// Интерпретатор
protocol IntegerExp {
    func evaluate(context: IntegerContext) -> Int
    func replace(character: Character, integerExp: IntegerExp) -> IntegerExp
    func copy() -> IntegerExp
}

// Контекст
class IntegerContext {
    private var data: [Character: Int] = [:]
    
    func lookup(name: Character) -> Int {
        return self.data[name]!
    }
    
    func assign(integerVarExp: IntegerVarExp, value: Int) {
        self.data[integerVarExp.name] = value
    }
}

// Переменные
class IntegerVarExp: IntegerExp {
    let name: Character
    
    init(name: Character) {
        self.name = name
    }
    
    func evaluate(context: IntegerContext) -> Int {
        return context.lookup(self.name)
    }
    
    func replace(character: Character, integerExp: IntegerExp) -> IntegerExp {
        if name == self.name {
            return integerExp.copy()
        } else {
            return IntegerVarExp(name: self.name)
        }
    }
    
    func copy() -> IntegerExp {
        return IntegerVarExp(name: self.name)
    }
}

// Грамматика
class AddExp: IntegerExp {
    private var op1: IntegerExp
    private var op2: IntegerExp
    
    init(op1: IntegerExp, op2: IntegerExp) {
        self.op1 = op1
        self.op2 = op2
    }
    
    func evaluate(context: IntegerContext) -> Int {
        return self.op1.evaluate(context) + self.op2.evaluate(context)
    }
    
    func replace(character: Character, integerExp: IntegerExp) -> IntegerExp {
        return AddExp(op1: op1.replace(character, integerExp: integerExp), op2: op2.replace(character, integerExp: integerExp))
    }
    
    func copy() -> IntegerExp {
        return AddExp(op1: self.op1, op2: self.op2)
    }
}

var expression: IntegerExp?
var integerContext = IntegerContext()

var a = IntegerVarExp(name: "a")
var b = IntegerVarExp(name: "b")
var c = IntegerVarExp(name: "c")

expression = AddExp(op1: a, op2: AddExp(op1: b, op2: c)) // a + (b + c)

integerContext.assign(a, value: 2)
integerContext.assign(b, value: 6)
integerContext.assign(c, value: 3)

var result = expression?.evaluate(integerContext)


/*
Итератор (англ. Iterator) — поведенческий шаблон проектирования. Представляет собой объект, позволяющий получить последовательный доступ к элементам объекта-агрегата без использования описаний каждого из агрегированных объектов.
*/

struct AutomateCollections<T> {
    var things: [T]
}

extension AutomateCollections: SequenceType {
    typealias Generator = AnyGenerator<T>
    
    func generate() -> Generator {
        var i = 0
        return anyGenerator {
            return i >= self.things.count ? nil : self.things[i++]
        }
    }
}

struct Chips {
    let name: String
}

enum Drinks {
    case Pepsi
    case Cola
    case Sprite
}

let chipsAutomate = AutomateCollections(things: [Chips(name: "Lays"), Chips(name: "Pringles")])

// for in это и есть Итератор
for chip in chipsAutomate {
    print(chip.name)
}

let drinksAutomate = AutomateCollections(things: [Drinks.Pepsi, Drinks.Cola, Drinks.Sprite])

for drink in drinksAutomate {
    print(drink)
}


/*
Посредник (англ. Mediator) — поведенческий шаблон проектирования, обеспечивающий взаимодействие множества объектов, формируя при этом слабую связанность и избавляя объекты от необходимости явно ссылаться друг на друга.
*/

class Sensor {
    let mediator: Mediator
    
    init(mediator: Mediator) {
        self.mediator = mediator
    }
    
    func send(message: String) {
        mediator.send(message, sensor: self)
    }
    
    func receive(message: String, sensor: Sensor) {
        
    }
}

protocol Mediator {
    func send(message: String, sensor: Sensor)
}

class Computer: Mediator {
    private var sensors = [Sensor]()
    
    func addSensor(sensor: Sensor) {
        sensors.append(sensor)
    }
    
    func send(message: String, sensor: Sensor) {
        for s in sensors {
            if s !== sensor {
                sensor.receive(message, sensor: s)
            }
        }
    }
}

class ConcreteSensor: Sensor {
    let name: String

    init(name: String, mediator: Mediator) {
        self.name = name
        super.init(mediator: mediator)
    }
    
    override func receive(message: String, sensor: Sensor) {
        guard let sensor = sensor as? ConcreteSensor else {return}
        
        print("Sensor \(sensor.name) received: \(message)")
    }
}

let computer = Computer()

let camera = ConcreteSensor(name: "camera", mediator: computer)
let radar = ConcreteSensor(name: "radar", mediator: computer)
let gps = ConcreteSensor(name: "gps", mediator: computer)

computer.addSensor(camera)
computer.addSensor(radar)
computer.addSensor(gps)

gps.send("lat: 20.34, lon: 50.23")


/*
Хранитель (англ. Memento) — поведенческий шаблон проектирования, позволяющий, не нарушая инкапсуляцию, зафиксировать и сохранить внутреннее состояние объекта так, чтобы позднее восстановить его в это состояние.
*/

protocol Memento {}

protocol Originator {
    func createMemento() -> Memento
    func applyMemento(memento: Memento)
}

class LedgerEntry {
    let id: Int
    let counterParty: String
    let amount: Float
    
    init(id: Int, counterParty: String, amount: Float) {
        self.id = id
        self.counterParty = counterParty
        self.amount = amount
    }
}

class LedgerMemento: Memento {
    private let entries: [LedgerEntry]
    private let total: Float
    private let nextId: Int
    
    init(ledger: Ledger) {
        self.entries = Array(ledger.entries.values)
        self.total = ledger.total
        self.nextId = ledger.nextId
    }
    
    func apply(ledger: Ledger) {
        ledger.total = self.total
        ledger.nextId = self.nextId
        ledger.entries.removeAll(keepCapacity: true)
        
        for entry in self.entries {
            ledger.entries[entry.id] = entry
        }
    }
}

// Счетная книга
class Ledger: Originator {
    private var entries = [Int : LedgerEntry]()
    private var nextId = 1
    var total: Float = 0.0
    
    func addEntry(counterParty: String, amount: Float) {
        let entry = LedgerEntry(id: nextId++, counterParty: counterParty, amount: amount)
        entries[entry.id] = entry
        total += amount
    }
    
    func createMemento() -> Memento {
        return LedgerMemento(ledger: self)
    }
    
    func applyMemento(memento: Memento) {
        if let m = memento as? LedgerMemento {
            m.apply(self)
        }
    }
    
    func printEntries() {
        for id in Array(entries.keys).sort(<) {
            if let entry = entries[id] {
                print("#\(id): \(entry.counterParty) $\(entry.amount)")
            }
        }
        
        print("Total: $\(total)")
        print("----")
    }
}

let ledger = Ledger()

ledger.addEntry("Bob", amount: 100.43)
ledger.addEntry("Joe", amount: 200.20)

let memento = ledger.createMemento()

ledger.addEntry("Alice", amount: 500)
ledger.addEntry("Tony", amount: 20)

ledger.printEntries()

ledger.applyMemento(memento)

ledger.printEntries()


/*
Наблюдатель (англ. Observer) — поведенческий шаблон проектирования. Также известен как «подчинённые» (Dependents). Создает механизм у класса, который позволяет получать экземпляру объекта этого класса оповещения от других объектов об изменении их состояния, тем самым наблюдая за ними.
*/

protocol Observer: class {
    func notify(user: String, success: Bool)
}

protocol Subject {
    func addObservers(observers: Observer...)
    func removeObserver(observer: Observer)
}

class SubjectBase: Subject {
    private var observers = [Observer]()
    private var collectionQueue = dispatch_queue_create("colQ", DISPATCH_QUEUE_CONCURRENT)
    
    func addObservers(observers: Observer...) {
        dispatch_barrier_sync(self.collectionQueue) {
            for newOb in observers {
                self.observers.append(newOb)
            }
        }
    }
    
    func removeObserver(observer: Observer) {
        dispatch_barrier_sync(self.collectionQueue) {
            self.observers = self.observers.filter({$0 !== observer})
        }
    }
    
    func sendNotification(user: String, success: Bool) {
        dispatch_sync(self.collectionQueue) {
            for ob in self.observers {
                ob.notify(user, success: success)
            }
        }
    }
}

class AuthenticationManager: SubjectBase {
    func authenticate(user: String, pass: String) -> Bool {
        var result = false
        
        if user == "bob" && pass == "secret" {
            result = true
            print("User \(user) is authenticated")
        } else {
            print("Failed authentication attempt")
        }
        
        sendNotification(user, success: result)
        
        return result
    }
}

class ActivityLog: Observer {
    func notify(user: String, success: Bool) {
        print("Auth request for \(user). Success: \(success)")
    }
    
    func logActivity(activity: String) {
        print("Log: \(activity)")
    }
}

class FileCache: Observer {
    func notify(user: String, success: Bool) {
        if success {
            loadFiles(user)
        }
    }
    
    func loadFiles(user: String) {
        print("Load files for \(user)")
    }
}

class AttackMonitor: Observer {
    func notify(user: String, success: Bool) {
        monitorSuspiciousActivity = !success
    }
    
    var monitorSuspiciousActivity: Bool = false {
        didSet {
            print("Monitoring for attack: \(monitorSuspiciousActivity)")
        }
    }
}

let log = ActivityLog()
let cache = FileCache()
let monitor = AttackMonitor()

let authManager = AuthenticationManager()
authManager.addObservers(log, cache, monitor)

authManager.authenticate("bob", pass: "secret")
print("-----")
authManager.authenticate("joe", pass: "shhh")


/*
Состояние (англ. State) — поведенческий шаблон проектирования. Используется в тех случаях, когда во время выполнения программы объект должен менять своё поведение в зависимости от своего состояния.
*/

class Context {
    private var state: State = UnauthorizedState()
    
    var isAuthorized: Bool {
        get { return state.isAuthorized(self) }
    }
    
    var userId: String? {
        get { return state.userId(self) }
    }
    
    func changeStateToAuthorized(userId userId: String) {
        state = AuthorizedState(userId: userId)
    }
    
    func changeStateToUnauthorized() {
        state = UnauthorizedState()
    }
}

protocol State {
    func isAuthorized(context: Context) -> Bool
    func userId(context: Context) -> String?
}

class UnauthorizedState: State {
    func isAuthorized(context: Context) -> Bool { return false }
    func userId(context: Context) -> String? { return nil }
}

class AuthorizedState: State {
    let userId: String
    
    init(userId: String) { self.userId = userId }
    
    func isAuthorized(context: Context) -> Bool { return true }
    func userId(context: Context) -> String? { return userId }
}

let context = Context()
(context.isAuthorized, context.userId)

context.changeStateToAuthorized(userId: "admin")
(context.isAuthorized, context.userId) // now logged in as "admin"

context.changeStateToUnauthorized()
(context.isAuthorized, context.userId)


/*
Стратегия (англ. Strategy) — поведенческий шаблон проектирования, предназначенный для определения семейства алгоритмов, инкапсуляции каждого из них и обеспечения их взаимозаменяемости. Это позволяет выбирать алгоритм путем определения соответствующего класса. Шаблон Strategy позволяет менять выбранный алгоритм независимо от объектов-клиентов, которые его используют.
*/

protocol Strategy {
    func execute(values: [Int]) -> Int
}

class SumStrategy: Strategy {
    func execute(values: [Int]) -> Int {
        return values.reduce(0, combine: {$0 + $1})
    }
}

class MultiplyStrategy: Strategy {
    func execute(values: [Int]) -> Int {
        return values.reduce(1, combine: {$0 * $1})
    }
}

final class Sequence {
    private var numbers: [Int]
    
    init(numbers: Int...) {
        self.numbers = numbers
    }
    
    func addNumber(value: Int) {
        self.numbers.append(value)
    }
    
    func compute(strategy: Strategy) -> Int {
        return strategy.execute(self.numbers)
    }
}

let sequence = Sequence(numbers: 1, 2, 3, 4)
sequence.addNumber(10)
sequence.addNumber(20)

let sumStrategy = SumStrategy()
let multiplyStrategy = MultiplyStrategy()

let sum = sequence.compute(sumStrategy)
let multiply = sequence.compute(multiplyStrategy)


/*
Посетитель (англ. Visitor) — поведенческий шаблон проектирования, описывающий операцию, которая выполняется над объектами других классов. При изменении visitor нет необходимости изменять обслуживаемые классы.
*/

protocol Shape {
    func accept(visitor: Visitor)
}

protocol Visitor {
    func visit(shape: Circle)
    func visit(shape: Square)
    func visit(shape: Rectangle)
}

class Circle: Shape {
    let radius: Float
    
    init(radius: Float) {
        self.radius = radius
    }
    
    func accept(visitor: Visitor) {
        visitor.visit(self)
    }
}

class Square: Shape {
    let length: Float
    
    init(length: Float) {
        self.length = length
    }
    
    func accept(visitor: Visitor) {
        visitor.visit(self)
    }
}

class Rectangle: Shape {
    let xLen: Float
    let yLen: Float
    
    init(x: Float, y: Float) {
        self.xLen = x
        self.yLen = y
    }
    
    func accept(visitor: Visitor) {
        visitor.visit(self)
    }
}

class ShapeCollection {
    let shapes: [Shape]
    
    init() {
        shapes = [
            Circle(radius: 2.5), Square(length: 4), Rectangle(x: 10, y: 2)
        ]
    }
    
    func accept(visitor: Visitor) {
        for shape in shapes {
            shape.accept(visitor)
        }
    }
}

class AreaVisitor: Visitor {
    var totalArea: Float = 0.0
    
    func visit(shape: Circle) {
        totalArea += 3.14 * powf(shape.radius, 2)
    }
    
    func visit(shape: Square) {
        totalArea += powf(shape.length, 2)
    }
    
    func visit(shape: Rectangle) {
        totalArea += shape.xLen * shape.yLen
    }
}

class EdgesVisitor: Visitor {
    var totalEdges = 0
    
    func visit(shape: Circle) {
        totalEdges += 1
    }
    
    func visit(shape: Square) {
        totalEdges += 4
    }
    
    func visit(shape: Rectangle) {
        totalEdges += 4
    }
}

let shapes = ShapeCollection()
let areaVisitor = AreaVisitor()

shapes.accept(areaVisitor)
print("Area: \(areaVisitor.totalArea)")

let edgeVisitor = EdgesVisitor()
shapes.accept(edgeVisitor)
print("Edges: \(edgeVisitor.totalEdges)")


/*
Шаблонный метод (англ. Template method) — поведенческий шаблон проектирования, определяющий основу алгоритма и позволяющий наследникам переопределять некоторые шаги алгоритма, не изменяя его структуру в целом.
*/

struct Donor {
    let title: String
    let firstName: String
    let familyName: String
    let lastDonation: Float
    
    init(title: String, firstName: String, familyName: String, lastDonation: Float) {
        self.title = title
        self.firstName = firstName
        self.familyName = familyName
        self.lastDonation = lastDonation
    }
}

class DonorDatabase {
    private var donors: [Donor]
    var filter: ([Donor] -> [Donor])?
    var generate: ([Donor] -> [String])?
    
    init() {
        donors = [
            Donor(title: "Ms", firstName: "Anne", familyName: "Jones", lastDonation: 0),
            Donor(title: "Mr", firstName: "Bob", familyName: "Smith", lastDonation: 100),
            Donor(title: "Dr", firstName: "Alice", familyName: "Doe", lastDonation: 200),
            Donor(title: "Prof", firstName: "Joe", familyName: "Davis", lastDonation: 320)
        ]
    }
    
    func generate(maxNumber: Int) -> [String] {
        var targetDonors: [Donor] = filter?(donors) ?? donors.filter({$0.lastDonation > 0})
        
        targetDonors.sort({$0.lastDonation > $1.lastDonation})
        
        if targetDonors.count > maxNumber {
            targetDonors = Array(targetDonors[0..<maxNumber])
        }
        
        return generate?(targetDonors) ?? targetDonors.map({ donor in
            return "Dear \(donor.title). \(donor.familyName)"
        })
    }
}

let donorDb = DonorDatabase()

let galaInvitations = donorDb.generate(2)

for invite in galaInvitations {
    print(invite)
}

donorDb.filter = {$0.filter({$0.lastDonation == 0})}
donorDb.generate = {$0.map({"Hi \($0.firstName)"})}

let newDonors = donorDb.generate(Int.max)

for invite in newDonors {
    print(invite)
}


// ---------------------------------Порождающие паттерны------------------------------------
/*
Абстрактная фабрика (англ. Abstract factory) — порождающий шаблон проектирования, предоставляет интерфейс для создания семейств взаимосвязанных или взаимозависимых объектов, не специфицируя их конкретных классов. Шаблон реализуется созданием абстрактного класса Factory, который представляет собой интерфейс для создания компонентов системы (например, для оконного интерфейса он может создавать окна и кнопки). Затем пишутся классы, реализующие этот интерфейс.
*/

/*
Фабричный метод (англ. Factory Method также известен как Виртуальный конструктор (англ. Virtual Constructor)) — порождающий шаблон проектирования, предоставляющий подклассам интерфейс для создания экземпляров некоторого класса. В момент создания наследники могут определить, какой класс создавать. Иными словами, Фабрика делегирует создание объектов наследникам родительского класса. Это позволяет использовать в коде программы не специфические классы, а манипулировать абстрактными объектами на более высоком уровне.
*/

/*
Прототип (англ. Prototype) — Это паттерн создания объекта через клонирование другого объекта вместо создания через конструктор.
*/

/*
Одиночка (англ. Singleton) — порождающий шаблон проектирования, гарантирующий, что в однопоточном приложении будет единственный экземпляр класса с глобальной точкой доступа.
*/













