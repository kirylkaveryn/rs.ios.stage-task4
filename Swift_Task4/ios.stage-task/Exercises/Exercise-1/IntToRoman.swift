import Foundation

public extension Int {
    
    var roman: String? {
        
        if self < 1 || self > 3999 {
            return nil
        }
        
        var stringOutput: String = ""
        var number = self
        print("input number: \(number)")
        while number > 0 {
            
            if number >= 1000 {
                stringOutput.append("M")
                number -= 1000
//                print("Roman string: \(stringOutput)")
                
            }
            else if number >= 900 {
                stringOutput.append("CM")
                number -= 900
//                print("Roman string: \(stringOutput)")
            }
            else if number >= 500 {
                stringOutput.append("D")
                number -= 500
//                print("Roman string: \(stringOutput)")
            }
            else if number >= 400 {
                stringOutput.append("CD")
                number -= 400
//                print("Roman string: \(stringOutput)")
            }
            else if number >= 100 {
                stringOutput.append("C")
                number -= 100
//                print("Roman string: \(stringOutput)")
            }
            else if number >= 90 {
                stringOutput.append("XC")
                number -= 90
//                print("Roman string: \(stringOutput)")
            }
            else if number >= 50 {
                stringOutput.append("L")
                number -= 50
//                print("Roman string: \(stringOutput)")
            }
            else if number >= 40 {
                stringOutput.append("XL")
                number -= 40
//                print("Roman string: \(stringOutput)")
            }
            else if number >= 10 {
                stringOutput.append("X")
                number -= 10
//                print("Roman string: \(stringOutput)")
            }
            else if number >= 9 {
                stringOutput.append("IX")
                number -= 9
//                print("Roman string: \(stringOutput)")
            }
            else if number >= 8 {
                stringOutput.append("VIII")
                number -= 8
//                print("Roman string: \(stringOutput)")
            }
            else if number >= 7 {
                stringOutput.append("VII")
                number -= 7
//                print("Roman string: \(stringOutput)")
            }
            else if number >= 6 {
                stringOutput.append("VI")
                number -= 6
//                print("Roman string: \(stringOutput)")
            }
            else if number >= 5 {
                stringOutput.append("V")
                number -= 5
//                print("Roman string: \(stringOutput)")
            }
            else if number >= 4 {
                stringOutput.append("IV")
                number -= 4
//                print("Roman string: \(stringOutput)")
            }
            else if number >= 3 {
                stringOutput.append("III")
                number -= 3
//                print("Roman string: \(stringOutput)")
            }
            else if number >= 2 {
                stringOutput.append("II")
                number -= 2
//                print("Roman string: \(stringOutput)")
            }
            else if number >= 1 {
                stringOutput.append("I")
                number -= 1
//                print("Roman string: \(stringOutput)")
            }
        }
        print("Roman string final: \(stringOutput)")
        return stringOutput
    }
}
