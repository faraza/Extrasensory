//
//  ESEventsListView.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 12/30/21.
//

import SwiftUI

struct XSEventsListView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: XSEvent.entity(), sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: true)])
    private var events: FetchedResults<XSEvent>
    @State private var showingAlert = false
    
    var _previewEvents: [XSEvent]? = nil
        
    var body: some View {
        if #available(iOS 15.0, *) {
            NavWrappedEventsList
                .navigationViewStyle(StackNavigationViewStyle())
                .alert("Exported to Files as a .json", isPresented: $showingAlert){
                    Button("OK", role: .cancel){}
                }
        } else {
            NavWrappedEventsList
                .navigationViewStyle(StackNavigationViewStyle())                
        }
            
    }
}

extension XSEventsListView{
    private var NavWrappedEventsList: some View{
        let groupedEvents = _previewEvents == nil ? XSEvent.groupEventsByDate(events: events) : XSEvent.groupEventsByDate(events: _previewEvents!)
        
        return NavigationView{
            List{
                ForEach(groupedEvents){ group in
                    Section(header: Text(group.groupDate)){
                       ForEach(group.events){ event in
                            NavigationLink(destination: XSEventDetailsView(event: event)){
                                XSEventCardView(event: event)
                            }
                        }
                        .onDelete(){ offsets in
                            for offset in offsets{
                                let eventToDelete = group.events[offset]
                                managedObjectContext.delete(eventToDelete)
                                CoreDataStore.shared.saveContext()
                            }
                        }
                    }
                }
            }
            .navigationTitle("Saved Events")
            .toolbar{
                ToolbarItemGroup(placement: .primaryAction){
                    Button("Export"){
                        CoreDataStore.shared.exportToJSON()
                        showingAlert = true
                    }
                }
            }
        }
    }
}

struct XSEventsListView_Previews: PreviewProvider {
    
    static var previews: some View {
        XSEventsListView(_previewEvents: XSEvent.sampleData)
    }
}
