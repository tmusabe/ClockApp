//
//  ContentView.swift
//  ClockApp
//
//  Created by BS-272 on 4/1/21.
//

import SwiftUI

struct ContentView: View {
            
    var body: some View {
        TabView {
            AlarmWatchView()
                .tabItem {
                    Image(systemName: "alarm")
                    Text("Alarm")
                }
            StopWatchView()
                .tabItem {
                    Image(systemName: "stopwatch")
                    Text("Stopwatch")
                }
            TimeWatchView()
                .tabItem {
                    Image(systemName: "clock")
                    Text("Time")
                }
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
