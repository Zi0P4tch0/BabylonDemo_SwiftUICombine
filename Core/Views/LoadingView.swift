import SwiftUI

struct LoadingView<Content>: View where Content: View {

    @Binding var isShowing: Bool
    @Binding var localizedMessage: String
    var content: () -> Content

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {

                self.content()
                    .disabled(self.isShowing)
//                    .blur(radius: self.isShowing ? 3 : 0)

                VStack {
                    Text(self.localizedMessage)
                    ActivityIndicator(isAnimating: .constant(true), style: .large)
                }
                .frame(width: geometry.size.width / 2,
                       height: geometry.size.height / 5)
                .background(Color.secondary.colorInvert())
                .foregroundColor(Color.primary)
                .cornerRadius(20)
                .opacity(self.isShowing ? 1 : 0)

            }
        }
    }

}
