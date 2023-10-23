# Flutter Reactive BLE Device Finder

This project is a Flutter application that allows you to find devices with reactive Bluetooth Low Energy (BLE) and connect to their services. It provides a user-friendly interface to discover nearby BLE devices and interact with their services.

## Features

- Device Discovery: The application scans for nearby BLE devices and displays them in a list.
- Device Details: You can view detailed information about each discovered device, such as its name, MAC address, and signal strength.
- Service Discovery: Once connected to a device, you can explore its available services and characteristics.
- Characteristic Interaction: You can read, write, and subscribe to characteristic values of the connected device.

## Installation

To use this application, follow these steps:

1. Clone the repository to your local machine:

   ```bash
   git clone https://github.com/caxtonmbuvi/BLESubscription.git
   ```

2. Change into the project directory:

   ```bash
   cd BLESubscription
   ```

3. Install the required dependencies:

   ```bash
   flutter pub get
   ```

4. Run the application on a connected device (Not yet Tested for Emulators):

   ```bash
   flutter run
   ```

## Usage
NOTE: REMEBBER TO CHANGE THE SERVICE UUID AND CHARACTERISTIC UUID.

1. Launch the application on your device or emulator.
2. Grant the necessary permissions for Bluetooth access if prompted.
3. Once the device is discovered, it will be connected automatically and subscribe to the Service and Characteristic you need to listen to.

## Dependencies

This project relies on the following dependencies:

- `permission_handler`: A Flutter plugin that Defines the permissions which can be checked and requested.
- `flutter_reactive_ble`: Flutter library that handles BLE operations for multiple devices.
- `provider`: A wrapper around InheritedWidget to make them easier to use and more reusable.
  

For more information about these dependencies, please refer to their respective documentation.

## Contributing

Contributions to this project are welcome! If you encounter any issues or have suggestions for improvements, please open an issue on the GitHub repository. You can also submit pull requests with your proposed changes.

Before contributing, please review the [contribution guidelines](CONTRIBUTING.md) for this project.

## License

This project is licensed under the [MIT License](LICENSE). Feel free to use, modify, and distribute the code as per the terms of the license.

## Acknowledgements

We would like to thank the Flutter community for their continuous support and the developers of the `flutter_reactive_ble`,`provider` and `permission_handler` packages for their valuable contributions.

## Contact

If you have any questions or need further assistance, you can reach out to the project maintainer at [caxtonbranson17@gmail.com]

Happy coding!
