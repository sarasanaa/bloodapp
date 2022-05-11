import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mana7yaha/controller/controller.dart';
import 'package:mana7yaha/controller/my_sizer.dart';
import 'package:mana7yaha/view/wiget/text_form.dart';

class AddComment extends StatefulWidget {
  AddComment({Key? key, required this.id}) : super(key: key);
  String? id;

  @override
  State<AddComment> createState() => _AddCommentState();
}

class _AddCommentState extends State<AddComment> {
  TextEditingController comment=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('التعليقات')),
      body: FutureBuilder<List<String>>(
        future: Controller.fetchComments(id: widget.id ?? ''),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CupertinoActivityIndicator());
          }else if(snapshot.hasData==false){
            return  SingleChildScrollView(
              child:Center(
                child:  Wrap(
                  children: [
                    Container(
                      alignment: Alignment.center,
                        height: MySizer.h(context)*.8,
                        child:const Text( '..لا توجد تعليقات ')),
                    SizedBox(
                      height: MySizer.h(context)/10,
                      child: TextForm(
                        hint: 'اضف تعليق',
                        controller: comment,
                        widget: IconButton(
                          icon:const Icon(Icons.send),
                          onPressed: (){
                            Controller.addComment(id: widget.id??'', content: comment.text);
                            setState(() {});
                            comment.clear();
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }else{
            return SingleChildScrollView(
              child: Wrap(
                children: [
                  SizedBox(
                    height: MySizer.h(context)*.8,
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context,index){
                        return   snapshot.data!.isEmpty? const Center(child: Text('لا توجد تعليقات'),):
                        Card(child: Text(snapshot.data![index]));
                      },
                    ),
                  ),
                  SizedBox(
                    height: MySizer.h(context)/10,
                    child: TextForm(
                      hint: 'اضف تعليق',
                      controller: comment,
                      widget: IconButton(
                        icon:const Icon(Icons.send),
                        onPressed: (){
                          Controller.addComment(id: widget.id??'', content: comment.text);
                          setState(() {});
                          comment.clear();
                        },
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
