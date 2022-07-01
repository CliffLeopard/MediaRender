//
//  AliPlayerVM.swift
//  MDRCase
//
//  Created by CliffLeopard on 2022/6/10.
//

import Foundation

class AliPlayerVM : NSObject,ObservableObject {
    let mdr:Bool
    var backSender:SendBackProtocal?
    var player:AliPlayer
    var duration:Int64 = -1
    let bounds =  UIScreen.main.bounds
    var url:String? = nil
    @Published var width:CGFloat = -1
    @Published var height:CGFloat
    @Published var state:VideoState = .idle
    @Published var touching:Bool = false
    
    init(_ mdr:Bool = false) {
        self.mdr = mdr
        if mdr {
            backSender = RenderCenter.share
        } else {
            backSender = nil
        }
        self.player = AliPlayer("DisableAnalytics")
        self.width = bounds.width
        self.height = 200
        super.init()
        self.player.delegate = self
    }
    
    func setPlayerView(_ view:UIView) {
        self.player.playerView = view
    }
    
    func setPlayUrl(_ url: String) {
        let urlSouce = AVPUrlSource().url(with: url)
        self.player.setUrlSource(urlSouce)
        self.player.isAutoPlay = false
        self.player.scalingMode = AVP_SCALINGMODE_SCALEASPECTFIT
        self.player.prepare()
    }
    
    func pause() {
        self.player.pause()
    }
    
    func reset() {
        self.player.reset()
    }
    
    func play() {
        self.player.start()
    }
    
    func stop() {
        self.player.stop()
    }
    
    /// 设置倍速
    func setRate(_ rate: Float = 1.0) {
        self.player.rate = rate
        
    }
    
    /// 跳到到指定位置
    func setPosition(_ position: Int64) {
        self.player.seek(toTime: position, seekMode: AVP_SEEKMODE_ACCURATE)
    }
    
    /// 设置视频清晰度
    func setTrack(_ track: AVPTrackInfo) {
        self.player.selectTrack(track.trackIndex)
    }
}

enum VideoState:Int {
    case idle      // 闲置中
    case loading   // 加载中
    case playing   // 播放中
    case pausing   // 暂停中
    case stoped    // 播放停止
    case complete  // 播放完成
    case error     // 播放错误
}
