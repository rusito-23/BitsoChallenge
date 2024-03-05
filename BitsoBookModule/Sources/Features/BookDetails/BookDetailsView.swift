import BitsoUI
import SwiftUI

struct BookDetailsView<ViewModel: BookDetailsViewModeling>: View {
    @StateObject private var viewModel: ViewModel

    init(viewModel: ViewModel) {
        _viewModel = .init(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            switch viewModel.state {
            case .loading:
                ProgressView()

            case let .failed(notice: noticeViewModel):
                NoticeView(viewModel: noticeViewModel)

            case let .loaded(sections):
                contentView(sections)
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
    func contentView(_ sections: [BookDetailsViewState.Section]) -> some View {
        VStack(spacing: Spacing.medium.rawValue) {
            Text(viewModel.title ?? "")
                .font(.largeTitle)

            ForEach(sections) { section in
                CardView {
                    sectionView(section)
                }
            }

            Spacer()
        }
    }

    @ViewBuilder
    func sectionView(_ section: BookDetailsViewState.Section) -> some View {
        VStack(spacing: Spacing.medium.rawValue) {
            ForEach(section.items, id: \.label) { (label, value) in
                HStack {
                    Text(label).font(.callout.weight(.light))
                    Spacer()
                    Text(value).font(.callout)
                }
            }
        }
    }
}

// MARK: - Previews

#if DEBUG
struct BookDetailsView_Previews: PreviewProvider {
    final class ViewModelMock: BookDetailsViewModeling {
        var title: String? = "BTC MXN"
        var state: BookDetailsViewState = .loading
        init(state: BookDetailsViewState) { self.state = state }
        func load() -> Task<Void, Never> { Task {} }
    }

    static var previews: some View {
        Group {
            BookDetailsView(
                viewModel: ViewModelMock(state: .loaded(sections: [
                    .init(items: [
                        (label: "volume", value: "1000"),
                        (label: "high", value: "1000"),
                        (label: "bid", value: "1000"),
                    ]),
                    .init(items: [
                        (label: "ask", value: "1200"),
                        (label: "bid", value: "1200"),
                    ]),
                ]))
            )
        }
    }
}
#endif
