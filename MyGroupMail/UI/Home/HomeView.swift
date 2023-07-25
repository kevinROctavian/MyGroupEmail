//
//  ContentView.swift
//  MyGroupMail
//
//  Created by Kevin Renata on 25/07/23.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var vm = HomeViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView{
                Button("refresh") {
                    vm.getGroupList()
                }
                ForEach($vm.group){ group in
                    GroupItemView(group: group, onEmailTapped: {
                        vm.composeMessage(group: group.wrappedValue)
                    }) {
//                        vm.getGroupList()
                        
                    }.padding(.bottom, 20)
                }.padding(20.0)
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    NavigationLink(destination:
                                    GroupView(name: "", emails: []).onDisappear(perform: {
//                        vm.getGroupList()
                    })) {
                        Text("Add Group")
                    }
                }
            }
        }
        .onAppear {
            vm.getGroupList()
        }
    }
}

struct GroupItemView: View{
    @Binding var group: Group
    
    var onEmailTapped: () -> ()
    var onItemEdited: () -> ()
    
    var body: some View {
        VStack(alignment: .leading){
            HStack(alignment: .center){
                Text(group.name).font(.title3)
                Spacer()
                if (group.emails.isEmpty == false){
                    Button("Email", action: onEmailTapped)
                }
                NavigationLink(destination: GroupView(id: group.groupId, name: group.name, emails: group.emails).onDisappear(perform: onItemEdited)) {
                    Text("Edit")
                }
            }
            ForEach(group.emails){ email in
                Text("\t\(email.name)").foregroundColor(.gray)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    
    
    static var previews: some View {
        HomeView()
    }
}
