//
//  Constants.swift
//  GHFollowers
//
//  Created by Eugene Yehanovskiy on 07.11.2022.
//

import UIKit

enum SFSymbols {
    static let location = "mappin.and.ellipse"
    static let repo = "folder"
    static let gists = "text.alignleft"
    static let following = "heart"
    static let followers = "person.2"
}

enum Images {
    static let avatar = UIImage(named: "avatar-placeholder")
    static let logo = UIImage(named: "gh-logo")
    static let emptyStateLogo = UIImage(named: "empty-state-logo")
    static let repo = UIImage(systemName: SFSymbols.repo)
    static let gists = UIImage(systemName: SFSymbols.gists)
    static let followers = UIImage(systemName: SFSymbols.followers)
    static let following = UIImage(systemName: SFSymbols.following)
    static let location = UIImage(systemName: SFSymbols.location)
}

enum ScreenSize {
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
    static let maxLength = max(ScreenSize.width, ScreenSize.height)
    static let minLenght = min(ScreenSize.width, ScreenSize.height)
}

enum DeviceTypes {
    static let idiom = UIDevice.current.userInterfaceIdiom
    static let nativeScale = UIScreen.main.nativeScale
    static let scale = UIScreen.main.scale
    
    static let isiPhoneSE2nd3rdGen = idiom == .phone && ScreenSize.maxLength == 667.0
    static let isiPhone8Standartd = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale
    static let isiPhone8Zoomed = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale > scale
    static let isiPhone8PlusStandartd = idiom == .phone && ScreenSize.maxLength == 736.0
    static let isiPhone8PlusZoomed = idiom == .phone && ScreenSize.maxLength == 736.0 && nativeScale > scale
    static let isiPhoneX = idiom == .phone && ScreenSize.maxLength == 812.0
    static let isiPhoneXsMaxAndXr = idiom == .phone && ScreenSize.maxLength == 896.0
    static let isiPad = idiom == .pad && ScreenSize.maxLength >= 1024.0
    
    static func isiPhoneXAspectRatio() -> Bool {
        return isiPhoneX || isiPhoneXsMaxAndXr
    }
    
}
