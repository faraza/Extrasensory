//
//  MoreButtonsView.swift
//  Extrasensory WatchKit Extension
//
//  Created by Faraz Abidi on 12/31/21.
//

import SwiftUI

struct MoreButtonsView: View {
    var body: some View {
        VStack{
            Text("Nail Biting")
            Button(action:{}){ //TODO: State variable
                Text("Lapse Start")
            }
            Button(action: {}){
                Text("Atomic Lapse")
            }
        }
    }
}

struct MoreButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        MoreButtonsView()
    }
}
