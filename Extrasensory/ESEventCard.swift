//
//  ESEventCard.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 12/30/21.
//

import SwiftUI

struct ESEventCard: View {
    let event: ESEvent
    var body: some View {
        HStack{
            Text(event.goal)
                .accessibilityLabel("goal")
            Text(event.typeOfEvent.rawValue)
            Text(event.getPrintableTime())
        }
    }
}

struct ESEventCard_Previews: PreviewProvider {
    static var previews: some View {
        ESEventCard(event: ESEvent.sampleData[0])
//            .previewLayout(.sizeThatFits)
    }
}
