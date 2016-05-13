//
//  FourChanAPI.swift
//  FourChanAPI
//
//  Created by Erik Little on 1/23/15.
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

struct FourChanAPI {
    static func createJSONLinkForBoard(board: String) -> NSURL {
        return NSURL(string: "https://a.4cdn.org/\(board)/catalog.json")!
    }
    
    static func getAllBoardsLink() -> NSURL {
        return NSURL(string: "https://a.4cdn.org/boards.json")!
    }
    
    static func getImageLinkForTim(tim: Int, withExt ext: Int, forBoard board: FCBoard) -> NSURL {
        return NSURL(string: "https://i.4cdn.org/\(board.board)/\(tim).\(ext)")!
    }
    
    static func getNSArrayWithRequest(req: NSURLRequest, withCallback callback: ArrayCallback) {
        NSURLSession.sharedSession().dataTaskWithRequest(req) {data, res, err in
            if err != nil || data == nil {
                callback([])
                return
            }
            
            do {
                guard let arr = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? [AnyObject] else {
                    callback([])
                    return
                }
                
                callback(arr)
            } catch {
                callback([])
            }
        }.resume()
    }
    
    static func getNSDictionaryWithRequest(req: NSURLRequest, withCallback callback: DictionaryCallback) {
        NSURLSession.sharedSession().dataTaskWithRequest(req) {data, res, err in
            if err != nil || data == nil {
                callback([:])
                return
            }
            
            do {
                guard let dict = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? [String: AnyObject] else {
                    callback([:])
                    return
                }
                
                callback(dict)
            } catch {
                callback([:])
            }
        }.resume()
    }
    
    static func getThreadsJSONForBoard(board: FCBoard) -> NSURL {
        return NSURL(string: "https://a.4cdn.org/\(board.board)/threads.json")!
    }
    
    static func getThreadJSONForBoard(board: FCBoard, withThread thread: Int) -> NSURL {
        return NSURL(string: "https://a.4cdn.org/\(board.board)/thread/\(thread).json")!
    }
}