//
//  VPNManager.swift
//  MinimalVPN
//
//  Created by Dr. Brandon Wiley on 6/1/22.
//

import Foundation
import Network
import NetworkExtension

public class VPNManager
{
    let manager = NETunnelProviderManager()

    public init()
    {
    }

    public func load()
    {
        print("Loading...")

        self.manager.loadFromPreferences
        {
            maybeError in

            print("Loaded.")
        }
    }

    public func enable()
    {
        self.manager.loadFromPreferences
        {
            param in

            print("loadFromPreferences 1")
            print("\(String(describing: param))")

            self.manager.saveToPreferences
            {
                _ in

                print("saveToPreferences 1")

                self.manager.loadFromPreferences
                {
                    _ in

                    print("loadFromPreferences 2")

                    let protocolConfiguration = NETunnelProviderProtocol()
                    let appId = Bundle.main.bundleIdentifier!
                    protocolConfiguration.providerBundleIdentifier = "\(appId).MinimalVPNPacketTunnel"
                    protocolConfiguration.serverAddress = "206.189.200.18"
                    protocolConfiguration.includeAllNetworks = true
                    self.manager.protocolConfiguration = protocolConfiguration
                    self.manager.localizedDescription = "MinimalVPN"
                    self.manager.isEnabled = true

                    print(protocolConfiguration)

                    self.manager.saveToPreferences
                    {
                        _ in

                        print("saveToPreferences 2")

                        self.manager.loadFromPreferences
                        {
                            _ in

                            print("loadFromPreferences 2")

                            self.manager.saveToPreferences
                            {
                                _ in

                                print("saveToPreferences 3")

                                print("Done.")
                            }
                        }
                    }
                }
            }
        }
    }
}
