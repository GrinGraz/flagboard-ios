import Foundation
import SwiftUI

public struct FlagboardView: View {

    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: FlagboardViewModel
    
    public init(viewModel: FlagboardViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        NavigationView {
            VStack{
                TextField("Buscar", text: $viewModel.searchText)
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .padding(10)
                   Spacer()
                if viewModel.filteredItems.count > 0 {
                    List(viewModel.filteredItems) { flag in
                        switch flag.featureFlag {
                        case .stringFlag(let param):
                            StringFlagRow(key: param.key.value, value: param.value, image: "string-icon")
                        case .booleanFlag(let param):
                            BooleanFlagRow(key: param.key.value, value: param.value, viewModel: viewModel)
                        case .intFlag(let param):
                            let stringValue = String(param.value)
                            StringFlagRow(key: param.key.value, value: stringValue, image: "number-icon")
                        case .jsonFlag(let param):
                            let jsonData = try? JSONSerialization.data(withJSONObject: param.value, options: .prettyPrinted)
                            let jsonString = String(data: jsonData ?? Data(), encoding: .utf8) ?? ""
                            
                            StringFlagRow(key: param.key.value, value: jsonString, image: "json-icon")
                        default:
                            EmptyView()
                        }
                    }
                } else {
                    Text("¡No hay flags para mostrar 🚩!")
                }
                Spacer()
            }
            .navigationTitle("Flagboard")
            .toolbar(content: {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark")
                }
            })
        }
        
    }
    
    struct BooleanFlagRow: View {
        let key: String
        @State var value: Bool
        @ObservedObject var viewModel: FlagboardViewModel
        
        var body: some View {
            HStack {
                Image("boolean-icon", bundle: Bundle.flagboardBundle)
                    .frame(width: 24, height: 24)
                Text(key)
                    .font(.callout)
                Spacer()
                Toggle("", isOn: $value)
                    .onChange(of: value) { newValue in
                        viewModel.updateFlag(key: key, isOn: newValue)
                    }
                    .labelsHidden()
                
            }
        }
    }
    
    struct StringFlagRow: View {
        let key: String
        var value: String
        let image: String
        @State private var showSheet = false
        
        var body: some View {
            HStack{
                //Image("string-icon", bundle: Bundle.flagboardBundle)
                Image(image, bundle: Bundle.flagboardBundle)
                    .frame(width: 24, height: 24)
                Text(key)
                    .font(.callout)
                    .onTapGesture {
                        showSheet.toggle()
                    }
                    .sheet(isPresented: $showSheet) {
                        SheetView(title: key,
                                  message: value)
                    }
            }
        }
    }
    
    
}

struct FlagboardView_Previews: PreviewProvider {
    static var previews: some View {
        FlagboardView(viewModel: FlagboardViewModel())
    }
}


