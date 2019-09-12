//
//  InputFieldModel.swift
//  Renzo
//
//  Created by Sonam Verma on 23/08/18.
//  Copyright © 2018 Umesh Verma. All rights reserved.
//

import UIKit

final class InputFieldValidator : NSObject {
    static let shared = InputFieldValidator()
    
    var socialsignIn : SocialSignInModel = SocialSignInModel()
    var signUp : SignUpModel = SignUpModel()
    var signIn : SignInModel = SignInModel()
    var bulkOrder : BulkOrderModel = BulkOrderModel()
    var updateProfile : ProfileModel = ProfileModel()
    var passwordMatcher : PasswordModel = PasswordModel()
    var recentOrder : RecentOrderModel = RecentOrderModel()
    var filter : FilterModel = FilterModel()
    var addToCart : AddtoCartModel = AddtoCartModel()
    var addToFavorite : AddtoFavorites = AddtoFavorites()
    var removeFavorite : RemoveFavorites = RemoveFavorites()
    var finalorder : FinalOrderModel = FinalOrderModel()
    var munchiesadd : MunchiesAdd = MunchiesAdd()
    var mixeradd : MixerAdd = MixerAdd()
    var promocode : PromoCodeModel = PromoCodeModel()
    var removecart : RemoveCartModel = RemoveCartModel()
    var updateQuantity : UpdateQuantityModel = UpdateQuantityModel()
    func validateSignUp() -> String {
        var alert : String = ""
        
        if (signUp.fname == ""){
            alert = "First name can't be empty"
            return alert
        }
        if (signUp.lname == ""){
            alert = "Last name can't be empty"
            return alert
        }
        
        if (signUp.email == ""){
            alert = "Email ID can't be empty"
            return alert
        }
        
        if (isValidEmail(email: signUp.email)==false){
            alert = "Invalid Email ID"
            return alert
        }
        
        if (signUp.password == ""){
            alert = "Password can't be empty"
            return alert
        }
        
        
        if (signUp.password.count < 2){
            alert = "Invalid password, Passord should be minimum 2 characters."
            return alert
        }
        
        if (signUp.userType == ""){
            alert = "Select User Type"
            return alert
        }
        
        return alert
        
    }
    
    func validateUpdate() -> String {
        var alert : String = ""
        
        if (signUp.fname == ""){
            alert = "First name can't be empty"
            return alert
        }
        if (signUp.lname == ""){
            alert = "Last name can't be empty"
            return alert
        }
        
        if (signUp.email == ""){
            alert = "Email ID can't be empty"
            return alert
        }
        
        if (isValidEmail(email: signUp.email)==false){
            alert = "Invalid Email ID"
            return alert
        }
        return alert
    }
    
    func validateSignInEmail() -> String {
        var alert : String = ""
        
        if (signIn.email == ""){
            alert = "Email ID can't be empty"
            return alert
        }
        
        if (isValidEmail(email: signIn.email)==false){
            alert = "Invalid Email ID"
            return alert
        }
        
        return alert
        
    }
    
    func validateSignInPassword() -> String {
        var alert : String = ""
        
        if (signIn.password == ""){
            alert = "Password can't be empty"
            return alert
        }
        
        if (signIn.password.count < 2){
            alert = "Invalid password, Passord should be minimum 2 characters."
            return alert
        }
    
        return alert
        
    }
    
    func validatePasswordModel() -> String {
        var alert : String = ""
        
        if (passwordMatcher.oldPassword.count == 0){
            alert = "Password can't be empty"
            return alert
        }
        
        if (passwordMatcher.newPassword.count == 0){
            alert = "New Password can't be empty"
            return alert
        }
        
        if (passwordMatcher.confirmPassword.count == 0){
            alert = "Confirm Password can't be empty"
            return alert
        }
        
        if (passwordMatcher.newPassword.count < 2){
            alert = "Invalid password, Passord should be minimum 2 characters."
            return alert
        }
        
        if (passwordMatcher.newPassword != passwordMatcher.confirmPassword){
            alert = "New Password Mismatch"
            return alert
        }
        
        return alert
        
    }
    
    func validateBulkOrderModel() -> String {
        var alert : String = ""
        
        if (bulkOrder.name == ""){
            alert = "Name can't be empty"
            return alert
        }
        
        if (bulkOrder.address == ""){
            alert = "Address can't be empty"
            return alert
        }
        
        return alert
        
    }
    
    func isValidEmail(email : String) -> Bool{
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        
        return emailPredicate.evaluate(with: email)
    }
}

struct SignUpModel {
    
    var fname : String = ""
    var lname : String = ""
    var email : String = ""
    var password : String = ""
    var userType : String = ""
    
}

struct SignInModel {
    var email : String = ""
    var password : String = ""
}

struct SocialSignInModel {
    var email : String = ""
    var password : String = ""
   var deviceid : String = ""
   var provider : String = ""
   var provider_id : String = ""
   var fcm_reg_token : String = ""
   var name : String = ""
   var mobile : String = ""
   var dob : String = ""
}


struct PasswordModel {
    var oldPassword : String = ""
    var newPassword : String = ""
    var confirmPassword : String = ""
}

struct BulkOrderModel {
    var name : String = ""
    var occassion : String = ""
    var address : String = ""
    var date : String = ""
    var note : String = ""
  
}

struct ProfileModel {
    var name : String = ""
    var email : String = ""
    var ph : String = ""
    var date : String = ""
    var password : String = ""
    
}

struct RecentOrderModel {
    var limit : String = ""
    var offset : String = ""
   
    
}
struct FilterModel {
    var cat_id : String = ""
    var order : String = ""
    var key:  String = ""
    
    
}

struct AddtoCartModel {
    var sub_pr_id : String = ""
    var order : String = ""
    var type:  String = ""
    var product_id: String = ""
    var user_id: String = ""
    
}

struct AddtoFavorites {
    var sub_pr_id : String = ""
    var type:  String = ""
    var product_id: String = ""
    var user_id: String = ""
    
}
struct RemoveFavorites {
    
    var fav_id: String = ""
    var user_id: String = ""
    
}
struct FinalOrderModel {
  
    var payment_mode : String = ""
    var addr_id : String = ""
    var phone_number : String = ""
    var user_id: String = ""
    var promo_id : String = ""
     var lat : String = ""
     var lng : String = ""
    var point_applied : String = ""
    var is_gift : String = ""
    var gift_msg : String = ""
    var occassion : String = ""
    var delievery_date :String = ""
    
}
struct MunchiesAdd {
    var acc_id: String = ""
    var user_id: String = ""
    var order_qty: String = ""
    var type: String = ""
    
}

struct MixerAdd {
    var acc_id: String = ""
    var user_id: String = ""
    var order_qty: String = ""
    var type: String = ""
    
}


struct PromoCodeModel {
    var promo_code: String = ""
    var user_id: String = ""
    var action: String = ""
   
    
}
struct RemoveCartModel {
    var promo_id: String = ""
    var user_id: String = ""
    var id: String = ""
    
    
}
struct UpdateQuantityModel {
    var promo_id: String = ""
    var user_id: String = ""
    var id: String = ""
    var order_qty: String = ""
    
    
}
