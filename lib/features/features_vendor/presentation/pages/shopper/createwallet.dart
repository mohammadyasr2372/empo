// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter_clean_arichitecture/features_vendor/data/data_source/User_Shopper_datasource/shopper_datasource.dart';
// import '../../../data/models/user_model/wallat/createwallet_model.dart';
// import '../../../data/models/user_model/wallat/createchargewallet_model.dart';
// import '../../../data/models/user_model/wallat/getwallet_model.dart';

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Vendor App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: VendorDashboard(),
//     );
//   }
// }

// class VendorDashboard extends StatefulWidget {
//   @override
//   _VendorDashboardState createState() => _VendorDashboardState();
// }

// class _VendorDashboardState extends State<VendorDashboard> {
//   bool walletCreated = false;
//   String walletPassword = '';
//   String walletBalance = '';
//   String walletId = '';
//   final ShopperDatasourceImp shopperDatasource = ShopperDatasourceImp(dio: Dio());

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       await _checkWalletExists();
//     });
//   }

//   Future<void> _checkWalletExists() async {
//     try {
//       final response = await shopperDatasource.GetWallet();
//       if (response.data != null) {
//         setState(() {
//           walletCreated = true;
//           walletId = response.data ?? '';
//           walletBalance = response.money?.toString() ?? '0';
//         });
//         _showRechargeDialog();
//       } else {
//         _showCreateWalletDialog();
//       }
//     } catch (e) {
//       _showErrorDialog('Failed to check wallet. Please try again.');
//       _showCreateWalletDialog();
//     }
//   }

//   void _showCreateWalletDialog() {
//     TextEditingController passwordController = TextEditingController();

//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) {
//         return AlertDialog(
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(Icons.account_balance_wallet, size: 50, color: Colors.blue),
//               SizedBox(height: 20),
//               TextField(
//                 controller: passwordController,
//                 obscureText: true,
//                 decoration: InputDecoration(hintText: 'Enter password'),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () async {
//                   try {
//                     final wallet = await shopperDatasource.createShopperWallet(
//                       CreatewalletModel(password: passwordController.text),
//                     );
//                     Navigator.of(context).pop();
//                     setState(() {
//                       walletCreated = true;
//                       walletPassword = passwordController.text;
//                       walletId = wallet.id ?? '';
//                     });
//                     _showRechargeDialog();
//                   } catch (e) {
//                     _showErrorDialog('Failed to create wallet. Please try again.');
//                   }
//                 },
//                 child: Text('Create Wallet'),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   void _showRechargeDialog() {
//     TextEditingController amountController = TextEditingController();
//     TextEditingController passwordController = TextEditingController();

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Recharge Wallet'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: amountController,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(hintText: 'Enter amount to recharge'),
//               ),
//               SizedBox(height: 20),
//               TextField(
//                 controller: passwordController,
//                 obscureText: true,
//                 decoration: InputDecoration(hintText: 'Enter password'),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 _confirmRecharge(amountController.text, passwordController.text);
//               },
//               child: Text('Recharge Wallet'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _confirmRecharge(String amount, String password) {
//     if (password.isEmpty || amount.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Password or amount should not be empty')),
//       );
//       return;
//     }

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Confirm Recharge'),
//           content: Text('Are you sure you want to recharge the wallet with $amount?'),
//           actions: [
//             TextButton(
//               onPressed: () async {
//                 Navigator.of(context).pop();
//                 try {
//                   await shopperDatasource.chargeWallet(
//                     CreatechargewalletModel(
//                       password: password,
//                       rechargeMoney: amount,
//                       walteId: walletId,
//                     ),
//                   );
//                   await _getWalletBalance();
//                 } catch (e) {
//                   _showErrorDialog('Failed to recharge wallet. Please try again.');
//                 }
//               },
//               child: Text('Yes'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Cancel'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Future<void> _getWalletBalance() async {
//     try {
//       final response = await shopperDatasource.GetWallet();
//       setState(() {
//         walletBalance = response.money?.toString() ?? '0';
//       });
//     } catch (e) {
//       _showErrorDialog('Failed to get wallet balance. Please try again.');
//     }
//   }

//   void _showErrorDialog(String message) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Error'),
//           content: Text(message),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Vendor Dashboard'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.account_balance_wallet, size: 50, color: Colors.blue),
//             SizedBox(height: 10),
//             Text('Wallet Balance: $walletBalance'),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: walletCreated ? _paidWalletBalance : _showCreateWalletDialog,
//               child: Text(walletCreated ? 'Pay' : 'Create Wallet'),
//             ),
//             ElevatedButton(
//               onPressed: _getWalletBalance,
//               child: Text('Refresh Balance'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _paidWalletBalance() async {
//     try {
//       await shopperDatasource.PaidSopper();
//     } catch (e) {
      
//       // _showErrorDialog('Failed to pay. Please try again.');
//     }
//   }
// }




// // import 'package:flutter/material.dart';
// // import 'package:dio/dio.dart';
// // import 'package:flutter_clean_arichitecture/features_vendor/data/data_source/User_Shopper_datasource/shopper_datasource.dart';
// // import '../../../data/models/user_model/createwallet_model.dart';
// // import '../../../data/models/user_model/createchargewallet_model.dart';
// // import '../../../data/models/user_model/getwallet_model.dart';

// // void main() {
// //   runApp(MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Vendor App',
// //       theme: ThemeData(
// //         primarySwatch: Colors.blue,
// //       ),
// //       home: VendorDashboard(),
// //     );
// //   }
// // }

// // class VendorDashboard extends StatefulWidget {
// //   @override
// //   _VendorDashboardState createState() => _VendorDashboardState();
// // }

