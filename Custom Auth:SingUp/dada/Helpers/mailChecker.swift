//
//  mailChecker.swift
//  dada
//
//  Created by Danil Bochkarev on 02.10.2022.
//

import SwiftUI

struct mailChecker: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

func isValidEmail(testStr:String) -> Bool {
   let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

   let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
   return emailTest.evaluate(with: testStr)
}

struct mailChecker_Previews: PreviewProvider {
    static var previews: some View {
        mailChecker()
    }
}
