//
//  Model.swift
//  Beipu
//
//  Created by 陳Mike on 2022/6/28.
//

import Foundation
import UIKit.UIImage

class Banner {
//    id
    let bid: String
    let banner_subject: String
    let banner_date: String
    let banner_enddate: String
    let banner_descript: String
//    廣告連結
    var banner_link: String
//    廣告圖
    var banner_picture: UIImage? {
        didSet{
            self.renewImage?()
            self.renewImage = nil
        }
    }
//    圖片更新用closuere
    var renewImage: (()->())?
    
    init(from dict: [String: Any]) {
        let tempDict = dict.castToStrStr()
        
        self.bid = tempDict["bid"] ?? ""
        self.banner_subject = tempDict["banner_subject"] ?? ""
        self.banner_descript = tempDict["banner_descript"] ?? ""
        self.banner_date = tempDict["banner_date"] ?? ""
        self.banner_enddate = tempDict["banner_enddate"] ?? ""
        let banner_link = tempDict["banner_link"] ?? ""
        if banner_link == "http://" {
            self.banner_link = ""
        }else{
            self.banner_link = banner_link
        }
//        讀取圖片
        let banner_picture = tempDict["banner_picture"] ?? ""
        WebAPI.shared.requestImage(urlString: PIC_URL + banner_picture) { image in
            self.banner_picture = image
        }
    }
}


class Store {
    let sid: String
    let store_id: String
    let store_type: String
    let store_name: String
    let shopping_area: String
    let store_phone: String
    let store_address: String
    let store_website: String
    let store_facebook: String
    let store_news: String
    let store_latitude: Double
    let store_longitude: Double
    let store_status: String
    let distance: Double
    var store_picture: UIImage? {
        didSet{
            self.renewImage?()
            renewImage = nil
        }
    }
    var renewImage: (()->())?
    
    
    init(from dict: [String:Any]) {
        let temp = dict.castToStrStr()
        
        sid = temp["sid"] ?? ""
        store_id = temp["store_id"] ?? ""
        store_type = temp["store_type"] ?? ""
        store_name = temp["store_name"] ?? ""
        shopping_area = temp["shopping_area"] ?? ""
        store_phone = temp["store_phone"] ?? ""
        store_address = temp["store_address"] ?? ""
        store_website = temp["store_website"] ?? ""
        store_facebook = temp["store_facebook"] ?? ""
        store_news = temp["store_news"] ?? ""
        store_longitude = Double(temp["store_longitude"] ?? "") ?? 0
        store_latitude = Double(temp["store_latitude"] ?? "") ?? 0
        store_status = temp["store_status"] ?? ""
        distance = Double((dict["distance"] as? Int ?? 999999) / 100) / 10
        
        let store_picture = temp["store_picture"] ?? ""
        WebAPI.shared.requestImage(urlString: PIC_URL + store_picture) { image in
            self.store_picture = image
        }
    }
}


class Coupon {
    let pid: String
    let mid: String
    let coupon_no: String
    let using_flag: String
    let using_date: String
    let coupon_id: String
    let coupon_name: String
    let coupon_type: String
    let coupon_description: String
    let coupon_startdate: String
    let coupon_enddate: String
    let coupon_status: String
//    滿額使用
    let coupon_rule: Int
//    折扣方式  1:折扣金額  2:折扣%
    let coupon_discount: String
//    折扣額
    let discount_amount: Int
    let coupon_storeid: String
    let coupon_for: String
    let coupon_picture: String
    
    init(from dict: [String: Any]) {
        let tempDict = dict.castToStrStr()
        
        self.coupon_name = tempDict["coupon_name"] ?? ""
        self.coupon_description = tempDict["coupon_description"] ?? ""
        self.coupon_startdate = tempDict["coupon_startdate"] ?? ""
        self.coupon_enddate = tempDict["coupon_enddate"] ?? ""
        self.coupon_rule = Int(tempDict["coupon_rule"] ?? "0") ?? 0
        self.coupon_discount = tempDict["coupon_discount"] ?? ""
        self.discount_amount = Int(tempDict["discount_amount"] ?? "0") ?? 0
        self.coupon_for = tempDict["coupon_for"] ?? ""
        self.mid = tempDict["mid"] ?? ""
        self.pid = tempDict["pid"] ?? ""
        self.coupon_status = tempDict["coupon_status"] ?? ""
        self.coupon_type = tempDict["coupon_type"] ?? ""
        self.using_flag = tempDict["using_flag"] ?? ""
        self.coupon_storeid = tempDict["coupon_storeid"] ?? ""
        self.coupon_no = tempDict["coupon_no"] ?? ""
        self.using_date = dict["using_date"] as? String ?? ""
        self.coupon_id = tempDict["coupon_id"] ?? ""
        self.coupon_picture = tempDict["coupon_picture"] ?? ""
        
    }
//    檢查coupon的可用性
    func checkAvailable()->CouponStatus {
        if self.using_flag == "1" {
            return .Used
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let start = dateFormatter.date(from: self.coupon_startdate)
        var end = dateFormatter.date(from: self.coupon_enddate)
        end?.addTimeInterval(60*60*24-1)
        if let start = start, let end = end, Date() < start || Date() > end {
            return .OutDate
        }
        if self.coupon_status == "2" {
            return .Unavailable
        }
        return .Available
    }
}

enum CouponStatus {
    case Available
    case Used
    case OutDate
    case Unavailable
}

class PayRecord {
    let oid: String
    let order_no: String
    let order_date: String
    let store_id: String
    let member_id: String
    let order_amount: String
    let coupon_no: String
    let discount_amount: String
    let pay_type: String
    let order_pay: String
    let pay_status: String
    let bonus_point: String
    let order_status: String
    /*
    let bonus_get: String
    let bonus_date: String
    let bonus_end_date: String
    let sid: String
    let description: String
    let order_created_at: String
    let order_updated_at: String
    */
    init(from dict: [String:Any]){
        let temp = dict.castToStrStr()
        
        oid = temp["oid"] ?? ""
        order_no = temp["order_no"] ?? ""
        order_date = temp["order_date"] ?? ""
        store_id = temp["store_id"] ?? ""
        member_id = temp["member_id"] ?? ""
        order_amount = temp["order_amount"] ?? ""
        coupon_no = temp["coupon_no"] ?? ""
        discount_amount = temp["discount_amount"] ?? ""
        order_pay = temp["order_pay"] ?? ""
        bonus_point = temp["bonus_point"] ?? ""
        order_status = temp["order_status"] ?? ""
        /*
        bonus_get = temp["bonus_get"] ?? ""
        bonus_date = temp["bonus_date"] ?? ""
        bonus_end_date = temp["bonus_end_date"] ?? ""
        sid = temp["sid"] ?? ""
        description = temp["description"] ?? ""
        order_created_at = temp["order_created_at"] ?? ""
        order_updated_at = temp["order_updated_at"] ?? ""
         */
        pay_status = temp["pay_status"] ?? ""
        let pay_type = temp["pay_type"] ?? ""
        switch pay_type {
        case "-1":
            self.pay_type = "未付款"
        case "1":
            self.pay_type = "Linepay"
        case "2":
            self.pay_type = "街口支付"
        case "3":
            self.pay_type = "信用卡支付"
        default:
            self.pay_type = ""
        }
        
    }
}