// // class _VendorDashboardState extends State<VendorDashboard> {
// //   bool walletCreated = false;
// //   String walletPassword = '';
// //   String walletBalance = '';
// //   String walletId = '';
// //   final ShopperDatasourceImp shopperDatasource = ShopperDatasourceImp(dio: Dio());

// //   @override
// //   void initState() {
// //     super.initState();
// //     WidgetsBinding.instance.addPostFrameCallback((_) {
// //       _showCreateWalletDialog();
// //     });
// //   }

// //   void _showCreateWalletDialog() {
// //     TextEditingController passwordController = TextEditingController();

// //     showDialog(
// //       context: context,
// //       barrierDismissible: false,
// //       builder: (context) {
// //         return AlertDialog(
// //           content: RefreshIndicator(
// //             onRefresh: _getWalletBalance,
// //             child: Column(
// //               mainAxisSize: MainAxisSize.min,
// //               children: [
// //                 Icon(Icons.account_balance_wallet, size: 50, color: Colors.blue),
// //                 SizedBox(height: 20),
// //                 TextField(
// //                   controller: passwordController,
// //                   obscureText: true,
// //                   decoration: InputDecoration(hintText: 'Enter password'),
// //                 ),
// //                 SizedBox(height: 20),
// //                 ElevatedButton(
// //                   onPressed: () async {
// //                     try {
// //                       final wallet = await shopperDatasource.createShopperWallet(
// //                         CreatewalletModel(password: passwordController.text),
// //                       );
// //                       Navigator.of(context).pop();
// //                       setState(() {
// //                         walletCreated = true;
// //                         walletPassword = passwordController.text;
// //                         walletId = wallet.id ?? '';
// //                       });
// //                       _showRechargeDialog();
// //                     } catch (e) {
// //                       _showErrorDialog('Failed to create wallet. Please try again.');
// //                     }
// //                   },
// //                   child: Text('Create Wallet'),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         );
// //       },
// //     );
// //   }

// //   void _showRechargeDialog() {
// //     TextEditingController amountController = TextEditingController();
// //     TextEditingController passwordController = TextEditingController();

// //     showDialog(
// //       context: context,
// //       builder: (context) {
// //         return AlertDialog(
// //           title: Text('Recharge Wallet'),
// //           content: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               TextField(
// //                 controller: amountController,
// //                 keyboardType: TextInputType.number,
// //                 decoration: InputDecoration(hintText: 'Enter amount to recharge'),
// //               ),
// //               SizedBox(height: 20),
// //               TextField(
// //                 controller: passwordController,
// //                 obscureText: true,
// //                 decoration: InputDecoration(hintText: 'Enter password'),
// //               ),
// //             ],
// //           ),
// //           actions: [
// //             TextButton(
// //               onPressed: () {
// //                 Navigator.of(context).pop();
// //                 _confirmRecharge(amountController.text, passwordController.text);
// //               },
// //               child: Text('Recharge Wallet'),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }

// //   void _confirmRecharge(String amount, String password) {
// //     if (password.isEmpty || amount.isEmpty) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text('Password or amount should not be empty')),
// //       );
// //       return;
// //     }

// //     showDialog(
// //       context: context,
// //       builder: (context) {
// //         return AlertDialog(
// //           title: Text('Confirm Recharge'),
// //           content: Text('Are you sure you want to recharge the wallet with $amount?'),
// //           actions: [
// //             TextButton(
// //               onPressed: () async {
// //                 Navigator.of(context).pop();
// //                 try {
// //                   await shopperDatasource.chargeWallet(
// //                     CreatechargewalletModel(
// //                       password: password,
// //                       rechargeMoney: amount,
// //                       walteId: walletId,
// //                     ),
// //                   );
// //                   setState(() {
// //                     walletCreated = true;
// //                   });
// //                   await _getWalletBalance();
// //                 } catch (e) {
// //                   _showErrorDialog('Failed to recharge wallet. Please try again.');
// //                 }
// //               },
// //               child: Text('Yes'),
// //             ),
// //             TextButton(
// //               onPressed: () {
// //                 Navigator.of(context).pop();
// //               },
// //               child: Text('Cancel'),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }

// //   Future<void> _getWalletBalance() async {
// //     try {
// //       final response = await shopperDatasource.GetWallet();
// //       setState(() {
// //         walletBalance = response.money?.toString() ?? '0';
// //       });
// //     } catch (e) {
// //       _showErrorDialog('Failed to get wallet balance. Please try again.');
// //     }
// //   }

// //   void _showErrorDialog(String message) {
// //     showDialog(
// //       context: context,
// //       builder: (context) {
// //         return AlertDialog(
// //           title: Text('Error'),
// //           content: Text(message),
// //           actions: [
// //             TextButton(
// //               onPressed: () {
// //                 Navigator.of(context).pop();
// //               },
// //               child: Text('OK'),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Vendor Dashboard'),
// //       ),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Icon(Icons.account_balance_wallet, size: 50, color: Colors.blue),
// //             SizedBox(height: 10),
// //             Text('Wallet Balance: $walletBalance'),
// //             SizedBox(height: 20),
// //             ElevatedButton(
// //               onPressed: walletCreated ? _paidWalletBalance : _showCreateWalletDialog,
// //               child: Text(walletCreated ? 'Pay' : 'Create Wallet'),
// //             ),
// //             ElevatedButton(
// //               onPressed: _getWalletBalance,
// //               child: Text('Refresh Balance'),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Future<void> _paidWalletBalance() async {
// //     try {
// //       await shopperDatasource.PaidSopper();
// //     } catch (e) {
// //       _showErrorDialog('Failed to pay. Please try again.');
// //     }
// //   }
// // }
