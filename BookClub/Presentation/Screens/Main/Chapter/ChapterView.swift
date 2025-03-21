//
//  ChapterView.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 20.03.2025.
//

import SwiftUI
import MarkdownUI

struct ChapterView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var isPlaying = false
    let markdownText = """
*Париж, Лувр*  

*21.46*  

Знаменитый куратор Жак Соньер, пошатываясь, прошел под сводчатой аркой Большой галереи и устремился к первой попавшейся ему на глаза картине — полотну Караваджо. Ухватился руками за позолоченную раму и стал тянуть ее на себя, пока шедевр не сорвался со стены и не рухнул на семидесятилетнего старика Соньера, погребя его под собой.  

Как и предполагал Соньер, неподалеку с грохотом опустилась металлическая решетка, преграждающая доступ в этот зал. Паркетный пол содрогнулся. Где-то завыла сирена сигнализации.  

Несколько секунд куратор лежал неподвижно, хватая ртом воздух и пытаясь сообразить, на каком свете находится. *Я все еще жив.* Потом он выполз из-под полотна и начал судорожно озираться в поисках места, где можно спрятаться.  

Голос прозвучал неожиданно близко:  

— Не двигаться.  

Стоявший на четвереньках куратор похолодел, потом медленно обернулся. Всего в пятнадцати футах от него, за решеткой, высилась внушительная и грозная фигура его преследователя. Высокий, широкоплечий, с мертвенно-бледной кожей и редкими белыми волосами. Белки розовые, а зрачки угрожающе темнокрасного цвета. Альбинос достал из кармана пистолет, сунул длинный ствол в отверстие между железными прутьями и прицелился в куратора.  

— Ты не должен бежать, — произнес он с трудно определимым акцентом. — А теперь говори: где оно?  

— Но я ведь уже сказал, — запинаясь пробормотал куратор, — никакого бесполезного обмана не потерпят... Понятий не имею, о чем вы говорите.  

— Ложь! — Мужчина был неподвижен и смотрел на него исподлобья своим страшным взглядом, в которых поблескивали злые искорки. — У тебя и твоих братьев есть кое-что, принадлежащее отнюдь не вам.

"""
    
    var body: some View {
        ZStack {
            Color("AccentDark")
                .ignoresSafeArea()
            VStack(spacing: 0) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(markdownText)
                            .font(.custom("georgia", size: 14))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                }
                .background(Color("Background"))
                
                HStack {
                    HStack (spacing: 8) {
                        CustomIcon(name: "Previous", size: 24, color: "White")
                            .padding(8)
                        
                        CustomIcon(name: "Contents", size: 24, color: "White")
                            .padding(8)
                        
                        CustomIcon(name: "Next", size: 24, color: "White")
                            .padding(8)
                        
                        CustomIcon(name: "Settings", size: 24, color: "White")
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
                                CustomIcon(
                                    name: isPlaying ? "Pause" : "Play",
                                    size: 24,
                                    color: "AccentDark"
                                )
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
                    SecondaryText(text: "Пролог", lineHeight: 1.5, size: 14)
                }
            }
        }
        .toolbarBackground(Color("Background"), for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
    }
}

