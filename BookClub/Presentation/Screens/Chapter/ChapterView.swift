import SwiftUI

struct ChapterView: View {
    
    @State private var timer: DispatchSourceTimer?
    @Environment(\.dismiss) var dismiss
    @State private var isPlaying = false
    @State private var currentTime: Double = 0.0
    @State private var currentParagraphIndex: Int = -1
    @State private var currentLineIndex: Int = -1
    @State private var isUserScrolling = false
    @State private var scrollDebounceTimer: Timer?
    @State private var offset = CGFloat.zero
    
    
    let bookParagraphs: [BookParagraph] = [
        BookParagraph(lines: [
            BookLine(time: 0.0, text: "*Париж, Лувр*")
        ]),
        BookParagraph(lines: [
            BookLine(time: 2.0, text: "*21.46*")
        ]),
        BookParagraph(lines: [
            BookLine(time: 4.0, text: "Знаменитый куратор Жак Соньер, пошатываясь, прошел под сводчатой аркой Большой галереи и устремился к первой попавшейся ему на глаза картине — полотну Караваджо."),
            BookLine(time: 8.0, text: "Ухватился руками за позолоченную раму и стал тянуть ее на себя, пока шедевр не сорвался со стены и не рухнул на семидесятилетнего старика Соньера, погребя его под собой.")
        ]),
        BookParagraph(lines: [
            BookLine(time: 12.0, text: "Как и предполагал Соньер, неподалеку с грохотом опустилась металлическая решетка, преграждающая доступ в этот зал."),
            BookLine(time: 14.0, text: "Паркетный пол содрогнулся."),
            BookLine(time: 15.0, text: "Где-то завыла сирена сигнализации.")
        ]),
        BookParagraph(lines: [
            BookLine(time: 16.0, text: "Несколько секунд куратор лежал неподвижно, хватая ртом воздух и пытаясь сообразить, на каком свете находится."),
            BookLine(time: 19.0, text: "*Я все еще жив.*"),
            BookLine(time: 21.0, text: "Потом он выполз из-под полотна и начал судорожно озираться в поисках места, где можно спрятаться.")
        ]),
        BookParagraph(lines: [
            BookLine(time: 23.0, text: "Голос прозвучал неожиданно близко:"),
        ]),
        BookParagraph(lines: [
            BookLine(time: 25.0, text: "— Не двигаться."),
        ]),
        BookParagraph(lines: [
            BookLine(time: 27.0, text: "Стоявший на четвереньках куратор похолодел, потом медленно обернулся."),
            BookLine(time: 30.0, text: "Всего в пятнадцати футах от него, за решеткой, высилась внушительная и грозная фигура его преследователя."),
            BookLine(time: 33.0, text: "Белки розовые, а зрачки угрожающего темно красного цвета."),
            BookLine(time: 33.0, text: "Альбинос достал из кармана пистолет, сунул длинный ствол в отверстие между железными прутьями и прицелился в куратора."),
        ]),
        BookParagraph(lines: [
            BookLine(time: 36.0, text: "— Ты не должен бежать, — произнес он с трудно определимым акцентом."),
            BookLine(time: 39.0, text: "— А теперь говори: где оно?"),
        ]),
        BookParagraph(lines: [
            BookLine(time: 42.0, text: "— Ложь! — Мужчина был неподвижен и смотрел на него немигающим взором страшных глаз, в которых поблескивали красные искорки."),
        ]),
        BookParagraph(lines: [
            BookLine(time: 43.0, text: "*Париж, Лувр*")
        ]),
        BookParagraph(lines: [
            BookLine(time: 47.0, text: "*21.46*")
        ]),
        BookParagraph(lines: [
            BookLine(time: 50.0, text: "Знаменитый куратор Жак Соньер, пошатываясь, прошел под сводчатой аркой Большой галереи и устремился к первой попавшейся ему на глаза картине — полотну Караваджо."),
            BookLine(time: 53.0, text: "Ухватился руками за позолоченную раму и стал тянуть ее на себя, пока шедевр не сорвался со стены и не рухнул на семидесятилетнего старика Соньера, погребя его под собой.")
        ]),
        BookParagraph(lines: [
            BookLine(time: 56.0, text: "Как и предполагал Соньер, неподалеку с грохотом опустилась металлическая решетка, преграждающая доступ в этот зал."),
            BookLine(time: 59.0, text: "Паркетный пол содрогнулся."),
            BookLine(time: 62.0, text: "Где-то завыла сирена сигнализации.")
        ]),
        BookParagraph(lines: [
            BookLine(time: 66.0, text: "Несколько секунд куратор лежал неподвижно, хватая ртом воздух и пытаясь сообразить, на каком свете находится."),
            BookLine(time: 69.0, text: "*Я все еще жив.*"),
            BookLine(time: 72.0, text: "Потом он выполз из-под полотна и начал судорожно озираться в поисках места, где можно спрятаться.")
        ]),
        BookParagraph(lines: [
            BookLine(time: 76.0, text: "Голос прозвучал неожиданно близко:"),
        ]),
        BookParagraph(lines: [
            BookLine(time: 79.0, text: "— Не двигаться."),
        ]),
        BookParagraph(lines: [
            BookLine(time: 82.0, text: "Стоявший на четвереньках куратор похолодел, потом медленно обернулся."),
            BookLine(time: 85.0, text: "Всего в пятнадцати футах от него, за решеткой, высилась внушительная и грозная фигура его преследователя."),
            BookLine(time: 88.0, text: "Белки розовые, а зрачки угрожающего темно красного цвета."),
            BookLine(time: 91.0, text: "Альбинос достал из кармана пистолет, сунул длинный ствол в отверстие между железными прутьями и прицелился в куратора."),
        ]),
        BookParagraph(lines: [
            BookLine(time: 94.0, text: "— Ты не должен бежать, — произнес он с трудно определимым акцентом."),
            BookLine(time: 97.0, text: "— А теперь говори: где оно?"),
        ]),
        BookParagraph(lines: [
            BookLine(time: 100.0, text: "— Ложь! — Мужчина был неподвижен и смотрел на него немигающим взором страшных глаз, в которых поблескивали красные искорки."),
        ])
    ]
    
