//
//  EscapingBootcamp.swift
//  Swiftfulthinking
//
//  Created by Raden Dimas on 26/10/21.
//

import SwiftUI



class EscapingViewModel: ObservableObject {
    @Published var text: String = "Hello"
    
    func getData() {
//        let newData = donwloadData()
//        text = newData
//        donwloadData3 { [weak self] (returnedData) in
//            self?.text = returnedData
        
        donwloadData5 { [weak self] (retrunResult) in
            self?.text = retrunResult.data
            }
        }
//        doSomething(forData: "Hei")
    
    func donwloadData() -> String {
        return "NewData!"
    }
    
    func donwloadData2(completionHandler: (_ data: String) -> Void ){
        completionHandler("New Data!")
    }
    
    //escaping closures
    func donwloadData3(completionHandler: @escaping (_ data: String) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completionHandler("New Data!")
        }
        
    }
    
    
    func donwloadData4(completionHandler: @escaping (DonwloadResult) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let result = DonwloadResult(data: "New Data!")
            completionHandler(result)
        }
        
    }
    
    func donwloadData5(completionHandler: @escaping DonwloadCompletion) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let result = DonwloadResult(data: "New Data!")
            completionHandler(result)
        }
        
    }
    
    // ekternal and internal
//    func doSomething(forData data: String) {
//        print(data)
//    }
    
//    func doSomething(data: String) -> Void {
//
//    }
    
//    func doSomeThing(data: String) -> () {
//
//    }
}

typealias DonwloadCompletion = (DonwloadResult) -> ()


struct DonwloadResult {
    let data: String
}

struct EscapingBootcamp: View {
    
    @StateObject var vm = EscapingViewModel()
    
    var body: some View {
        
        Text(vm.text)
            .font(.largeTitle)
            .bold()
            .foregroundColor(.blue)
            .onTapGesture {
                vm.getData()
            }
    }
}

struct EscapingBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        EscapingBootcamp()
    }
}
