//  SignInView.swift
//  BookClub
//
//  Created by Станислав Дейнекин on 15.03.2025.
//

import SwiftUI

struct SignInView: View {
    @State private var offset: CGFloat = 0
    @State private var keyboardHeight: CGFloat = 0
    let bookCovers = Array(repeating: "book", count: 5)
    
    @Binding var isSignedIn: Bool
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    
    private var isFormValid: Bool {
        !email.isEmpty && !password.isEmpty
    }
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                bookCarouselView
                Spacer()
                headerSection
                Spacer()
                formView
                Spacer()
                signInButton
                Spacer()
            }
            .padding(.bottom, keyboardHeight)
            .animation(.easeOut, value: keyboardHeight)
        }
        .background(Color("AccentDark"))
        .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                                  to: nil,
                                                  from: nil,
                                                  for: nil)
                }
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { notification in
                    if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                        keyboardHeight = keyboardFrame.height
                    }
                }
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                    keyboardHeight = 0
                }
    }
}

// MARK: View Components
private extension SignInView {
    @ViewBuilder
    var bookCarouselView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                let bookCovers = Array(repeating: "book", count: 5)
                ForEach(0..<bookCovers.count * 10, id: \.self) { index in
                    Image(bookCovers[index % bookCovers.count])
                        .resizable()
                        .scaledToFit()
                        .frame(width: 172, height: 270)
                        .cornerRadius(4)
                }
            }
            .offset(x: offset)
            .animation(.linear(duration: 300).repeatForever(autoreverses: false), value: offset)
            .onAppear {
                offset = -172 * CGFloat(bookCovers.count * 10)
            }
        }
        .frame(height: 270)
        .allowsHitTesting(false)
    }
    
    
    @ViewBuilder
    func customSecureField(title: String, text: Binding<String>, isPasswordVisible: Binding<Bool>) -> some View {
        GeometryReader { geometry in
            HStack {
                Text(title)
                    .foregroundColor(Color("AccentMedium"))
                    .bodySmallTextStyle()
                Spacer()
                Group {
                    if isPasswordVisible.wrappedValue {
                        TextField("", text: text)
                    } else {
                        SecureField("", text: text)
                    }
                }
                .foregroundColor(Color("AccentLight"))
                .bodySmallTextStyle()
                .frame(width: geometry.size.width * 0.5 + (!text.wrappedValue.isEmpty ? 0 : 24))
                if !text.wrappedValue.isEmpty {
                    Button(action: { isPasswordVisible.wrappedValue.toggle() }) {
                        CustomIcon(name: isPasswordVisible.wrappedValue ? "EyeOff" : "EyeOn", size: 24, color: Color("AccentLight"))
                    }
                }
            }
            .frame(height: 24)
            .padding(.horizontal, 16)
            .padding(.vertical, 11)
        }
    }
    
    @ViewBuilder
    func customTextField(title: String, text: Binding<String>, icon: String?) -> some View {
        GeometryReader { geometry in
            HStack {
                Text(title)
                    .foregroundColor(Color("AccentMedium"))
                    .bodySmallTextStyle()
                Spacer()
                TextField("", text: text)
                    .foregroundColor(Color("AccentLight"))
                    .bodySmallTextStyle()
                    .frame(width: geometry.size.width * 0.5 + (!text.wrappedValue.isEmpty ? 0 : 24))
                if let icon = icon, !text.wrappedValue.isEmpty {
                    Button(action: { text.wrappedValue = "" }) {
                        CustomIcon(name: icon, size: 24, color: Color("AccentLight"))
                    }
                }
            }
            .frame(height: 24)
            .padding(.horizontal, 16)
            .padding(.vertical, 11)
        }
    }
    
    @ViewBuilder
    var signInButton: some View {
        HStack {
            Button(action: {
                isSignedIn = true
            }) {
                Text("Войти")
                    .font(Font.custom("VelaSans-Bold", size: 16))
                    .foregroundColor(isFormValid ? Color("AccentDark") : Color("AccentLight"))
                    .bodyTextStyle()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            .disabled(!isFormValid)
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(isFormValid ? Color("White") : Color("AccentMedium"))
            .cornerRadius(12)
        }
        .padding(.horizontal, 16)
        .frame(height: 50)
    }
    
    @ViewBuilder
    var formView: some View {
        VStack(spacing: 0) {
            customTextField(title: "Почта", text: $email, icon: "Close")
            Divider().background(Color("AccentMedium")).padding(.leading, 16)
            customSecureField(title: "Пароль", text: $password, isPasswordVisible: $isPasswordVisible)
        }
        .frame(height: 92)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(RoundedRectangle(cornerRadius: 10).stroke(Color("AccentMedium"), lineWidth: 1))
        .padding(.horizontal, 16)
    }
    
    @ViewBuilder
    var headerSection: some View {
        VStack(alignment: .leading, spacing: -16) {
            Text("Открой для себя")
                .h1TextStyle()
                .foregroundColor(Color("AccentLight"))
            VStack(alignment: .leading, spacing: -40) {
                Text("книжный")
                    .font(.custom("AlumniSans-Bold", size: 96))
                    .textCase(.uppercase)
                    .foregroundColor(Color("Secondary"))
                
                Text("мир")
                    .font(.custom("AlumniSans-Bold", size: 96))
                    .textCase(.uppercase)
                    .foregroundColor(Color("Secondary"))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
    }
}

#Preview {
    SignInView(isSignedIn: .constant(false))
}
