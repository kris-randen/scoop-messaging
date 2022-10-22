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

    var body: some View {
        VStack {
            Spacer()
            Text("scoop 🦉🌈")
                .foregroundColor(Colors.scoopRed)
                .font(.custom("Avenir", size: 36, relativeTo: .largeTitle).weight(.black))
            createLoginTextField(with: Shapes.textField)
                .padding(.vertical)
            createPasswordTextField(with: Shapes.textField)
                .padding(.vertical)
            Button {
                //
            } label: {
                createSignInButtonLabel(with: Shapes.textField)
                    .fullButtonify(height: .height(scaling: 25, tolerance: 0.1))
            }
            .padding(.vertical, 25)
            
            HStack {
                Spacer()
                Button {
                    //
                } label: {
                    Text("Forgot password?")
                        .font(Fonts.signInScreenSmall.weight(.bold))
                        .foregroundColor(Colors.scoopRed)
                        .shadowify(x: 1, y: 1)
                }
            }
            .padding(.vertical)
            
            HStack {
                Text("Sign in")
                    .font(Fonts.signInTextField.weight(.bold))
                    .foregroundColor(.white)
                    .halfButtonify(height: .height(scaling: 17, tolerance: 0.1))
                    .backgroundify(shape: Shapes.textField, color: Colors.facebookBlue)
                    .shadowify()
                    .padding(.trailing, Dimensions.WidthScaling.halfButtonPadding)
                    .padding(.vertical)
                Spacer()
                Text("Sign in")
                    .font(Fonts.signInTextField.weight(.bold))
                    .foregroundColor(.white)
                    .halfButtonify(height: .height(scaling: 17, tolerance: 0.1))
                    .backgroundify(shape: Shapes.textField, color: Colors.googleRed)
                    .shadowify()
                    .padding(.leading, Dimensions.WidthScaling.halfButtonPadding)
                    .padding(.vertical)
            }
            Group {
                Text("get the inside scoop \non what you eat")
                    .multilineTextAlignment(.center)
                    .font(Fonts.signInButtonLabel)
                    .foregroundColor(Colors.scoopRed)
            }
            .padding()
            Spacer()
            Button {
                //
            } label: {
                Text("Don’t have an account? **Sign up**")
                    .font(Fonts.signInScreenSmall.weight(.bold))
                    .foregroundColor(Colors.scoopRed)
                    .shadowify()
            }
        }
        .padding()
    }
    
    func createLoginTextField(with shape: Modifiers.Shapes) -> some View {
        TextField("swamy@scoop.fit", text: $login)
            .disableAutocorrection(true)
            .textInputAutocapitalization(.never)
            .textFieldify(heightScaling: Dimensions.HeightScaling.textField)
            .font(Fonts.signInTextField)
            .borderify(shape: shape, color: Colors.scoopYellow)
            .clippify(shape: shape)
            .shadowify()
            .overlay(alignment: .trailing) {
                HStack {
                    Image(systemName: "envelope")
                        .font(Fonts.signInTextFieldIcon.weight(.ultraLight))
                        .foregroundColor(Colors.scoopRed)
                        .padding()
                }
            }
    }
    
    func createPasswordTextField(with shape: Modifiers.Shapes) -> some View {
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
        .textFieldify(heightScaling: Dimensions.HeightScaling.textField)
        .borderify(shape: shape, color: Colors.scoopYellow)
        .clippify(shape: shape)
        .overlay(alignment: .trailing) {
            HStack {
                Button {
                    isSecured.toggle()
                } label: {
                    passwordVisibilityLabel()
                }
                .padding()
            }
        }
        .shadowify()
    }
    
    func createSignInButtonLabel(with shape: Modifiers.Shapes) -> some View {
        Text("Sign in")
            .foregroundColor(Colors.scoopRed)
            .font(Fonts.signInButtonLabel)
            .fullYellowButtonify(height: .height(scaling: 13, tolerance: 0.1))
            .borderify(shape: shape, color: Colors.scoopYellow)
            .clippify(shape: shape)
            .shadowify()
    }
    
    var loginTextField: some View {
        TextField("Phone number, email or username", text: $login)
            .disableAutocorrection(true)
            .textInputAutocapitalization(.never)
            .textFieldify(heightScaling: Dimensions.HeightScaling.textField, backgroundColor: .white)
            .borderify(shape: .rectangle(cornerRadiusScaling: 20), color: Colors.scoopYellow)
            .clippify(shape: .rectangle(cornerRadiusScaling: 20))
    }
    var passwordTextField: some View {
        Group {
            if isSecured {
                SecureField("Password", text: $password)
            } else {
                TextField("Password", text: $password)
            }
        }
        .textFieldify(withHeightScaling: 25)
        .overlay(alignment: .trailing) {
            HStack {
                Button {
                    isSecured.toggle()
                } label: {
                    passwordVisibilityLabel()
                        .offset(x: -screen.minDim / 60)
                }
            }
        }
    }
    
    @ViewBuilder
    func passwordVisibilityLabel() -> some View {
        if isSecured {
            Image(systemName: "eye.slash")
                .symbolRenderingMode(.hierarchical)
                .foregroundColor(Colors.scoopRed)
        } else {
            Image(systemName: "eye")
                .symbolRenderingMode(.hierarchical)
                .foregroundColor(Colors.scoopRed)
        }
    }
    
    var loginAndPassword: Bool {
        !login.isEmpty && !password.isEmpty
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
