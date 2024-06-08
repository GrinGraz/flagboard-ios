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
                TextField("Buscar", text: viewModel.$searchText)
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                   Spacer()
                if viewModel.filteredItems.count > 0 {
                    List(viewModel.filteredItems) { flag in
                        FeatureFlagRow(featureFlag: flag.featureFlag)
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
    
    struct FeatureFlagRow: View {
        var featureFlag: FeatureFlag
        
        var body: some View {
            HStack {
                switch featureFlag {
                case .stringFlag(let param):
                    StringFlagRow(key: param.key.value, value: param.value)
                case .booleanFlag(let param):
                    BooleanFlagRow(key: param.key.value, value: param.value)
                default:
                    EmptyView()
                }
            }
        }
    }
    
    struct BooleanFlagRow: View {
        let key: String
        @State var value: Bool
        
        var body: some View {
            Text(key)
            Toggle("", isOn: $value)
        }
    }
    
    struct StringFlagRow: View {
        let key: String
        var value: String
        @State private var showSheet = false
        
        var body: some View {
            Text(key)
                .onTapGesture {
                    showSheet.toggle()
                }
                .sheet(isPresented: $showSheet) {
                    SheetView(title: key,
                              message: value)
                }
        }
    }
    
    struct SheetView: View {
        @Environment(\.presentationMode) var presentationMode
        var title: String
        var message: String
        
        var body: some View {
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "multiply.circle")
                            .font(.title)
                    }
                    .padding()
                }
                
                Text(title)
                Text(message)
                Spacer()
            }
        }
    }
}

struct FlagboardView_Previews: PreviewProvider {
    static var previews: some View {
        FlagboardView(viewModel: FlagboardViewModel())
    }
}


