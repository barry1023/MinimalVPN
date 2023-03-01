//
//  VPNManager.swift
//  MinimalVPN
//
//  Created by Dr. Brandon Wiley on 6/1/22.
//

import Foundation
import Network
import NetworkExtension
import NotificationCenter
import OSLog

func getNEStatusString(_ status: NEVPNStatus) -> String {
    switch status.rawValue {
    case 0:
        return "invalid"
    case 1:
        return "disconnected"
    case 2:
        return "connecting"
    case 3:
        return "connected"
    case 4:
        return "reasserting"
    case 5:
        return "disconnecting"
    default:
        return ""
    }
}

public class VPNManager {
    var manager = NETunnelProviderManager()
    let logger: Logger

    public init() {
        logger = Logger(subsystem: "MinimalVPN", category: "manager")
        logger.debug("Initialized MinimalVPN Manager")
        Task {
            await prepare(logger)
        }
    }

    public func prepare(_ logger: Logger) async {
        let managers = try? await NETunnelProviderManager.loadAllFromPreferences()
        if managers != nil && managers!.count > 0 {
            manager = managers![0]
            logger.debug("loaded vpn preference")
        } else {
            logger.debug("new NETunnelProviderManager")
            let neProtocol = NETunnelProviderProtocol()
            neProtocol.serverAddress = "127.0.0.1"
            neProtocol.providerBundleIdentifier = "\(Bundle.main.bundleIdentifier!).MinimalVPNPacketTunnel"
            logger.debug("***********\nVPNManager protocolConfiguration:\n\(neProtocol)\n***********")
            manager.protocolConfiguration = neProtocol
            manager.localizedDescription = "MinimalVPNTunnel"
            
            manager.isEnabled = true
            manager.isOnDemandEnabled = false
            try! await manager.saveToPreferences()
            try! await manager.loadFromPreferences()
        }
        NotificationCenter.default.addObserver(
            forName: NSNotification.Name.NEVPNStatusDidChange,
            object: manager.connection,
            queue: OperationQueue.main,
            using: { notification in
                let session = notification.object! as! NETunnelProviderSession
                let status = getNEStatusString(session.status)
                self.logger.debug("neStatus: \(status, privacy: .public)")
                if status == "connecting" {
                    Task {
                        let waitms: Float = 30
                        self.logger.debug("wait: \(waitms, privacy: .public)ms")
                        try! await Task.sleep(nanoseconds: UInt64(waitms*1000000))
                        self.sendMsg()
                    }
                }
            })
    }
    public func start() {
        try! manager.connection.startVPNTunnel()
        logger.debug("startVPNTunnel")
    }
    public func stop() {
        manager.connection.stopVPNTunnel()
        logger.debug("stopVPNTunnel")
    }
    public func sendMsg() {
        let session = manager.connection as! NETunnelProviderSession
        try! session.sendProviderMessage(Data("xxxasdf".utf8))
        logger.debug("sendProviderMessage")
    }
}
