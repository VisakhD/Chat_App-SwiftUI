//
//  ContentView.swift
//  Chat_App
//
//  Created by Visakh D on 19/02/25.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct LogInView: View {
    @State var isLogInMode = false
    @State var email = ""
    @State var password = ""
    @State var shouldShowImagePicker = false
    @State var logInStatusMessage = ""
    @State var image : UIImage?
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some View {
    
        NavigationView {
                ScrollView{
                    VStack(spacing:16){
                        Picker("selection", selection: $isLogInMode) {
                            Text("LogIn")
                                .tag(true)
                            Text("Create Account")
                                .tag(false)
                            
                        }.pickerStyle(SegmentedPickerStyle())
                         
                        if isLogInMode == false {
                            Button {
                                shouldShowImagePicker.toggle()
                            } label: {
                                VStack{
                                    if let image = image {
                                        Image(uiImage: image)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 128, height: 128)
                                            .cornerRadius(64)
                                    }else {
                                        Image(systemName: "person.fill")
                                            .font(.system(size: 64))
                                            .padding()
                                            .foregroundStyle(Color(.label))
                                    }
                                } .overlay(RoundedRectangle(cornerRadius: 64)
                                    .stroke(Color.black, lineWidth: 3))
                                
                            }
                        }
                        
                        Group{
                            TextField("Enter Email", text: $email)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                            
                            SecureField("Enter Password", text: $password)
                               
                        } .padding(12)
                          .background(Color.white)
                          .cornerRadius(8)
                        
                        Button {
                            handleAction()
                        } label: {
                            HStack{
                                Spacer()
                                Text(isLogInMode ? "Log In" :"Create Account")
                                    .foregroundStyle(.white)
                                    .padding(.vertical,10)
                                    .font(.system(size: 14 , weight: .semibold))
                                Spacer()
                            }.background(Color.blue)
                             .cornerRadius(5)
                        }
                        Text(self.logInStatusMessage)
                            .foregroundStyle(.red)
                    }
                    .padding()
                  
                    
                    
                }.navigationTitle(isLogInMode ? "Log In" : "Create Account")
                 .background(Color(.init(white: 0, alpha: 0.05))
                    .ignoresSafeArea())
        }.fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil) {
            ImagePicker(image: $image)
        }
        
    
    }
    
  
    
    private func handleAction() {
        if isLogInMode {
            logInUser()
        }else {
            createNewAccount()
           
        }
    }
    
    private func logInUser() {
        Auth.auth().signIn(withEmail: email, password: password) { result, err in
            if let error = err {
                debugPrint("Failed to logIn User\(error.localizedDescription)")
                self.logInStatusMessage = "Failed to LogIn User\(error.localizedDescription)"
                return
            }
            debugPrint("Successfully Logged User \(result?.user.uid ?? "")")
            self.logInStatusMessage = "Successfully Logged User\(result?.user.uid ?? "")"
            email = ""
            password = ""
        }
    }
    
    private func createNewAccount() {
        Auth.auth().createUser(withEmail: email, password: password) { result, err in
            if let error = err {
                debugPrint("Failed to Create User\(error.localizedDescription)")
                self.logInStatusMessage = "Failed to Create User\(error.localizedDescription)"
                return
            }
            debugPrint("Successfully Created User\(result?.user.uid ?? "")")
            self.logInStatusMessage = "Successfully Created User\(result?.user.uid ?? "")"
            email = ""
            password = ""
        }
    }
}

#Preview {
    LogInView()
}
