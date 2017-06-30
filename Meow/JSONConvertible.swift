import SwiftyJSON
import DateToolsSwift


public protocol JSONConvertible {
    static func fromJSON(_ json: JSON) -> Self?
}

public extension JSON {
    func toType<T: JSONConvertible>() -> T? {
        return T.fromJSON(self)
    }
}

extension Int : JSONConvertible {
    public static func fromJSON(_ json: JSON) -> Int? {
        return json.int ?? Int(json.stringValue)
    }
}
extension Float : JSONConvertible {
    public static func fromJSON(_ json: JSON) -> Float? {
        return json.float ?? Float(json.stringValue)
    }
}

extension Double : JSONConvertible {
    public static func fromJSON(_ json: JSON) -> Double? {
        return json.double ?? Double(json.stringValue)
    }
}

extension Bool : JSONConvertible {
    public static func fromJSON(_ json: JSON) -> Bool? {
        return json.bool ?? Bool(json.stringValue)
    }
}

extension String : JSONConvertible {
    public static func fromJSON(_ json: JSON) -> String? {
        return json.string
    }
}


extension URL : JSONConvertible {
    public static func fromJSON(_ json: JSON) -> URL? {
        return URL(string: json.stringValue)
    }
}


//ceveat: This is a workaround!
//What we want to achieve is to exploit Array's covariance, i.e. if Element : JSONConvertible, [Element] should also be JSONConvertible.
//some kind of declaration like
//extension Array : JSONConvertible where Element : JSONConvertible
//However this cannot be achieved, at least in Swift 3:
//      Extension of type 'Array' with constraints cannot have an inheritance clause
//

extension Array : JSONConvertible {
    public static func fromJSON(_ json: JSON) -> Array? {
        if let type = Element.self as? JSONConvertible.Type {
            return json.arrayValue.flatMap { type.fromJSON($0) as? Element }
        }
        fatalError("Element \(Element.self) is not JSONConvertible")
    }
}



extension Date : JSONConvertible {
    public static func tryParse(dateString: String, formats: [String]) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none;
        dateFormatter.timeStyle = .none;
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent;
        
        for format in formats {
            dateFormatter.dateFormat = format;
            if let date = dateFormatter.date(from: dateString) {
                return date
            }
        }
        return nil
    }
    
    public static func fromJSON(_ json: JSON) -> Date? {
        return Date.tryParse(
            dateString: json.stringValue,
            formats:
                ["yyyy-MM-dd'T'HH:mm:ssZ", //2014-09-27T17:40:00Z
                 "yyyy-MM-dd HH:mm", //2014-09-27 17:40
                 "yyyy-MM-dd HH:mm:ss", //2014-09-27 17:40:59
            ])
    }
    
    
}


infix operator <- : AssignmentPrecedence

func JSON_resolve<T:JSONConvertible>(_ jsons: [JSON]) -> T? {
    for json in jsons {
        if let t:T = json.toType() {
            return t
        }
    }
    return nil
}

func <- <T:JSONConvertible>(lhs:inout T, rhs:([JSON],T)) -> Void {
    lhs = (JSON_resolve(rhs.0) ?? rhs.1)
}

func <- <T:JSONConvertible>(lhs:inout T, rhs:JSON) -> Void {
    if let newVal:T = JSON_resolve([rhs]) {
        lhs = newVal
    }
}

func <- <T:JSONConvertible>(lhs:inout T!, rhs:JSON) -> Void {
    if let newVal:T = JSON_resolve([rhs]) {
        lhs = newVal
    }
}

func <- <T:JSONConvertible>(lhs:inout T, rhs:(JSON,T)) -> Void {
    lhs = (JSON_resolve([rhs.0]) ?? rhs.1)
}

func <- <T:JSONConvertible>(lhs:inout T?, rhs:JSON) -> Void {
    lhs = JSON_resolve([rhs])
}

func <- <T : JSONConvertible> (lhs: inout T?, rhs: (JSON,T?)) -> Void {
    lhs = (JSON_resolve([rhs.0]) ?? rhs.1)
}

func <- <T:JSONConvertible>(lhs:inout T?, rhs:[JSON]) -> Void {
    lhs = JSON_resolve(rhs)
}

func <- <T : JSONConvertible> (lhs: inout T?, rhs: ([JSON],T?)) -> Void {
    lhs = (JSON_resolve(rhs.0) ?? rhs.1)
}
