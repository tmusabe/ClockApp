//
//  AlarmWatchViewModel.swift
//  ClockApp
//
//  Created by BS-272 on 9/2/21.
//

import Foundation
import UserNotifications

class AlarmWatchViewModel: ObservableObject{
    @Published var time: AlarmTime = AlarmTime(minute: "00", hour: "12", meridium: "AM", weekdays: [false, false, false, false, false, false, false])
    @Published var leftButtonType: LeftButtonType = .cancel
    @Published var alert: AlertOption = AlertOption(type: .none, message: "")
    @Published var showingAlert: Bool = false
    @Published var alarmIsSet: Bool = false
    
    private var granted = false
    private let center = UNUserNotificationCenter.current()
    
    init() {
        center.requestAuthorization(options: [.alert, .badge, .sound]) { [self] (granted, error) in
            self.granted = granted
            if let error = error {
                print(error.localizedDescription)
            }
        }
        resetAlarm()
    }
    
    public func rightButtonTapped(){
        center.removeAllPendingNotificationRequests()
        self.setAlarm()
        self.leftButtonType = .cancel
    }
    
    public func leftButtonTapped() {
        switch leftButtonType {
        case .reset:
            resetAlarm()
            self.leftButtonType = .cancel
            break
        case .cancel:
            cancelAlarm()
        default:
            ()
            
        }
    }
    
    private func setAlarm() {
        var num: Int = 0
        
        if alarmIsSet {
            self.alert = AlertOption(type: .error, message: "Alarm has already set on this time")
            self.showingAlert = true
            return
        }
        
        for index in 0...6 {
            if time.weekdays[index] {
                let content = UNMutableNotificationContent()
                content.title = "Alarm"
                var dateComponents = DateComponents()
                dateComponents.hour = (time.meridium == "AM") ? Int(time.hour) : (Int(time.hour) ?? 0) + 12
                dateComponents.minute = Int(time.minute)
                dateComponents.weekday = index+1
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                center.add(request)
            } else {
                num = num + 1
            }
        }
        
        if num == 7 {
            self.alert = AlertOption(type: .error, message: "Select Any Weekday to set Alarm")
            self.showingAlert = true
        } else {
            self.alert = AlertOption(type: .success, message: "Alarm is set successfully")
            self.showingAlert = true
            self.alarmIsSet = true
        }
    }
    
    private func resetAlarm() {
        center.getPendingNotificationRequests { (alarms) in
            for alarm in alarms {
                if alarm.content.title == "Alarm" {
                    if let triggar:UNNotificationTrigger = alarm.trigger {
                        if let dateComponents: DateComponents = triggar.value(forKey: "dateComponents") as? DateComponents {
                            DispatchQueue.main.async {
                                if dateComponents.hour! > 12 {
                                    self.time.meridium = "PM"
                                    self.time.hour = String("0\(dateComponents.hour!-12)")
                                } else {
                                    self.time.meridium = "AM"
                                    self.time.hour = dateComponents.hour! < 10 ? String("0\(dateComponents.hour!)") : String(dateComponents.hour!)
                                }
                                self.time.minute = dateComponents.minute! < 10 ? String("0\(dateComponents.minute!)") : String(dateComponents.minute!)
                                self.time.weekdays[dateComponents.weekday!-1] = true
                                self.alarmIsSet = true
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func cancelAlarm() {
        center.removeAllPendingNotificationRequests()
        time = AlarmTime(minute: "00", hour: "12", meridium: "AM", weekdays: [false, false, false, false, false, false, false])
        if alarmIsSet {
            self.alert = AlertOption(type: .success, message: "Alarm is unset successfully")
        } else {
            self.alert = AlertOption(type: .error, message: "No Alarm is set for cancel")
        }
        self.showingAlert = true
        self.alarmIsSet = false
    }
}


