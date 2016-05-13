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
    public let board: String
    public let boardJSONURL: NSURL
    
    public private(set) var pages: NSArray?
    public private(set) var threads = [FCThread]()
    
    init(name: String) {
        self.board = name
        self.boardJSONURL = FourChanAPI.createJSONLinkForBoard(board)
    }
    
    public static func getAllBoards(callback: BoardsCallback) {
        let req = NSURLRequest(URL: NSURL(string: "https://a.4cdn.org/boards.json")!)
        
        FourChanAPI.getNSDictionaryWithRequest(req) {boards in
            guard let boards = boards["boards"] as? [[String: AnyObject]] else {
                callback([])
                return
            }
            
            callback(boards.map({
                let name = $0["board"] as? String ?? ""
                
                return FCBoard(name: name)
            }))
        }
    }
    
//    public func getCatalogWithCallback(callback: ThreadsCallback) {
//        let req = NSURLRequest(URL: boardJSONURL)
//        
//        FourChanAPI.getNSArrayWithRequest(req) {threads in
//            print(threads)
//        }
//    }
    
    // Should probably use updateThreadsWithCallback
    public func getThreads(callback: ThreadsCallback) {
        let url = FourChanAPI.getThreadsJSONForBoard(self)
        let req = NSURLRequest(URL: url)
        
        FourChanAPI.getNSArrayWithRequest(req) {threads in
            if threads.count == 0 {
                callback([])
                return
            }
            
            self.pages = threads
            self._updateThreadsFromPages()
            callback(self.threads)
        }
    }
    
    public func updateThreads(callback: ThreadsCallback) {
        getThreads(callback)
    }
    
    private func _updateThreadsFromPages() {
        if pages == nil {
            return
        }
        
        threads.removeAll(keepCapacity: true)
        
        for page in pages! {
            for thread in page["threads"] as! NSArray {
                if let t = thread as? [String: AnyObject] {
                    threads.append(FCThread.createThreadFromJSON(t, onBoard: self))
                }
            }
        }
    }
}