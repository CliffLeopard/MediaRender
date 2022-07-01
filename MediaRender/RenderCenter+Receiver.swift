//
//  ReceiverCenter.swift
//  MediaRender
//
//  Created by CliffLeopard on 2022/6/16.
//  接收并解析视频源发送来的消息，解析视频和处理播放状态
//

import Foundation
import SwiftUI

extension RenderCenter : RenderReceiverProtocal,RenderEventProtocal{
    
    func onEvent(_ type: Int32, param1 p1: String, param2 p2: String, param3 p3: String) {
        RenderEventParser.parse(type: type, p1: p1, p2: p2, p3: p3,receiver:self)
    }
    
    // 设置播放源地址
    func onSetAVTransportUri(_ mediaInfo:MediaInfo) {
        debugPrint("RenderCenter","onSetAVTransportUri")
        DispatchQueue.main.async {
            for receiver in self.receivers {
                receiver.onSetAVTransportUri(mediaInfo)
            }
        }
    }
    
    // 播放
    func onPlay(_ mediaInfo:MediaInfo) {
        debugPrint("RenderCenter","onPlay")
        DispatchQueue.main.async {
            for receiver in self.receivers {
                receiver.onPlay(mediaInfo)
            }
        }
    }
    
    
    // 下一条
    func onNext() {
        debugPrint("RenderCenter","next")
        DispatchQueue.main.async {
            for receiver in self.receivers {
                receiver.onNext()
            }
        }
    }
    // 暂停
    func onPause() {
        debugPrint("RenderCenter","onPause")
        DispatchQueue.main.async {
            for receiver in self.receivers {
                receiver.onPause()
            }
        }
    }
    
    
    // 上一条
    func onPrevious() {
        debugPrint("RenderCenter","onPrevious")
        DispatchQueue.main.async {
            for receiver in self.receivers {
                receiver.onPrevious()
            }
        }
    }
    
    // 滑动播放位置
    func onSeek(_ time:Int64) {
        debugPrint("RenderCenter","onSeek")
        DispatchQueue.main.async {
            for receiver in self.receivers {
                receiver.onSeek(time)
            }
        }
    }
    
    // 停止播放
    func onStop() {
        debugPrint("RenderCenter","onStop")
        DispatchQueue.main.async {
            for receiver in self.receivers {
                receiver.onStop()
            }
        }
    }
    

    
    // 切换播放模式
    func onSetPlayMode() {
        debugPrint("RenderCenter","onSetPlayMode")
        DispatchQueue.main.async {
            for receiver in self.receivers {
                receiver.onSetPlayMode()
            }
        }
    }
    
    // 设置音量
    func onSetVolume(_ volume:Float) {
        debugPrint("RenderCenter","onSetVolume")
        DispatchQueue.main.async {
            for receiver in self.receivers {
                receiver.onSetVolume(volume)
            }
        }
    }
    
    // 静音
    func onSetMute() {
        debugPrint("RenderCenter","onSetMute")
        DispatchQueue.main.async {
            for receiver in self.receivers {
                receiver.onSetMute()
            }
        }
    }
    
    // 设置媒体时长
    func onSetMediaDuration() {
        debugPrint("RenderCenter","onSetMediaDuration")
        DispatchQueue.main.async {
            for receiver in self.receivers {
                receiver.onSetMediaDuration()
            }
        }
    }
    
    // 设置媒体位置
    func onSetMediaPosition() {
        debugPrint("RenderCenter","onSetMediaPosition")
        DispatchQueue.main.async {
            for receiver in self.receivers {
                receiver.onSetMediaPosition()
            }
        }
    }
    
    // 设置媒体播放状态
    func onSetMediaPlayingState() {
        debugPrint("RenderCenter","onSetMediaPlayingState")
        DispatchQueue.main.async {
            for receiver in self.receivers {
                receiver.onSetMediaPlayingState()
            }
        }
    }
    
    func hashValue() -> Int {
        var hasher = Hasher()
           self.hash(into: &hasher)
           return hasher.finalize()
    }
}
