//
//  ViewController.swift
//  Test
//
//  Created by iOS Development on 9/12/19.
//  Copyright © 2019 iOS Development. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import Reachability
import AVKit


class ViewController:UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var faceIdAccess = String()
    var apiTokenAccess = String()
    var passcode = String()
    let imagePickerController = UIImagePickerController()
    var strOccsn = String()
    var strDOB = String()
    var strDateOfIssue = String()
    var strDateOfExp = String()
    var imageData : Data?
    var idProofDic = [String:Any]()
    var para = Parameters()
    @IBOutlet weak var imgCamera: UIImageView!
    @IBOutlet weak var imgFace: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        for i in 1 ... 4 {
        //            createpasscode(withcount: i)
        //        }
        // Do any additional setup after loading the view.
    }
    
    func createpasscode(withcount count: Int){
        switch count {
        case 1:
            let faceID = faceIdAccess
            let appID =  apiTokenAccess
            let UUIDValue = UIDevice.current.identifierForVendor!.uuidString
            let first8 = String(UUIDValue.prefix(8))
            let last8 = String(UUIDValue.suffix(8))
            passcode = (faceID[0...8]) + (first8[0...1]) + (last8[0...1]) + (appID[0...7])
            
            
            break
        case 2:
            let faceID = faceIdAccess
            let appID =  apiTokenAccess
            let UUIDValue = UIDevice.current.identifierForVendor!.uuidString
            let first8 = String(UUIDValue.prefix(8))
            let last8 = String(UUIDValue.suffix(8))
            passcode = passcode + (faceID[9...17]) + (first8[2...3]) + (last8[2...3]) + (appID[8...15])
            
            
            break
        case 3:
            let faceID = faceIdAccess
            let appID =  apiTokenAccess
            let UUIDValue = UIDevice.current.identifierForVendor!.uuidString
            let first8 = String(UUIDValue.prefix(8))
            let last8 = String(UUIDValue.suffix(8))
            passcode = passcode + (faceID[18...26]) + (first8[4...5]) + (last8[4...5]) + (appID[16...23])
            
            
            break
        case 4:
            let faceID = faceIdAccess
            let appID =  apiTokenAccess
            let UUIDValue = UIDevice.current.identifierForVendor!.uuidString
            print(UUIDValue)
            let first8 = String(UUIDValue.prefix(8))
            let last8 = String(UUIDValue.suffix(8))
            passcode = passcode + (faceID[27...35]) + (first8[6...7]) + (last8[6...7]) + (appID[24...31])
            print(passcode)
           
            UserDefaults.standard.set(passcode, forKey: "passcode")
            break
        default:
            break
        }
        
    }
    
    @IBAction func btnCameraOn(_ sender: Any) {
        //        if UIImagePickerController.isSourceTypeAvailable(.camera) {
        //            var imagePicker = UIImagePickerController()
        //            imagePicker.delegate = self
        //            imagePicker.sourceType = .camera;
        //            imagePicker.allowsEditing = false
        //            imagePicker.cameraDevice = .front
        //            self.present(imagePicker, animated: true, completion: nil)
        //        }
        //     //  login()
        pushViewController(withfromviewController: self, withtoViewController: "LoginViewController")
        
    }
    
    
    func login(){
        let params : Parameters = [
            "passCode": passcode
            
            
            ] as [String : Any]
        let headers = [
            "x-api-key" : "391103740e4943fd9a63884502c25b29"
        ]
        
        signin(withparameter: params, header: headers)
        
    }
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        imgCamera.image = image
        
        self.imageData = image.pngData()
        
        self.imageData = image.jpegData(compressionQuality: 0.75)
        
        print(imageData)
        //obtaining saving path
        let fileManager = FileManager.default
        let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        
        let imagePath = documentsPath?.appendingPathComponent("image.jpg")
        print(imagePath)
        self.imageData = image.pngData()
        
        self.idProofDic["data"] = self.imageData as! Data
        self.idProofDic["mimeType"] = "image/jpg" as String
        self.idProofDic["extension"] = ".jpg"
        
        
        Addimage()
        
        // extract image from the picker and save it
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func Addimage(){
        self.imgFace.isHidden = true
        uploadImage()
    }
    
    func uploadImage(){
        let params : Parameters = [
            "mode" : "get-face-id"
            ] as [String : Any]
        requestWithImage(withurlString: Urls.imageurl, forImageOne: self.idProofDic, parameters: params, withSuccess: { (response) in
            print(response)
            let Main_response = response as! [String: Any]
            let status  = Main_response["status"] as! NSNumber
            if status == 0 {
                let message  = Main_response["message"] as! String
                alert(withmessage: message, withpresentviewcontroller: self, withtype: "Single")
                
            } else if status == 1 {
                
                let message  = Main_response["message"] as! String
                let body  = Main_response["body"] as! [String:Any]
                
                print("@@@@\(body)")
                let isCreated = body["isCreated"] as? NSNumber
                let faceId = body["faceId"] as? String
                let apiToken = body["apiToken"] as? String
                self.faceIdAccess = body["faceId"] as! String
                self.apiTokenAccess = body["apiToken"] as! String
                print(self.faceIdAccess)
                print(self.apiTokenAccess)
                for i in 1 ... 4 {
                    self.createpasscode(withcount: i)
                }
                if isCreated == 0 {
                    self.login()
                }
                if isCreated == 1 {
                    self.login()
                }
                
            } else if status ==  2 {
                let message  = Main_response["message"] as! String
                alert(withmessage: message, withpresentviewcontroller: self, withtype: "Single")
                
            } else {
                
            }
        }) { (ERROR) in
            print(ERROR)
        }
    }
    func requestWithImage(withurlString urlString: String, forImageOne imageDataOne: [String: Any],parameters: [String : Any], withSuccess success:@escaping (_ response: (Any)) -> Void, andFailure failure:@escaping (_ error: APIError?) -> Void) {
        
        
        let reachability = Reachability()!
        
        if reachability.connection != .none {
            
            SVProgressHUD.show()
            print("Main url==\(urlString)")
            print("Parameters==\(parameters)")
            
            let headers: HTTPHeaders = [
                /* "Authorization": "your_access_token",  in case you need authorization header */
                
                "x-api-key": "391103740e4943fd9a63884502c25b29"
                
            ]
            
            Alamofire.upload(
                
                multipartFormData: { (multipartFormData) in
                    
                    for (key, value) in parameters {
                        multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                    }
                    
                    let idproofData = imageDataOne["data"] as? Data
                    
                    let idproofExtension = imageDataOne["extension"] as? String
                    let idproofFileName = "image" + idproofExtension!
                    let idproofMimeType = imageDataOne["mimeType"] as? String
                    
                    print("idproofFileName==\(idproofFileName)")
                    print(imageDataOne)
                    
                    
                    
                    print(imageDataOne)
                    
                    let timestamp = NSDate().timeIntervalSince1970
                    let myTimeInterval = TimeInterval(timestamp)
                    let time = NSDate(timeIntervalSince1970: TimeInterval(myTimeInterval))
                    let filename = (Int(round(timestamp)))
                    
                    if let data_id_proof = idproofData{
                        multipartFormData.append(data_id_proof, withName: "image", fileName: "\(filename)", mimeType: "image/png")
                    }
                    
                    
                    //                    print("Multi part Content -Type")
                    //                    print(multipartFormData.contentType)
                    //                    print("Multi part FIN ")
                    //                    print("Multi part Content-Length")
                    //                    print(multipartFormData.contentLength)
                    //                    print("Multi part Content-Boundary")
                    //                    print(multipartFormData.boundary)
                    
            }, usingThreshold: UInt64.init(), to: urlString, method: .post, headers: headers) { (result) in
                
                print(result)
                
                switch result {
                    
                case .success(let upload,_,_ ):
                    
                    upload.uploadProgress(closure: { (progress) in
                        print("Upload Progress: \(progress.fractionCompleted)")
                    })
                    
                    upload.responseJSON { response in
                        
                        SVProgressHUD.dismiss()
                        
                        switch response.result {
                            
                        case .success(let response):
                            
                            print("json : \(response)")
                            success(response)
                            break
                            
                        case .failure( _):
                            
                            let error = APIError(errorCode: -201, errorDetails: "api failure")
                            failure (error)
                            print("Webservice Error - \(error.localizedDescription)")
                            break
                        }
                        
                    }
                    
                case .failure( _):
                    
                    let error = APIError(errorCode: -201, errorDetails: "api failure")
                    failure (error)
                }
            }
            
        } else {
            let error = APIError(errorCode: -200, errorDetails: "No network")
            failure(error)
        }
        
    }
}

