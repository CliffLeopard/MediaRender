//
//  VideoState.swift
//  MDRCase
//
//  Created by CliffLeopard on 2022/6/23.
//

import Foundation
enum VideoState:Int {
    case idle      // 闲置中
    case loading   // 加载中
    case playing   // 播放中
    case pausing   // 暂停中
    case stoped    // 播放停止
    case complete  // 播放完成
    case error     // 播放错误
}
