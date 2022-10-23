//
//  SignInView.swift
//  messaging
//
//  Created by Krishnaswami Rajendren on 10/21/22.
//

import SwiftUI

struct SignInView: View {
    @State private var login: String = ""
    @State private var password: String = ""
    @State private var isSecured: Bool = true
    @State private var isEmail: Bool = true
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack {
                    Spacer()
                    VStack(spacing: 38) {
                        scoopLogo()
                            .padding(.top, Constants.screenHeight/8)
                        loginTextField()
                        passwordTextField()
                        signInButton()
                        forgotPasswordButtonRightIndented()
                        facebookAndGoogleSignIn()
                        tagline()
                            .padding(.top)
                    }
                    Spacer()
                    noAccountSignUpButton()
                        .padding(.top, Constants.screenHeight/12)
                }
            }
        }
        .padding(.horizontal)
    }

    fileprivate func textFieldEmailIcon() -> some View {
        Image(systemName: "envelope.fill")
            .foregroundColor(Colors.scoopRed)
//            .padding()
    }
    
    fileprivate func textFieldPhoneIcon() -> some View {
        Image(systemName: "phone.fill")
            .foregroundColor(Colors.scoopRed)
//            .padding()
    }
    
    fileprivate func emailPhoneIcon() -> some View {
        Group {
            if isEmail {
                textFieldEmailIcon()
            } else {
                textFieldPhoneIcon()
            }
        }
        .font(Fonts.signInTextFieldIcon)
    }
    
    fileprivate func loginTextField(with shape: Modifiers.Shapes = Shapes.textField) -> some View {
        TextField(text: $login, prompt: Text(isEmail ? "Email" : "Phone").foregroundColor(Colors.scoopRedPlaceholder)) {
                Text("").foregroundColor(Colors.scoopRedPlaceholder)
           }
            .foregroundColor(Colors.scoopRed)
            .disableAutocorrection(true)
            .textInputAutocapitalization(.never)
            .textFieldify(heightScaling: Dimensions.HeightScaling.textField)
            .font(Fonts.signInTextField)
            .borderify(shape: shape, color: Colors.scoopYellow)
            .clippify(shape: shape)
            .shadowify()
            .overlay(alignment: .trailing) {
                HStack {
                    Button {
                        isEmail.toggle()
                    } label: {
                        emailPhoneIcon()
                    }
                    .padding()
                }
            }
    }
    
    fileprivate func passwordInvisibleIcon() -> some View {
        Image(systemName: "eye.slash")
            .symbolRenderingMode(.hierarchical)
            .foregroundColor(Colors.scoopRed)
    }
    
    fileprivate func passwordVisibleIcon() -> some View {
        Image(systemName: "eye")
            .symbolRenderingMode(.hierarchical)
            .foregroundColor(Colors.scoopRed)
    }
    
    func passwordVisibilityIcon() -> some View {
        Group {
            if isSecured {
                passwordInvisibleIcon()
            } else {
                passwordVisibleIcon()
            }
        }
        .font(Fonts.signInTextFieldIcon)
    }
    
    fileprivate func passwordTextField(with shape: Modifiers.Shapes = Shapes.textField) -> some View {
        Group {
            if isSecured {
                SecureField(text: $password, prompt: Text("Password").foregroundColor(Colors.scoopRedPlaceholder)) {
                        Text("Password").foregroundColor(Colors.scoopRedPlaceholder)
                   }
                
            } else {
                TextField(text: $password, prompt: Text("Password").foregroundColor(Colors.scoopRedPlaceholder)) {
                        Text("Password").foregroundColor(Colors.scoopRedPlaceholder)
                   }
            }
        }
        .font(Fonts.signInTextField)
        .foregroundColor(Colors.scoopRed)
        .textFieldify(heightScaling: Dimensions.HeightScaling.textField)
        .borderify(shape: shape, color: Colors.scoopYellow)
        .clippify(shape: shape)
        .shadowify()
        .overlay(alignment: .trailing) {
            HStack {
                Button {
                    isSecured.toggle()
                } label: {
                    passwordVisibilityIcon()
                }
                .padding()
            }
        }
    }
    
    fileprivate func signInButtonLabel(with shape: Modifiers.Shapes = Shapes.textField) -> some View {
        Text("Sign in")
            .foregroundColor(Colors.scoopRed)
            .font(Fonts.fullWidthButtonLabel)
            .fullYellowButtonify(height: .height(scaling: Dimensions.HeightScaling.button, tolerance: 0))
            .borderify(shape: shape, color: Colors.scoopYellow)
            .clippify(shape: shape)
            .shadowify()
    }
    
    var loginAndPassword: Bool {
        !login.isEmpty && !password.isEmpty
    }
    
    fileprivate func scoopLogo() -> Text {
        Text("scoop 🦉 🌈")
            .foregroundColor(Colors.scoopRed)
            .font(Fonts.scoopLogoSignIn)
    }
    
    fileprivate func noAccountSignUpButton() -> some View {
        Button {
            //
        } label: {
            Text("Don’t have an account? **Sign up**")
                .font(Fonts.signInScreenSmall)
                .foregroundColor(Colors.scoopRed)
        }
    }
    
    fileprivate func tagline() -> some View {
        Text("get the inside scoop \non what you eat")
            .lineLimit(2, reservesSpace: true)
            .multilineTextAlignment(.center)
            .font(Fonts.fullWidthButtonLabel)
            .foregroundColor(Colors.scoopRed)
    }
    
    fileprivate func googleSignInLabel() -> some View {
        HStack {
            Spacer()
            Text("g")
                .font(Fonts.googleButtonIconFont)
                .padding(.bottom, 10)
            Spacer()
            Text("|")
                .font(Fonts.halfWidthButtonLabel.weight(.light))
            Spacer()
            Text("Sign in")
                .padding(.horizontal)
            Spacer()
        }
            .font(Fonts.halfWidthButtonLabel.weight(.bold))
            .foregroundColor(.white)
            .halfButtonify(height: .height(scaling: Dimensions.HeightScaling.button, tolerance: 0))
            .backgroundify(shape: Shapes.textField, color: Colors.googleRed)
            .shadowify()
    }
    
    fileprivate func googleSignInButton() -> some View {
        Button {
            
        } label: {
            googleSignInLabel()
        }
    }
    
    fileprivate func facebookSignInLabel() -> some View {
        HStack {
            Spacer()
            Text("f")
                .font(Fonts.scoopLogoSignIn)
                .padding(.top, 5)
            Spacer()
            Text("|")
                .font(Fonts.halfWidthButtonLabel.weight(.light))
            Spacer()
            Text("Sign in")
                .padding(.horizontal)
            Spacer()
        }
        .font(Fonts.halfWidthButtonLabel.weight(.bold))
        .foregroundColor(.white)
        .halfButtonify(height: .height(scaling: Dimensions.HeightScaling.button, tolerance: 0))
        .backgroundify(shape: Shapes.textField, color: Colors.facebookBlue)
        .shadowify()
    }
    
    fileprivate func facebookSignInButton() -> some View {
        Button {
            
        } label: {
            facebookSignInLabel()
        }

    }
    
    fileprivate func facebookAndGoogleSignIn() -> some View {
        HStack {
            facebookSignInButton()
                .padding(.trailing, 10)
            Spacer()
            googleSignInButton()
                .padding(.leading, 10)
        }
    }
    
    fileprivate func forgotPasswordLabel() -> some View {
        return Text("Forgot password?")
            .font(Fonts.signInScreenSmall.weight(.bold))
            .foregroundColor(Colors.scoopRed)
    }
    
    fileprivate func forgotPasswordButton() -> some View {
        Button {
            //
        } label: {
            forgotPasswordLabel()
        }
    }
    
    fileprivate func forgotPasswordButtonRightIndented() -> some View {
        HStack {
            Spacer()
            forgotPasswordButton()
        }
    }
    
    fileprivate func signInButton() -> some View {
        Button {
            //
        } label: {
            signInButtonLabel()
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