private typealias Apicalling = ViewController
extension Apicalling {
    
    private func signin(withparameter parameter:Parameters,header:HTTPHeaders){
        
        
        
        FetchData.BaseApiCalling(withurlString: Urls.loginurl, withjsonString: parameter,header: header ,withloaderMessage: "", withSuccess: { (response) in
            print("myresponse")
            print(response)
            
            
            let Main_response = response as! NSDictionary
            let message  = Main_response["message"] as! String
            let status  = Main_response["status"] as! Bool
            if status == false {
                let message  = Main_response["message"] as! String
                alert(withmessage: message, withpresentviewcontroller: self, withtype: "Single")
            } else if status == true {
                
                let message  = Main_response["message"] as! String
                let body  = Main_response["body"] as! [String:Any]
                
                print("@@@@\(body)")
                let endpointDid = body["endpointDid"] as? String
                let isPassportVerified = body["isPassportVerified"] as? String
                let isDrivingLicenceVerified = body["isDrivingLicenceVerified"] as? String
                let isPhoneVerified = body["isPhoneVerified"] as? String
                let isEmailVerified = body["isEmailVerified"] as? String
                let publicVerkey = body["publicVerkey"] as? String
                let isWalletCreated = body["isWalletCreated"] as? String
                let userType = body["userType"] as? String
                
                UserDefaults.standard.set(endpointDid, forKey: "isPassportVerified")
                UserDefaults.standard.set(endpointDid, forKey: "endpointDid")
                print(endpointDid)
                
                
                pushViewController(withfromviewController: self, withtoViewController: "LoginViewController")
            } else {
                let message  = Main_response["message"] as! String
                alert(withmessage: message, withpresentviewcontroller: self, withtype: "Single")
            }
            
            
        }) { (error) in
            print (error)
        }
    }
    
}

extension String {
    subscript(_ i: Int) -> String {
        let idx1 = index(startIndex, offsetBy: i)
        let idx2 = index(idx1, offsetBy: 1)
        return String(self[idx1..<idx2])
    }
    
    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[start ..< end])
    }
    
    subscript (r: CountableClosedRange<Int>) -> String {
        let startIndex =  self.index(self.startIndex, offsetBy: r.lowerBound)
        let endIndex = self.index(startIndex, offsetBy: r.upperBound - r.lowerBound)
        return String(self[startIndex...endIndex])
    }
}
