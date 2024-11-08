
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:taskmanager/data/model/network_response.dart';
import 'package:taskmanager/data/model/task_model.dart';
import 'package:taskmanager/data/service/network_caller.dart';
import 'package:taskmanager/data/utils/urls.dart';
import 'package:taskmanager/ui/utilits/app_colors.dart';
import 'package:taskmanager/ui/widgets/snacbar_massage.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key, required this.taskModel, required this.onRefreshList,
  });

  final TaskModel taskModel;
  final VoidCallback onRefreshList;


  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  String _selectedStatus='';
  bool _changeStatusInProgress=false;
  bool _deleteStatusInProgress=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedStatus=widget.taskModel.status!;
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.taskModel.title?? '',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Text(
              widget.taskModel.description?? '',
            ),
            Text(
              'Date ${widget.taskModel.createdDate?? ''}',
            ),
            const SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildTaskStatusChip(),
                Wrap(

                  children: [
                    Visibility(
                      visible: _changeStatusInProgress==false,
                      replacement: Text('Wait'),
                      child: IconButton(
                        onPressed: _onTapEditButton,
                        icon: Icon(Icons.edit),
                      ),
                    ),
                    Visibility(
                      visible: _deleteStatusInProgress==false,
                      replacement: Text('Wait'),
                      child: IconButton(
                        onPressed: _onTapDeleteButton,
                        icon: Icon(Icons.delete),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

    void _onTapEditButton(){
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: const Text('Edit Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              'New', 'Complete', 'Canceled', 'Progress'
            ].map((e){
              return ListTile(
                onTap: (){
                  _changeStatus(e);
                  Navigator.pop(context);
                },
                title: Text(e),
                selected: _selectedStatus==e,
                trailing: _selectedStatus==e? const Icon(Icons.check):null,
              );
            }).toList(),
          ),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: const Text('Cancel'),),
            TextButton(onPressed: (){}, child: const Text('Okey'),),
          ],
        );
      });
    }

    void _onTapDeleteButton() async {
      _deleteStatusInProgress=true;
      setState(() {});
      final NetworkResponse response = await NetworkCaller.getRequest(
          Url: urls.deleteStatus(widget.taskModel.sId!));

      if(response==200){
        widget.onRefreshList();

      }else{
        _deleteStatusInProgress=false;
        setState(() { });
        showSnacBarMassage(context, response.erroMessage);
      }
    }

  Widget _buildTaskStatusChip() {
    return Chip(
                label: Text(widget.taskModel.status!, style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold
                ),),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: AppColors.themColor),
                ),
              );
  }

  Future<void> _changeStatus(String newState) async {
    _changeStatusInProgress=true;
    setState(() {});
    final NetworkResponse response = await NetworkCaller.getRequest(
        Url: urls.changeStatus(widget.taskModel.sId!, newState));

    if(response==200){
      widget.onRefreshList();

    }else{
      _changeStatusInProgress=false;
      setState(() { });
      showSnacBarMassage(context, response.erroMessage);
    }



  }


}