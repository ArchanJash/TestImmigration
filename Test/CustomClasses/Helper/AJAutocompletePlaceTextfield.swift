//
//  AJAutocompletePlaceTextfield.swift
//  AJAutoCompletePlaceTextField
//
//  Created by Arpit Jain on 28/07/17.
//  Copyright © 2017 Arpit Jain. All rights reserved.
//

import UIKit
import MapKit

var currentselectedPlace: String! = ""
var country : String? = ""
var locality : String? = ""
var subLocality : String? = ""
var thoroughfare : String? = ""
var postalCode : String? = ""
var subThoroughfare : String? = ""
var administrativeArea : String? = ""
var latitude : String? = ""
var longitude : String? = ""
var address : String? = ""
let mapview = MKMapView()

class AJAutocompletePlaceTextfield: UITextField , UITextFieldDelegate {
    
    //MARK: - PROPERTIES

    /// Instance of autoCompleteTableView
    fileprivate var autoCompleteTableView:UITableView?
    /// Gives the array of autoCompletePlacesData
    open var autoCompletePlacesData = [String]()
    /// Gives the selected place and indexPath
    open var selectedPlace: ((String, IndexPath) -> ())?
    
    /// Font for the places data
    open var autoCompleteTextFont = UIFont.systemFont(ofSize: 12)
    /// Color of the places data
    open var autoCompleteTextColor = UIColor.black
    /// Used to set the height of cell for each suggestions
    open var autoCompleteCellHeight:CGFloat = 44.0
    /// The maximum visible suggestion
    open var maxAutoCompleteDataCount = 5
    /// Used to set your own preferred separator inset
    open var autoCompleteSeparatorInset = UIEdgeInsets.zero
    /// Hides autoCompleteTableView after selecting a place
    open var hidesWhenSelected = true
    /// Shows autoCompletePlacesData with formatting
    open var highLightTypeTextedEnabled:Bool?
    /// Define attributes for highlighted text
    open var highLightTypeTextedAttributes:[NSAttributedString.Key :Any]?
    
    
    /// Hides autoCompleteTableView when the textfield is empty
    open var hidesWhenEmpty:Bool?{
        didSet{
            DispatchQueue.main.async {
                self.autoCompleteTableView?.isHidden = self.hidesWhenEmpty!
            }
        }
    }
    /// The autoCompleteTableView height
    open var autoCompleteTableHeight:CGFloat?{
        didSet{
            redrawTable()
        }
    }
   
    /// this is the x margin for table view from textfield
    open var autoCompleteTableMargin = CGFloat()

    //MARK: - INIT FUNCTIONS
        
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
        setupAutocompleteTable(superview!)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        commonInit()
        setupAutocompleteTable(superview!)
        
    }
//    open override func willMove(toSuperview newSuperview: UIView?) {
//        super.willMove(toSuperview: newSuperview)
//        commonInit()
//        setupAutocompleteTable(newSuperview!)
//    }
    
    fileprivate func commonInit(){
        
        hidesWhenEmpty = true
        highLightTypeTextedEnabled = false
       // highLightTypeTextedAttributes = [NSAttributedString.foregroundColor.rawValue:UIColor.black]
        //highLightTypeTextedAttributes![NSFontAttributeName] = UIFont.boldSystemFont(ofSize: 12)
        self.clearButtonMode = .always
//        self.addTarget(self, action: #selector(AJAutocompletePlaceTextfield.textFieldDidChange), for: .editingChanged)
//        self.addTarget(self, action: #selector(AJAutocompletePlaceTextfield.textFieldDidEndEditing), for: .editingDidEnd)
    }
    
    fileprivate func setupAutocompleteTable(_ view:UIView){
        
        autoCompleteTableMargin = 10.0
        let tableView = UITableView(frame: CGRect(x: self.frame.origin.x + autoCompleteTableMargin/2, y: self.frame.origin.y + self.frame.height, width: (self.frame.width - autoCompleteTableMargin), height: 30.0))
        tableView.dataSource = self
        tableView.delegate = self
      //  tableView.backgroundColor = .red
        tableView.rowHeight = autoCompleteCellHeight
        tableView.isHidden = hidesWhenEmpty ?? true
        tableView.layer.borderColor = UIColor.lightGray.cgColor
        tableView.layer.borderWidth = 0.5
        tableView.layer.zPosition = CGFloat.greatestFiniteMagnitude
        view.addSubview(tableView)
        autoCompleteTableView = tableView
        autoCompleteTableHeight = 200.0
    }
    
    fileprivate func redrawTable(){
        
        if let autoCompleteTableView = autoCompleteTableView, let autoCompleteTableHeight = autoCompleteTableHeight {
            var newFrame = autoCompleteTableView.frame
            newFrame.size.height = autoCompleteTableHeight
            autoCompleteTableView.frame = newFrame
        }
    }
    
    //MARK: - Private Methods
    
    fileprivate func showHighlightedTypedText(aStr : NSString) -> NSAttributedString {
        
        let attrs = [NSAttributedString.Key.foregroundColor.rawValue:autoCompleteTextColor, NSAttributedString.Key.font:autoCompleteTextFont] as! [NSAttributedString.Key : Any]
        let range = aStr.range(of: text!, options: .caseInsensitive) 
        let attString = NSMutableAttributedString(string: aStr as! String, attributes: attrs)
        attString.addAttributes(highLightTypeTextedAttributes!, range: range)
        autoCompleteTextColor = UIColor.gray
        return attString
    }

    //MARK: - AJAutoCompleteTextfieldDelegate

