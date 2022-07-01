//
//  DLNACenter.swift
//  MDRCase
//
//  Created by CliffLeopard on 2022/5/26.
//

import Foundation

class RenderCenter : NSObject {
    let name:String = "MeidaRender"
    let showIp = true
    let uuid:String = "awecadvgfrbvuusrtyvfcadfr235sdvsfg"
    var receivers = [RenderReceiverProtocal]()
    
    static var share:RenderCenter!
    
    static func initShare(){
        debugPrint("Init DLNA")
        RenderCenter.share = RenderCenter()
        RenderBridge.initBridge(RenderCenter.share)
    }
    
    private override init() {}
    override class func copy() -> Any { return share ?? "nil" }
    override class func mutableCopy() -> Any { return share ?? "nil"}
}
