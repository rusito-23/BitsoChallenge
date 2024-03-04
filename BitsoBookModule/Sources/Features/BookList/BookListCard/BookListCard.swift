import BitsoUI
import SwiftUI

/// Displays the card of the
struct BookListCard: View {

    // MARK: Properties

    private let viewModel: BookListCardViewModel

    // MARK: Initializer

    init(viewModel: BookListCardViewModel) {
        self.viewModel = viewModel
    }

    // MARK: Body

    var body: some View {
        CardContainer {
            content
        }
        .frame(maxWidth: .infinity)
    }

    private var content: some View {
        VStack(alignment: .center) {
            Text(viewModel.name)
                .font(.headline)

            Text(viewModel.maximumValue)
                .font(.body)

            valueStack
        }
        .frame(maxWidth: .infinity)
    }

    private var valueStack: some View {
        HStack {
            Text(viewModel.maximumValue)
                .font(.callout)

            Text(viewModel.minimumValue)
                .font(.callout)
        }
    }
}

// MARK: - Previews

#if DEBUG
struct BookListCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BookListCard(viewModel: BookListCardViewModel(
                name: "Book Name",
                maximumValue: "$ 150",
                minimumValue: "$ 100",
                maximumPrice: "$200"
            ))
        }
    }
}
#endif
