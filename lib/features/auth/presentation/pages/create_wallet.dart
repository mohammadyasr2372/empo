// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:party/features/auth/data/model/createchargewallet_model.dart';
import 'package:party/features/auth/data/model/createwallet_model.dart';
import 'package:party/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/strings/constans.dart';
import '../../../../injection_container.dart' as di;
import '../../../features_vendor/presentation/pages/cande/post_cande/post_cande.dart';
import '../../../features_vendor/presentation/pages/restaurant/post_restaurant/post_restaurant.dart';
import '../../../features_vendor/presentation/pages/wedding_hall/post_wedding_hall/Wedding_Hall_Post.dart';
import '../../../hotel/presentation/pages/hotel/post_hotel/hotel_post.dart';
import '../../data/data_sources/remote/shopper_api_service.dart';
import '../../data/model/paid_shopper_model.dart';

class CreateWallet extends StatefulWidget {
  const CreateWallet({super.key});

  @override
  _CreateWalletState createState() => _CreateWalletState();
}

class _CreateWalletState extends State<CreateWallet> {
  bool walletCreated = false;
  String walletPassword = '';
  String walletBalance = '';
  String walletId = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _checkWalletExists();
    });
  }

  Future<void> _checkWalletExists() async {
    try {
      final response = await sl<ShopperApiService>().GetWallet();
      if (response.data != null) {
        setState(() {
          walletCreated = true;
          walletId = response.data ?? '';
          walletBalance = response.money?.toString() ?? '0';
        });
        _showRechargeDialog();
      } else {}
    } catch (e) {
      _showCreateWalletDialog();
      // _showErrorDialog('Failed to check wallet. Please try again.');
      // _showCreateWalletDialog();
    }
  }

  void _showCreateWalletDialog() {
    TextEditingController passwordController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.account_balance_wallet,
                  size: 50, color: Colors.blue),
              const SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(hintText: 'Enter password'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await sl<ShopperApiService>().createShopperWallet(
                      CreatewalletModel(password: passwordController.text),
                    );
                    Navigator.of(context).pop();
                    setState(() {
                      walletCreated = true;
                      walletPassword = passwordController.text;
                    });
                    _showRechargeDialog();
                  } catch (e) {
                    _showErrorDialog(
                        'Failed to create wallet. Please try again.');
                  }
                },
                child: const Text('Create Wallet'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showRechargeDialog() {
    TextEditingController amountController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Recharge Wallet'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(hintText: 'Enter amount to recharge'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(hintText: 'Enter password'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _confirmRecharge(
                    amountController.text, passwordController.text);
              },
              child: const Text('Recharge Wallet'),
            ),
          ],
        );
      },
    );
  }

  void _confirmRecharge(String amount, String password) {
    if (password.isEmpty || amount.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password or amount should not be empty')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Recharge'),
          content: Text(
              'Are you sure you want to recharge the wallet with $amount?'),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                try {
                  await sl<ShopperApiService>().chargeWallet(
                    chargewallet: CreatechargewalletModel(
                      password: password,
                      rechargeMoney: amount,
                      walteId: di.sl
                          .get<SharedPreferences>()
                          .getString(CACHED_ID_Wallet)!,
                    ),
                  );
                  await _getWalletBalance();
                } catch (e) {
                  _showErrorDialog(
                      'Failed to recharge wallet. Please try again.');
                }
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _getWalletBalance() async {
    try {
      final response = await sl<ShopperApiService>().GetWallet();
      setState(() {
        walletBalance = response.money?.toString() ?? '0';
      });
    } catch (e) {
      _showErrorDialog('Failed to get wallet balance. Please try again.');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
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
        title: const Text('Vendor Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.account_balance_wallet,
                size: 50, color: Colors.blue),
            const SizedBox(height: 10),
            Text('Wallet Balance: $walletBalance'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed:
                  walletCreated ? _paidWalletBalance : _showCreateWalletDialog,
              child: Text(walletCreated ? 'Pay' : 'Create Wallet'),
            ),
            ElevatedButton(
              onPressed: _getWalletBalance,
              child: const Text('Refresh Balance'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _paidWalletBalance() async {
    try {
      PaidShopperModel paidShopperModel =
          await sl<ShopperApiService>().PaidSopper();
      if (paidShopperModel.success!) {
        String temp =
            sl.get<SharedPreferences>().getString(CACHED_TYPE_SHOPPER)!;
        print(temp);
        if (temp == 'Wedding Hall') {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const WeddingHallPost()));
        } else if (temp == 'Hotal') {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const PostHotel()));
        } else if (temp == 'Candies shop') {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const PostCande()));
        } else if (temp == 'Restorant') {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const PostRestaurant()));
        } else {
          _showErrorDialog(paidShopperModel.msg!);
        }
      }
    } catch (e) {
      _showErrorDialog('Failed to pay. Please try again.');
    }
  }
}
