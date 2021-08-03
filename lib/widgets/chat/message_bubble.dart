import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {


  final String message;
  final String userName;
  final bool isMe;

  MessageBubble(
      this.message,this.isMe, this.userName,
      );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe? MainAxisAlignment.end:MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isMe?  Colors.grey[300]:Theme.of(context).accentColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(14.0),
              topLeft: Radius.circular(14.0),
              bottomRight: isMe? Radius.circular(0):Radius.circular(14.0),
              bottomLeft: !isMe? Radius.circular(0):Radius.circular(14.0),
            ),
          ),
          width: 140.0,
          padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 16.0),
          margin: EdgeInsets.symmetric(vertical: 4.0,horizontal: 8.0),
          child: Column(
            crossAxisAlignment: isMe?CrossAxisAlignment.end:CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isMe? Colors.black:Theme.of(context).accentTextTheme.headline6!.color,
                ),
              ),
              Text(
                message,
                style: TextStyle(
                  color: isMe? Colors.black:Theme.of(context).accentTextTheme.headline6!.color,
                ),
                textAlign: isMe?TextAlign.end:TextAlign.start,
              ),

            ],
          ),
        ),
      ],
    );
  }
}
