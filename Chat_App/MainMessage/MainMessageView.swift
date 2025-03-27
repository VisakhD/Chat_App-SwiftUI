//
//  MainMessageView.swift
//  Chat_App
//
//  Created by Visakh D on 05/03/25.
//

import SwiftUI

struct ChatUser : Codable {
    var uid,email : String
}

class MainMessageViewModel : ObservableObject {
    
    @Published var errorMessage = ""
    @Published var chatUser : ChatUser?
    
    init() {
        fetchCurrentUser()
    }
    
  private func  fetchCurrentUser() {
    
      guard let uuid = FirebaseManager.shared.auth.currentUser?.uid else
      {return}
      
      FirebaseManager.shared.fireStore.collection("User").document(uuid).getDocument { shapShot, error in
          if let error = error {
              debugPrint("Failed to fetch Current user data \(error)")
          }
              
          guard let data = shapShot?.data()  else {
                  return}
          
          
          let uid = data["uuid"] as? String ?? ""
          let email = data["emailID"] as? String ?? ""
          self.chatUser = ChatUser(uid: uid, email: email)
          
      }
    }
}

struct MainMessageView: View {
    
    @State var shouldShowLogOutOptions = false
    
    @ObservedObject private var vm = MainMessageViewModel()
    
    var body: some View {
        NavigationView{
            VStack{
                //custnm nav
            customNavBar
            messageView
                
            }
           
        }.overlay(alignment: .bottom, content: {
         newMessageButton
        })
        .navigationBarHidden(true)
            

    }
    
    private var customNavBar: some View {
        HStack(spacing: 16){
            
            Image(systemName: "person.fill")
                .font(.system(size: 34,weight: .heavy))
            let email = vm.chatUser?.email.replacingOccurrences(of: "@gmail.com", with: "") ?? ""
            VStack(alignment:.leading,spacing: 4){
                Text(email)
                    .font(.system(size: 24,weight: .bold))
                HStack{
                    Circle()
                        .foregroundStyle(Color(.green))
                        .frame(width: 14,height: 14)
                    Text("online")
                        .font(.system(size: 12))
                        .foregroundStyle(Color(.gray))
                }
            }
           
            Spacer()
            Button {
                shouldShowLogOutOptions.toggle()
            } label: {
                Image(systemName: "gear")
                    .font(.system(size: 24,weight: .bold))
                    .foregroundStyle(Color(.label))
            }
        }.padding()
            .actionSheet(isPresented: $shouldShowLogOutOptions) {
                .init(title: Text("Settings"),message: Text("What do you want to do ?"),buttons: [
                    .destructive(Text("Sign Out"), action: {
                        print("handle sign out")
                    }),
                    .cancel()
                ])
            }
    }
    
 
}

private var messageView  :some View {
    ScrollView{
        ForEach (0..<15, id: \.self) { num in
            VStack{
                HStack(spacing: 16){
                    Image(systemName: "person.fill")
                        .font(.system(size: 32))
                        .padding(8)
                        .overlay(RoundedRectangle(cornerRadius: 44)
                            .stroke(Color(.label), lineWidth:1)
                        )
                    
                    VStack(alignment: .leading){
                        Text("Username")
                            .font(.system(size: 16,weight: .semibold))
                        Text("Message Sent to User")
                            .font(.system(size:14))
                            .foregroundStyle(Color(.lightGray))
                    }
                    Spacer()
                    Text("22d")
                        .font(.system(size: 14,weight: .semibold))
                }
                Divider()
                    .padding(.vertical,8)
            }.padding(.horizontal)
        }
    }.padding(.bottom,50)
}

private var newMessageButton : some View {
    Button {
        
    } label: {
        HStack{
            Spacer()
            Text("+ New Message")
                .font(.system(size:16,weight: .bold))
            Spacer()
        }
        .foregroundStyle(.white)
        .padding(.vertical)
            .background(Color(.blue))
            .cornerRadius(32)
            .padding(.horizontal)
            .shadow(radius : 15)
    }
}

#Preview {
    MainMessageView()
      //  .preferredColorScheme(.dark)
}
