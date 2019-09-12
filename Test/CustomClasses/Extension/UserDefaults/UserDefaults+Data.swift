//
//  UserDefaults+UserData.swift
//  FishingAppLTSL
//
//  Created by Umesh kumar on 11/04/18.
//  Copyright © 2018 Umesh kumar. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    enum UserDefaultsKeys:String {
        case isLogin
        case userID
        case email
        case fullName
        case firstName
        case lastName
        case phone
        case profileImage
        case socialFlag
        case userTypeKey
        case socialUserID
        case authKey
        case history
        case deviceToken
        case notification
        case languageId
        case language
    }
    
    func isUserLogin(_ value:Bool){
        set(value, forKey: UserDefaultsKeys.isLogin.rawValue)
        synchronize()
    }
    
    func getUserLoggedIn()->Bool {
        return bool(forKey: UserDefaultsKeys.isLogin.rawValue)
    }
    
    //MARK:- Set User Data
    func setUserID(_ value:String){
        set(value, forKey: UserDefaultsKeys.userID.rawValue)
        synchronize()
    }
    
    func getUserID()->String {
        return string(forKey: UserDefaultsKeys.userID.rawValue) ?? ""
    }
    
    func setemail(_ value:String){
        set(value, forKey: UserDefaultsKeys.email.rawValue)
        synchronize()
    }
    
    func getemail()->String {
        return string(forKey: UserDefaultsKeys.email.rawValue) ?? ""
    }
    
    func setfullName(_ value:String){
        set(value, forKey: UserDefaultsKeys.fullName.rawValue)
        synchronize()
    }
    
    func getfullName()->String? {
        return string(forKey: UserDefaultsKeys.fullName.rawValue)
    }
    
    func setfirstName(_ value:String){
        set(value, forKey: UserDefaultsKeys.firstName.rawValue)
        synchronize()
    }
    
    func getfirstName()->String {
        return string(forKey: UserDefaultsKeys.firstName.rawValue) ?? ""
    }
    func setlastName(_ value:String){
        set(value, forKey: UserDefaultsKeys.lastName.rawValue)
        synchronize()
    }
    
    func getlastName()->String {
        return string(forKey: UserDefaultsKeys.lastName.rawValue) ?? ""
    }
    func setphone(_ value:String){
        set(value, forKey: UserDefaultsKeys.phone.rawValue)
        synchronize()
    }
    
    func getphone()->String? {
        return string(forKey: UserDefaultsKeys.phone.rawValue)
    }
    func setprofileImage(_ value:String){
        set(value, forKey: UserDefaultsKeys.profileImage.rawValue)
        synchronize()
    }
    
    func getprofileImage()->String? {
        return string(forKey: UserDefaultsKeys.profileImage.rawValue)
    }
    
    func setsocialFlag(_ value:String){
        set(value, forKey: UserDefaultsKeys.socialFlag.rawValue)
        synchronize()
    }
    
    func getsocialFlag()->String {
        return string(forKey: UserDefaultsKeys.socialFlag.rawValue)!
    }
  
    func setsocialUserID(_ value:String){
        set(value, forKey: UserDefaultsKeys.socialUserID.rawValue)
        synchronize()
    }
    
    func getsocialUserID()->String? {
        return string(forKey: UserDefaultsKeys.socialUserID.rawValue)
    }
    
  
    
    func setAuthToken(_ value:String){
        set(value, forKey: UserDefaultsKeys.authKey.rawValue)
        synchronize()
    }
    
    func getauthToken()->String? {
        return string(forKey: UserDefaultsKeys.authKey.rawValue)
    }
    
    func setHistoryArr(_ value:Any?){
        set(value, forKey: UserDefaultsKeys.history.rawValue)
        synchronize()
    }
    
    func getHistoryArr()-> [String]? {
        return array(forKey: UserDefaultsKeys.history.rawValue) as? [String]
    }
    
    func setDeviceToken(_ value:String){
        set(value, forKey: UserDefaultsKeys.deviceToken.rawValue)
        synchronize()
    }
    
    func getDeviceToken()->String {
        return string(forKey: UserDefaultsKeys.deviceToken.rawValue) ?? ""
    }
    
    func setNotification(_ value:[AnyHashable: Any]){
        set(value, forKey: UserDefaultsKeys.notification.rawValue)
        synchronize()
    }
    
    func getNotification()->[AnyHashable: Any]? {
        return object(forKey: UserDefaultsKeys.notification.rawValue) as? [AnyHashable:Any]
    }
    
    func setLanguageId(_ value:String){
        set(value, forKey: UserDefaultsKeys.languageId.rawValue)
        synchronize()
    }
    
    func getLanguageId()->String? {
        return string(forKey: UserDefaultsKeys.languageId.rawValue)
    }
    
    func setLanguage(_ value:String){
        set(value, forKey: UserDefaultsKeys.language.rawValue)
        synchronize()
    }
    
    func getLanguage()->String {
        return string(forKey: UserDefaultsKeys.language.rawValue) ?? "en"
    }
    
    func removeNotification(){
        removeObject(forKey: UserDefaultsKeys.notification.rawValue)
    }
    
    func clearData(){
        removeObject(forKey: UserDefaultsKeys.userID.rawValue)
        removeObject(forKey: UserDefaultsKeys.email.rawValue)
        removeObject(forKey: UserDefaultsKeys.firstName.rawValue)
        removeObject(forKey: UserDefaultsKeys.lastName.rawValue)
        removeObject(forKey: UserDefaultsKeys.profileImage.rawValue)
        removeObject(forKey: UserDefaultsKeys.phone.rawValue)
        removeObject(forKey: UserDefaultsKeys.socialFlag.rawValue)
        removeObject(forKey: UserDefaultsKeys.fullName.rawValue)
        removeObject(forKey: UserDefaultsKeys.userTypeKey.rawValue)
        removeObject(forKey: UserDefaultsKeys.authKey.rawValue)
        removeObject(forKey: UserDefaultsKeys.history.rawValue)
        removeObject(forKey: UserDefaultsKeys.notification.rawValue)
        removeObject(forKey: UserDefaultsKeys.languageId.rawValue)
        removeObject(forKey: UserDefaultsKeys.language.rawValue)
    }
    
}
