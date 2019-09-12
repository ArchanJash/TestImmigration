


import Foundation
class Urls {
    //URL
    static let mainurl = "https://develop.ssid.ky/api/"
    static let imageurl = "http://34.249.235.184:4000/face"
    static let passportimageurl = "http://34.249.235.184:4000/passport"
    static let drivingimageurl = "http://34.249.235.184:4000/driving-licence"
    static let immigrationurl = "http://34.249.235.184:3000/immigration-form"
    static let customsurl = "http://34.249.235.184:3000/customs-declaration-form"
    //Login
    static let registerurl = mainurl + "Wallet"
    static let loginurl = "http://34.249.235.184:3000/login"
    static let emailverification = mainurl + "Wallet"
    static let adminurl = mainurl + "Admin"
    
    //Connections
    static let sendconnectionurl = mainurl + "Connections"
    static let viewconnectionurl = mainurl + "Connections"
    static let acceptconnectionurl = mainurl + "Connections"
    static let connectionlisturl = mainurl + "Connections"
    
    //AddMunchies
    static let walletactivityurl = mainurl + "Wallet"
    
    
    
    //Credential offer
    static let pendingdatalisturl = mainurl + "Credential"
   
    //Address schema
    static let addressurl = mainurl + "Wallet"
    
    //get profile
    static let getprofileurl = mainurl + "api/get_profile"
    
    //update profile
    static let updateprofileurl = mainurl + "api/update_profile"
    
    //fetch cart
    static let fetchcarturl = mainurl + "api/fetch_cart"
    
    //recent order
    static let recentorderurl = mainurl + "api/fetch_order_history"
    
    //filter
    static let filterurl = mainurl + "api/wines_per_cat"
    
    //add to cart
    static let addtocarturl = mainurl + "api/add_to_cart"
    
    //add to favorite
    static let addtofavurl = mainurl + "api/add_to_fav"
    
    //remove to favorite
    static let removefavurl = mainurl + "api/delete_favorite"
    
    //finalorder
    static let finalorderurl = mainurl + "api/final_order"
    

 
}

