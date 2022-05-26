import 'package:flutter/material.dart';
import 'package:flutter_dapp_demo/contract_linking.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var contractLink = Provider.of<ContractLinking>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Center(
            child: contractLink.isLoading
                ? const CircularProgressIndicator()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome to DApp, ${contractLink.deployedContractName}',
                      ),
                      TextFormField(
                        controller: _messageController,
                      ),
                      ElevatedButton(
                        onPressed: () =>
                            contractLink.setMessage(_messageController.text),
                        child: const Text('Set Message'),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
