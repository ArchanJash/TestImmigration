


import Foundation
import UIKit
public let LoginScreenStatusColor = UIColorRGBA(red: 255.0, green: 255.0, blue: 255.0, alpha: 0.6)
public let ScreenGreenColor = UIColorRGB(red: 150.0, green: 210.0, blue: 62.0)
public let StatusBarBlueColor = UIColorRGB(red: 6.0, green: 94.0, blue: 166.0)
public let ScreenlightblueColor = UIColorRGB(red: 130.0, green: 196.0, blue: 255.0)
public let ScreenlightGreenColor = UIColorRGB(red: 227.0, green: 240.0, blue: 193.0)
public let BLACKColor = UIColorRGB(red: 34.0, green: 34.0, blue: 34.0)
public let WINEColor = UIColorRGB(red: 173.0, green: 37.0, blue: 50.0)
public let screenWidth = UIScreen.main.bounds.width
public let screenHeight = UIScreen.main.bounds.height
public var myProfileContent : [String:Any]? = nil
public let DeviceID = UIDevice.current.identifierForVendor!.uuidString

let verificationText = "You must be 18 or over to access this store.If you are under 18 then you must leave."
let AgeverificationtitleText = "Age Verification Required"
struct APIError: Error {
    var errorCode: Int?
    var errorDetails: String?
}

var locationaddress = ""

enum PostType {
    case postProperty
    case postCar
    case realState
    case none
}

enum ViewcontrollerType {
    case SplashViewController
    case DashboardViewController
    case LoginViewController
     case OtherViewController
    case ProductDetailsViewController
    case MixerViewController
    case BlukOrderViewController
    case MyFavouriteViewController
    case ProfileViewController
    case MyCartViewController
    case ProductListViewController
    case OrderHistoryViewController
    case ProductAlertViewController
    case ConfirmAddressViewController
    
}
enum StatusType {
    case Success
    case Error
    case Business
    case ChangePassword
    case Filter
    case PromoCode
    
}

enum PopupviewType {
    case Single         //for only Ok button
    case Double         //for Ok and cancel button
    
}



enum ApiCallType {
    case DashboardCategory
    case Login
    case SocialLogin
    case Mixer
    case Munchies
    case Other
    case getProfile
    case applyPromoCode
    case updateProfile
    case addfavorite
    case Cart
    case RemoveCart
    case UpdateQuantity
    case Favorites
    case Remove
    case AddMixer
    case AddMunchies
}

extension Float {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
