//
//  ContentView.swift
//  SignUpForm
//
//  Created by Xun Ruan on 2021/7/29.
//

import SwiftUI
import Combine

// Model
enum PasswordStatus{
    case empty
    case notStrongEnough
    case repeatPasswordWrong
    case valid
}

// View Models
class FormViewModel: ObservableObject{
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var passwordAgain: String = ""

    @Published var isValid = false
    
    private var cancellables = Set<AnyCancellable>()
    
    private static let predicate = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&]).{6.}$")
    
    private var isUsernameValidPublisher: AnyPublisher<Bool, Never>{
        $username
            .debounce(for: 0.8, scheduler: RunLoop.main)    // We don't need to set value too often
            .removeDuplicates() // We only care if the value changes
            .map{$0.count > 3}
            .eraseToAnyPublisher()  // Wrap this publisher with a type eraser
    }
    
    private var isPasswordEmptyPublisher: AnyPublisher<Bool, Never>{
        $password
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map{$0.isEmpty}
            .eraseToAnyPublisher()
    }
    
    private var arePasswordsEqualPublisher: AnyPublisher<Bool, Never>{
        Publishers.CombineLatest($password, $passwordAgain)
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .map{$0 == $1}
            .eraseToAnyPublisher()
    }
    
    private var isPasswordStrongPublisher: AnyPublisher<Bool, Never>{
        $password
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .removeDuplicates()
            .map{ Self.predicate.evaluate(with: $0)}
            .eraseToAnyPublisher()
    }
    
    private var isPasswordValidPublisher: AnyPublisher<PasswordStatus, Never>{
        Publishers.CombineLatest3(isPasswordEmptyPublisher, arePasswordsEqualPublisher, isPasswordStrongPublisher)
            .map{
                if $0 {return PasswordStatus.empty}
                if !$1 {return PasswordStatus.repeatPasswordWrong}
                if !$2 {return PasswordStatus.notStrongEnough}
                return PasswordStatus.valid
            }
            .eraseToAnyPublisher()
    }
    
    private var isFormValidPublisher: AnyPublisher<Bool, Never>{
        Publishers.CombineLatest(isUsernameValidPublisher, isPasswordValidPublisher)
            .map{$0 == true && $1 == .valid}
            .eraseToAnyPublisher()
    }
    
    init(){
        isFormValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isValid, on: self)
            .store(in: &cancellables)
    }
        
    
}

struct ContentView: View {
    @StateObject private var formViewModel = FormViewModel()
    var body: some View {
        NavigationView{
            VStack{
                Form{
                    Section(header: Text("Username")){
                        TextField("Username", text: $formViewModel.username)
                            .autocapitalization(.none)
                    }
                    Section(header: Text("Password")){
                        SecureField("Password", text:$formViewModel.password)
                        SecureField("Password again", text:$formViewModel.passwordAgain)
                    }
                }
                
                Button(action: {}){
                    RoundedRectangle(cornerRadius: 10.0)
                        .frame(height: 50)
                        .overlay(
                            Text("Continue")
                                .foregroundColor(.white)
                        )
                        
                }
                .edgesIgnoringSafeArea(.all)
                .padding()
                .disabled(!formViewModel.isValid)
            }
            .navigationBarTitle(Text("Sign up"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
