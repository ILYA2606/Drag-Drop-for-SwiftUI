// UserView.swift
// Copyright © Darkness Production. All rights reserved.

import SwiftUI

struct UserView: View {
    let user: String
    
    var body: some View {
        HStack {
            acronymView
            Text(user)
            Spacer()
        }
        .frame(height: 40.0)
    }
    
    private var acronymView: some View {
        let words = user.components(separatedBy: " ")
        var acronym = ""
        if words.count > 1 {
            for (index, word) in words.enumerated() {
                guard index < 2 else { break }
                acronym += word.prefix(1)
            }
        } else {
            acronym = String(words.first?.prefix(2) ?? "")
        }
        return ZStack {
            Circle()
                .frame(width: 32, height: 32)
                .foregroundColor(.gray)
            Text(acronym.uppercased())
                .foregroundColor(.white)
        }
    }

}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(user: "Ivan Ivanov")
    }
}
