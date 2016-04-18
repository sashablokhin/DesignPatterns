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

/*
Interface segregation principle - Принцип разделения интерфейса
Много специализированных интерфейсов лучше, чем один универсальный.
*/

/*
Dependency inversion principle - Принцип инверсии зависимостей
Зависимости внутри системы строятся на основе абстракций. Модули верхнего уровня не зависят от модулей нижнего уровня. Абстракции не должны зависеть от деталей. Детали должны зависеть от абстракций.
*/