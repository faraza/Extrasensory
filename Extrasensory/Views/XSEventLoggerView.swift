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
        
        VStack{
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
            
            Button(action: {}){
                Text(XSEventType.dangerZone.rawValue)
                    .fontWeight(.bold)
                    .padding()
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .frame(minWidth: 1000)
            }
            .background(XSEventType.dangerZone.textColor)
            
            Button(action: {}){
                Text(XSEventType.lapseStart.rawValue)
                    .fontWeight(.bold)
                    .padding()
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .frame(minWidth: 1000)
            }
            .background(XSEventType.lapseStart.textColor)
                                    
        }
    }
}

struct XSEventLoggerView_Previews: PreviewProvider {
    static var previews: some View {
        XSEventLoggerView()
    }
}
