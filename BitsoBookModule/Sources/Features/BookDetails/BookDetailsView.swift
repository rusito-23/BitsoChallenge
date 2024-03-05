import BitsoUI
import SwiftUI

struct BookDetailsView<ViewModel: BookDetailsViewModel>: View {
    @StateObject private var viewModel: ViewModel

    init(viewModel: ViewModel) {
        _viewModel = .init(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case let .failed(error: error):
                errorView(error)
            case let .loaded(sections):
                bookDetailsView(sections)
            }
        }
        .padding(Spacing.medium.rawValue)
        .onAppear {
            viewModel.load()
        }
    }
}

// MARK: - Private Views

private extension BookDetailsView {
    func errorView(_ error: BookServiceError) -> some View {
        NoticeView(
            icon: .error,
            title: "",
            message: ""
            // title: Content.noticeTitle.localize(bundle: .module),
            // subtitle: Content.emptyResultsMessage.localize(bundle: .module)
        )
    }

    func bookDetailsView(_ sections: [BookDetailsViewState.Section]) -> some View {
        VStack(spacing: Spacing.medium.rawValue) {
            Text(viewModel.title ?? "")
                .font(.largeTitle)

            ForEach(sections, id: \.self) { section in
                CardView {
                    displaySection(section)
                }
            }

            Spacer()
        }
    }

    @ViewBuilder
    func displaySection(_ section: BookDetailsViewState.Section) -> some View {
        switch section {
        case let .history(volume: volume, high: high, change: change):
            historySection(volume: volume, high: high, change: change)
        case let .bid(ask: ask, bid: bid):
            bidSection(ask: ask, bid: bid)
        }
    }

    func historySection(volume: String, high: String, change: String) -> some View {
        VStack(spacing: Spacing.medium.rawValue) {
            value(label: "Volume", value: volume)
            value(label: "High", value: high)
            value(label: "Change", value: change)
        }
    }

    func bidSection(ask: String, bid: String) -> some View {
        VStack(spacing: Spacing.medium.rawValue) {
            value(label: "Ask", value: ask)
            value(label: "Bid", value: bid)
        }
    }

    func value(label: String, value: String) -> some View {
        HStack {
            Text(label).font(.callout.weight(.light))
            Spacer()
            Text(value).font(.callout)
        }
    }
}

// MARK: - Previews

#if DEBUG
struct BookDetailsView_Previews: PreviewProvider {
    final class MockViewModel: BookDetailsViewModel {
        var title: String? = "BTC MXN"
        var state: BookDetailsViewState = .loading

        init(state: BookDetailsViewState) {
            self.state = state
        }

        func load() -> Task<Void, Never> { Task {} }
    }

    static var previews: some View {
        Group {
            BookDetailsView(viewModel: MockViewModel(state: .loaded(sections: [
                .history(volume: "10000", high: "20000", change: "30000"),
                .bid(ask: "9000", bid: "10000"),
            ])))
        }
    }
}
#endif
