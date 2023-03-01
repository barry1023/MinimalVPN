//
//  ContentView.swift
//  MinimalVPN
//
//  Created by Dr. Brandon Wiley on 6/1/22.
//

import SwiftUI

struct ContentView: View
{
    let vpn = VPNManager()

    var body: some View
    {
        Text("🫧 MinimalVPN 🫧")
        Button("Connect") {
            self.vpn.start()
        }
        
        Button("Disconnect") {
            self.vpn.stop()
        }

        Button("Send") {
            self.vpn.sendMsg()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
