//
//  LapItemPresenter.swift
//  ClockApp
//
//  Created by BS-272 on 5/1/21.
//

import Foundation
struct LapItemPresenter: Identifiable {
    
    let id = UUID()
    var lap: String = ""
    var time: String = ""
    var type: LapType = .normal
    
    
}
