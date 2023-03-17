import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_example/src/helpers/data_validators.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isPasswordShown = false;
 final GlobalKey<FormState>_formKey =GlobalKey();
 TextEditingController _emailController= TextEditingController();
  TextEditingController _phoneController= TextEditingController();
  TextEditingController _passwordController= TextEditingController();
  TextEditingController _dobController= TextEditingController();
  bool? isCheckBoxSelected=false;
  String? genderGroupValue;
  String? cityValue;
  double sliderValue =50;
  bool light=true;

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Example"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                TextFormField(
                  controller: _emailController,
                  validator:DataValidator.isValidEmail ,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(color: Colors.red)
                  ),
                ),
              ),
              SizedBox(height: 8,),
              TextFormField(

controller: _phoneController,
                maxLength: 10,
                validator: DataValidator.isValidMobile,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly
                ],
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Phone",
                  prefixText: "+91",
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green)),
                  focusedBorder: OutlineInputBorder(

                      borderRadius: BorderRadius.circular(24),

                    borderSide: BorderSide(color: Colors.red,width: 2)
                  ),
                ),
              ),
                  TextFormField(
controller: _dobController,
                    readOnly: true,
                    onTap: ()async{
                      DateTime  dateSelected=  await showDatePicker(
    context: context,
    initialDate: DateTime(1990),
    firstDate: DateTime(1958),
    lastDate: DateTime.now())?? DateTime(1990) ;
_dobController.text=dateSelected.toString().substring(0,10);
                    },
                    decoration: InputDecoration(
                      labelText: "DOB",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)),

                      focusedBorder: OutlineInputBorder(

                  borderRadius: BorderRadius.circular(24),

                borderSide: BorderSide(color: Colors.red,width: 2)
            ),
          ),

                  ),
              SizedBox(height: 8,),
              TextFormField(
                controller: _passwordController,
                validator: DataValidator.isValidPassword,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  labelText: "Password",
                  suffixIcon:Visibility(
                      visible: isPasswordShown,
                      replacement:IconButton(
                          onPressed: (){
                            setState(() {
                              isPasswordShown=!isPasswordShown;
                            });
                          }, icon: Icon(Icons.visibility)),
                      child:IconButton(
                        onPressed: (){
                          setState(() {
                            isPasswordShown=!isPasswordShown;
                          });
                        }, icon: Icon(Icons.visibility_off),
                      )
                  ),
                ),
                  obscureText: !isPasswordShown,
                ),
                  SizedBox(height:16,),
                  DropdownButtonFormField<String>(
                    validator:DataValidator.isNullOrEmpty,
                      value: cityValue,
                      items: [
                    DropdownMenuItem(child: Text("Kochi"),value: "kochi",),
                    DropdownMenuItem(child: Text("Mumbai"),value: "mumbai",),
                    DropdownMenuItem(child: Text("Dubai"),value: "dubai",),
                    DropdownMenuItem(child: Text("Kuwait"),value: "kuwait",),
                    DropdownMenuItem(child: Text("Banglure"),value: "banglure",),
                  ],
                      hint: Text("Please select your city"),
                      onChanged: (val){
                      setState(() {
                        cityValue=val;
                      });
                      },
                  ),
                  SizedBox(height:16,),
                Row(
                  children: [
                    Text("Gender"),
                  ],
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Radio(
                            value: "M",
                            groupValue: genderGroupValue,
                            onChanged: (option){
                              setState(() {
                                genderGroupValue=option.toString();
                              });
                            }
                        ),
                        Text("Male"),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(value: "F",
                            groupValue: genderGroupValue,
                            onChanged: (option){
                              setState(() {
                                genderGroupValue=option.toString();
                              });
                            }),
                        Text("Female"),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(value: "o",
                            groupValue: genderGroupValue,
                            onChanged: (option){
                              setState(() {
                                genderGroupValue=option.toString();
                              });
                            }),
                        Text("Others"),
                      ],
                    ),
                  ],
                ),

                SizedBox(height:32,),
                Row(
                  children: [
                    Checkbox(value: isCheckBoxSelected,
                        onChanged: (isSelected){
setState(() {
  isCheckBoxSelected=isSelected;
});
                        }),
                    Text("I agree to terms & condition")
                  ],
                ),
                  SizedBox(height: 8,),
                  Switch(
                      value: light,
                      activeColor: Colors.red,
                      onChanged: (value){
                        setState(() {
                          light=value;
                        });
                      }),
                  SizedBox(height: 8,),
                  Slider(
                      min: 0,
                      max: 100,
                      divisions: 4,
                      value: sliderValue,
                      onChanged: (changedValue){
                        setState(() {
                          sliderValue=changedValue;
                        });
                      },
                  ),
                ElevatedButton(onPressed: (){
                  showDialog(
                      context: context,
                      builder: (context){
                        return AlertDialog(
title: Text("Sample Title"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Sample Body"),
                              Icon(Icons.access_alarms_outlined)
                            ],
                          ),
                          actions: [
                            TextButton(onPressed: (){
                              Navigator.pop(context);
                            }, 
                                child: Text("Cancel")),
                            TextButton(onPressed: (){
                              Navigator.pop(context);
                            },
                                child: Text("Ok"))
                          ],
                        );
                      }
                  );
                },
                    child: Text("Show Dialog")),
                const SizedBox(height: 24,),
                ElevatedButton(onPressed:(isCheckBoxSelected ?? false)?(){
                  if(_formKey.currentState?.validate()??false){
                    String email= _emailController.text;
                    String password= _passwordController.text;
                    String phone= _phoneController.text;
                    print("Email inserted=$email");
                    print("password inserted=$password");
                    print("phone inserted=$phone");
                    print("Selected city=$cityValue");
                  }
                }:null,
                    child:Text("CLICK ME",
                  style: TextStyle(
                      fontSize: 12,fontWeight: FontWeight.w300),
    ))
          ],
              ),
            ),

          ),
        ),
      ),
    );
  }
}