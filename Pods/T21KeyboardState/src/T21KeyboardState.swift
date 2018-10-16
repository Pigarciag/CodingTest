//
//  T21KeyboardState.swift
//  T21KeyboardState
//
//  Created by Eloi Guzmán Cerón on 10/11/16.
//  Copyright © 2016 Worldline. All rights reserved.
//

import UIKit
import T21Notifier

@objc public protocol T21KeyboardNotifications : AnyObject {
    
    @objc optional func keyboardWillChange()
    @objc optional func keyboardDidChange()
    @objc optional func keyboardWillShow()
    @objc optional func keyboardDidShow()
    @objc optional func keyboardWillHide()
    @objc optional func keyboardDidHide()
}

public class T21KeyboardState : NSObject, T21KeyboardNotifications {
    public static let sharedInstance = T21KeyboardState()
    
    private var notifier = T21Notifier<T21KeyboardNotifications>()
    public private(set) var isKeyboardShown = false
    public private(set) var keyboardSize = CGRect.zero
    
    private override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: Notification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidChange), name: Notification.Name.UIKeyboardDidChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide), name: Notification.Name.UIKeyboardDidHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //no need to remove the observer as it keep only weak references
    public func addObserver(obs: T21KeyboardNotifications) {
        notifier.addObserver(observer: obs)
    }
    
    @objc func keyboardWillChange(notification: Notification) {
        self.notifier.notify(send: { (obs: T21KeyboardNotifications) in
            obs.keyboardWillChange?()
        })
    }
    
    @objc func keyboardDidHide(notification: Notification) {
        isKeyboardShown = false
        keyboardSize = CGRect.zero
        self.notifier.notify(send: { (obs: T21KeyboardNotifications) in
            obs.keyboardDidHide?()
        })
    }
    
    @objc func keyboardDidShow(notification: Notification) {
        if !isKeyboardShown {
            isKeyboardShown = true
            if let userInfo = notification.userInfo {
                if let keyboardSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                    self.keyboardSize = keyboardSize
                    self.notifier.notify(send: { (obs: T21KeyboardNotifications) in
                        obs.keyboardDidShow?()
                    })
                }
            }
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        self.notifier.notify(send: { (obs: T21KeyboardNotifications) in
            obs.keyboardWillHide?()
        })
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if !self.isKeyboardShown {
            self.notifier.notify(send: { (obs: T21KeyboardNotifications) in
                obs.keyboardWillShow?()
            })
        }
    }
    
    @objc func keyboardDidChange(notification: Notification) {
        if let userInfo = notification.userInfo {
            if let keyboardSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                self.keyboardSize = keyboardSize
                self.notifier.notify(send: { (obs: T21KeyboardNotifications) in
                    obs.keyboardDidChange?()
                })
            }
        }
    }
}
