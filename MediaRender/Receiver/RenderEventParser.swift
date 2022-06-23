//
//  RenderEventParser.swift
//  MDRCase
//
//  Created by CliffLeopard on 2022/5/30.
//

import Foundation

class RenderEventParser {
    static func parse(type: Int32,  p1: String,  p2: String,  p3: String, receiver:RenderReceiverProtocal) {
        debugPrint("RenderEventParser","ttpe:",type,"p1",p1, "p2",p2, "p3",p3)
        switch type {
        case CALLBACK_EVENT_ON_NEXT:
            receiver.onNext()
        case CALLBACK_EVENT_ON_PAUSE:
            receiver.onPause()
        case CALLBACK_EVENT_ON_PLAY:
            MetaParser().parseMeta(url: p1, meta: p2) { info in
                receiver.onPlay(info)
            }
        case CALLBACK_EVENT_ON_PREVIOUS:
            receiver.onPrevious()
        case CALLBACK_EVENT_ON_SEEK:
            let time = strToMs(p2)
            if time != -1 {
                receiver.onSeek(time)
            }
        case CALLBACK_EVENT_ON_STOP:
            receiver.onStop()
        case CALLBACK_EVENT_ON_SET_AV_TRANSPORT_URI:
            MetaParser().parseMeta(url: p1, meta: p2) { info in
                receiver.onSetAVTransportUri(info)
            }
        case CALLBACK_EVENT_ON_SET_PLAY_MODE:
            receiver.onSetPlayMode()
        case CALLBACK_EVENT_ON_SET_VOLUME:
            if let volume = Float(p1) {
                receiver.onSetVolume(volume)
            }
        case CALLBACK_EVENT_ON_SET_MUTE:
            receiver.onSetMute()
        case CALLBACK_EVENT_ON_SET_MEDIA_DURATION:
            receiver.onSetMediaDuration()
        case CALLBACK_EVENT_ON_SET_MEDIA_POSITION:
            receiver.onSetMediaPosition()
        case CALLBACK_EVENT_ON_SET_MEDIA_PLAYING_STATE:
            receiver.onSetMediaPlayingState()
        default :
            debugPrint("RenderEventParser","unknown")
        }
    }
    
    // Seek 解析
    private static func strToMs(_ time:String) -> Int64 {
        let seq = time.split(separator: Character(":"))
        if seq.count != 3 {
            return -1
        }
       
        if let hour = Int64(seq[0]),let  min = Int64(seq[1]), let second = Int64(seq[2]) {
            return  ((hour*60 + min)*60 + second) * 1000
        } else {
            return -1
        }
    }
}
