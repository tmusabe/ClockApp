//
//  ViewModel.swift
//  ClockApp
//
//  Created by BS-272 on 5/1/21.
//

import Foundation
class StopWatchViewModel: ObservableObject {
    
    @Published var presenters: [LapItemPresenter] = []
    @Published var totalFormattedTime: String = ""
    @Published var isLapStarted: Bool = false
    @Published var leftButtonType: LeftButtonType = .lapPassive
    @Published var totalTimeDegree: Double = 0
    @Published var currentLapDegree: Double?
    
    private var lapIndex: Int = 0
    private var lapTimes: [Double] = []
    private var startDate: Date?
    private var timer: Timer?
    private var totalTimeElapse: Double = 0
    
    init() {
        self.reserView()
    }
    
    func rightButtonTapped() {
        if self.isLapStarted {
            self.updateTimes()
            self.timer?.invalidate()
            self.leftButtonType = .reset
        } else {
            self.startDate = Date()
            self.updatePresenters()
            self.timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { [weak self] (_) in
                self?.updateCurrentLapTime()
            })
            self.leftButtonType = .lapActive
        }
        self.isLapStarted.toggle()
    }
    
    func leftButtonTapped() {
        switch self.leftButtonType {
            case .lapPassive:
                ()
            case .lapActive:
                self.updateTimes()
                self.lapTimes.append(0)
                self.lapIndex += 1
                self.startDate = Date()
                self.updatePresenters()
            case .reset:
                self.reserView()
            case .cancel:
                ()
        }
    }
    
    func updateTimes() {
        let timeElapsed = self.getTimeElapsed()
        self.totalTimeElapse += timeElapsed
        self.lapTimes[self.lapIndex] += timeElapsed
    }
    
    private func reserView() {
        self.leftButtonType = .lapPassive
        self.presenters = []
        self.lapTimes = []
        self.lapTimes.append(0)
        self.lapIndex = 0;
        self.totalFormattedTime = self.getFormattedString(0)
        self.totalTimeElapse = 0
        self.totalTimeDegree = 0
        self.currentLapDegree = 0
    }
    
    private func updateCurrentLapTime() {
        var timeElapsed: TimeInterval = 0
        var lapTimeElapsed: TimeInterval = 0
        
        if startDate != nil {
            lapTimeElapsed =  self.getTimeElapsed() + self.lapTimes[self.lapIndex]
            timeElapsed = self.getTimeElapsed() + self.totalTimeElapse
            
            if timeElapsed != 0 {
                self.totalTimeDegree = Double.pi * Double(timeElapsed) / 30
            }
            
            if lapTimeElapsed != 0 {
                self.currentLapDegree = Double.pi * Double(lapTimeElapsed) / 30
            }
        }
//        timeElapsed += self.lapTimes[self.lapIndex]
        self.totalFormattedTime = self.getFormattedString(timeElapsed)
        self.presenters[0].time = self.getFormattedString(lapTimeElapsed)
    }
    
    private func getTimeElapsed() -> Double {
        return Date().timeIntervalSince1970 - self.startDate!.timeIntervalSince1970
    }
    
    private func getFormattedString(_ timeElapsed: Double) -> String {
        var timeElapsed = timeElapsed
        let mintues: Int = Int(timeElapsed / 60)
        timeElapsed -= Double(mintues) * 60
        
        let seconds: Int = Int(timeElapsed)
        timeElapsed -= Double(seconds)
        
        let miliseconds = Int(timeElapsed * 100)
        
        return String(format: "%02d:%02d:%02d", mintues, seconds, miliseconds)

    }
    
    func updatePresenters() {
        self.presenters = []
        for (index, lap) in self.lapTimes.enumerated() {
            self.presenters.append(LapItemPresenter(lap: "Lap \(index + 1)", time: self.getFormattedString(lap), type: .normal))
        }
        var times = self.lapTimes
        times.removeLast()
        if times.count > 1 {
            var minIndex = 0
            var maxIndex = 0
            for (index, time) in times.enumerated(){
                if time < times[minIndex] {
                    minIndex = index
                }
                if time > times[maxIndex] {
                    maxIndex = index
                }
            }
            self.presenters[minIndex].type = .best
            self.presenters[maxIndex].type = .worst
        }
        self.presenters.reverse()
    }
}
