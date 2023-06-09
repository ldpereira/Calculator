//
//  CalculatorModel.swift
//  Calculator
//
//  Created by Lucas Pereira on 09/06/23.
//

import Foundation
import SwiftUI

enum Keys:String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case divide = "÷"
    case multiply = "x"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "-/+"
    
    var buttonColor:Color {
        switch self {
        case .add, .subtract, .multiply, .divide, .equal:
            return Color("VOperatorColor")
        case .clear, .negative, .percent:
            return Color("HOperatorColor")
        default :
            return Color("numColor")
        }
    }
    
    var fontColor:Color {
        switch self {
        case .clear, .negative, .percent:
            return Color(.black)
        default :
            return Color(.white)
        }
    }
}

enum Operation {
    case add, subtract, multiply, divide, none
}
