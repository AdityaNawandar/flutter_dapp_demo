import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class ContractLinking extends ChangeNotifier {
  final String _rpcUrl = 'http://192.168.1.35:7545';
  final String _wsUrl = 'ws://192.168.1.35:7545';
  final String _privateKey =
      '28f5b60f62ab3a13483cbb647d1fd1e9c32086f59c2e1b1aeb6ed3fb7b678f3c';

  Web3Client? _web3Client;
  bool isLoading = false;
  String _abiCode = '';
  EthereumAddress? _contractAddress;
  Credentials? _credentials;
  DeployedContract? _contract;
  ContractFunction? _getMessage;
  ContractFunction? _setMessage;
  String? deployedContractName;

  ContractLinking() {
    setup();
  }

  setup() async {
    try {
      _web3Client = Web3Client(_rpcUrl, Client(), socketConnector: () {
        return IOWebSocketChannel.connect(_wsUrl).cast();
      });
      await getAbi();
      await getCredentials();
      await getDeployedContract();
    } catch (e) {
      print(e);
    }
  }

  getAbi() async {
    var abiList;
    var abiFileString =
        await rootBundle.loadString('build/contracts/HelloWorld.json');
    final jsonAbi = jsonDecode(abiFileString);
    abiList = jsonAbi['abi'];

    _abiCode = jsonEncode(abiList);
    _contractAddress =
        EthereumAddress.fromHex(jsonAbi['networks']['5777']['address']);
  }

  getCredentials() async {
    _credentials = EthPrivateKey.fromHex(_privateKey);
  }

  getDeployedContract() async {
    try {
      _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, "HelloWorld"),
        _contractAddress!,
      );

      _getMessage = _contract!.function("getMessage");
      _setMessage = _contract!.function("setMessage");
      getMessage();
    } catch (e) {
      print(e);
    }
  }

  getMessage() async {
    try {
      final message = await _web3Client!.call(
        contract: _contract!,
        function: _getMessage!,
        params: [],
      );
      deployedContractName = message[0];
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  setMessage(String message) async {
    try {
      isLoading = true;
      notifyListeners();
      await _web3Client!.sendTransaction(
        _credentials!,
        Transaction.callContract(
          contract: _contract!,
          function: _setMessage!,
          parameters: [message],
        ),
      );
      getMessage();
    } catch (e) {
      print(e);
    }
  }
}
