import BitsoUI
import SwiftUI

struct BookDetailView<ViewModel: BookDetailViewModel>: View {

    // MARK: Properties

    @StateObject private var viewModel: ViewModel

    // MARK: Initializer

    init(viewModel: ViewModel) {
        _viewModel = .init(wrappedValue: viewModel)
    }

    // MARK: Body

    var body: some View {
        Text("Hello")
    }
}

// MARK: - Previews

#if DEBUG
struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Text("World!")
        }
    }
}
#endif
