//
//  ContentView.swift
//  dada
//
//  Created by Danil Bochkarev on 29.09.2022.


import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseCore

struct ContentView: View {
    @State private var user = ""
    @State private var pass = ""
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    

    var body : some View{
        authSrceen()
    }
}

struct backgroundScreen: View {
    var body : some View {
        LinearGradient(gradient: Gradient(colors: [Color("one"), Color("two")]), startPoint: .topLeading, endPoint: .bottomLeading).edgesIgnoringSafeArea(.all)
    }
}

struct mainScreen: View {
    @State private var user = ""
    @State private var pass = ""
    @State var hidde = false
    @State private var showingAlert1 = false
    
    var body: some View {
        VStack {
            Image(systemName: (isValidEmail(testStr: self.user) == true && self.pass.count > 6) ? "figure.wave" : "figure.stand")
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
                .frame(width: 180, height: 180)
                .shadow(color: (isValidEmail(testStr: self.user) == true && self.pass.count > 6) ? .white : .white, radius: (isValidEmail(testStr: self.user) == true && self.pass.count > 6) ? 3 : 3)


            VStack{
                VStack(alignment: .leading){
                    VStack(spacing: 15){
                        
                        Text("Mail")
                            .foregroundColor(.white)
                            .font(.system(size: 25, weight: .medium))
                            .fontWeight(.bold)
                            .frame(width: 350, height: 20, alignment: .topLeading)
                            .shadow(color: .white, radius: 1)
                            
                            

                        HStack{
                            TextField("Enter Your Mail", text: $user)
                                .foregroundColor(.black)
                                .font(.system(size: 20, weight: .medium))
                                .autocapitalization(.none)
                                .keyboardType(.asciiCapable)
                                

                            if isValidEmail(testStr: self.user) == true {
                                Image(systemName: "checkmark.circle")
                                    .foregroundColor(.green)
                                    .frame(width: 20, height: 20)
                            } else if ((isValidEmail(testStr: self.user) == false) && (self.user.count > 1)) {
                                Image(systemName: "xmark.circle")
                                    .foregroundColor(.red)
                                    .frame(width: 20, height: 20)
                            }
                        }
                        Divider()
                    }.padding(.bottom, 15)

                    VStack(spacing: 15){
                        
                        Text("Password")
                            .foregroundColor(.white)
                            .font(.system(size: 25, weight: .medium))
                            .fontWeight(.bold)
                            .frame(width: 350, height: 20, alignment: .topLeading)
                            .shadow(color: .white, radius: 1)
                        
                        HStack {
                            
                            if self.hidde {
                                TextField("Enter Your Password", text: $pass)
                                    .foregroundColor(.black)
                                    .font(.system(size: 20, weight: .medium))
                                    .autocapitalization(.none)
                                    .keyboardType(.asciiCapable)
                            } else {
                                SecureField("Enter Your Password", text: $pass)
                                    .foregroundColor(.black)
                                    .font(.system(size: 20, weight: .medium))
                                    .autocapitalization(.none)
                                    .keyboardType(.asciiCapable)
                            }
                            
                            Button(action: {
                                self.hidde.toggle()
                            }) {
                                if self.pass.count > 0 {
                                    Image(systemName: self.hidde ? "eye.fill": "eye.slash.fill")
                                        .frame(width: 10, height: 10)
                                        .foregroundColor((self.hidde == true) ? Color.green : Color.secondary)
                                }
                            }

                        }
                        Divider()
                    }

                }.padding(.horizontal, 6)

            }.padding()
            VStack {
                
                Button(action: {
                    if (isValidEmail(testStr: self.user) == true && self.pass.count > 6) {
                        print("Mail: \(user)")
                        print("Password: \(pass)")

                    } else {
                        showingAlert1 = true
                    }
                    
                }) {
                    Text("Sign In")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width - 220).padding()
                        .alert(isPresented: $showingAlert1) {
                                    Alert(
                                        title: Text("Error 🤯"),
                                        message: Text("You entered incorrect data."),
                                        dismissButton: .default(Text("Reenter")))
                                }
                        
                

                    
                }.background((isValidEmail(testStr: self.user) == true && self.pass.count > 6) ? Color.green : Color.secondary)
                    .clipShape(Capsule())
                    .padding(.top, 45)
                    .shadow(color: (isValidEmail(testStr: self.user) == true && self.pass.count > 6) ? .green : .black, radius: (isValidEmail(testStr: self.user) == true && self.pass.count > 6) ? 12 : 0)
                    
                
                Text("(or)")
                    .foregroundColor(.white)
                    .padding(.top, 20)



                HStack(spacing: 8){

                    Text("Don't Have An Account ?")
                        .foregroundColor(.white)
                    
                    NavigationLink(destination: singUp(), label: {
                        Text("Sing Up")
                            .fontWeight(.bold)
                            .foregroundColor(Color("colorSingUp"))
                            
                    })

                }.padding(.top, 15)
            }
        }
    }
    
    func login() {
        Auth.auth().signIn(withEmail: user, password: pass) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
    
}

struct authSrceen: View {
    var body: some View {
        NavigationView {
            ZStack {
                backgroundScreen() //структура где находиться фон
                mainScreen() //структура где весь вью
            }
        }.accentColor(Color(.white))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