    var body: some View {
        ZStack {
            Color("AccentDark")
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                ScrollViewReader { scrollProxy in
                    ScrollView {
                        VStack(alignment: .leading, spacing: 16) {
                            ForEach(bookParagraphs.indices, id: \.self) { paragraphIndex in
                                Text(attributedString(for: paragraphIndex))
                                    .font(.custom("georgia", size: 14))
                                    .foregroundColor(Color("Black"))
                                    .id(paragraphIndex)
                            }
                            Spacer()
                                .frame(height: 64)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 16)
                        .background(GeometryReader {
                            Color.clear
                                .preference(key: ViewOffsetKey.self, value: -$0.frame(in: .named("scroll")).origin.y)
                        })
                        .onPreferenceChange(ViewOffsetKey.self) { newOffset in
                            offset = newOffset
                            if isPlaying {
                                isUserScrolling = true
                                scrollDebounceTimer?.invalidate()
                                scrollDebounceTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
                                    isUserScrolling = false
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        if currentParagraphIndex >= 0 {
                                            scrollProxy.scrollTo(currentParagraphIndex, anchor: .center)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .coordinateSpace(name: "scroll")
                    .overlay(
                        Group {
                            if offset > 0 {
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color("Background").opacity(0),
                                        Color("Background")
                                    ]),
                                    startPoint: .bottom,
                                    endPoint: .top
                                )
                                .frame(height: 64)
                                .padding(.horizontal, 16)
                                .edgesIgnoringSafeArea(.top)
                            }
                        },
                        alignment: .top
                    )
                    .overlay(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color("Background").opacity(0),
                                Color("Background")
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(height: 64)
                        .padding(.horizontal, 16)
                        .edgesIgnoringSafeArea(.bottom)
                        , alignment: .bottom
                    )
                    .padding(.vertical, 16)
                    .background(Color("Background"))
                    .onChange(of: currentParagraphIndex) { _ in
                        if isPlaying && !isUserScrolling {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                if currentParagraphIndex >= 0 {
                                    scrollProxy.scrollTo(currentParagraphIndex, anchor: .center)
                                }
                            }
                        }
                    }
                }
                
                HStack {
                    HStack(spacing: 8) {
                        CustomIcon(name: "Previous", size: 24, color: Color("White"))
                            .padding(8)
                        CustomIcon(name: "Contents", size: 24, color: Color("White"))
                            .padding(8)
                        CustomIcon(name: "Next", size: 24, color: Color("White"))
                            .padding(8)
                        CustomIcon(name: "Settings", size: 24, color: Color("White"))
                            .padding(8)
                    }
                    Spacer()
                    Button(action: {
                        isPlaying.toggle()
                    }) {
                        Circle()
                            .fill(Color("AccentLight"))
                            .frame(width: 50, height: 50)
                            .overlay(
                                CustomIcon(name: isPlaying ? "Pause" : "Play", size: 24, color: Color("AccentDark"))
                            )
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                CustomBackButton(dismiss: dismiss, style: .dark)
            }
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("Код Да Винчи")
                        .h2TextStyle()
                    Text("Пролог")
                        .bodySmallTextStyle()
                }
            }
        }
        .toolbarBackground(Color("Background"), for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            let timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global(qos: .userInitiated))
            timer.schedule(deadline: .now(), repeating: 0.1)
            timer.setEventHandler {
                if isPlaying {
                    let newTime = currentTime + 0.1
                    DispatchQueue.main.async {
                        currentTime = newTime
                        print(currentTime)
                        updateCurrentIndices()
                        if currentTime > bookParagraphs.last!.lines.last!.time + 2 {
                            isPlaying = false
                            currentTime = 0.0
                            currentParagraphIndex = -1
                            currentLineIndex = -1
                        }
                    }
                }
            }
            timer.resume()
            self.timer = timer
        }
        .onDisappear {
            timer?.cancel()
            timer = nil
        }
    }
            
    private func attributedString(for paragraphIndex: Int) -> AttributedString {
        var result = AttributedString()
        let paragraph = bookParagraphs[paragraphIndex]
        
        for (lineIndex, line) in paragraph.lines.enumerated() {
            let indentation = String(repeating: " ", count: lineIndex)
            var lineString = AttributedString(indentation + line.text)
            
            if isPlaying && paragraphIndex == currentParagraphIndex && lineIndex == currentLineIndex {
                lineString.foregroundColor = .red
            } else {
                lineString.foregroundColor = .primary
            }
            
            result += lineString
            if lineIndex < paragraph.lines.count - 1 {
                result += AttributedString(" ")
            }
        }
        return result
    }
    
    private func updateCurrentIndices() {
        var maxTime: Double = -1.0
        var newParagraphIndex = -1
        var newLineIndex = -1
        
        for (pIndex, paragraph) in bookParagraphs.enumerated() {
            for (lIndex, line) in paragraph.lines.enumerated() {
                if line.time <= currentTime && line.time > maxTime {
                    maxTime = line.time
                    newParagraphIndex = pIndex
                    newLineIndex = lIndex
                }
            }
        }
        
        if newParagraphIndex != currentParagraphIndex || newLineIndex != currentLineIndex {
            withAnimation {
                currentParagraphIndex = newParagraphIndex
                currentLineIndex = newLineIndex
            }
        }
    }
}
