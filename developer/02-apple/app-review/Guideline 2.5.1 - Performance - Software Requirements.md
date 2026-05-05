Your app uses or references the following non-public APIs:

LSApplicationWorkspace

The use of non-public APIs is not permitted on the App Store because it can lead to a poor user experience should these APIs change.

Continuing to use or conceal non-public APIs in future submissions of this app may result in the termination of your Apple Developer account, as well as removal of all associated apps from the App Store.

Next Steps

If you are using third-party libraries, please update to the most recent version of those libraries. If you do not have access to the libraries' source, you may be able to search the compiled binary using the "strings" or "otool" command line tools. The "strings" tool can output a list of the methods that the library calls and "otool -ov" will output the Objective-C class structures and their defined methods. These tools can help you narrow down where the problematic code resides. You could also use the "nm" tool to verify if any third-party libraries are calling these APIs.

Resources

For information on the "nm" tool, please review the ["nm tool" Xcode manual page](https://developer.apple.com/legacy/library/documentation/Darwin/Reference/ManPages/man1/nm.1.html).

If there are no alternatives for providing the functionality your app requires, you can file an [enhancement request](https://developer.apple.com/bugreporter/).
