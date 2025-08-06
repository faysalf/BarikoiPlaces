<H2>Swift Package for Barikoi Auto Complete Places</H2>
    Barikoi Auto-complete Places SDK is a Swift package that provides detailed place information across Bangladesh, supporting both English and Bangla. This SDK supports integration with both UIKit and SwiftUI. While originally developed for an internal use, but the SDK is fully reusable in your own projects.
[<i> ※ Requires a minimum of iOS 14.</i>]

<br><br><B>Here's how you can integrate it in your Swift UIKit project:</B><br>

<B>Step 1</B>. Add the BarikoiPlaces Package to your iOS project and create a UI element like a button to connect with the Barikoi View Controller. <br>
<B>Setp 2</B>. Get an <Code>API_KEY</Code> from the <i><a href="https://barikoi.com/product/api">Barikoi Website</a></i> and set it to the AppDelegate.
```  
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    BarikoiPlacesClient.myApiKey("YourApiKey")
    return true
}
```
 <br>
<B>Setp 3</B>. Create an instance of the BarikoiAutocompleteViewController, set the parent view controller as the delegate and present it using <Code>[self presentViewController...]</Code>, or <Code>[navigationController..]</Code>.
    
```
let vc = BarikoiAutocompleteViewController()
vc.delegate = self
vc.modalPresentationStyle = .fullScreen
self.present(vc, animated: true)
```

<B>Setp 4</B>. Implement the Barikoi Autocomplete Delegate protocol in the parent view controller and handle the user's selection in the places(_:) delegate method. And you will receive the response in the <i><a href="https://github.com/faysalf/BarikoiPlaces/blob/main/Sources/BarikoiPlaces/UIKit/Model/PlaceModel.swift">BarikoiModel</a> model.</i>

```
class YourViewController: BarikoiAutocompleteDelegate {
    func places(_ place: BarikoiPlaces.Place?) {
        debugPrint(place)
    }
}
```



<br>
<h2>For SwiftUI:</h2> Adding a full-screen control to your SwiftUI app is straightforward. Here's how you can do it: <br><br>

<B>Step 1</B>. Define a <Code>@State</Code> variable to control the presentation of <Code>BarikoiAutoCompletePlacesView</Code>. <br>
<B>Step 2</B>. Then present the view using <Code>.sheet</Code>, <Code>NavigationLink</Code>, or any other SwiftUI navigation method you preferred.<br>
[Make sure to initialize the view with your <Code>API_KEY</Code>, an optional initial query, and a closure to handle the selected place:
```
struct YourSwiftUIView: View {
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
            BarikoiAutoCompletePlacesView(
                apiKey: "YOUR_API_KEY",
                initialQuery: "Dhanmondi",
                didTapPlace: { place in
                    debugPrint("Selected place- ", place)
                }
            )
        }
    }
}
```

<B><i>[For any assistance or suggestions, please feel free to send me a message on <a href="https://www.linkedin.com/in/faysalf/">LinkedIn</a>]</i></B>
