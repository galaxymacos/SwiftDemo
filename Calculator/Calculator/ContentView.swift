//
//  ContentView.swift
//  Calculator
//
//  Created by 阮迅 on 2021-10-14.
//

import SwiftUI


enum CalculatorButton: String {
    case one, two, three, four, five, six, seven, eight, nine, zero
    case equals, plus, minus, multiple, divide
    case ac, plusMinus, percent, dot
    
    var title: String {
        switch self {
        case .one:
            return "1"
        case .two:
            return "2"
        case .three:
            return "3"
        case .four:
            return "4"
        case .five:
            return "5"
        case .six:
            return "6"
        case .seven:
            return "7"
        case .eight:
            return "8"
        case .nine:
            return "9"
        case .zero:
            return "0"
        case .equals:
            return "="
        case .plus:
            return "+"
        case .minus:
            return "-"
        case .multiple:
            return "X"
        case .divide:
            return "/"
        case .ac:
            return "AC"
        case .plusMinus:
            return "+/-"
        case .percent:
            return "%"
        case .dot:
            return "."
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .zero:
            return Color(.darkGray)
        case .equals, .plus, .minus, .multiple, .divide:
            return Color(.orange)
        case .ac, .plusMinus, .percent, .dot:
            return Color(.lightGray)
        default:
            return Color.red
        }
    }
}

struct ContentView: View {
    
    let buttons: [[CalculatorButton]] = [
        [.ac, .plusMinus, .percent, .divide],
        [.seven,.eight,.nine,.multiple],
        [.four,.five,.six,.minus],
        [.one,.two,.three,.plus],
        [.zero, .dot,.equals],
    ]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 12) {
                HStack {
                    Spacer()
                    Text("72").foregroundColor(.white).font(.system(size: 72))
                }.padding()
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { button in
                            Button {
                                
                            } label: {
                                    // Make a view clickable, you just need to move it into a button's label parameter
                                Text(button.title)
                                    .font(.system(size: 32))
                                    .frame(width: self.buttonWidth(button: button), height: (UIScreen.main.bounds.width - 5 * 12) / 4)
                                    .foregroundColor(.white)
                                    .background(button.backgroundColor)
                                    .cornerRadius(buttonWidth(button: button))
                            }

                            
                        }
                    }
                    
                }
            }
            
        }
    }
    
    func buttonWidth(button: CalculatorButton) -> CGFloat {
        if button == .zero {
            return (UIScreen.main.bounds.width - 4 * 12) / 4 * 2
        }
        return (UIScreen.main.bounds.width - 5 * 12) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
