//
//  EmailView.swift
//  MyGroupMail
//
//  Created by Kevin Renata on 25/07/23.
//

import SwiftUI

struct EmailView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var vm = EmailViewModel()
    
    @State private var email = ""
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Email:")
            TextField("Type your email here", text: $email)
            HStack{
                Spacer()
                Button(action: {
                    vm.saveEmail(email: Email(name: email, isChecked: true))
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Save")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 100, height: 50)
                        .background(Color.green)
                        .cornerRadius(15.0)
                }
            }.padding(.top, 10)
            Spacer()
        }.padding()
    }
}

struct EmailView_Previews: PreviewProvider {
    static var previews: some View {
        EmailView()
    }
}
