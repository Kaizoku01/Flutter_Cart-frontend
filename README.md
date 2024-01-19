# FlutterCart - E-commerce Application (Frontend)

FlutterCart is an e-commerce application with a Flutter frontend and a Node.js backend powered by MongoDB. This project allows users to browse and purchase products in an online store.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
  - [Installation](#installation)
  - [Configuration](#configuration)
- [Images](#images)
- [Contributing](#contributing)

## Prerequisites <a name="prerequisites"></a>

Before you begin, ensure you have the following prerequisites installed:

- [Flutter](https://docs.flutter.dev/get-started/install)
- [Razorpay client library](https://pub.dev/packages/razorpay_flutter)
- [Backend Code](https://github.com/Kaizoku01/Flutter_Cart-backend)

## Getting Started <a name="getting-started"></a>

### Installation <a name="installation"></a>


1. Clone the current repository:
   
   ```bash
   git clone https://github.com/Kaizoku01/Flutter_Cart-frontend.git

2. Clone the backend repository

   ```bash
   git clone https://github.com/Kaizoku01/Flutter_Cart-backend.git
   
### Configuration <a name="configuration"></a>

1. Create a `keys.dart` file in the `lib` directory to store your keys. This file should include the baseUrl and Razorpay keys as follows:

   ```dart
   // lib/keys.dart
   const kRAZORPAYID = '';
   const kBASEURL = 'http://IPADDRESS:5000/api'; 

The App will send request on the above url.

### Images <a name="images"></a>
<img src="https://github.com/Kaizoku01/Flutter_Cart-frontend/assets/90988390/ec126c54-e6ad-4c94-a2fb-6615a1b76d8f" alt="login_screen" width="200">
<img src="https://github.com/Kaizoku01/Flutter_Cart-frontend/assets/90988390/bb5f3478-9573-4fbc-b252-075e97c78951" alt="home_screen" width="200">
<img src="https://github.com/Kaizoku01/Flutter_Cart-frontend/assets/90988390/8dc548c2-9a9e-4a06-9282-a7ae4500444b" alt="product" width="200">
<img src="https://github.com/Kaizoku01/Flutter_Cart-frontend/assets/90988390/de8db48d-179d-4305-bf84-7f3ff24cd861" alt="product_added_to_cart" width="200">
<img src="https://github.com/Kaizoku01/Flutter_Cart-frontend/assets/90988390/72195ee0-07d5-477c-b8e1-eff6bee3c8a8" alt="category_screen" width="200">
<img src="https://github.com/Kaizoku01/Flutter_Cart-frontend/assets/90988390/5e6bc9cc-add7-42ef-b883-1c5680eccdd7" alt="product_by_category" width="200"> 
<img src="https://github.com/Kaizoku01/Flutter_Cart-frontend/assets/90988390/399ddfd4-1ef7-4427-86b4-89e37e9acfea" alt="profile_screen" width="200"> 
<img src="https://github.com/Kaizoku01/Flutter_Cart-frontend/assets/90988390/55b8e5bf-aa76-450a-b06c-94492cd5b380" alt="cart_screen" width="200">
<img src="https://github.com/Kaizoku01/Flutter_Cart-frontend/assets/90988390/7633dd26-d866-4f4d-9d45-9ecfebccc51b" alt="order_screen" width="200">
<img src="https://github.com/Kaizoku01/Flutter_Cart-frontend/assets/90988390/18c697a5-0931-49d4-8ec9-13d8e788e615" alt="razor_pay_gateway" width="200"> 


## Contributing <a name="contributing"></a>

We welcome contributions! Feel free to open issues or submit pull requests.
