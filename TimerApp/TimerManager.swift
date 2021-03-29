//
//  TimerManager.swift
//  TimerApp
//
//  Created by Taichi Uragami on R 3/03/28.
//

//  追加すると良さそうな機能
//  ・アラーム機能
//  ・秒数まで指定できるように

import Foundation
import SwiftUI

class TimerManager: ObservableObject{
    
    @Published var timerMode: TimerMode = .initial
    
    @Published var secondsLeft = UserDefaults.standard.integer(forKey: "timerLength")
    
    
//  Timer
//  scheduledTimer(): create timer
//  invalidate(): finish timer
//  fire(): call the timer at any time
    
    var timer = Timer()
    
    func setTimerLength(minutes: Int){
        let defaults = UserDefaults.standard
        defaults.set(minutes, forKey: "timerLength")
        secondsLeft = minutes
    }
    
    func start() {
        timerMode = .running
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: {timer in
            self.secondsLeft -= 1
            
            if self.secondsLeft == 0 {
                self.timerMode = .initial
//              self.secondsLeft = 60
                timer.invalidate()
            }
        })
    }
    
    func reset() {
        self.timerMode = .initial
        self.secondsLeft = 0
        timer.invalidate()
    }
    
    func pause() {
        self.timerMode = .paused
        timer.invalidate()
    }
    
}
