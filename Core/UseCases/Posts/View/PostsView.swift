import SwiftUI
import Combine

public struct PostsView: View {

    @ObservedObject var viewModel: PostsViewModel = PostsViewModel()

    public init() { }

    public var body: some View {
        LoadingView(isShowing: $viewModel.isLoading,
                    localizedMessage: $viewModel.loadingMessage) {
            NavigationView {
                List(self.viewModel.posts) { post in
                    NavigationLink(destination: PostDetailView(post: post)) {
                        PostCell(post: post)
                    }
                }
                .navigationBarTitle(Localized("posts.title").text)
            }
            .onAppear(perform: self.viewModel.onAppear)
        }
    }

}
