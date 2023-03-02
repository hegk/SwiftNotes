//
//  Global.swift
//  SwiftNotes
//
//  Created by DOVE on 2023/3/1.
//  Copyright © 2023 Hegk. All rights reserved.
//

import Foundation
import UIKit

// MARK: 尺寸信息：

/// 顶部状态栏高度（包括安全区）
func kStatusBar_Height() -> CGFloat {
    // 从iOS 14开始，全面屏iPhone的状态栏高度不一定是 44 或 20（还可能时47、48）
    var statusBarHeight: CGFloat = 0;
    if #available(iOS 13.0, *) {
        let scene = UIApplication.shared.connectedScenes.first;
        guard let windowScene = scene as? UIWindowScene else {return 0};
        guard let statusBarManager = windowScene.statusBarManager else {return 0};
        statusBarHeight = statusBarManager.statusBarFrame.height;
    } else {
        statusBarHeight = UIApplication.shared.statusBarFrame.height;
    }
    return statusBarHeight;
}

/// 顶部安全区高度
func kSafeAreaInsetsTopHeight() -> CGFloat {
    let scene = UIApplication.shared.connectedScenes.first;
    guard let windowScene = scene as? UIWindowScene else {return 0};
    guard let window = windowScene.windows.first else {return 0};
    return window.safeAreaInsets.top;
}

/// 底部安全区高度
func kSafeAreaInsetsBottomHeight() -> CGFloat {
    let scene = UIApplication.shared.connectedScenes.first;
    guard let windowScene = scene as? UIWindowScene else {return 0};
    guard let window = windowScene.windows.first else {return 0};
    return window.safeAreaInsets.bottom;
}

/** 屏幕宽度 */
let kScreenWidth = UIScreen.main.bounds.size.width

/** 屏幕高度 */
let kScreenHeight = UIScreen.main.bounds.size.height

/* 导航栏高度 固定高度 = 44.0f */
//let k_Height_NavContentBar :CGFloat  = UINavigationBar.appearance().frame.size.height
let kNavigationBarHeight: CGFloat = 44.0

/** 状态栏高度 */
let kStatusBarHeight: CGFloat = kStatusBar_Height()

/** 状态栏+导航栏的高度 */
let kNavigationtBarAndStatuBarHeight: CGFloat = kNavigationBarHeight + kStatusBarHeight

/** 底部tabBar栏高度 */
let kTabBarHeight :CGFloat = 49.0

/** 底部导航栏高度 */
let kTabBarAndSafeBottomHeight :CGFloat = kSafeAreaInsetsBottomHeight() + kTabBarHeight

/** 安全区高度 */
let kSafeAreaHeight: CGFloat = kScreenHeight - kNavigationtBarAndStatuBarHeight - kTabBarAndSafeBottomHeight


// MARK: 检查系统版本

/// 版本号相同：
func systemVersionEqual(version:String) -> Bool {
    return UIDevice.current.systemVersion == version
}

/// 系统版本高于等于该version  测试发现只能传入带一位小数点的版本号  不然会报错    具体原因待探究
func systemVersionGreaterThan(version:String) -> Bool {
    return UIDevice.current.systemVersion.compare(version, options: .numeric, range: version.startIndex..<version.endIndex, locale: Locale(identifier:version)) != ComparisonResult.orderedAscending
}

//判断是否是 x、及x以上 系列
func isIphoneX() -> Bool {
    return kSafeAreaInsetsBottomHeight() > 0.0;
}

