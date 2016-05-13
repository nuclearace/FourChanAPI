//
//  CFThread.swift
//  FourChanAPI
//
//  Created by Erik Little on 1/24/15.
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

public class FCThread {
    public let board: FCBoard
    public let num: Int
    
    public private(set) var lastModified: Int?
    public private(set) var posts = [FCPost]()
    
    public var count: Int {
        return posts.count
    }
    
    public subscript(n: Int) -> FCPost? {
        if n >= count {
            return nil
        } else if n < 0 {
            return nil
        }
        
        return posts[n]
    }
    
    public init(board: FCBoard, num: Int, lastModified: Int) {
        self.board = board
        self.num = num
        self.lastModified = lastModified
    }
    
    static func createThreadFromJSON(json: [String: AnyObject], onBoard board: FCBoard) -> FCThread {
        let no = json["no"] as! Int
        let last = json["last_modified"] as! Int
        
        return FCThread(board: board, num: no, lastModified: last)
    }

    public func updatePosts(callback: PostsCallback) {
        let url = FourChanAPI.getThreadJSONForBoard(board, forThread: num)
        let req = NSURLRequest(URL: url)
        
        FourChanAPI.getNSDictionaryWithRequest(req) {thread in
            guard let posts = thread["posts"] as? [[String: AnyObject]] else { return }
            
            self.posts = posts.map({FCPost(post: $0)})
            callback(self.posts)
        }
    }
}
