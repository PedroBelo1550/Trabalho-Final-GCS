import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Repository/account_repository.dart';

class CardMainPageBalanco extends StatelessWidget {
  final String? title;

  const CardMainPageBalanco({
    this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      margin: const EdgeInsetsDirectional.only(top: 30),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          height: height * 0.11,
          width: width * 0.30,
          decoration: const BoxDecoration(
            borderRadius: BorderRadiusDirectional.all(
              Radius.circular(15.0),
            ),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "$title",
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              FutureBuilder(
                future:
                Provider.of<RepositoryAccount>(context).valorBalancoMes(),
                builder: (context, snapshot) => snapshot.connectionState ==
                    ConnectionState.waiting
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : Consumer<RepositoryAccount>(
                  key: Key('balanço'),
                  builder: (context, trasaction, child) => Container(
                    margin: const EdgeInsetsDirectional.only(bottom: 7.0),
                    child: Text(
                      "R\$ ${trasaction.saldoBalancoMes.toStringAsFixed(2).replaceAll('.', ',')}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
