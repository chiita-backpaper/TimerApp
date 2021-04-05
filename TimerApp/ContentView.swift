//
//  ContentView.swift
//  TimerApp
//
//  Created by Taichi Uragami on R 3/03/28.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var timerManager = TimerManager()
    
    @State var timerMode: TimerMode = .initial
    
    @State var selectPickerIndexMinute = 0
    @State var selectPickerIndexSecond = 0
    
    let availableMinutes = Array(0...59)
    let availableSeconds = Array(0...59)
    
    var body: some View {
        NavigationView{
            VStack{
                Text(secondsToMinutesAndSeconds(seconds: timerManager.secondsLeft))
                    .font(.system(size: 60, design: .monospaced))
                    .padding(.top, 80)
                Image(systemName: timerManager.timerMode == .running ? "pause.circle.fill" : "play.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .foregroundColor(.red)
                    .onTapGesture(perform: {
                        if self.timerManager.timerMode == .initial{
                            self.timerManager.setTimerLength(
                                time: self.availableMinutes[self.selectPickerIndexMinute]*60 + self.availableSeconds[self.selectPickerIndexSecond]
                                )
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
                    HStack {
                        Picker(selection: $selectPickerIndexMinute, label: Text("")){
                            ForEach(0 ..< availableMinutes.count){
                                Text("\(self.availableMinutes[$0]) min")
                            }
                        }
                        .labelsHidden()
                        .frame(width: 80)
                        .clipped()
                        
                        Picker(selection: $selectPickerIndexSecond, label: Text("")){
                            ForEach(0 ..< availableSeconds.count){
                                Text("\(self.availableSeconds[$0]) sec")
                            }
                        }
                        .labelsHidden()
                        .frame(width: 80)
                        .clipped()
                    }
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
        }
    }
}
