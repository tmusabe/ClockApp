//
//  StopWatchView.swift
//  ClockApp
//
//  Created by BS-272 on 9/2/21.
//

import SwiftUI

struct StopWatchView: View {
    
    private let marginLeading: CGFloat = 16
    private let marginTrailing: CGFloat = 16
    private let marginTop: CGFloat = 12
    private let tickHeight: CGFloat = 8
    private let longTickHeight: CGFloat = 14
    private let tickWidth: CGFloat = 2
    private let numberPadding: CGFloat = 40
    private let actionButtonPadding: CGFloat = 16
    
    @ObservedObject private var viewModel: StopWatchViewModel = StopWatchViewModel()
    
    var body: some View {
        ZStack {
            Color.backgroundColor.ignoresSafeArea()
            GeometryReader { geometryReader in
                VStack {
                    ZStack {
                        let width = geometryReader.size.width - self.marginLeading - self.marginTrailing
                        ClockView(count: 60, longDivider: 5, longTickHeight: self.longTickHeight, tickHeight: self.tickHeight, tickWidth: self.tickWidth, highlightedColorDivider: 20, highlightedColor: .clockHighlightedLineColor, normalColor: .clockLineColor)
                            .frame(width: width, height: width)
                        
                        let numberWidth = width - self.numberPadding
                        NumberView(numbers: self.getNumbers(count: 12), textColor: .clockTextColor, font: .clockText)
                            .frame(width: numberWidth, height: numberWidth)
                    
                        Text(self.viewModel.totalFormattedTime)
                            .font(.lapText)
                            .foregroundColor(.clockTextColor)
                            .padding(.top, width * 0.39)
                        
                        if self.viewModel.currentLapDegree != nil {
                            NeedleView(width: 8, height: width*3/4, color: .needleCurrentLap, bottomLineHeight: Constraint.needleViewBottomLineHeight)
                                .rotationEffect(.radians(self.viewModel.currentLapDegree!))
                        }
                        
                        NeedleView(width: 8, height: width*3/4, color: .needleNormal, bottomLineHeight: Constraint.needleViewBottomLineHeight)
                            .rotationEffect(.radians(self.viewModel.totalTimeDegree))
                        
                        HStack {
                            let leftButtonFeatures = self.getLeftButtonFeatures(self.viewModel.leftButtonType)
                            Button(leftButtonFeatures.0) {
                                self.viewModel.leftButtonTapped()
                            }
                            .buttonStyle(ActionButtonStyle(textColor: leftButtonFeatures.1, backgroundColor: leftButtonFeatures.2))
                            Spacer()
                            let rightButtonTextColor: Color = self.viewModel.isLapStarted ? .stopButtonText
                                : .startButtonText
                            let rightButtonBackgroundColor: Color = self.viewModel.isLapStarted ? .stopButton
                                : .startButton
                            
                            Button(self.viewModel.isLapStarted ? "Stop" : "Start") {
                                self.viewModel.rightButtonTapped()
                            }
                            .buttonStyle(ActionButtonStyle(textColor: rightButtonTextColor, backgroundColor: rightButtonBackgroundColor))
                        }
                        .padding(.top, width + self.actionButtonPadding)
                    }
                    .padding(.leading, self.marginLeading)
                    .padding(.trailing, self.marginTrailing)
                    .padding(.top, self.marginTop)
                
                    List {
                        ForEach(self.viewModel.presenters) { item in
                            VStack(alignment: .leading, spacing: 12, content: {
                                Color.lapCellSeparator.frame(width: geometryReader.size.width, height: 1)
                                
                                HStack {
                                    let color = self.getLapTextColor(item.type)
                                    Text(item.lap)
                                        .foregroundColor(color)
                                        .font(.lapCellText)
                                    Spacer()
                                    Text(item.time)
                                        .foregroundColor(color)
                                        .font(.lapCellText)
                                }
                            })
                        }
                        .listRowBackground(Color.backgroundColor)
                    }.onAppear(perform: {
                        UITableView.appearance().backgroundColor = .clear
                        UITableViewCell.appearance().backgroundColor = .clear
                    })
                }
            }
        }
        
        
    }
    
    private func getNumbers(count: Int) -> [Int] {
        var numbers: [Int] = []
        numbers.append(count * 5)
        for index in 1..<count {
            numbers.append(index * 5)
        }
        return numbers
    }
    
    private func getLapTextColor(_ type: LapType) -> Color {
        switch type {
        case .normal:
            return .lapCellNormal
        case .best:
            return .lapCellBest
        case .worst:
            return .lapCellWorst
        
        }
    }
    
    func getLeftButtonFeatures(_ type: LeftButtonType) -> (String, Color, Color) {
        switch type {
        case .lapPassive:
            return ("Lap", .lapButtonText, .lapButton)
        case .lapActive:
            return ("Lap", .lapButtonActiveText, .lapButtonActive)
        case .reset:
            return ("Reset", .lapButtonActiveText, .lapButtonActive)
        case .cancel:
            return ("Cancel", .lapButtonActiveText, .lapButtonActive)
        }
    }
}

struct StopWatchView_Previews: PreviewProvider {
    static var previews: some View {
        StopWatchView()
    }
}
