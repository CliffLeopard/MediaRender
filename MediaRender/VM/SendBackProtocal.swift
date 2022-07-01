//
//  SendBackProtocal.swift
//  MediaRender
//
//  Created by CliffLeopard on 2022/7/1.
//

import Foundation
protocol SendBackProtocal {
    func setMediaPosition(position:Int64)
    func setMediaDuration(duration:Int64)
    func setMeidaPlayState(state:String)
    func addRenderReceiver(receiver:RenderReceiverProtocal)
    func removeReceiver(receiver:RenderReceiverProtocal)
}
