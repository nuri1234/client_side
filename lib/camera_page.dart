
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'images.dart';
import 'texts.dart';
import 'colors.dart';
import 'sos_screen.dart';


class camera_page extends StatefulWidget {
  const camera_page({Key? key}) : super(key: key);

  @override
  State<camera_page> createState() => _camera_pageState();
}

class _camera_pageState extends State<camera_page> {
  File? imageFile;
  bool _isButtonDisabled=false;
  Widget img_picker_icon() => Icon(
    Icons.camera,color: Colors.blue.withOpacity(0.2),size: 40,
  );
  Widget img_delete_icon() => Icon(
      Icons.delete_forever_sharp,color: Colors.red,size: 30,
  );
  Widget img_container(File img) => Container(
    width: 540,
    height: 380,

    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.grey,
      image: DecorationImage(image: FileImage(img),fit: BoxFit.cover),

      border: Border.all(width: 8,color: Colors.black12),
      borderRadius: BorderRadius.circular(12.0),

    ),
  );
  Widget non_img_container()=>Container(
    width: 540,
    height: 380,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.grey,
      border: Border.all(width: 8,color: Colors.black12),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Center(child: Icon(Icons.add_box_outlined,color: Colors.black54,size: 50,)),
  );
  Widget img_side(File img) => Container(
    width: 80,
    height: 80,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.grey,
      image: DecorationImage(image: FileImage(img),fit: BoxFit.cover),
      border: Border.all(width: 8,color: Colors.black12),
      borderRadius: BorderRadius.circular(12.0),
    ),

  );
  Widget Button_Row()=>Row(children: [
    Expanded(
        child: ElevatedButton(

      onPressed: ()
      {
        _isButtonDisabled?null:
        getImage(source: ImageSource.camera);
        my_images.count++;
        if (my_images.count>=3){

          setState(() {_isButtonDisabled=true;});

        }
        },

      child: Text(my_texts.captur_image,style:my_texts.buttonTextStyle,),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
            ),
            primary: _isButtonDisabled?app_colors.Disablebutton:app_colors.button,
            minimumSize: Size(20.0, 30.0),
          ),



    )),
    SizedBox(width: 4,),
    Expanded(child: ElevatedButton(
      onPressed: (){
        _isButtonDisabled?null:
        getImage(source: ImageSource.gallery);
        my_images.count++;
        if (my_images.count>=3){

          setState(() {_isButtonDisabled=true;});

        }
        },
      child: Text(my_texts.select_image,style:my_texts.buttonTextStyle,),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
        ),
        primary: _isButtonDisabled?app_colors.Disablebutton:app_colors.button,
        minimumSize: Size(20.0, 30.0),
      ),
    )),



  ],);

  Widget img_Row()=>Row(children: [
    const SizedBox(width: 17,),
    if(my_images.imageFile1 != null)
    img_side(my_images.imageFile1!) ,
    const SizedBox(width: 17,),
    if(my_images.imageFile2 != null)
      img_side(my_images.imageFile2!),
    const SizedBox(width:17,),
    if(my_images.imageFile3 != null)
      img_side(my_images.imageFile3!),
  ],
  );

  Widget stak_images() => Stack(
    children: [
      img_Row(),
      Column(
        children: [
          SizedBox(height:2,),
          Row(children: [
            SizedBox(width:17,),
            if(my_images.imageFile1 != null)
              IconButton(
                onPressed: (){setState(() {imageFile=my_images.imageFile1; });},
                icon:img_picker_icon(),
                tooltip: 'show image',
              ),
            SizedBox(width:56,),
            if(my_images.imageFile2 != null)
              IconButton(
                onPressed: (){setState(() {imageFile=my_images.imageFile2; });},
                icon:img_picker_icon(),
                tooltip: 'show image',
              ),
            SizedBox(width:55,),
            if(my_images.imageFile3 != null)
              IconButton(
                onPressed: (){setState(() {
                  imageFile=my_images.imageFile3; });},
                icon:img_picker_icon(),
                tooltip: 'show image',
              ),

          ],),
          Row(children: [
            SizedBox(width:67,),
            if(my_images.imageFile1 != null)
            IconButton(
              onPressed: (){setState(() {
                my_images.imageFile1=my_images.imageFile2;
                my_images.imageFile2=my_images.imageFile3;
                my_images.imageFile3=null;
                my_images.count--;
                _isButtonDisabled=false;}
              );},

              icon:img_delete_icon(),
              tooltip: my_texts.delet_image,
            ),
            SizedBox(width:50,),
            if(my_images.imageFile2 != null)
            IconButton(
              onPressed: (){setState(() {
                my_images.imageFile2=my_images.imageFile3;
                my_images.imageFile3=null;
                my_images.count--;
                  _isButtonDisabled=false;
              });},
              icon:img_delete_icon(),
              tooltip:my_texts.delet_image,
            ),
            SizedBox(width:50,),
            if(my_images.imageFile3 != null)
            IconButton(
              onPressed: (){setState(() {
                my_images.imageFile3=null;
              my_images.count--;
              _isButtonDisabled=false;
              });},
              icon:img_delete_icon(),
              tooltip: my_texts.delet_image,
            ),

            ],),
        ],
      )



    ],

  );









  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: app_colors.camera_page_background,
      appBar: AppBar(
        backgroundColor: app_colors.app_bar_background,
        title: Text(my_texts.capturing_Image,style: my_texts.buttonTextStyle,),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed:() {
             my_images.count=0;
             my_images.imageFile1=null;
             my_images.imageFile2=null;
             my_images.imageFile3=null;

                 Navigator.push(context, MaterialPageRoute(builder: (context)=>Sos()));
            },
            icon: Icon(Icons.cancel,color: Colors.red,size: 40,),
            tooltip:my_texts.cancel,
          ),
          IconButton(
            onPressed:() {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Sos()));
            },
            icon: Icon(Icons.verified,color: Colors.green,size: 40,),
            tooltip: my_texts.continue_bot,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            stak_images(),
            const SizedBox(height:1,),
            if(imageFile != null)
              img_container(imageFile!)
            else
            non_img_container(),
            const SizedBox(height: 10,),
            Button_Row(),
          ],
        ),
      ),
    );
  }
  void getImage({required ImageSource source}) async{
    final file=await ImagePicker().pickImage(source: source);

    if(file?.path !=null){
      setState(() {imageFile=File(file!.path);});

      if(my_images.imageFile1 == null){
        setState(() {my_images.imageFile1=imageFile;});
      }
      else if(my_images.imageFile2 == null){
        setState(() {my_images.imageFile2=imageFile;});
      }
      else if(my_images.imageFile3 == null){
        setState(() {my_images.imageFile3=imageFile;});
      }
    }
  }
}


