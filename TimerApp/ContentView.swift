//
//  ContentView.swift
//  TimerApp
//
//  Created by Taichi Uragami on R 3/03/28.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    @ObservedObject var timerManager = TimerManager()
    
    @State var timerMode: TimerMode = .initial
    
    @State var selectPickerIndex = 0
    
    let availableMinutes = Array(1...59)
    var body: some View {
        NavigationView{
            VStack{
                Text(secondsToMinutesAndSeconds(seconds: timerManager.secondsLeft))
                    .font(.system(size: 80))
                    .padding(.top, 80)
                Image(systemName: timerManager.timerMode == .running ? "pause.circle.fill" : "play.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .foregroundColor(.red)
                    .onTapGesture(perform: {
                        if self.timerManager.timerMode == .initial{
                            self.timerManager.setTimerLength(minutes: self.availableMinutes[self.selectPickerIndex]*60)
                        }
                        self.timerManager.timerMode == .running ? self.timerManager.pause() : self.timerManager.start()
                    })
                if timerManager.timerMode == .paused  {
                    Image(systemName: "gobackward")
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .padding(.top, 40)
                        .onTapGesture(perform: {
                            self.timerManager.reset()
                        })
                }
                if timerManager.timerMode == .initial {
                    Picker(selection: $selectPickerIndex, label: Text("")){
                        ForEach(0 ..< availableMinutes.count){
                            Text("\(self.availableMinutes[$0]) min")
                        }
                    }
                    .labelsHidden()
                }
                Spacer()
            }
            .navigationBarTitle("Timer")
        }
        .environment(\.colorScheme, .dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
        }
    }
}
