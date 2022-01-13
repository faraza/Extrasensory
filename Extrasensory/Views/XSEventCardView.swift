//
//  ESEventCard.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 12/30/21.
//

import SwiftUI

struct XSEventCardView: View {
    let event: XSEvent
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: Goal.entity(), sortDescriptors: [NSSortDescriptor(key: "activeListPosition", ascending: false)])
    private var allGoals: FetchedResults<Goal>        
    
    var body: some View {
        HStack{
            Text(GoalCDInterface.getGoalNameFromKey(goalKey: event.goalKey, goalsList: allGoals))
                .font(.headline)                
                .accessibilityLabel("goal")
            Text(event.urgeFamilyType!)
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(UrgeFamilyType(rawValue: event.urgeFamilyType!)!.textColor)
            Spacer()
            Text(event.getPrintableTime())
                .foregroundColor(Color.gray)
        }
        .padding(.horizontal)
    }
}

struct XSEventCard_Previews: PreviewProvider {
    static let event = XSEvent.fromData(typeOfEvent: .atomicLapse, intervalTimeStamp: 1000, goal: "random")
    static var previews: some View {
        XSEventCardView(event: event)
    }
}
