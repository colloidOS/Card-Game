//
//  FirstViewModel.swift
//  Card Game
//
//  Created by Macintosh HD on 17/08/2021.
//

import SwiftUI

struct TextFieldWithInputView : UIViewRepresentable {
//     var first = FirstView()
    
  var data : [String]
  var placeholder : String

  @Binding var selectionIndex : Int
  @Binding var selectedText : String?


  private let textField = UITextField()
  private let picker = UIPickerView()

  func makeCoordinator() -> TextFieldWithInputView.Coordinator {
       Coordinator(textfield: self)
  }

  func makeUIView(context: UIViewRepresentableContext<TextFieldWithInputView>) -> UITextField {
       picker.delegate = context.coordinator
       picker.dataSource = context.coordinator
       picker.backgroundColor = (#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))
       picker.tintColor = .black
       textField.placeholder = placeholder
       textField.inputView = picker
       textField.delegate = context.coordinator
       return textField
  }

  func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<TextFieldWithInputView>) {
       uiView.text = selectedText
      
  }
//    func ChooseEmojiType(){
//        if selectedText == first.EmojiType[1] {
//            emojiMemoryGame.emojis = emojiMemoryGame.Animal
//        }
//    }

  class Coordinator: NSObject, UIPickerViewDataSource, UIPickerViewDelegate , UITextFieldDelegate {

       private let parent : TextFieldWithInputView

       init(textfield : TextFieldWithInputView) {
            self.parent = textfield
       }

       func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
       }
       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return self.parent.data.count
       }
       func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return self.parent.data[row]
       }
       func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            self.parent.$selectionIndex.wrappedValue = row
            self.parent.selectedText = self.parent.data[self.parent.selectionIndex]
            self.parent.textField.endEditing(true)

       }
       func textFieldDidEndEditing(_ textField: UITextField) {
            self.parent.textField.resignFirstResponder()
       }
 }
}


