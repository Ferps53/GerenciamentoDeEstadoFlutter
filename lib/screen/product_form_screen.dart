import 'package:flutter/material.dart';

import '../widget/app_drawer.dart';

class ProductFormScreen extends StatefulWidget {
  const ProductFormScreen({super.key});

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageUrlFocus = FocusNode();
  final _imageUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(updateImage);
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imageUrlFocus.removeListener(updateImage);
    _imageUrlFocus.dispose();
  }

  void updateImage() {
    print("Update");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text("Formulário de Produto"),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Nome"),
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Descrição"),
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocus,
                maxLines: 3,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Preço"),
                focusNode: _priceFocus,
                textInputAction: TextInputAction.next,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      focusNode: _imageUrlFocus,
                      controller: _imageUrlController,
                      decoration:
                          const InputDecoration(labelText: "Url da Imagem"),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.url,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 10,
                      left: 10,
                    ),
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: _imageUrlController.text.isEmpty
                        ? const Text(
                            "Informe a Url",
                          )
                        : FittedBox(
                            fit: BoxFit.cover,
                            child: Image.network(_imageUrlController.text),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
