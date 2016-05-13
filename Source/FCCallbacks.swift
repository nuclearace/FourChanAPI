//
//  FCCallbacks.swift
//  FourChanAPI
//
//  Created by Erik Little on 5/13/16.
//  Copyright © 2016 Erik Little. All rights reserved.
//

import Foundation

public typealias BoardsCallback = ([FCBoard]) -> Void
public typealias ThreadsCallback = ([FCThread]) -> Void
public typealias ThreadCallback = (FCThread) -> Void
public typealias PostsCallback = ([FCPost]) -> Void

typealias DictionaryCallback = ([String: AnyObject]) -> Void
typealias ArrayCallback = ([AnyObject]) -> Void
