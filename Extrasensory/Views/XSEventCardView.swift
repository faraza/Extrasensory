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
            Text(event.goal)
                .font(.headline)                
                .accessibilityLabel("goal")
            Text(event.typeOfEvent.rawValue)
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(event.typeOfEvent.textColor)
            Spacer()
            Text(event.getPrintableTime())
                .foregroundColor(Color.gray)
        }
        .padding(.horizontal)
    }
}

struct XSEventCard_Previews: PreviewProvider {
    static var previews: some View {
        XSEventCardView(event: XSEvent.sampleData[0])
//            .previewLayout(.sizeThatFits)
    }
}
