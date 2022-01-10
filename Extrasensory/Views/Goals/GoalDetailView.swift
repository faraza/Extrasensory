//
//  GoalDetailView.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 1/9/22.
//

import SwiftUI

struct GoalDetailView: View{
    @Environment(\.presentationMode) var presentationMode
    
    var existingGoalEntity: Goal? = nil
    
    @State private var goalName = ""
    @State private var goalDescription = ""
    @State private var isActiveGoal = false
    
    
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
            GoalCDInterface.shared.updateGoal(goalEntity: unwrapped, goalDescription: goalDescription, isActiveGoal: isActiveGoal)
        }
        else{
            GoalCDInterface.shared.addGoal(goalName: goalName, goalDescription: goalDescription, isActiveGoal: isActiveGoal)
        }
    }
    
    var body: some View{
        
        Form{
            nameTextField
            Toggle(isOn: $isActiveGoal){
                Text("Active")
            }
            Section(header: Text("Description")){
                TextEditor(text: $goalDescription)
                    .frame(minHeight: 200)
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
