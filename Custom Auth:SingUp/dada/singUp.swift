//
//  singUp.swift
//  dada
//
//  Created by Danil Bochkarev on 29.09.2022.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseCore

struct singUp: View {
    @State private var newUser = ""
    @State private var newPass = ""
    @State private var repeatPass = ""
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    @State var hidde = true
    @State var checkStatusMail = ""
    
    var body: some View {
        singUp()
    }
    
    struct backgroundTwoScreen: View {
        var body : some View {
            LinearGradient(gradient: Gradient(colors: [Color("two"), Color("one")]), startPoint: .topLeading, endPoint: .bottomLeading).edgesIgnoringSafeArea(.all)
        }
    }
    
    struct singUp: View {
        var body: some View {
            NavigationView {
                ZStack {
                    backgroundTwoScreen()
                    singUpScreen()
                }
            }
        }
    }
    
    struct singUpScreen: View {
        @State private var newUser = ""
        @State private var newPass = ""
        @State private var repeatPass = ""
        @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
        @State var hidde = true
        @State private var showingAlert = false

        
        var body: some View {
            VStack {
                Image(systemName: "figure.fall")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                    .frame(width: 180, height: 180)
                    .shadow(color: .white, radius: 3)
                
                
                VStack {
                    VStack(alignment: .leading){
                        VStack(spacing: 15){
                            
                            Text("Mail")
                                .foregroundColor(.white)
                                .font(.system(size: 25, weight: .medium))
                                .fontWeight(.bold)
                                .frame(width: 350, height: 20, alignment: .topLeading)
                                .shadow(color: .white, radius: 1)
                            
                            
                            
                            HStack{
                                TextField("Enter Your Mail", text: $newUser)
                                    .foregroundColor(.black)
                                    .font(.system(size: 20, weight: .medium))
                                    .autocapitalization(.none)
                                    .keyboardType(.asciiCapable)
                                
                                
                                if isValidEmail(testStr: self.newUser) == true {
                                    Image(systemName: "checkmark.circle")
                                        .foregroundColor(.green)
                                        .frame(width: 20, height: 20)
                                    
                                } else if ((isValidEmail(testStr: self.newUser) == false) && (self.newUser.count > 1)) {
                                    Image(systemName: "xmark.circle")
                                        .foregroundColor(.red)
                                        .frame(width: 20, height: 20)
                                }
                            }
                            Divider()
                        }.padding(.bottom, 25)
                        
                        VStack(spacing: 15){
                            
                            Text("Password")
                                .foregroundColor(.white)
                                .font(.system(size: 25, weight: .medium))
                                .fontWeight(.bold)
                                .frame(width: 350, height: 20, alignment: .topLeading)
                                .shadow(color: .white, radius: 1)
                            
                            HStack {
                                
                                if self.hidde {
                                    TextField("Password (more than 6 characters)", text: $newPass)
                                        .foregroundColor(.black)
                                        .font(.system(size: 20, weight: .medium))
                                        .autocapitalization(.none)
                                        .keyboardType(.asciiCapable)
                                } else {
                                    SecureField("Password (more than 6 characters)", text: $newPass)
                                        .foregroundColor(.black)
                                        .font(.system(size: 20, weight: .medium))
                                        .autocapitalization(.none)
                                        .keyboardType(.asciiCapable)
                                }
                                
                                Button(action: {
                                    self.hidde.toggle()
                                }) {
                                    if self.newPass.count > 0 {
                                        Image(systemName: self.hidde ? "eye.fill": "eye.slash.fill")
                                            .frame(width: 10, height: 10)
                                            .foregroundColor((self.hidde == true) ? Color.green : Color.secondary)
                                    }
                                }
                                
                            }
                            Divider()
                        }.padding(.bottom, 25)
                        
                        VStack(spacing: 15){
                            
                            Text("Repeat Password")
                                .foregroundColor(.white)
                                .font(.system(size: 25, weight: .medium))
                                .fontWeight(.bold)
                                .frame(width: 350, height: 20, alignment: .topLeading)
                                .shadow(color: .white, radius: 1)
                            
                            HStack { //Repeat
                                
                                if self.hidde {
                                    TextField("Repeat Your Password", text: $repeatPass)
                                        .foregroundColor(.black)
                                        .font(.system(size: 20, weight: .medium))
                                        .autocapitalization(.none)
                                        .keyboardType(.asciiCapable)
                                } else {
                                    SecureField("Repeat Your Password", text: $repeatPass)
                                        .foregroundColor(.black)
                                        .font(.system(size: 20, weight: .medium))
                                        .autocapitalization(.none)
                                        .keyboardType(.asciiCapable)
                                }
                                
                                Button(action: {
                                    self.hidde.toggle()
                                }) {
                                    if self.repeatPass.count > 0 {
                                        Image(systemName: self.hidde ? "eye.fill": "eye.slash.fill")
                                            .frame(width: 10, height: 10)
                                            .foregroundColor((self.hidde == true) ? Color.green : Color.secondary)
                                    }
                                }
                                
                            }
                            Divider()
                        }.padding(.bottom, 25)
                        
                    }.padding(.horizontal, 6)
                    
                }.padding()
                VStack {
                    
                    Button(action: {
                        if (isValidEmail(testStr: self.newUser) == true && self.newPass == self.repeatPass && newUser.count > 6 && self.newPass.count != 0 && self.repeatPass.count != 0 && self.newPass.count > 6) {
                            
                            print("Mail: \(newUser)")
                            print("Password: \(newPass)")
                            print("Repeat password status: true")
                            
                            func register() {
                                Auth.auth().createUser(withEmail: newUser, password: newPass) { result, error in
                                    if error != nil {
                                        print(error!.localizedDescription)
                                    }
                                }
                            }
                            
                            register()
                        } else {
                            showingAlert = true
                        }
                    }) {
                        
                        Text("Verify")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width - 220).padding()
                            .alert(isPresented: $showingAlert) {
                                        Alert(
                                            title: Text("Error 🤯"),
                                            message: Text("You entered incorrect data."),
                                            dismissButton: .default(Text("Reenter")))
                                    }
                        
                    }.background((isValidEmail(testStr: self.newUser) == true && self.newPass == self.repeatPass && newUser.count > 6 && self.newPass.count != 0 && self.repeatPass.count != 0 && self.newPass.count > 6) ? Color.green : Color.secondary)
                        .clipShape(Capsule())
                        .padding(.top, 5)
                        .shadow(color: (isValidEmail(testStr: self.newUser) == true && self.newPass == self.repeatPass && newUser.count > 6 && self.newPass.count != 0 && self.repeatPass.count != 0 && self.newPass.count > 6) ? .green : .black, radius: (isValidEmail(testStr: self.newUser) == true && self.newPass == self.repeatPass && newUser.count > 6 && self.newPass.count != 0 && self.repeatPass.count != 0 && self.newPass.count > 6) ? 12 : 0)
                    
                }.padding(.top, 15)
            }
        }
    }
    
}





struct singUp_Previews: PreviewProvider {
    static var previews: some View {
        singUp()
    }
}




