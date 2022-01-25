//
//  UIStoryboard+Helper.swift
//  TagSoftTestTask
//
//  Created by Raushan Ruslan kyzy on 20/1/22.
//

import UIKit

extension UIStoryboard {
    class func createViewController<T: UIViewController>(storyboard: AppStoryboard, controllerType: T.Type) -> T {
        let st = UIStoryboard.init(name: storyboard.rawValue, bundle: nil)
        let vc = st.instantiateViewController(withIdentifier: controllerType.className) as! T
        return vc
    }
}

extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}
