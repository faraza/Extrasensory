//
//  GoalDetailView.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 1/9/22.
//

import SwiftUI

struct GoalDetailView: View{
    @Environment(\.managedObjectContext) var managedObjectContext //TODO: Delete this. Should be handled by manager
    @Environment(\.presentationMode) var presentationMode
    
    var existingGoalEntity: Goal? = nil
    @State private var goalName = ""
    @State private var goalDescription = ""
    @State private var isActiveGoal = true
    
    
    private var nameTextField: some View{
        if let unwrapped = existingGoalEntity{
            return AnyView(Text("\(unwrapped.shortName!)"))
        }
        else{
            return AnyView(TextField("Goal Name", text: $goalName))
        }
    }
    
    private var navBarText: String{
        if(existingGoalEntity != nil){
            return "Edit Goal"
        }
        else{
            return "Add Goal"
        }
    }
    
    func updateCoreData(){ //TODO: Migrate all this stuff to manager
        if let unwrapped = existingGoalEntity{
            unwrapped.shortName = goalName
            unwrapped.isActive = isActiveGoal
            unwrapped.longDescription = goalDescription
        }
        else{
            let newGoalEntity = Goal(context: managedObjectContext)
            newGoalEntity.shortName = goalName
            newGoalEntity.isActive = isActiveGoal
            newGoalEntity.longDescription = goalDescription
        }
        do {
            try managedObjectContext.save()
            print("XSEventLogger. Saved successfully")
        }
        catch{
            print("ERROR -- XSEventLoggerView. Unable to save")
        }
    }
    
    var body: some View{
        
        Form{
            nameTextField
            TextField("Description", text: $goalDescription)
            Toggle(isOn: $isActiveGoal){
                Text("Active")
            }
        }
        .onAppear{
            if let unwrapped = existingGoalEntity{
                goalName = unwrapped.shortName ?? "SHORTNAME NOT SET"
                goalDescription = unwrapped.longDescription ?? ""
                isActiveGoal = unwrapped.isActive
            }
        }
        .navigationTitle(navBarText)
        .toolbar{
            ToolbarItem(placement: .cancellationAction){
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "xmark")
                })
            }
            ToolbarItem(placement: .confirmationAction){
                Button(action: {
                    updateCoreData()
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Save")
                })
                    .disabled(goalName.isEmpty)
            }
        }
        .navigationBarBackButtonHidden(true)
        
    }
    
}

struct GoalDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            GoalDetailView()
        }
    }
}
