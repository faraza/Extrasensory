//
//  UrgeView.swift
//  Extrasensory WatchKit Extension
//
//  Created by Faraz Abidi on 12/31/21.
//

import SwiftUI

struct UrgeView: View {
    var body: some View {
        VStack{
            Text("Nail Biting")
            Button(action: {}){
                Text("Urge")
                    .font(.largeTitle)
                    .fontWeight(.thin)
                    .padding(.vertical, 30) //TODO: Don't hardcode the number
            }
            
            
        }
    }
}

struct UrgeView_Previews: PreviewProvider {
    static var previews: some View {
        UrgeView()
    }
}
