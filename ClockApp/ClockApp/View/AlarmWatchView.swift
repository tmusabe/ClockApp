//
//  AlarmWatchView.swift
//  ClockApp
//
//  Created by BS-272 on 9/2/21.
//

import SwiftUI

struct AlarmWatchView: View {
    
    @State var selectedNeedle: NeedleType = .none
    
    @ObservedObject private var viewModel: AlarmWatchViewModel = AlarmWatchViewModel()
        
    var body: some View {
        ZStack {
            Color.backgroundColor.ignoresSafeArea()
            GeometryReader { geometryReader in
                VStack{
                    ZStack {
                        let width = geometryReader.size.width - Constraint.marginLeading - Constraint.marginTrailing
                        ClockView(count: 60, longDivider: 5, longTickHeight: Constraint.longTickHeight, tickHeight: Constraint.tickHeight, tickWidth: Constraint.tickWidth, highlightedColorDivider: 20, highlightedColor: .clockHighlightedLineColor, normalColor: .clockLineColor)
                            .frame(width: width, height: width)
                        
                        let numberWidth = width - Constraint.numberPadding
                        NumberView(numbers: self.getNumbers(count: 12), textColor: .clockTextColor, font: .clockText)
                            .frame(width: numberWidth, height: numberWidth)
                        
                        self.getSelectableView(width: Constraint.needleViewWidth, height: width)
                        
                        NeedleView(width: Constraint.needleViewWidth, height: numberWidth/2, color: .needleGeneral, bottomLineHeight: Constraint.needleViewBottomLineHeight)
                            .rotationEffect(.degrees(Double($viewModel.time.hour.wrappedValue)!)*30)
                        
                        NeedleView(width: Constraint.needleViewWidth, height: numberWidth-10, color: .needleGeneral, bottomLineHeight: Constraint.needleViewBottomLineHeight)
                            .rotationEffect(.degrees(Double($viewModel.time.minute.wrappedValue)!)*6)
                        
                        HStack {
                            Button("AM") {
                                $selectedNeedle.wrappedValue = .none
                                $viewModel.time.meridium.wrappedValue = "AM"
                            }
                            .buttonStyle(ActionButtonStyle(textColor: .meridiumText, backgroundColor: .meridiumColor))
                            
                            Spacer()
                            
                            Button("PM") {
                                $selectedNeedle.wrappedValue = .none
                                $viewModel.time.meridium.wrappedValue = "PM"
                            }
                            .buttonStyle(ActionButtonStyle(textColor: .meridiumText, backgroundColor: .meridiumColor))
                        }
                        .padding(.top, width + Constraint.actionButtonPadding)
                        
                        
                    }
                    .padding(.leading, Constraint.marginLeading)
                    .padding(.trailing, Constraint.marginTrailing)
                    .padding(.top, Constraint.marginTop)
                    
                    HStack {
                        Spacer()
                        Text($viewModel.time.hour.wrappedValue)
                            .background($selectedNeedle.wrappedValue == .hour ? Color.timeSelectedColor : Color.timeColor)
                            .foregroundColor($selectedNeedle.wrappedValue == .hour ? .timeTextSelected : .timeText)
                            .onTapGesture {
                                $selectedNeedle.wrappedValue = $selectedNeedle.wrappedValue == .hour ? .none : .hour
                            }
                        Text(":")
                        Text($viewModel.time.minute.wrappedValue)
                            .font(.timeText)
                            .background($selectedNeedle.wrappedValue == .minute ? Color.timeSelectedColor : Color.timeColor)
                            .foregroundColor($selectedNeedle.wrappedValue == .minute ? .timeTextSelected : .timeText)
                            .onTapGesture {
                                $selectedNeedle.wrappedValue = $selectedNeedle.wrappedValue == .minute ? .none : .minute
                            }
                        Text($viewModel.time.meridium.wrappedValue)
                            
                        Spacer()
                    }
                    .font(.timeText)
                    .padding(.top, Constraint.actionButtonPadding)
                    VStack {
                        HStack {
                            CheckBoxView(name: "Fri", selected: $viewModel.time.weekdays[5])
                            CheckBoxView(name: "Sat", selected: $viewModel.time.weekdays[6])
                            CheckBoxView(name: "Sun", selected: $viewModel.time.weekdays[0])
                            CheckBoxView(name: "Mon", selected: $viewModel.time.weekdays[1])
                        }
                        HStack {
                            CheckBoxView(name: "Tue", selected: $viewModel.time.weekdays[2])
                            CheckBoxView(name: "Wed", selected: $viewModel.time.weekdays[3])
                            CheckBoxView(name: "Thu", selected: $viewModel.time.weekdays[4])
                        }
                    }
                    .accentColor(.black)
                    
                    Spacer()
                    
                    HStack {
                        let leftButtonFeatures = self.getLeftButtonFeatures(self.viewModel.leftButtonType)
                        Button(leftButtonFeatures.0) {
                            viewModel.leftButtonTapped()
                            $selectedNeedle.wrappedValue = .none
                        }
                        .buttonStyle(RoundRectangleButtonStyle(textColor: .actionButtonText, backgroundColor: leftButtonFeatures.1, conrnerRadius: Constraint.buttonCornerRadius))
                        Spacer()
                        Button("Save") {
                            viewModel.rightButtonTapped()
                            $selectedNeedle.wrappedValue = .none
                        }
                        .buttonStyle(RoundRectangleButtonStyle(textColor: .actionButtonText, backgroundColor: .saveActionButton, conrnerRadius: Constraint.buttonCornerRadius))
                        .alert(isPresented: $viewModel.showingAlert) {
                            Alert(title: Text($viewModel.alert.type.wrappedValue.rawValue), message: Text($viewModel.alert.message.wrappedValue), dismissButton: .default(Text("Ok")))
                        }

                    }
                    .padding(20)

                }
            }
        }
    }

    
    @ViewBuilder func getSelectableView(width: CGFloat, height: CGFloat) -> some View {
        ForEach(0..<360){ index in
            NeedleView(width: width, height: height, color: Color.backgroundColor.opacity(0.001), bottomLineHeight: 30)
                .rotationEffect(.degrees(Double(index)))
                .onTapGesture {
                    updateNeedlePosition(position: index)
                }
        }
    }
    
    private func getNumbers(count: Int) -> [Int] {
        var numbers: [Int] = []
        numbers.append(count)
        for index in 1..<count {
            numbers.append(index)
        }
        return numbers
    }
    
    private func updateNeedlePosition(position: Int) {
        if self.selectedNeedle == .minute {
            $viewModel.time.minute.wrappedValue = position/6 < 10 ? String("0\(Int(position/6))") : String(Int(position/6))
        }
        if self.selectedNeedle == .hour {
            $viewModel.time.hour.wrappedValue = position/30 < 10 ? (Int(position/30) == 0 ? String("12"): String("0\(Int(position/30))")) : String(Int(position/30))
        }
        $viewModel.leftButtonType.wrappedValue = $viewModel.alarmIsSet.wrappedValue ? .reset : .cancel
    }
    
    func getLeftButtonFeatures(_ type: LeftButtonType) -> (String, Color) {
        switch type {
        case .cancel:
            return ("Cancel",. cancelActionButton)
        case .lapActive:
            return ("Lap", .clear)
        case .reset:
            return ("Reset", .resetActionButton)
        case .lapPassive:
            return ("Lap", .clear)
        }
    }
    
}

struct AlarmWatchView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmWatchView()
    }
}
