import SwiftUI

struct PostCell: View {

    let post: Post

    var body: some View {
        Text(verbatim: post.title)
    }
    
}
