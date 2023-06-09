//
//  KeyView.swift
//  Calculator
//
//  Created by Lucas Pereira on 09/06/23.
//

import SwiftUI

struct KeyView: View {
    
    @State var valueDesc = "0"
    @State var runningNumber = 0.0
    @State var currentOperation: Operation = .none
    @State private var changeColor = false
    
    let buttons : [[Keys]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal]
    ]
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width, height: 280)
                    .foregroundColor(.black)
                    .overlay(alignment: .bottomTrailing) {
                        Text(valueDesc)
                            .font(.system(size: self.getFontSize(text: valueDesc)))
                    }
            }.padding()
            ForEach(buttons, id: \.self) { row in
                HStack (spacing: 12) {
                    ForEach(row, id: \.self) { key in
                        Button {
                            self.didTap(button: key)
                        } label: {
                            Text(key.rawValue)
                                .font(.system(size: 30))
                                .frame(width: self.getWidth(key: key), height: self.getHeight(key: key))
                                .background(key.buttonColor)
                                .foregroundColor(key.fontColor)
                                .cornerRadius(self.getWidth(key: key)/2)
                        }

                    }
                }.padding(.bottom, 4)
            }
        }
    }
    
    func getFontSize(text: String) -> CGFloat {
        if (text.count <= 6) {
            return 100
        } else if (text.count < 9) {
            return 80
        } else {
            return 70
        }
    }
    
    func getWidth(key: Keys) -> CGFloat {
        return (UIScreen.main.bounds.width - (5*10)) / (key == .zero ? 1.9 : 4)
    }
    
    func getHeight(key: Keys) -> CGFloat {
        return (UIScreen.main.bounds.width - (5*10)) / 5
    }
    
    func didTap(button: Keys) {
        switch button {
        case .add, .subtract, .multiply, .divide, .equal:
            self.defineOperation(button: button)
            if (button != .equal) {
                self.valueDesc = "0"
            }
            break
        case .clear:
            self.valueDesc = "0"
            break
        case .decimal:
            if (!self.valueDesc.contains(".")) {
                self.valueDesc = "\(self.valueDesc)."
            }
            break
        case .negative:
            if (self.valueDesc.starts(with: "-")) {
                self.valueDesc = "\(self.valueDesc.dropFirst())"
            } else {
                self.valueDesc = "-\(self.valueDesc)"
            }
            break
        case .percent:
            break
        default:
            let number = button.rawValue
            if (self.valueDesc == "0") {
                self.valueDesc = number
            } else {
                self.valueDesc = "\(self.valueDesc)\(number)"
            }
        }
    }
    
    func defineOperation(button: Keys) {
        if (button == .add) {
            self.currentOperation = .add
            self.runningNumber = Double(self.valueDesc) ?? 0
        } else if (button == .subtract) {
            self.currentOperation = .subtract
            self.runningNumber = Double(self.valueDesc) ?? 0
        } else if (button == .multiply) {
            self.currentOperation = .multiply
            self.runningNumber = Double(self.valueDesc) ?? 0
        } else if (button == .divide) {
            self.currentOperation = .divide
            self.runningNumber = Double(self.valueDesc) ?? 0
        } else if (button == .equal) {
            self.executeOperation()
        }
    }
    
    func executeOperation() {
        let runningValue = self.runningNumber
        let currentValue = Double(self.valueDesc) ?? 0
        var tempDesc = self.valueDesc
        
        switch self.currentOperation {
        case .add:
            tempDesc = "\(runningValue + currentValue)"
            break
        case .subtract:
            tempDesc = "\(runningValue - currentValue)"
            break
        case .multiply:
            tempDesc = "\(runningValue * currentValue)"
            break
        case .divide:
            tempDesc = "\(runningValue / currentValue)"
            break
        default:
            break
        }
        
        if (tempDesc.hasSuffix(".0")) {
            tempDesc = "\(tempDesc.prefix(upTo: tempDesc.firstIndex(of: ".")!))"
        }
        
        self.valueDesc = tempDesc
    }
}

struct KeyView_Previews: PreviewProvider {
    static var previews: some View {
        KeyView()
            .preferredColorScheme(.dark)
    }
}
