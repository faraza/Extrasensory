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
    var shouldBoldVal: Bool = false
    
    var body: some View{
        HStack{
            Text(propertyName)
                .bold()
            Spacer()
            if(shouldBoldVal){
                Text(propertyVal)
                    .foregroundColor(propertyValColor ?? .gray)
                    .bold()
            }
            else{
                Text(propertyVal)
                .foregroundColor(propertyValColor ?? .gray)
            }
        }
    }
}

struct XSEventDetailsView: View{
    var event: XSEvent
    @State var textfieldString = ""
    @Environment(\.scenePhase) private var scenePhase

     
    var body: some View{
        Form{
            Section(header: Text("Event")){
                List{
                    ListInfoItem(propertyName: "Goal", propertyVal: event.goalKey!)
                    ListInfoItem(propertyName: "Type", propertyVal: event.urgeFamilyType!, propertyValColor: XSEventType(rawValue: event.urgeFamilyType!)?.textColor, shouldBoldVal: true)
                    ListInfoItem(propertyName: "Date", propertyVal: event.getPrintableDate())
                    ListInfoItem(propertyName: "Time", propertyVal: event.getPrintableTime())
                }
            }
            Section(header: Text("Description")){
                TextEditor(text: $textfieldString)
                    .frame(minHeight: 200)
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive {
                event.userNotes = textfieldString
                CoreDataStore.shared.saveContext()                
            }
        }
        .onAppear{
            textfieldString = event.userNotes ?? ""
        }
        .onDisappear{
            event.userNotes = textfieldString
            CoreDataStore.shared.saveContext()
        }
    }
}

struct XSEventDetailsView_Previews: PreviewProvider {
    static var events = XSEvent.sampleData
    static var previews: some View {
        XSEventDetailsView(event: events[0])
    }
}
