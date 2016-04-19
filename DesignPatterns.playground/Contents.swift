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
Приспособленец (англ. Flyweight, "легковесный (элемент)") — структурный шаблон проектирования, при котором объект, представляющий себя как уникальный экземпляр в разных местах программы, по факту не является таковым.
*/

/*
Заместитель (англ. Proxy) — структурный шаблон проектирования, который предоставляет объект, который контролирует доступ к другому объекту, перехватывая все вызовы (выполняет функцию контейнера).
*/

// ----------------------------------Паттерны поведения-------------------------------------
/*
Цепочка обязанностей (англ. Chain of responsibility) — поведенческий шаблон проектирования, предназначенный для организации в системе уровней ответственности.
*/

/*
Команда (англ. Command) — поведенческий шаблон проектирования, используемый при объектно-ориентированном программировании, представляющий действие. Объект команды заключает в себе само действие и его параметры.
*/

/*
Интерпретатор (англ. Interpreter) — поведенческий шаблон проектирования, решающий часто встречающуюся, но подверженную изменениям, задачу.
*/

/*
Итератор (англ. Iterator) — поведенческий шаблон проектирования. Представляет собой объект, позволяющий получить последовательный доступ к элементам объекта-агрегата без использования описаний каждого из агрегированных объектов.
*/

/*
Посредник (англ. Mediator) — поведенческий шаблон проектирования, обеспечивающий взаимодействие множества объектов, формируя при этом слабую связанность и избавляя объекты от необходимости явно ссылаться друг на друга.
*/

/*
Хранитель (англ. Memento) — поведенческий шаблон проектирования, позволяющий, не нарушая инкапсуляцию, зафиксировать и сохранить внутреннее состояние объекта так, чтобы позднее восстановить его в это состояние.
*/

/*
Наблюдатель (англ. Observer) — поведенческий шаблон проектирования. Также известен как «подчинённые» (Dependents). Создает механизм у класса, который позволяет получать экземпляру объекта этого класса оповещения от других объектов об изменении их состояния, тем самым наблюдая за ними.
*/

/*
Состояние (англ. State) — поведенческий шаблон проектирования. Используется в тех случаях, когда во время выполнения программы объект должен менять своё поведение в зависимости от своего состояния.
*/

/*
Стратегия (англ. Strategy) — поведенческий шаблон проектирования, предназначенный для определения семейства алгоритмов, инкапсуляции каждого из них и обеспечения их взаимозаменяемости. Это позволяет выбирать алгоритм путем определения соответствующего класса. Шаблон Strategy позволяет менять выбранный алгоритм независимо от объектов-клиентов, которые его используют.
*/

/*
Шаблонный метод (англ. Template method) — поведенческий шаблон проектирования, определяющий основу алгоритма и позволяющий наследникам переопределять некоторые шаги алгоритма, не изменяя его структуру в целом.
*/

/*
Посетитель (англ. visitor) — поведенческий шаблон проектирования, описывающий операцию, которая выполняется над объектами других классов. При изменении visitor нет необходимости изменять обслуживаемые классы.
*/

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













