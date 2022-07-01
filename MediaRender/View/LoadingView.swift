//
//  LoadingView.swift
//  MDRCase
//
//  Created by CliffLeopard on 2022/6/15.
//

import Foundation
import SwiftUI

struct LoadingView : View {
    @Binding var state: VideoState
    @Binding var touching:Bool
    var count:Int = 8
    var body: some View {
        if touching {
            GeometryReader { geometry in
                Image("暂停")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
        } else {
            switch state {
            case .idle:
                // 空转, 闲时，静态
                EmptyView()
            case .loading:
                // 加载，缓冲中
                GeometryReader { geometry in
                    ForEach(0..<count, id: \.self) { index in
                        IndicatorItemView(index: index, count: count, size: geometry.size)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                }
            case .playing:
                // 播放中
                EmptyView()
            case .pausing:
                // 播放暂停
                GeometryReader { geometry in
                    Image("播放")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                }
            case .stoped:
                // 播放停止
                EmptyView()
            case .complete:
                // 播放停止
                EmptyView()
            case .error:
                // 播放错误
                GeometryReader { geometry in
                    Image(systemName: "xmark.octagon")
                        .frame(width: geometry.size.width, height: geometry.size.height)
                }
            }
        }
    }
}

struct IndicatorItemView : View {
    let index: Int
    let count: Int
    let size: CGSize
    
    @State private var opacity: Double = 0
    var body: some View {
        let height = size.height / 3.2
        let width = height / 2
        let angle = 2 * .pi / CGFloat(count) * CGFloat(index)
        let x = (size.width / 2 - height / 2) * cos(angle)
        let y = (size.height / 2 - height / 2) * sin(angle)
        
        let animation = Animation.default
            .repeatForever(autoreverses: true)
            .delay(Double(index) / Double(count) / 2)
        
        return RoundedRectangle(cornerRadius: width / 2 + 1)
            .frame(width: width, height: height)
            .rotationEffect(Angle(radians: Double(angle + CGFloat.pi / 2)))
            .offset(x: x, y: y)
            .opacity(opacity)
            .onAppear {
                opacity = 1
                withAnimation(animation) {
                    opacity = 0.3
                }
            }
    }
}


