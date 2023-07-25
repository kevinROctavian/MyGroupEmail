//
//  GroupView.swift
//  MyGroupMail
//
//  Created by Kevin Renata on 25/07/23.
//

import SwiftUI

struct GroupView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var vm = GroupViewModel()
    
    var id = ""
    
    @State var name: String
    @State var emails: [Email]
    
    var body: some View {
        VStack{
            GroupHeaderView (name: $name)
            Spacer(minLength: 50)
            GroupEmailView(emailsInGroup: $emails, emails: $vm.emails) {}
        }.padding()
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("Save") {
                        vm.save(id: id, name: name, emailsInGroup: emails)
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .onAppear {
                vm.getAllEmailListExclude(email: emails)
            }
    }
}

struct GroupHeaderView: View{
    
    @Binding var name: String
    
    var body: some View{
        VStack(alignment: .leading){
            Text("Group Name:").font(.headline)
            TextField("Type your group name here", text: $name)
        }
    }
}

struct GroupEmailView: View{
    
    @Binding var emailsInGroup: [Email]
    @Binding var emails: [Email]
    
    var onAddEmailTapped: ()->()
    
    var body: some View{
        VStack(alignment: .leading){
            HStack{
                Text("Email").font(.headline)
                Spacer()
                NavigationLink("Add Email") {
                    EmailView()
                }
            }
            List{
                ForEach($emailsInGroup){ email in
                    EmailToggleView(email: email, isOn: email.isChecked)
                }
                ForEach($emails){ email in
                    EmailToggleView(email: email, isOn: email.isChecked)
                }
            }
        }
    }
}

struct EmailToggleView: View {
    
    @Binding var email: Email
    
    @Binding var isOn: Bool
    
    var body: some View {
        Toggle(isOn: $isOn) {
            Text(email.name)
        }.onChange(of: isOn) { newValue in
            email.isChecked = newValue
        }
    }
}

struct GroupView_Previews: PreviewProvider {
    static var previews: some View {
        GroupView(name: "", emails: [])
    }
}
