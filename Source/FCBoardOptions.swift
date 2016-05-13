//
//  FCBoardOptions.swift
//  FourChanAPI
//
//  Created by Erik Little on 5/13/16.
//  Copyright © 2016 Erik Little. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation

public enum FCBoardOption {
    case Archived(Bool)
    case Board(String)
    case BumpLimit(Int)
    case Cooldowns([FCBoardOptionCooldown])
    case CustomSpoilers(Bool)
    case ImageLimit(Int)
    case MaxCommentChars(Int)
    case MaxFilesize(Int)
    case MaxWebMDuration(Int)
    case MaxWebMFilesize(Int)
    case Meta(String)
    case Pages(Int)
    case Spoilers(Bool)
    case ThreadsPerPage(Int)
    case Title(String)
    case Worksafe(Bool)
    
    static func createOptionsFromJSON(json: [String: AnyObject]) -> [FCBoardOption] {
        var options = [FCBoardOption]()
        
        for (key, value) in json {
            switch (key, value) {
            case let ("is_archived", value as Bool):
                options.append(.Archived(value))
            case let ("board", value as String):
                options.append(.Board(value))
            case let ("bump_limit", value as Int):
                options.append(.BumpLimit(value))
            case let ("cooldowns", value as [String: Int]):
                options.append(.Cooldowns(FCBoardOptionCooldown.createCooldownsFromJSON(value)))
            case let ("custom_spoilers", value as Bool):
                options.append(.CustomSpoilers(value))
            case let ("image_limit", value as Int):
                options.append(.ImageLimit(value))
            case let ("max_comment_chars", value as Int):
                options.append(.MaxCommentChars(value))
            case let ("max_filesize", value as Int):
                options.append(.MaxFilesize(value))
            case let ("max_webm_duration", value as Int):
                options.append(.MaxWebMDuration(value))
            case let ("max_webm_filesize", value as Int):
                options.append(.MaxWebMFilesize(value))
            case let ("meta_description", value as String):
                options.append(.Meta(value))
            case let ("pages", value as Int):
                options.append(.Pages(value))
            case let ("spoilers", value as Bool):
                options.append(.Spoilers(value))
            case let ("per_page", value as Int):
                options.append(.ThreadsPerPage(value))
            case let ("title", value as String):
                options.append(.Title(value))
            case let ("ws_board", value as Bool):
                options.append(.Worksafe(value))
            default:
                continue
            }
        }
        
        return options
    }
}

public enum FCBoardOptionCooldown {
    case Images(Int)
    case ImagesIntra(Int)
    case Replies(Int)
    case RepliesIntra(Int)
    case Threads(Int)
    
    private static func createCooldownsFromJSON(json: [String: Int]) -> [FCBoardOptionCooldown] {
        var options = [FCBoardOptionCooldown]()
        
        for (key, value) in json {
            switch key {
            case "images":
                options.append(.Images(value))
            case "images_intra":
                options.append(.ImagesIntra(value))
            case "replies":
                options.append(.Replies(value))
            case "replies_intra":
                options.append(.RepliesIntra(value))
            case "threads":
                options.append(.Threads(value))
            default:
                continue
            }
        }
        
        return options
    }
}
