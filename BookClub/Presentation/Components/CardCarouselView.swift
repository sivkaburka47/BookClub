//
//  CardCarouselView.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 28.06.2025.
//

import SwiftUI

struct CardCarouselView: View {
    // MARK: - Private Properties
    private let cards: [FeaturedBookCard]
    @State private var cardsState: [FeaturedBookCard]

    // MARK: - Init
    init(cards: [FeaturedBookCard]) {
        self.cards = cards
        self._cardsState = State(initialValue: cards)
    }

    var body: some View {
        VStack {
            GeometryReader { geometry in
                let size = geometry.size

                ScrollView(.horizontal, showsIndicators: false) {
                    NavigationLink(destination: MovieDetailsView()) {
                        HStack(spacing: Metrics.cardSpacing) {
                            ForEach(cardsState) { card in
                                cardView(card, screenWidth: size.width)
                            }
                        }
                        .padding(.trailing, size.width - Metrics.cardWidth)
                        .scrollTargetLayout()
                    }
                }
                .scrollTargetBehavior(.viewAligned)
                .clipShape(.rect(cornerRadius: Metrics.cornerRadius))
            }
            .frame(height: Metrics.carouselHeight)
        }
    }
}

// MARK: - Card View Components
private extension CardCarouselView {
    @ViewBuilder
    func cardView(_ card: FeaturedBookCard, screenWidth: CGFloat) -> some View {
        GeometryReader { proxy in
            let size = proxy.size
            let minX = proxy.frame(in: .scrollView).minX
            let reducingWidth = (minX / Metrics.widthDivisor) * Metrics.maxWidth
            let cappedWidth = min(reducingWidth, Metrics.maxWidth)

            let frameWidth = size.width - (minX > 0 ? cappedWidth : -cappedWidth)
            let isFullyVisible = frameWidth >= Metrics.visibilityThreshold

            cardContent(card: card, size: size, frameWidth: frameWidth, isFullyVisible: isFullyVisible, cappedWidth: cappedWidth)
        }
        .frame(width: Metrics.cardWidth, height: Metrics.carouselHeight)
        .offsetX { offset in
            updateNextCardOffset(for: card, with: offset)
        }
    }

    @ViewBuilder
    func cardContent(card: FeaturedBookCard, size: CGSize, frameWidth: CGFloat, isFullyVisible: Bool, cappedWidth: CGFloat) -> some View {
        ZStack(alignment: .bottom) {
            ImageLoader(imageUrlString: card.image)
                .frame(width: size.width, height: size.height)
                .frame(width: frameWidth < 0 ? 0 : frameWidth)
                .clipShape(RoundedRectangle(cornerRadius: Metrics.cornerRadius))

            cardGradient(size: size, frameWidth: frameWidth)

            if isFullyVisible {
                carouselLabel(description: card.description, title: card.title)
                    .padding(.bottom, Metrics.labelBottomPadding)
                    .padding(.horizontal, Metrics.labelHorizontalPadding)
            }
        }
        .offset(x: minOffsetX(for: cappedWidth))
        .offset(x: -card.previousOffset)
    }

    @ViewBuilder
    func cardGradient(size: CGSize, frameWidth: CGFloat) -> some View {
        LinearGradient(
            gradient: Gradient(colors: [
                .clear,
                .black.opacity(0.5)
            ]),
            startPoint: .top,
            endPoint: .bottom
        )
        .frame(width: size.width, height: size.height)
        .frame(width: frameWidth < 0 ? 0 : frameWidth)
        .blendMode(.multiply)
        .clipShape(.rect(cornerRadius: Metrics.cornerRadius))
    }

    @ViewBuilder
    func carouselLabel(description: String, title: String) -> some View {
        VStack(alignment: .leading, spacing: Metrics.labelSpacing) {
            Text(description)
                .foregroundColor(Color("White"))
                .bodySmallTextStyle()
                .lineLimit(2)

            Text(title)
                .foregroundColor(Color("White"))
                .h2TextStyle()
                .lineLimit(2)
        }
        .padding(.vertical, Metrics.labelVerticalPadding)
    }

    func minOffsetX(for cappedWidth: CGFloat) -> CGFloat {
        cappedWidth > 0 ? 0 : -cappedWidth
    }

    func updateNextCardOffset(for card: FeaturedBookCard, with offset: CGFloat) {
        let reducingWidth = (offset / Metrics.widthDivisor) * Metrics.maxWidth
        if let index = cardsState.firstIndex(where: { $0.id == card.id }),
           cardsState.indices.contains(index + 1) {
            cardsState[index + 1].previousOffset = (offset < 0 ? 0 : reducingWidth)
        }
    }
}

// MARK: - Metrics & Constants
private extension CardCarouselView {
    enum Metrics {
        // Carousel
        static let cardWidth: CGFloat = 252
        static let carouselHeight: CGFloat = 256
        static let cardSpacing: CGFloat = 8
        static let cornerRadius: CGFloat = 8
        static let widthDivisor: CGFloat = 260
        static let maxWidth: CGFloat = 196
        static let visibilityThreshold: CGFloat = 200

        // Label
        static let labelSpacing: CGFloat = 4
        static let labelVerticalPadding: CGFloat = 8
        static let labelBottomPadding: CGFloat = 16
        static let labelHorizontalPadding: CGFloat = 16
        static let descriptionLineLimit: Int = 2
    }
}
