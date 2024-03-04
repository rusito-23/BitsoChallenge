import BitsoUI
import BitsoKit
import SwiftUI

/// Displays a book card with its basic information.
/// When tapped, will navigate to the book details.
struct BookListCard: View {

    // MARK: Properties

    @EnvironmentObject var router: Router
    private let viewModel: BookListCardViewModel

    // MARK: Initializer

    init(viewModel: BookListCardViewModel) {
        self.viewModel = viewModel
    }

    // MARK: Body

    var body: some View {
        Button {
            router.navigate(to: BookInternalDestination.bookDetails(id: viewModel.id))
        } label: {
            CardContainer {
                content
            }
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
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
