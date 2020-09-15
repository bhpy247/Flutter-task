import 'package:flutter/material.dart';
import 'package:toast/toast.dart';


class MyToast{


    static void showError(String msg,BuildContext context)
    {
      Toast.show(msg, context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM,backgroundColor: Colors.red,textColor: Colors.white);
    }

    static void showSuccess(String msg,BuildContext context)
    {

      Toast.show(msg, context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM,backgroundColor: Colors.green,textColor: Colors.white);
    }

    static void normalMsg(String msg,BuildContext context)
    {
      Toast.show(msg, context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM,backgroundColor: Colors.grey,textColor: Colors.white);

    }
    static void normalMsgG(String msg,BuildContext context,int gravity)
    {
      Toast.show(msg, context, duration: Toast.LENGTH_LONG, gravity:  gravity,backgroundColor: Colors.white,textColor: Colors.black);

    }
}