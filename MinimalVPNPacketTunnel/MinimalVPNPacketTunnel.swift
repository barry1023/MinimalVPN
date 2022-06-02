//
//  PacketTunnelProvider.swift
//  MinimalVPNPacketTunnel
//
//  Created by Dr. Brandon Wiley on 6/1/22.
//

import Logging
import Network
import NetworkExtension

class MinimalVPNPacketTunnel: NEPacketTunnelProvider {
    var logger: Logger
    var connection: NWTCPConnection! = nil

    public override init()
    {
        self.logger = Logger(label: "MoonbounceNetworkExtension")
        self.logger.logLevel = .debug

        self.logger.debug("Initialized MoonbouncePacketTunnelProvider")
        self.logger.debug("MoonbouncePacketTunnelProvider.init")

        super.init()
    }

    override func startTunnel(options: [String : NSObject]?, completionHandler: @escaping (Error?) -> Void) {
        completionHandler(nil)

        self.connection = self.createTCPConnection(to: NWHostEndpoint(hostname: "206.189.200.18", port: "8888"), enableTLS: false, tlsParameters: nil, delegate: nil)
        self.connection.write("hello".data(using: .utf8)!)
        {
            maybeError in

            return
        }

//        let ipv4 = IPv4Address("206.189.200.18")!
//        let port = NWEndpoint.Port(integerLiteral: 8888)
//        let connection = NWConnection(host: NWEndpoint.Host.ipv4(ipv4), port: port, using: .tcp)
//        connection.stateUpdateHandler =
//        {
//            (state: NWConnection.State) in
//
//            self.logger.debug("state: \(state)")
//            switch state
//            {
//                case .ready:
//                    self.logger.debug("ready!")
//                    completionHandler(nil)
//                case .cancelled:
//                    completionHandler(nil)
//                case .failed(_):
//                    completionHandler(nil)
//                default:
//                    return
//            }
//        }
    }
    
    override func stopTunnel(with reason: NEProviderStopReason, completionHandler: @escaping () -> Void) {
        // Add code here to start the process of stopping the tunnel.
        completionHandler()
    }
    
    override func handleAppMessage(_ messageData: Data, completionHandler: ((Data?) -> Void)?) {
        // Add code here to handle the message.
        if let handler = completionHandler {
            handler(messageData)
        }
    }
    
    override func sleep(completionHandler: @escaping () -> Void) {
        // Add code here to get ready to sleep.
        completionHandler()
    }
    
    override func wake() {
        // Add code here to wake up.
    }
}
