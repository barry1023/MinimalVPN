//
//  PacketTunnelProvider.swift
//  MinimalVPNPacketTunnel
//
//  Created by Dr. Brandon Wiley on 6/1/22.
//

import OSLog
import Network
import NetworkExtension

class MinimalVPNPacketTunnel: NEPacketTunnelProvider {
    let logger: Logger

    public override init() {
        self.logger = Logger(subsystem: "MinimalVPN", category: "provider")
        self.logger.debug("MinimalVPNPacketTunnel init")
        super.init()
    }

    override func startTunnel(options: [String : NSObject]?, completionHandler: @escaping (Error?) -> Void) {
        logger.debug("startTunnel")
        Task {
            try! await Task.sleep(nanoseconds: 1_000_000_000)
            logger.debug("startTunnel callback")
            completionHandler(nil)
        }
        return;
    }

    override func stopTunnel(with reason: NEProviderStopReason, completionHandler: @escaping () -> Void) {
        // Add code here to start the process of stopping the tunnel.
        logger.debug("stopTunnel")
        completionHandler()
    }

    override func handleAppMessage(_ messageData: Data, completionHandler: ((Data?) -> Void)?) {
        let msg = String(decoding: messageData, as: UTF8.self)
        logger.debug("AppMessage \(msg, privacy: .public)")
        if let handler = completionHandler {
            handler(messageData)
        }
    }

    override func sleep(completionHandler: @escaping () -> Void) {
        // Add code here to get ready to sleep.
        logger.debug("sleep")
        completionHandler()
    }

    override func wake() {
        logger.debug("wake")
        // Add code here to wake up.
    }
}
