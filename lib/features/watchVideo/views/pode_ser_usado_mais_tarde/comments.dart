/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'costumRatingBar.dart';

class Comments extends StatelessWidget {
  const Comments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String month = DateTime.now().toString().substring(5,7);
    String ano = DateTime.now().toString().substring(0,4);
    String dia = DateTime.now().toString().substring(8,10);
    String horaMinSegundo = DateTime.now().toString().substring(11,20);
    double screenWidth = MediaQuery.of(context).size.width;
    double _screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: (_screenWidth*964/1440)-10,
      child:Card(
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          child: Text(
                            "G",
                            style: TextStyle(color: Colors.black87),
                          ),
                          backgroundColor: Colors.grey,
                        ),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("gabrielbrsc2@gmail.com"),
                          ],
                        ),
                        SizedBox(width: 12,),
                        CustomRatingBar(
                          rating: 4.0,
                        ),
                      ],
                    ),
                    SizedBox(height: 8),

                    SizedBox(width: 8),
                    ConstrainedBox(
                        constraints:  BoxConstraints(
                          minHeight: 10,
                          minWidth: 100,
                          maxHeight: 206,
                          maxWidth: (_screenWidth*964/1440)-10,
                        ),

                        child: Container(
                          child: Text("dsdsdsxgfdxgxxffxfxgfxgxfg    fxxxxdxdxxxxdxgxdxxxddxxddxxddxdxfdfxxdfdxxdxdxdfxdxdfxdxdxdfxdfxdfxdfxdxhdxdhxdhxdhhxdxdxcxxdxfxdfhxxdfxdxdhxdhxdxhxdfxfdhxxxfdxdfxdfxxxdjjdddsjdsbdbsbdhsbhs",
                            style: Theme.of(context).textTheme.caption,),
                        )
                    ),
                    SizedBox(height: 8),
                    Text(
                      dia+' de '+getMonth(month)+' de '+ano+ ' às '+horaMinSegundo,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      maxLines: 20,
                      textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.caption,
                    )
                  ],
                ),
              ),
            ),

    );

  }
  String getMonth(String month){
    if(month == '01') return 'Janeiro';
    if(month == '02') return 'Fevereiro';
    if(month == '03') return 'Março';
    if(month == '04') return 'Abril';
    if(month == '05') return 'Maio';
    if(month == '06') return 'Junho';
    if(month == '07') return 'Julho';
    if(month == '08') return 'Agosto';
    if(month == '09') return 'Setembro';
    if(month == '10') return 'Outubro';
    if(month == '11') return 'Novembro';
    if(month == '12') return 'Dezembro';
    return 'Agosto';
  }
}

*/
