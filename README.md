
# ShareLinkButton SwiftUI Package

## Overview
This package provides a SwiftUI view, `ShareLinkButton`, that enables sharing of various data types. 

## Features
- **Customizable Button Label**: The label of the button is fully customizable with SwiftUI views.
- **Support for Multiple Data Types**: Supports sharing of text, images, URLs, and other `Transportable` types.
- **Custom Activities**: Ability to add custom activities to the share sheet.
- **Activity Exclusion**: Options to exclude specific activities from the share sheet.
- **iOS 14+ Compatibility**: Designed to be compatible with iOS 14 and above.

## Example Usage

To see the example code in action, refer to the [example](https://github.com/The-Igor/sharelink-for-swiftui-example).

![ShareLinkButton Example](https://github.com/The-Igor/sharelink-for-swiftui/blob/main/img/sharelink_swiftui.jpeg)

## API
### `ShareLinkButton` Struct
```swift
@available(iOS 14.0, *)
public struct ShareLinkButton<Label: View>: View {
    public init<T: Transportable>(
        item: T,
        icon: UIImage? = nil,
        title: String? = nil,
        printAction: Bool = true,
        applicationActivities: [UIActivity]? = nil,
        excludedActivityTypes: [UIActivity.ActivityType]? = nil,
        @ViewBuilder label: @escaping () -> Label
    )
    
    public init(
        itemSource: UIActivityItemSource,
        applicationActivities: [UIActivity]? = nil,
        excludedActivityTypes: [UIActivity.ActivityType]? = nil,
        @ViewBuilder label: @escaping () -> Label
    )
}
```

## Supported `Transportable` Types
- `String`
- `URL`
- `UIImage`
- `Data`
- `NSAttributedString`
- `CLLocation`

## Usage Examples

### Basic Usage with String
```swift
ShareLinkButton(item: "Hello, world!", label: {
    Text("Share Text")
})
```

### Advanced Usage with Custom Icon and Title
```swift
ShareLinkButton(item: URL(string: "https://example.com")!, icon: UIImage(systemName: "link"), title: "Check this out!", label: {
    HStack {
        Image(systemName: "square.and.arrow.up")
        Text("Share URL")
    }
})
```

### Sharing CLLocation
```swift
let location = CLLocation(latitude: 37.7749, longitude: -122.4194) // Coordinates for San Francisco

ShareLinkButton(item: location, label: {
    Text("San Francisco location")  
})
```

## Customization

The button appearance can be customized via the label closure, allowing integration with the design system of the host application. Additionally, developers can specify custom activities or exclude certain activity types to tailor the sharing experience to the app's needs.

The `ShareLinkButton` in SwiftUI allows developers to customize the sharing experience by providing their own `UIActivityItemSource`. This interface enables precise control over the data shared and its format, depending on the activity type selected by the user.

1. **Define a Custom `UIActivityItemSource`**:
   Begin by creating a class that conforms to the `UIActivityItemSource` protocol. This class will specify the data to be shared when the share sheet is activated.

```swift
import UIKit

class CustomItemSource: NSObject, UIActivityItemSource {
    let text: String
    let url: URL

    init(text: String, url: URL) {
        self.text = text
        self.url = url
    }

    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return text
    }

    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return text
    }

    func activityViewController(_ activityViewController: UIActivityViewController, subjectForActivityType activityType: UIActivity.ActivityType?) -> String {
        return "Custom Subject"
    }

    func activityViewController(_ activityViewController: UIActivityViewController, dataTypeIdentifierForActivityType activityType: UIActivity.ActivityType?) -> String? {
        return "public.url"
    }

    func activityViewController(_ activityViewController: UIActivityViewController, thumbnailImageForActivityType activityType: UIActivity.ActivityType?, suggestedSize size: CGSize) -> UIImage? {
        return UIImage(systemName: "link.circle")
    }
}
```

2. **Use the custom activity item source in ShareLinkButton**
   
```swift
let source = CustomItemSource(
    text: "Check out this amazing website!",
    url: URL(string: "https://www.example.com")!
)

ShareLinkButton(item: source) {
    Label("Share", systemImage: "square.and.arrow.up")
}
```

## License
This package is licensed under the MIT license. See the LICENSE file for more details.
