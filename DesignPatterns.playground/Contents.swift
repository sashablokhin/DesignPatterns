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


















