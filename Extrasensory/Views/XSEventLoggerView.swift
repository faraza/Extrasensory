//
//  XSEventLoggerView.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 1/4/22.
//

import SwiftUI

struct XSEventLoggerView: View {
    @StateObject var goalsModel = GoalsModel()
    
    var body: some View {
        NavigationView{
            VStack{
                //            Text("Add Event")
                //                .font(.largeTitle)
                //                .fontWeight(.bold)
                
                
                GoalsPicker()
                    .environmentObject(goalsModel)
                
                Button(action: {}){
                    Text(XSEventType.urge.rawValue)
                        .fontWeight(.bold)
                        .padding()
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .frame(minWidth: 1000)
                }
                .background(XSEventType.urge.textColor)
                //TODO: Long hold for danger zone
                
                
                Button(action: {}){
                    Text(XSEventType.lapseStart.rawValue)
                        .fontWeight(.bold)
                        .padding()
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .frame(minWidth: 1000)
                }
                .background(XSEventType.lapseStart.textColor)
                //TODO: Long hold for atomic lapse
                
            }.navigationTitle("Add Event")
            
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct XSEventLoggerView_Previews: PreviewProvider {
    static var previews: some View {
        XSEventLoggerView()
    }
}
