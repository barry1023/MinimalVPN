//
//  ContentView.swift
//  MinimalVPN
//
//  Created by Dr. Brandon Wiley on 6/1/22.
//

import SwiftUI

struct ContentView: View {
    let vpn = VPNManager()

    var body: some View {
        Button("Connect")
        {
            self.vpn.enable()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
