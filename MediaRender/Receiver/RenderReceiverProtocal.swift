//
//  RenderReceiverProtocal.swift
//  MediaRender
//
//  Created by CliffLeopard on 2022/6/16.
//

import Foundation

protocol RenderReceiverProtocal{
    func onSetAVTransportUri(_ mediaInfo:MediaInfo)
    func onPlay(_ mediaInfo:MediaInfo)
    func onNext()
    func onPause()
    func onPrevious()
    func onSeek(_ time:Int64)
    func onStop()
    func onSetPlayMode()
    func onSetVolume(_ vloume:Float)
    func onSetMute()
    func onSetMediaDuration()
    func onSetMediaPosition()
    func onSetMediaPlayingState()
    func hashValue() -> Int
}
