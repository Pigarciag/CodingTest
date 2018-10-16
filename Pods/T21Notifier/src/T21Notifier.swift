//
//  T21Notifier.swift
//  T21Notifier
//
//  Created by Eloi Guzmán Cerón on 10/11/16.
//  Copyright © 2016 Worldline. All rights reserved.
//

import UIKit

open class T21Notifier <ProtocolToImplement> {
    var mapTable = NSMapTable<AnyObject, AnyObject>(keyOptions: NSPointerFunctions.Options.weakMemory,
                                                    valueOptions: NSPointerFunctions.Options.weakMemory)
    
    public init() {
        
    }
    
    open func addObserver(observer: AnyObject?) {
        if let obs = observer as? ProtocolToImplement {
            mapTable.setObject(obs as AnyObject!, forKey: obs as AnyObject!)
        }
    }
    
    open func removeObserver(observer: AnyObject?) {
        if let obs = observer as? ProtocolToImplement {
            mapTable.removeObject(forKey: obs as AnyObject!)
        }
    }
    
    open func notify(send: (ProtocolToImplement) -> ()) {
        for item in mapTable.objectEnumerator()! {
            if let obj = item as? ProtocolToImplement {
                send(obj)
            }
        }
    }
}

/**
 I think this should be the ideal way to do a Generic Notifier, where you specify the Protocol (A)
 the observer will conform to. But, unfortunately, the Swift compiler complains when declaring a T21Notifier<MyProtocol>
 stating that: "Using 'MyProtocol' as a concrete type conforming to a protocol 'AnyObject' is not supported".
 
 
 class T21Notifier <A> where A: AnyObject {
 var mapTable = NSMapTable<A, A>(keyOptions: NSPointerFunctions.Options.weakMemory,
 valueOptions: NSPointerFunctions.Options.weakMemory)
 
 
 open func addObserver(observer: A?) {
 if let obs = observer {
 mapTable.setObject(obs, forKey: obs)
 }
 }
 
 open func removeObserver(observer: A?) {
 if let obs = observer {
 mapTable.removeObject(forKey: obs)
 }
 }
 
 open func notify(send: (A) -> ()) {
 for item in mapTable.objectEnumerator()! {
 let obj = item as! A
 send(obj)
 }
 }
 }
 
 
 */
