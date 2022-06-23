//
//  MediaSourceCenter.swift
//  MDRCase
//
//  Created by CliffLeopard on 2022/6/15.
//

import Foundation

class MeidaSourceCenter : NSObject, ObservableObject {
    static var share:MeidaSourceCenter = MeidaSourceCenter();
    @Published var receivedMediaInfo:MediaInfo? = nil
    
    private override init() {}
    override class func copy() -> Any { return share }
    override class func mutableCopy() -> Any { return share}
    
}
