Barikoi Auto-complete Places SDK is a package that provides extensive information about places around Bangladesh in both English and Bangla. Let me explain the Barikoi Places Auto-complete SDK which I've developed for work purposes, and you can use it with both Swift UIKit and SwiftUI. <i>[Currently minimum iOS version 14 needed]</i>

<B>Here's how you can integrate it into your Swift UIKit project:</B>

1. Add the Barikoi Places auto-complete Package to your iOS project and create a UI element like a button to connect with the Barikoi View Controller.
2. Get an API key from the <i><a href="https://barikoi.com/product/api">Barikoi Website</a></i> and set it to the AppDelegate.
```  
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    BarikoiPlacesClient.myApiKey("YourApiKey")
    return true
}
```
4. Create an instance of the Barikoi View Controller, set the parent view controller as the delegate and present it using [self presentViewController...].
```
let vc = BarikoiViewController()
vc.delegate = self
vc.modalPresentationStyle = .fullScreen
self.present(vc, animated: true)
```
4. Implement the Barikoi Autocomplete Delegate protocol in the parent view controller and handle the user's selection in the places(_ :) delegate method. And you will receive the response in the <i><a href="https://github.com/faysalf/BarikoiPlaces/blob/main/Sources/BarikoiPlaces/UIKit/Model/PlaceModel.swift">BarikoiModel</a> model.</i>
```
class YourViewController: BarikoiAutocompleteDelegate {
    func places(_ data: BarikoiPlaces.Place) {
        print(data)
    }
}
```

<br><B>For SwiftUI:</B>
Adding a full-screen control to your SwiftUI app is straightforward. Here's how you can do it:

1. Define a @State variable to control the presentation of the Barikoi Auto-Complete View.
Present the view using [.sheet…].
```
struct SwiftUIView: View {
    @State var isPresent = false
    
    var body: some View {
        VStack {
            Button(action: {
                isPresent.toggle()
            }, label: {
                Text("Present")
            })
        }
        .sheet(isPresented: $isPresent) {
            BarikoiAutoCompleteViewSiwftUI(apiKey: "YourApiKey", dismissAction: {
                isPresent = false
            }, didTapPlace: { place in
                print("Selected Places: \(place)")
            })
        }
    }
}
```

<B><i>[For any assistance or suggestions, feel free to send me a message on <a href="https://www.linkedin.com/in/faysalf/">LinkedIn</a>]</i></B>
