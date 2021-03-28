//
//  TimerManager.swift
//  TimerApp
//
//  Created by Taichi Uragami on R 3/03/28.
//

import Foundation
import SwiftUI

class TimerManager: ObservableObject{
    
    @Published var timerMode: TimerMode = .initial
    
    @Published var secondsLeft = UserDefaults.standard.integer(forKey: "timerLength")
    
    var timer = Timer()
    
    func setTimerLength(minutes: Int){
        let defaults = UserDefaults.standard
        defaults.set(minutes, forKey: "timerLength")
        secondsLeft = minutes
    }
    
    func start() {
        timerMode = .running
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: {timer in
            if self.secondsLeft == 0 {
                self.timerMode = .initial
                self.secondsLeft = 60
                timer.invalidate()
            }
            self.secondsLeft -= 1
        })
    }
    
    func reset() {
        self.timerMode = .initial
        self.secondsLeft = 60
        timer.invalidate()
    }
    
    func pause() {
        self.timerMode = .paused
        timer.invalidate()
    }
    
}
