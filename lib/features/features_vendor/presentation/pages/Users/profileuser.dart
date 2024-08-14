import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../../../auth/data/model/createchargewallet_model.dart';
import '../../../../auth/data/model/createwallet_model.dart';
import '../../../../auth/data/model/get_createwallet_model.dart';
import '../../../../auth/data/model/getwallet_model.dart';
import '../../../data/data_source/User_Shopper_datasource/user_datasource.dart';
import '../../../data/models/user_model/wallat/createchargewallet_model.dart';
import '../../../data/models/user_model/wallat/createwallet_model.dart';
import '../../../data/models/user_model/wallat/getwallet_model.dart';

class ProfileScreenUser extends StatefulWidget {
  const ProfileScreenUser({Key? key}) : super(key: key);

  @override
  State<ProfileScreenUser> createState() => _ProfileScreenUserState();
}

class _ProfileScreenUserState extends State<ProfileScreenUser> {
  int postLen = 10;
  int like = 5;
  int following = 2;
  bool isFollowing = false;
  bool isLoading = false;
  double walletBalance = 0.0; // الرصيد في المحفظة
  bool walletCreated = false;
  String walletId = ''; // معرف المحفظة
  GetCreatewalletModel? getCreatewallet;
  final UserDatasourceImp userDatasource = UserDatasourceImp(dio: Dio());

  @override
  void initState() {
    super.initState();
    _getWalletBalance(); // Load wallet balance on initialization
  }

  Future<void> _getWalletBalance() async {
    try {
      GetwalletModel wallet = await userDatasource.Getwallet_datasource();
      setState(() {
        walletBalance = wallet.money?.toDouble() ?? 0.0;
        walletCreated = true;
        walletId = wallet.data ?? '';
      });
    } catch (e) {
      print(e);
      _showErrorDialog('Failed to get wallet balance. Please try again.');
    }
  }

  void _createWallet() async {
    TextEditingController passwordController = TextEditingController();
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Create Wallet'),
          content: TextField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Enter Password',
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Create'),
              onPressed: () async {
                try {
                  final createwallet = await userDatasource.craetewallet(
                    CreatewalletModel(password: passwordController.text),
                  );
                  setState(() {
                    getCreatewallet = createwallet;
                    walletCreated = true;
                    walletId = getCreatewallet?.id ?? '';
                  });
                } catch (e) {
                  print(e);
                  _showErrorDialog(
                      'Failed to create wallet. Please try again.');
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _chargeWallet() async {
    TextEditingController amountController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Charge Wallet'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Enter Amount',
                ),
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Enter Password',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Charge'),
              onPressed: () async {
                try {
                  if (walletId.isEmpty) {
                    throw Exception('Wallet ID is empty');
                  }

                  await userDatasource.Chaegrwallet(
                    CreatechargewalletModel(
                      password: passwordController.text,
                      rechargeMoney: amountController.text,
                      walteId: walletId,
                    ),
                  );
                  Navigator.of(context).pop();

                  // Show Snackbar after charging the wallet
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Your request is being processed.'),
                      duration: Duration(seconds: 2),
                    ),
                  );

                  // Update wallet balance after charging
                  await _getWalletBalance();
                } catch (e) {
                  print(e);
                  _showErrorDialog(
                      'Failed to charge wallet. Please try again.');
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 82, 10, 111),
              ),
              child: Text('Menu'),
            ),
            ListTile(
              title: const Text('Wallet'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreenUser()),
                );
              },
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _getWalletBalance,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (!walletCreated) {
                                _createWallet();
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color.fromARGB(255, 88, 24, 109),
                                ),
                                padding: const EdgeInsets.all(20),
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.wallet,
                                        size: 40,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        '\$${walletBalance.toStringAsFixed(2)}', // عرض الرصيد
                                        style: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 252, 251, 251),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed:
                                  walletCreated ? _chargeWallet : _createWallet,
                              child: Text(walletCreated
                                  ? 'Charge Wallet'
                                  : 'Create Wallet'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, bottom: 10, right: 10),
                          child: CircleAvatar(
                            backgroundColor: Colors.grey,
                            backgroundImage: const NetworkImage(
                              'https://via.placeholder.com/150',
                            ),
                            radius: 50,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4, bottom: 7),
                          child: const Text(
                            'username',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Padding(
                          padding: const EdgeInsets.only(left: 4, bottom: 40),
                          child: const Text(
                            '0988708265',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
