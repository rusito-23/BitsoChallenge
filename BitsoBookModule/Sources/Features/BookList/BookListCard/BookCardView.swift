import BitsoUI
import BitsoKit
import SwiftUI

/// Displays a book card with its basic information.
/// When tapped, will navigate to the book details.
struct BookCardView: View {
    @EnvironmentObject var router: Router
    private let viewModel: BookCardViewModel

    init(viewModel: BookCardViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        Button {
            router.navigate(to: BookInternalDestination.bookDetails(id: viewModel.id))
        } label: {
            CardView {
                content
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Private Views

private extension BookCardView {
    var content: some View {
        HStack {
            Text(viewModel.name)
                .font(.title3.bold())

            Spacer()

            detailsStack
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    var detailsStack: some View {
        VStack(alignment: .trailing) {
            Text(viewModel.maximumPrice).font(.headline.bold())
            value(label: Content.minimum.localized, value: viewModel.minimumValue)
            value(label: Content.maximum.localized, value: viewModel.maximumValue)
        }
    }

    func value(label: String, value: String) -> some View {
        HStack {
            Text(label).font(.callout.weight(.light))
            Text(value).font(.callout)
        }
    }
}

// MARK: - Content

extension BookCardView {
    enum Content: String, LocalizableContent {
        case minimum = "MINIMUM"
        case maximum = "MAXIMUM"

        var localized: String {
            localize(bundle: .module)
        }
    }
}

// MARK: - Previews

#if DEBUG
struct BookListCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BookCardView(viewModel: BookCardViewModel(
                name: "Book Name",
                maximumValue: "$ 150",
                minimumValue: "$ 100",
                maximumPrice: "$200"
            ))
        }
    }
}
#endif
