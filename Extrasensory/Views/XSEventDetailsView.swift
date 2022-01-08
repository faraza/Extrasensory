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
    var event: XSEventEntity
    @State var textfieldString = ""
    @Environment(\.scenePhase) private var scenePhase

    var saveNewDescription: (XSEventEntity, String)->Void //TODO
     
    var body: some View{
        Form{
            Section(header: Text("Event")){
                List{
                    ListInfoItem(propertyName: "Goal", propertyVal: event.goal!)
                    ListInfoItem(propertyName: "Type", propertyVal: event.typeOfEvent!, propertyValColor: XSEventType(rawValue: event.typeOfEvent!)?.textColor, shouldBoldVal: true)
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
//                saveNewDescription(event, textfieldString)
                event.userNotes = textfieldString
                CoreDataStore.shared.saveContext() //TODO: This doesn't work
                
            }
        }
        .onAppear{
            textfieldString = event.userNotes ?? ""
        }
        .onDisappear{
            saveNewDescription(event, textfieldString)
        }
    }
}

struct XSEventDetailsView_Previews: PreviewProvider {
    static var events = XSEventEntity.sampleData
    static var previews: some View {
        XSEventDetailsView(event: events[0]){ event, newText in
            
        }
    }
}
