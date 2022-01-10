//
//  GoalDetailView.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 1/9/22.
//

import SwiftUI

struct GoalDetailView: View{
    @Environment(\.presentationMode) var presentationMode
    
    var existingGoalEntity: String? = nil //TODO: Make it the goal entity once that's been added
//        var existingGoalEntity: String? = "Sup"
    @State private var goalName = ""
    @State private var goalDescription = ""
    @State private var isActiveGoal = true
    
    private var nameTextField: some View{
        if let unwrapped = existingGoalEntity{
            return AnyView(Text("\(unwrapped)"))
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
    
    func updateCoreData(){
        //TODO
    }
    
    var body: some View{
        
        Form{
            nameTextField
            TextField("Description", text: $goalDescription)
            Toggle(isOn: $isActiveGoal){
                Text("Active")
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
