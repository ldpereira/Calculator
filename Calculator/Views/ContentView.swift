//
//  ContentView.swift
//  Calculator
//
//  Created by Lucas Pereira on 09/06/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            KeyView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
