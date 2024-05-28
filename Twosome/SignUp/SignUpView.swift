//
//  SignUpView.swift
//  Twosome
//
//  Created by ungQ on 5/27/24.
//

import SwiftUI

struct SignUpView: View {
    
	@State private var email: String = ""
	@State private var password: String = ""
	@State private var confirmPassword: String = ""
	@State private var name: String = ""


	@State private var isEmailChecked: Bool = false
	@State private var isEmailValid: Bool = false



	@State private var isCheckingEmail: Bool = false

	var body: some View {
		VStack {
			Text("Toss 회원가입")
				.font(.largeTitle)
				.fontWeight(.bold)
				.padding(.bottom, 40)

			VStack(alignment: .leading, spacing: 15) {
				HStack {
					TextField("이메일", text: $email)

						.onChange(of: email) {
							isEmailChecked = false
							isEmailValid = false
							print("흠")
						}

					.padding()
					.background(Color(.secondarySystemBackground))
					.cornerRadius(5.0)
					.keyboardType(.emailAddress)

					Button(action: checkEmail) {
						Text(isEmailValid ? "사용가능" : "중복체크")
							.foregroundColor(.white)
							.padding()
							.background(isEmailValid ? Color.green : Color.blue)
							.cornerRadius(5.0)
					}


				}

				if isCheckingEmail && isEmailValid {
					SecureField("비밀번호", text: $password)
						.padding()
						.background(Color(.secondarySystemBackground))
						.cornerRadius(5.0)

					SecureField("비밀번호 확인", text: $confirmPassword)
						.padding()
						.background(Color(.secondarySystemBackground))
						.cornerRadius(5.0)
				}

				if isPasswordsMatch() && isEmailValid {
					TextField("이름", text: $name)
						.padding()
						.background(Color(.secondarySystemBackground))
						.cornerRadius(5.0)
				}
			}
			.padding(.horizontal, 27.5)

			Button(action: {
				// 회원가입 로직
				print("회원가입 버튼 클릭됨")
			}) {
				Text("회원가입")
					.font(.headline)
					.foregroundColor(.white)
					.padding()
					.frame(width: 220, height: 60)
					.background(Color.blue)
					.cornerRadius(15.0)
					.padding(.top, 50)
			}
			.disabled(!isFormValid())
		}
	}

	func checkEmail() {


		// 이 부분에서 실제로 이메일 중복 체크를 해야 합니다.
		// 예를 들어, 네트워크 요청을 통해 서버에 확인하는 로직이 필요합니다.
		// 여기서는 2초 후에 이메일이 유효한 것으로 간주하는 시뮬레이션을 합니다.

		DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
			isCheckingEmail = true
			isEmailChecked = true
			// 이메일이 유효한 경우
			if email == "test@example.com" {
				isEmailValid = false
			} else {
				isEmailValid = true
			}
		}
	}

	func isPasswordsMatch() -> Bool {
		return !password.isEmpty && password == confirmPassword
	}

	func isFormValid() -> Bool {
		return isEmailValid && isPasswordsMatch() && !name.isEmpty
	}
}

#Preview {
    SignUpView()
}
