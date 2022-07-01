//
//  AliDelegateEvents.swift
//  MDRCase
//
//  Created by CliffLeopard on 2022/6/10.
//

import Foundation

extension AliPlayerVM:AVPDelegate {
    // 播放事件回调
    func onPlayerEvent(_ player: AliPlayer!, eventType: AVPEventType) {
        switch eventType {
        case AVPEventPrepareDone:
            // 准备完成
            debugPrint("onPlayerEvent","准备完成")
            self.duration  = self.player.duration;
            self.backSender?.setMediaDuration(duration: duration)
            debugPrint("onPlayerEvent","视频总时长:", duration)
        case AVPEventAutoPlayStart:
            //自动播放开始事件
            debugPrint("onPlayerEvent","自动播放开始事件")
        case AVPEventFirstRenderedStart:
            //首帧显示
            debugPrint("onPlayerEvent"," 首帧显示")
        case AVPEventCompletion:
            // 播放完成
            changeState(.complete)
            debugPrint("onPlayerEvent","播放完成")
        case AVPEventLoadingStart:
            // 缓冲开始
            changeState(.loading)
            debugPrint("onPlayerEvent","缓冲开始")
        case AVPEventLoadingEnd:
            // 缓冲完成
            changeState(.playing)
            debugPrint("onPlayerEvent","缓冲完成")
            self.play()
        case AVPEventSeekEnd:
            // 跳转完成
            changeState(.playing)
            debugPrint("onPlayerEvent","跳转完成")
        case AVPEventLoopingStart:
            // 循环播放开始
            debugPrint("onPlayerEvent","循环播放开始")
        default:
            debugPrint("onPlayerEvent","")
        }
    }
    
    // 播放器状态改变回调
    func onPlayerStatusChanged(_ player: AliPlayer!, oldStatus: AVPStatus, newStatus: AVPStatus) {
        debugPrint("onPlayerEvent", oldStatus, newStatus)
        switch newStatus {
        case AVPStatusIdle:
            // 空转, 闲时，静态
            changeState(.idle)
        case AVPStatusInitialzed:
            // 初始化完成
            break
        case AVPStatusPrepared:
            // 准备完成
            break
        case AVPStatusStarted:
            // 正在播放
            changeState(.playing)
        case AVPStatusPaused:
            // 播放暂停
            changeState(.pausing)
        case AVPStatusStopped:
            // 播放停止
            changeState(.stoped)
        case AVPStatusCompletion:
            // 播放完成
            changeState(.complete)
        case AVPStatusError:
            // 播放错误
            changeState(.error)
        default:
            break
        }
    }
    
    func changeState(_ state:VideoState){
        self.state = state
        switch state {
        case .idle:
            self.backSender?.setMeidaPlayState(state: "PAUSED_PLAYBACK")
        case .loading:
            break
        case .playing:
            self.backSender?.setMeidaPlayState(state: "PLAYING")
        case .pausing:
            self.backSender?.setMeidaPlayState(state: "PAUSED_PLAYBACK")
        case .stoped:
            self.backSender?.setMeidaPlayState(state: "STOPPED")
        case .complete:
            self.backSender?.setMeidaPlayState(state: "STOPPED")
        case .error:
            self.backSender?.setMeidaPlayState(state: "NO_MEDIA_PRESENT")
        }
    }
    
    
    // 播放器事件回调 + 说明
    func onPlayerEvent(_ player: AliPlayer!, eventWithString: AVPEventWithString, description: String!) {
        debugPrint("onPlayerEvent",eventWithString,description ?? "nil")
    }
    
    // 错误代理回调
    func onError(_ player: AliPlayer!, errorModel: AVPErrorModel!) {
        //        self.state = .loading
    }
    
    // 视频大小变化回调
    func onVideoSizeChanged(_ player: AliPlayer!, width: Int32, height: Int32, rotation: Int32) {
        self.height = self.width * (CGFloat(height) / CGFloat(width))
    }
    
    // 视频当前播放位置回调
    func onCurrentPositionUpdate(_ player: AliPlayer!, position: Int64) {
        if self.duration != -1 {
            self.backSender?.setMediaDuration(duration: duration)
        }
        self.backSender?.setMediaPosition(position: position)
    }
    
    // 视频当前播放内容对应的utc时间回调
    func onCurrentUtcTimeUpdate(_ player: AliPlayer!, time: Int64) {
        
    }
    
    // 视频缓存位置回调
    func onBufferedPositionUpdate(_ player: AliPlayer!, position: Int64) {
        
    }
    
    // 视频缓冲进度回调
    func onLoadingProgress(_ player: AliPlayer!, progress: Float) {
        
    }
    
    // 当前下载速度回调
    func onCurrentDownloadSpeed(_ player: AliPlayer!, speed: Int64) {
        
    }
    
    // 获取track信息回调
    func onTrackReady(_ player: AliPlayer!, info: [AVPTrackInfo]!) {
        
    }
    
    // 选择希望播放的流
    //    func onChooseTrackIndex(_ player: AliPlayer!, info: [AVPTrackInfo]!) -> Int32 {
    //
    //    }
    
    // track切换完成回调
    func onTrackChanged(_ player: AliPlayer!, info: AVPTrackInfo!) {
        
    }
    
    // 外挂字幕被添加
    func onSubtitleExtAdded(_ player: AliPlayer!, trackIndex: Int32, url URL: String!) {
        
    }
    
    // 字幕头信息回调，ass字幕，如果实现了此回调，则播放器不会渲染字幕，由调用者完成渲染，否则播放器自动完成字幕的渲染
    //    func onSubtitleHeader(_ player: AliPlayer!, trackIndex: Int32, header: String!) {
    //
    //    }
    
    // 字幕显示回调
    func onSubtitleShow(_ player: AliPlayer!, trackIndex: Int32, subtitleID: Int, subtitle: String!) {
        
    }
    
    // 字幕隐藏回调
    func onSubtitleHide(_ player: AliPlayer!, trackIndex: Int32, subtitleID: Int) {
        
    }
    
    // 获取缩略图成功回调
    func onGetThumbnailSuc(_ positionMs: Int64, fromPos: Int64, toPos: Int64, image: Any!) {
        
    }
    
    // 获取缩略图失败回调
    func onGetThumbnailFailed(_ positionMs: Int64) {
        
    }
    
    
    // 获取截图回调
    func onCaptureScreen(_ player: AliPlayer!, image: UIImage!) {
        
    }
    
    // SEI回调
    func onSEIData(_ player: AliPlayer!, type: Int32, data: Data!) {
        
    }
    
    // 播放器渲染信息回调
    func onVideoRendered(_ player: AliPlayer!, timeMs: Int64, pts: Int64) {
        
    }
}
