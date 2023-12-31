// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:gerenciamento_de_estado/models/product.dart';
import 'package:gerenciamento_de_estado/models/product_list.dart';
import 'package:provider/provider.dart';

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

  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(updateImage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final product = arg as Product;

        _formData['id'] = product.id;
        _formData['title'] = product.title;
        _formData['price'] = product.price;
        _formData['description'] = product.description;
        _formData['imageUrl'] = product.imageUrl;

        _imageUrlController.text = product.imageUrl;
      }
    }
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
    setState(() {});
  }

  Future<void> _submitForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    setState(() => _isLoading = true);

    if (!isValid) {
      return;
    }
    _formKey.currentState?.save();
    try {
      await Provider.of<ProductList>(context, listen: false)
          .saveProduct(_formData);
      Navigator.of(context).pop();
    } catch (error) {
      print(error.toString());
      return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Ocorreu um erro :("),
          content: const Text("Ocorreu um erro ao salvar um produto"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Ok"),
            ),
          ],
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  bool isImageUrlValid(String url) {
    bool isValid = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool endsWith = url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.jpeg');

    return isValid && endsWith;
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
        actions: [
          IconButton(
            onPressed: _submitForm,
            icon: const Icon(
              Icons.save,
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _formData['title']?.toString(),
                      decoration: const InputDecoration(labelText: "Nome"),
                      textInputAction: TextInputAction.next,
                      onSaved: (name) => _formData['title'] = name ?? '',
                      validator: (_name) {
                        final name = _name ?? '';
                        if (name.trim().isEmpty) {
                          return "Nome é Obrigatório";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData['description']?.toString(),
                      decoration: const InputDecoration(labelText: "Descrição"),
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionFocus,
                      maxLines: 3,
                      onSaved: (description) =>
                          _formData['description'] = description ?? '',
                      validator: (_description) {
                        final description = _description ?? '';
                        if (description.trim().isEmpty) {
                          return "Descrição é Obrigatória!";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData['price'].toString(),
                      decoration: const InputDecoration(labelText: "Preço"),
                      focusNode: _priceFocus,
                      textInputAction: TextInputAction.next,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      onSaved: (price) =>
                          _formData['price'] = double.parse(price ?? '0'),
                      validator: (_price) {
                        final priceString = _price ?? '';
                        final price = double.tryParse(priceString) ?? -1;

                        if (price <= 0) {
                          return "Informe um preço válido";
                        }
                        return null;
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: TextFormField(
                            onFieldSubmitted: (_) => _submitForm(),
                            focusNode: _imageUrlFocus,
                            controller: _imageUrlController,
                            decoration: const InputDecoration(
                                labelText: "Url da Imagem"),
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.url,
                            onSaved: (imageUrl) =>
                                _formData['imageUrl'] = imageUrl ?? '',
                            validator: (_imageUrl) {
                              final imageUrl = _imageUrl ?? '';
                              if (!isImageUrlValid(imageUrl)) {
                                return "Informe uma imagem valida!";
                              }
                              return null;
                            },
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
                                  child: Image.network(
                                    _imageUrlController.text,
                                    width: 100,
                                    height: 100,
                                  ),
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
