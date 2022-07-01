//
//  VideoRenderReceiver.swift
//  MediaRender
//
//  Created by CliffLeopard on 2022/6/16.
//

import Foundation

extension AliPlayerVM: RenderReceiverProtocal {
    // 设置播放源地址
    func onSetAVTransportUri(_ mediaInfo:MediaInfo) {
        if let url = mediaInfo.url {
            self.url = url
            self.setPlayUrl(url)
        }
    }
    
    // 播放
    func onPlay(_ mediaInfo:MediaInfo) {
        if let newUrl = mediaInfo.url {
            if self.url == nil || self.url != newUrl{
                self.setPlayUrl(newUrl)
            }
            self.play()
        }
    }
    
    // 下一条
    func onNext() {
        
    }
    // 暂停
    func onPause() {
        
        self.pause()
    }
    
    // 上一条
    func onPrevious() {
        
    }
    
    
    // 滑动播放位置
    func onSeek(_ time:Int64) {
        self.player.seek(toTime: time, seekMode: AVP_SEEKMODE_INACCURATE)
    }
    
    // 停止播放
    func onStop() {
        self.stop()
    }
    
    // 切换播放模式
    func onSetPlayMode() {
        
    }
    
    // 设置音量
    func onSetVolume(_ volume:Float) {
        self.player.volume = volume / 100.0
    }
    
    // 静音
    func onSetMute() {
        self.player.volume = 0.0
    }
    
    // 设置媒体时长
    func onSetMediaDuration() {
        
    }
    
    // 设置媒体位置
    func onSetMediaPosition() {
        
    }
    
    // 设置媒体播放状态
    func onSetMediaPlayingState() {
        
    }
    
    func hashValue() -> Int {
        var hasher = Hasher()
        self.hash(into: &hasher)
        return hasher.finalize()
    }
}
