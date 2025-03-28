//
//  ChapterView.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 20.03.2025.
//

import SwiftUI

struct ChapterView: View {
    @State private var isShowingSettingSheet = false
    @State private var isShowingSheet = false
    @State private var timer: DispatchSourceTimer?
    @Environment(\.dismiss) var dismiss
    @State private var isPlaying = false
    @State private var currentTime: Double = 0.0
    @State private var currentParagraphIndex: Int = -1
    @State private var currentLineIndex: Int = -1
    @State private var isUserScrolling = false
    @State private var scrollDebounceTimer: Timer?
    @State private var offset = CGFloat.zero
    private var parsedBookParagraphs: [BookParagraph] {
        BookTextParser().parse(rawText: rawText)
    }
    
    @State private var activeChapter: Int = 1
    @State private var fontSize: Double = 14
    @State private var paddingSize: Double = 6
    
    var rawText: String {
        chapters[activeChapter].text
    }
    
    var body: some View {
        ZStack {
            Color("AccentDark")
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                ScrollViewReader { scrollProxy in
                    ScrollView {
                        VStack(alignment: .leading, spacing: paddingSize * 2.6) {
                            chapterText
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
                
                bottomToolBar
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
                    Text(chapters[activeChapter].title)
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
                        if let lastParagraph = parsedBookParagraphs.last,
                           let lastLine = lastParagraph.lines.last {
                            if currentTime > lastLine.time + 2 {
                                isPlaying = false
                                currentTime = 0.0
                                currentParagraphIndex = -1
                                currentLineIndex = -1
                            }
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
        .onChange(of: activeChapter) { _ in
            currentTime = 0.0
            currentParagraphIndex = -1
            currentLineIndex = -1
            isPlaying = false
        }
        .sheet(isPresented: $isShowingSheet) {
            SideSheetView(chapters: chapters, activeChapter: $activeChapter, isShowingSheet: $isShowingSheet)
                .presentationDetents([.fraction(1.0)])
                .presentationDragIndicator(.visible)
                .presentationBackground(Color("Background"))
                .presentationCornerRadius(8)
        }
        .sheet(isPresented: $isShowingSettingSheet) {
            SettingsSheetView(isShowingSettingSheet: $isShowingSettingSheet, fontSize: $fontSize, paddingSize: $paddingSize)
                .presentationDetents([.fraction(0.25)])
                .presentationBackground(Color("Background"))
                .presentationBackgroundInteraction(.enabled)
        }
    }
}

// MARK: View Components
private extension ChapterView {
    @ViewBuilder
    var chapterText: some View {
        ForEach(parsedBookParagraphs.indices, id: \.self) { paragraphIndex in
            Text(attributedString(for: paragraphIndex))
                .foregroundColor(Color("Black"))
                .id(paragraphIndex)
                .lineSpacing(paddingSize)
        }
        Spacer()
            .frame(height: 64)
    }
    
    @ViewBuilder
    var bottomToolBar: some View {
        HStack {
            optionButtons
            Spacer()
            playButton
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
    
    @ViewBuilder
    var optionButtons: some View {
        HStack(spacing: 8) {
            previuousChapterButton
            contentsButton
            nextChapterButton
            settingsButton
        }
    }
    
    @ViewBuilder
    var previuousChapterButton: some View {
        Button(action: {
            if activeChapter > 0 {
                activeChapter -= 1
            }
        }, label: {
            CustomIcon(name: "Previous", size: 24, color: Color("White"))
                .padding(8)
        })
        .buttonStyle(PlainButtonStyle())
    }
    
    @ViewBuilder
    var contentsButton: some View {
        Button(action: {
            isShowingSheet.toggle()
        }, label: {
            CustomIcon(name: "Contents", size: 24, color: Color("White"))
                .padding(8)
        })
        .buttonStyle(PlainButtonStyle())
    }
    
    @ViewBuilder
    var nextChapterButton: some View {
        Button(action: {
            if activeChapter < chapters.count - 1 {
                activeChapter += 1
            }
        }, label: {
            CustomIcon(name: "Next", size: 24, color: Color("White"))
                .padding(8)
        })
        .buttonStyle(PlainButtonStyle())
    }
    
    @ViewBuilder
    var settingsButton: some View {
        Button(action: {
            isShowingSettingSheet.toggle()
        }, label: {
            CustomIcon(name: "Settings", size: 24, color: Color("White"))
                .padding(8)
        })
        .buttonStyle(PlainButtonStyle())
    }
    
    @ViewBuilder
    var playButton: some View {
        Button(action: {
            isPlaying.toggle()
        }, label: {
            Circle()
                .fill(Color("AccentLight"))
                .frame(width: 50, height: 50)
                .overlay(
                    CustomIcon(name: isPlaying ? "Pause" : "Play", size: 24, color: Color("AccentDark"))
                )
        })
    }
    
}

// MARK: Data and Parsing
private extension ChapterView {
    var chapters: [Chapter] {
        [
            Chapter(
                title: "Факты",
                text: "(0.0) Здесь будет текст первой главы, описывающий основные концепции и введение в тему."
            ),
            Chapter(
                title: "Пролог",
                text:         """
        (0.0) *Париж, Лувр*
        
        (2.0) *21.46*
        
        (4.0) Знаменитый куратор Жак Соньер, пошатываясь, прошел под сводчатой аркой Большой галереи и устремился к первой попавшейся ему на глаза картине — полотну Караваджо.
        (8.0) Ухватился руками за позолоченную раму и стал тянуть ее на себя, пока шедевр не сорвался со стены и не рухнул на семидесятилетнего старика Соньера, погребя его под собой.
        
        (12.0) Как и предполагал Соньер, неподалеку с грохотом опустилась металлическая решетка, преграждающая доступ в этот зал.
        (14.0) Паркетный пол содрогнулся.
        (15.0) Где-то завыла сирена сигнализации.
        
        (16.0) Несколько секунд куратор лежал неподвижно, хватая ртом воздух и пытаясь сообразить, на каком свете находится.
        (19.0) *Я все еще жив.*
        (21.0) Потом он выполз из-под полотна и начал судорожно озираться в поисках места, где можно спрятаться.
        
        (23.0) Голос прозвучал неожиданно близко:
        
        (25.0) — Не двигаться.
        
        (27.0) Стоявший на четвереньках куратор похолодел, потом медленно обернулся.
        (30.0) Всего в пятнадцати футах от него, за решеткой, высилась внушительная и грозная фигура его преследователя.
        (33.0) Белки розовые, а зрачки угрожающего темно красного цвета.
        (33.0) Альбинос достал из кармана пистолет, сунул длинный ствол в отверстие между железными прутьями и прицелился в куратора.
        
        (36.0) — Ты не должен бежать, — произнес он с трудно определимым акцентом.
        (39.0) — А теперь говори: где оно?
        
        (42.0) — Ложь! — Мужчина был неподвижен и смотрел на него немигающим взором страшных глаз, в которых поблескивали красные искорки.
        
        (43.0) *Париж, Лувр*
        
        (47.0) *21.46*
        
        (50.0) Знаменитый куратор Жак Соньер, пошатываясь, прошел под сводчатой аркой Большой галереи и устремился к первой попавшейся ему на глаза картине — полотну Караваджо.
        (53.0) Ухватился руками за позолоченную раму и стал тянуть ее на себя, пока шедевр не сорвался со стены и не рухнул на семидесятилетнего старика Соньера, погребя его под собой.
        
        (56.0) Как и предполагал Соньер, неподалеку с грохотом опустилась металлическая решетка, преграждающая доступ в этот зал.
        (59.0) Паркетный пол содрогнулся.
        (62.0) Где-то завыла сирена сигнализации.
        
        (66.0) Несколько секунд куратор лежал неподвижно, хватая ртом воздух и пытаясь сообразить, на каком свете находится.
        (69.0) *Я все еще жив.*
        (72.0) Потом он выполз из-под полотна и начал судорожно озираться в поисках места, где можно спрятаться.
        
        (76.0) Голос прозвучал неожиданно близко:
        
        (79.0) — Не двигаться.
        
        (82.0) Стоявший на четвереньках куратор похолодел, потом медленно обернулся.
        (85.0) Всего в пятнадцати футах от него, за решеткой, высилась внушительная и грозная фигура его преследователя.
        (88.0) Белки розовые, а зрачки угрожающего темно красного цвета.
        (91.0) Альбинос достал из кармана пистолет, сунул длинный ствол в отверстие между железными прутьями и прицелился в куратора.
        
        (94.0) — Ты не должен бежать, — произнес он с трудно определимым акцентом.
        (97.0) — А теперь говори: где оно?
        
        (100.0) — Ложь! — Мужчина был неподвижен и смотрел на него немигающим взором страшных глаз, в которых поблескивали красные искорки.
        """
            ),
            Chapter(
                title: "Глава 1",
                text:         """
        (0.0) *Париж, Лувр*
        
        (2.0) *21.46*
        
        (4.0) Знаменитый куратор Жак Соньер, пошатываясь, прошел под сводчатой аркой Большой галереи и устремился к первой попавшейся ему на глаза картине — полотну Караваджо.
        (8.0) Ухватился руками за позолоченную раму и стал тянуть ее на себя, пока шедевр не сорвался со стены и не рухнул на семидесятилетнего старика Соньера, погребя его под собой.
        
        (12.0) Как и предполагал Соньер, неподалеку с грохотом опустилась металлическая решетка, преграждающая доступ в этот зал.
        (14.0) Паркетный пол содрогнулся.
        (15.0) Где-то завыла сирена сигнализации.
        
        (16.0) Несколько секунд куратор лежал неподвижно, хватая ртом воздух и пытаясь сообразить, на каком свете находится.
        (19.0) *Я все еще жив.*
        (21.0) Потом он выполз из-под полотна и начал судорожно озираться в поисках места, где можно спрятаться.
        
        (23.0) Голос прозвучал неожиданно близко:
        
        (25.0) — Не двигаться.
        
        (27.0) Стоявший на четвереньках куратор похолодел, потом медленно обернулся.
        (30.0) Всего в пятнадцати футах от него, за решеткой, высилась внушительная и грозная фигура его преследователя.
        (33.0) Белки розовые, а зрачки угрожающего темно красного цвета.
        (33.0) Альбинос достал из кармана пистолет, сунул длинный ствол в отверстие между железными прутьями и прицелился в куратора.
        
        (36.0) — Ты не должен бежать, — произнес он с трудно определимым акцентом.
        (39.0) — А теперь говори: где оно?
        
        (42.0) — Ложь! — Мужчина был неподвижен и смотрел на него немигающим взором страшных глаз, в которых поблескивали красные искорки.
        """
            )
        ]
    }
    
}

// MARK: Helpers Methods
private extension ChapterView {
    private func attributedString(for paragraphIndex: Int) -> AttributedString {
        let paragraph = parsedBookParagraphs[paragraphIndex]
        var result = AttributedString()
        
        for (lineIndex, line) in paragraph.lines.enumerated() {
            let indentation = String(repeating: "", count: lineIndex)
            var lineContent = AttributedString(indentation)
            
            let components = line.text.components(separatedBy: "*")
            var isItalic = false
            
            for component in components {
                guard !component.isEmpty else {
                    isItalic.toggle()
                    continue
                }
                
                var attributedComponent = AttributedString(component)
                if isItalic {
                    attributedComponent.font = .custom("Georgia", size: fontSize).italic()
                } else {
                    attributedComponent.font = .custom("Georgia", size: fontSize)
                }
                
                lineContent += attributedComponent
                isItalic.toggle()
            }
            
            if isPlaying && paragraphIndex == currentParagraphIndex && lineIndex == currentLineIndex {
                lineContent.foregroundColor = Color("Secondary")
            }
            
            result += lineContent
            if lineIndex < paragraph.lines.count - 1 {
                result += " "
            }
        }
        
        return result
    }
    
    private func updateCurrentIndices() {
        var maxTime: Double = -1.0
        var newParagraphIndex = -1
        var newLineIndex = -1
        
        for (pIndex, paragraph) in parsedBookParagraphs.enumerated() {
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

struct BookTextParser {
    func parse(rawText: String) -> [BookParagraph] {
        let paragraphs = rawText.components(separatedBy: "\n\n")
        var result = [BookParagraph]()
        
        for paragraph in paragraphs {
            let lines = paragraph.components(separatedBy: .newlines)
            var bookLines = [BookLine]()
            
            for line in lines {
                let parts = line.components(separatedBy: ") ")
                guard parts.count >= 2 else { continue }
                
                let timePart = parts[0].replacingOccurrences(of: "(", with: "")
                let text = parts[1...].joined(separator: ") ").trimmingCharacters(in: .whitespaces)
                
                if let time = Double(timePart) {
                    bookLines.append(BookLine(time: time, text: text))
                }
            }
            
            if !bookLines.isEmpty {
                result.append(BookParagraph(lines: bookLines))
            }
        }
        
        return result
    }
}