//    @objc func textFieldDidChange(){
//        let placesClient = GMSPlacesClient()
//
//        placesClient.autocompleteQuery(text!, bounds: nil, filter: nil, callback: { (results, error) in
//
//            DispatchQueue.main.async {
//                self.autoCompletePlacesData.removeAll()
//                if results != nil {
//                    for result in results!{
//                        self.autoCompletePlacesData.append(result.attributedFullText.string)
//                    }
//                }
//                if self.autoCompletePlacesData.count != 0{
//                    self.hidesWhenEmpty = false
//                    if self.autoCompletePlacesData.count < self.maxAutoCompleteDataCount{
//                        self.autoCompleteTableHeight = self.autoCompleteTableView?.contentSize.height
//                    }else{
//                        self.autoCompleteTableHeight = 200
//                    }
//                    self.autoCompleteTableView?.reloadData()
//                }else{
//                    self.hidesWhenEmpty = true
//                }
//                self.autoCompleteTableView?.isHidden =  self.hidesWhenEmpty!
//            }
//        })
//    }
    
    @objc func textFieldDidEndEditing() {
        autoCompleteTableView?.isHidden = true
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(currentselectedPlace) { (placemarks:[CLPlacemark]?, error:Error?) in
            if error == nil {
                
                let placemark = placemarks?.first
                
                let anno = MKPointAnnotation()
                anno.coordinate = (placemark?.location?.coordinate)!
                anno.title = currentselectedPlace
                
                let span = MKCoordinateSpan(latitudeDelta: 0.075, longitudeDelta: 0.075)
                let region = MKCoordinateRegion(center: anno.coordinate, span: span)
                mapview.selectAnnotation(anno, animated: true)
                mapview.setRegion(region, animated: true)
                mapview.addAnnotation(anno)
                mapview.selectAnnotation(anno, animated: true)
                print("CORDINATE==== \(anno.coordinate)")
                latitude = "\(anno.coordinate.latitude)"
                longitude = "\(anno.coordinate.longitude)"
                self.getAddressFromLatLon(pdblLatitude: "\(anno.coordinate.latitude)", withLongitude: "\(anno.coordinate.longitude)")
                
            }else{
                print(error?.localizedDescription ?? "error")
            }
            
            
        }
        
        
      
}
    
    
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        //21.228124
        let lon: Double = Double("\(pdblLongitude)")!
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks! as [CLPlacemark]
                
                if pm.count > 0 {
                    let pm = placemarks![0]
                    print(pm.country)
                    if pm.country != nil {
                    country = pm.country!
                    }
                    print(pm.locality)
                    if  pm.locality != nil {
                    locality = pm.locality!
                    }
                    print(pm.subLocality)
                    if  pm.subLocality !=  nil {
                    subLocality = pm.subLocality!
                    }
                    print(pm.thoroughfare)
                    if pm.thoroughfare != nil {
                    thoroughfare = pm.thoroughfare!
                    }
                    print(pm.postalCode)
                    if pm.postalCode != nil {
                    postalCode = pm.postalCode!
                    }
                    print(pm.subThoroughfare)
                    if pm.subThoroughfare != nil {
                    subThoroughfare = pm.subThoroughfare!
                    }
                    var addressString : String = ""
                    if pm.subLocality != nil {
                        addressString = addressString + pm.subLocality! + ", "
                    }
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! + ", "
                    }
                    if pm.country != nil {
                        addressString = addressString + pm.country! + ", "
                    }
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }
                    if pm.administrativeArea != nil {
                        addressString = addressString + pm.administrativeArea! + " "
                    }
                    
                    address = addressString
                    
                    print(addressString)
                }
        })
        
    }
    
}

//MARK: - UITableViewDataSource & UITableViewDelegate

extension AJAutocompletePlaceTextfield: UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autoCompletePlacesData.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "autocompleteCellIdentifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
      //  cell?.backgroundColor = UIColor.red
        if cell == nil{
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        if highLightTypeTextedEnabled!{
            cell?.textLabel?.attributedText = showHighlightedTypedText(aStr: autoCompletePlacesData[indexPath.row] as NSString)
        }else{
            cell?.textLabel?.font = autoCompleteTextFont
            cell?.textLabel?.textColor = autoCompleteTextColor
            cell?.textLabel?.text = autoCompletePlacesData[indexPath.row]
        }
        cell?.textLabel?.numberOfLines = 0
        cell?.contentView.gestureRecognizers = nil
        return cell!
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        
        if let selectedText = cell?.textLabel?.text {
            self.text = selectedText
            currentselectedPlace = selectedText
            self.resignFirstResponder()
           
            selectedPlace!(selectedText, indexPath)
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            tableView.isHidden = self.hidesWhenSelected
        })
    }
    
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)){
            cell.separatorInset = autoCompleteSeparatorInset
        }
        if cell.responds(to: #selector(setter: UIView.preservesSuperviewLayoutMargins)){
            cell.preservesSuperviewLayoutMargins = false
        }
        if cell.responds(to: #selector(setter: UIView.layoutMargins)){
            cell.layoutMargins = autoCompleteSeparatorInset
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return autoCompleteCellHeight
    }
}
