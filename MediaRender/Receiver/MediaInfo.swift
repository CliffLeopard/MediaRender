//
//  MediaInfo.swift
//  MDRCase
//
//  Created by CliffLeopard on 2022/5/30.
//

import Foundation

struct MediaInfo:Equatable {
    var mediaType:MeidaType = .unknown
    var url:String? = nil
    
    var xmlns:String? = nil
    var xmlnsDc:String? = nil
    var xmlnsUpnp:String? = nil
    
    var id:String? = nil
    var parentID:String? = nil
    var restricted:String? = nil
    
    var tittle:String? = nil
    var storageMedium:String? = nil
    var writeStatus:String? = nil
    var longDescription:String? = nil
    
    var protocolInfo:String? = nil
    var res:String? = nil
    
    var unpnpClass:String? = nil
    var albumArtURI:String? = nil
}

enum MeidaType {
    case video
    case audio
    case img
    case unknown
}
