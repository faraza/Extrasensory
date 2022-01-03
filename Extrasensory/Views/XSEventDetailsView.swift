//
//  XSEventDetailsView.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 1/3/22.
//

import SwiftUI

struct ListInfoItem: View{
    var propertyName: String
    var propertyVal: String
    var propertyValColor: Color?
    
    var body: some View{
        HStack{
            Text(propertyName)
                .bold()
            Spacer()
            Text(propertyVal)
                .foregroundColor(propertyValColor ?? .gray)
        }
    }
}

struct XSEventDetailsView: View{
    var event: XSEvent
    @State var textfieldString = ""
    
    var body: some View{
        Form{
            Section(header: Text("Event")){
                List{
                    ListInfoItem(propertyName: "Goal", propertyVal: event.goal)
                    ListInfoItem(propertyName: "Type", propertyVal: event.typeOfEvent.rawValue, propertyValColor: event.typeOfEvent.textColor)
                    ListInfoItem(propertyName: "Date", propertyVal: event.getPrintableDate())
                    ListInfoItem(propertyName: "Time", propertyVal: event.getPrintableTime())
                }
            }
            Section(header: Text("Description")){
                TextEditor(text: $textfieldString)
                    .frame(minHeight: 200)
            }
        }
    }
}

struct XSEventDetailsView_Previews: PreviewProvider {
    static var events = XSEvent.sampleData
    static var previews: some View {
        XSEventDetailsView(event: events[0])
    }
}
