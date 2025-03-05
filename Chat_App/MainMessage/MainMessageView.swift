//
//  MainMessageView.swift
//  Chat_App
//
//  Created by Visakh D on 05/03/25.
//

import SwiftUI

struct MainMessageView: View {
    var body: some View {
        NavigationView{
            VStack{
                //custnm nav
                HStack(spacing: 16){
                    
                    Image(systemName: "person.fill")
                        .font(.system(size: 34,weight: .heavy))
                    
                    VStack(alignment:.leading,spacing: 4){
                        Text("USERNAME")
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
                    Image(systemName: "gear")
                }.padding()
                
                ScrollView{
                    ForEach (0..<10, id: \.self) { num in
                        VStack{
                            HStack(spacing: 16){
                                Image(systemName: "person.fill")
                                    .font(.system(size: 32))
                                    .padding(8)
                                    .overlay(RoundedRectangle(cornerRadius: 44)
                                        .stroke(Color.black, lineWidth:1)
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
                }
            }
           
        }.navigationBarHidden(true)
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
        }

    }
}

#Preview {
    MainMessageView()
}
