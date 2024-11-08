import 'package:flutter/material.dart';
import 'package:taskmanager/data/model/network_response.dart';
import 'package:taskmanager/data/service/network_caller.dart';
import 'package:taskmanager/data/utils/urls.dart';
import 'package:taskmanager/ui/widgets/snacbar_massage.dart';
import 'package:taskmanager/ui/widgets/tm_app_bar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {

  final TextEditingController _titleTEcontroller=TextEditingController();
  final TextEditingController _descriptionTEcontroller=TextEditingController();
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  bool _addNewTaskInProgress=false;
  bool _shouldRefreshPreviousPage=false;

  @override
  Widget build(BuildContext context) {
    
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop,result){
        if(didPop){
          return;
        }
        Navigator.pop(context, _shouldRefreshPreviousPage);
      },
      child: Scaffold(
        appBar: TMAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 42,
                  ),
                  Text(
                    'Add New Task',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16,),
                  TextFormField(
                    controller: _titleTEcontroller,
                    decoration: const InputDecoration(
                      hintText: 'Title',
                                              
                    ),
      
                    validator: (String? value){
                      if(value?.trim().isEmpty?? true){
                        return 'Enter  a Value';
                      }
                      return null;
                    },
      
                  ),
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: _descriptionTEcontroller,
                    maxLines: 5,
                    decoration: const InputDecoration(
                        hintText: 'Description'
                    ),
                    validator: (String? value){
                      if(value?.trim().isEmpty?? true){
                        return 'Enter  Description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Visibility(
                    visible: !_addNewTaskInProgress,
      
                    child: ElevatedButton(
                        onPressed: _onTapSubmitButton,
                        child: Icon(Icons.arrow_circle_right_outlined)),
                  ),
                ],
              ),
            ),
          ),
        ),
      
      ),
    );
  }
  void _onTapSubmitButton(){

    if(_formKey.currentState!.validate()){
      _addNewTask();
    }

  }

  Future<void> _addNewTask() async{
    _addNewTaskInProgress=true;
    setState(() {});
    Map<String, dynamic> requestBody={
      'title': _titleTEcontroller.text.trim(),
      'description':_descriptionTEcontroller.text.trim(),
      'status':'New',
    };

    final NetworkResponse response =
        await NetworkCaller.postRequest(Url: urls.addNewTask,body: requestBody);

    _addNewTaskInProgress=false;
    setState(() {});

    if(response.isSuccess){
      _clearTextField();
      showSnacBarMassage(context, 'New Task Added!');

    }else{
      showSnacBarMassage(context, response.erroMessage, true);

    }
  }
  void _clearTextField(){
    _titleTEcontroller.clear();
    _descriptionTEcontroller.clear();
  }
}


