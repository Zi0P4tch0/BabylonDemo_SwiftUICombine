import SwiftUI

struct PostDetailView: View {

    @ObservedObject var viewModel: PostDetailViewModel

    init(post: Post) {
        viewModel = PostDetailViewModel(post: post)
    }

    var body: some View {
        VStack {
            HStack {
                Text(viewModel.author).bold()
                Spacer()
                Text(verbatim: viewModel.numberOfComments).bold()
            }
            .padding()
            HStack {
                Text(verbatim: viewModel.description)
            }
            .padding()
            Spacer()
        }
        .onAppear(perform: viewModel.onAppear)
        .navigationBarTitle(Localized("posts.detail.title",
                                      args: "\(viewModel.id)").text,
                            displayMode: .inline)
    }

}
