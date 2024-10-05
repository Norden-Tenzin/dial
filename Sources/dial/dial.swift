// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

@available(iOS 17.0, *)
public struct Dial: View {
    @Binding var value: Int
    public var body: some View {
        GeometryReader(content: { geometry in
            let size = geometry.size
            VStack {
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 5) {
                        let steps = 10
                        ForEach(0 ... 1000, id: \.self) { num in
                            let step = num % steps
                            Rectangle()
                                .fill(Color.gray)
                                .frame(width: 1, height: {
                                    if num % 10 == 0 {
                                        return 20
                                    } else if num % 5 == 0 {
                                        return 15
                                    } else {
                                        return 10
                                    }
                                }(), alignment: .bottom)
                                .frame(height: num % 5 == 0 ? 15 : 0, alignment: .bottom)
                                .frame(maxHeight: 20, alignment: .bottom)
                                .overlay(alignment: .bottom) {
                                    if step == 0 {
                                        Text("\(num / steps)")
                                            .font(.caption)
                                            .fixedSize()
                                            .offset(y: 20)
                                    }
                                }
                        }
                    }
                    .frame(height: size.height)
                    .scrollTargetLayout()
                }
                .defaultScrollAnchor(.center)
                .scrollIndicators(.hidden)
                .scrollTargetBehavior(.viewAligned(limitBehavior: .never))
                .safeAreaPadding(.horizontal, size.width / 2)
                .scrollPosition(id: .init(get: {
                    let position: Int? = value
                    return position
                }, set: { newValue in
                    if let newValue {
                        value = newValue
                    }
                }))
                .overlay(alignment: .center) {
                    Rectangle()
                        .frame(width: 2, height: 30)
                        .padding(.bottom, 10)
                }
            }
        })
        .sensoryFeedback(.increase, trigger: value)
    }
}

