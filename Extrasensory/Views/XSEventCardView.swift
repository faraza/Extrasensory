//
//  ESEventCard.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 12/30/21.
//

import SwiftUI

struct XSEventCardView: View {
    let event: XSEvent
    var body: some View {
        HStack{
            Text(event.goalKey!)
                .font(.headline)                
                .accessibilityLabel("goal")
            Text(event.urgeFamilyType!)
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(XSEventType(rawValue: event.urgeFamilyType!)!.textColor)
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
