# FourChanAPI

Example:

```swift
import Foundation
import FourChanAPI

let a = FCBoard(name: "a")

// Getting a list of all boards
FCBoard.getAllBoards {boards in
    print(boards)
}

// Updates the board's thread list
a.updateThreads {threads in
    print(threads)
    let thread1 = a.threads[1]
    
    // Fill thread with posts
    thread1.updatePosts {posts in
        // Print last post
        print(thread1[thread1.count - 1]!)
    }
}
```
