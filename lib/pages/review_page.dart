// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';

import 'package:dicoding_restaurant_app/data/api/api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:dicoding_restaurant_app/provider/review_provider.dart';

class ReviewPage extends StatefulWidget {
  final String restaurantId;
  const ReviewPage({
    Key? key,
    required this.restaurantId,
  }) : super(key: key);

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  bool _loading = false;

  final _nameController = TextEditingController();
  final _reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ReviewProvider(
        apiService: ApiService(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Tulis Ulasan"),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Column(
              children: [
                Form(
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.orange,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                          contentPadding: EdgeInsets.all(20),
                          labelText: 'Name',
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _reviewController,
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.orange,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                          contentPadding: EdgeInsets.all(20),
                          labelText: 'Review',
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your review';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(55),
                          backgroundColor: Colors.orange,
                        ),
                        onPressed: () async {
                          if (_nameController.text.isEmpty ||
                              _reviewController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.red,
                                content:
                                    Text('Name and review cannot be empty!'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          } else {
                            setState(() {
                              _loading = true;
                            });
                            final reviewProvider = Provider.of<ReviewProvider>(
                              context,
                              listen: false,
                            );
                            reviewProvider.createData(
                              name: _nameController.text,
                              review: _reviewController.text,
                              restaurantId: widget.restaurantId,
                            );
                            await reviewProvider.addReview();
                            Timer(const Duration(seconds: 3), () {
                              setState(() {
                                _loading = false;
                              });
                              Navigator.pop(context);
                            });
                          }
                        },
                        child: _loading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "Submit",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
