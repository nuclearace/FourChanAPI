//
//  FCBoard.swift
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

public class FCBoard {
    let board: BoardString
    let boardJSONURL: NSURL
    var pages: NSArray?
    var threads = [FCThread]()
    
    init(name: BoardString) {
        self.board = name
        self.boardJSONURL = FourChanAPI.createJSONLinkForBoard(board)
    }
    
    public static func getAllBoardsWithCallback(callback:DictionaryCallback) {
        let req = NSURLRequest(URL: ALLBOARDS)
        
        FourChanAPI.getNSDictionaryWithRequest(req, withCallback: callback)
    }
    
    // callback: (success: Bool, arr:NSArray, error:NSError) -> Void
    public func getCatalogWithCallback(callback:ArrayCallback) {
        let req = NSURLRequest(URL: self.boardJSONURL)
        
        FourChanAPI.getNSArrayWithRequest(req, withCallback: callback)
    }
    
    public func getThreadJSONForThread(num:ThreadNumber, withCallback callback:DictionaryCallback) {
        let url = FourChanAPI.getThreadJSONForBoard(self, withThread: num)
        let req = NSURLRequest(URL: url)
        
        FourChanAPI.getNSDictionaryWithRequest(req, withCallback: callback)
    }
    
    // Should probably use updateThreadsWithCallback
    public func getThreadsWithCallback(callback: ArrayCallback) {
        let url = FourChanAPI.getThreadsJSONForBoard(self)
        let req = NSURLRequest(URL: url)
        
        FourChanAPI.getNSArrayWithRequest(req) {success, arr, err in
            if !success || arr == nil {
                callback(false, nil, err)
                return
            }
            
            self.pages = arr
            self._updateThreadsFromPages()
            callback(true, self.pages, nil)
        }
    }
    
    public func updateThreadsWithCallback(callback: ((Bool, String?) -> Void)?) {
        getThreadsWithCallback {success, arr, err in
            if !success || arr == nil {
                callback?(false, err)
                return
            }
            
            callback?(true, nil)
        }
    }
    
    private func _updateThreadsFromPages() {
        if pages == nil {
            return
        }
        
        threads.removeAll(keepCapacity: true)
        
        for page in pages! {
            for thread in page["threads"] as! NSArray {
                if let t = thread as? NSDictionary {
                    let no = t["no"] as! ThreadNumber
                    let last = t["last_modified"] as! Int
                    let newThread = FCThread(board: self, num: no, lastModified: last)
                    
                    threads.append(newThread)
                }
            }
        }
    }
}