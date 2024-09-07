import 'package:flutter/material.dart';


class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {

  final TextEditingController _onTapPulloverProductCounter=TextEditingController(
    text: '1',
  );
  final TextEditingController _onTapTShirtProductCounter=TextEditingController(
    text: '1',
  );
  final TextEditingController _onTapSportDressProductCounter=TextEditingController(
    text: '1',
  );
  int PulloverCountter=1;
  int PulloverUnitPrice=51;
  int TotalPullover=51;

  int TShirtCounter=1;
  int TshirtUnitPrice=30;
  int TotalTshirt=30;

  int SportDressCounter=1;
  int SportDressUnitPrice=43;
  int TotalSportDress=43;

  int grandTotal=51+30+43;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: Text('My Bag'),
        centerTitle: true,
      ),
      body: Column(
        children: [

      Container(
      margin: EdgeInsets.all(10.0),
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),

      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: 100,
                height: 130,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image:AssetImage('Assests/Images/T-shirt-01.jpg'),
                        fit: BoxFit.fill
                    )
                ),

              ),
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 14),
                    child: Container(
                      width: 200,
                      height: 80,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text('Pullover', style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Color: '),
                              Text('Black',style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),),
                              Text('  Size: '),
                              Text('L', style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  CircleAvatar(child: IconButton(onPressed: (){

                  if(PulloverCountter<=0){
                    _onTapPulloverProductCounter.text='1'.toString();
                    setState(() {

                    });
                  }
                 if(PulloverCountter>1){
                    PulloverCountter--;
                    TotalPullover=PulloverUnitPrice*PulloverCountter;
                    grandTotal-=PulloverUnitPrice;
                    _onTapPulloverProductCounter.text=PulloverCountter.toString();



                  }

                  setState(() {

                  });
                    //_onTapProductCounter.text=countter.toString();
                  }, icon: Icon(Icons.remove))),
                  SizedBox(

                      width: 30,
                      child: TextField(
                        controller: _onTapPulloverProductCounter,
                        textAlign: TextAlign.center,
                      )),
                  CircleAvatar(child: IconButton(onPressed: (){
                   if(PulloverCountter>=1){
                     PulloverCountter++;
                     TotalPullover=PulloverUnitPrice*PulloverCountter;
                     grandTotal+=PulloverUnitPrice;
                     _onTapPulloverProductCounter.text=PulloverCountter.toString();
                   }


                    setState(() {

                    });
                  }, icon: Icon(Icons.add))),

                ],
              )
            ],
          ),
          Column(
            children: [
              SizedBox(

                child:PopupMenuButton(itemBuilder: (context)=>[]),
              ),
              SizedBox(
                height: 40,
              ),
              Text('$TotalPullover\$', style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),),

            ],
          )
        ],
      ),

    ),
      Container(
            margin: EdgeInsets.all(10.0),
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),

            child: Row(
              children: [
                Column(
                  children: [
                    Container(
                      width: 100,
                      height: 130,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:AssetImage('Assests/Images/T-shirt-01.jpg'),
                              fit: BoxFit.fill
                          )
                      ),

                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 14),
                          child: Container(
                            width: 200,
                            height: 80,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text('T-Shirt', style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18
                                    ),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Color: '),
                                    Text('Gray',style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),),
                                    Text('  Size: '),
                                    Text('L', style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        CircleAvatar(child: IconButton(onPressed: (){

                          if(TShirtCounter<=0){
                            _onTapTShirtProductCounter.text='1'.toString();
                          }
                          if(TShirtCounter>1){
                            TShirtCounter--;
                            TotalTshirt=TshirtUnitPrice*TShirtCounter;
                            grandTotal-=TshirtUnitPrice;
                            _onTapTShirtProductCounter.text=TShirtCounter.toString();

                          }


                          setState(() {

                          });

                        }, icon: Icon(Icons.remove))),
                        SizedBox(

                            width: 30,
                            child: TextField(
                              controller: _onTapTShirtProductCounter,
                              textAlign: TextAlign.center,
                            )),
                        CircleAvatar(child: IconButton(onPressed: (){
                          if(TShirtCounter>=1) {
                            TShirtCounter++;
                            TotalTshirt = TshirtUnitPrice * TShirtCounter;
                            grandTotal+=TshirtUnitPrice;
                            _onTapTShirtProductCounter.text=TShirtCounter.toString();
                          }


                          setState(() {

                          });
                        }, icon: Icon(Icons.add))),

                      ],
                    )
                  ],
                ),
                Column(
                  children: [
                    SizedBox(

                      child:PopupMenuButton(itemBuilder: (context)=>[]),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text('$TotalTshirt\$', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),),

                  ],
                )
              ],
            ),

          ),
      Container(
            margin: EdgeInsets.all(10.0),
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),

            child: Row(
              children: [
                Column(
                  children: [
                    Container(
                      width: 100,
                      height: 130,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:AssetImage('Assests/Images/T-shirt-01.jpg'),
                              fit: BoxFit.fill
                          )
                      ),

                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 14),
                          child: Container(
                            width: 200,
                            height: 80,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text('Sport Dress', style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18
                                    ),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Color: '),
                                    Text('Black',style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),),
                                    Text('  Size: '),
                                    Text('M', style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(

                      children: [
                        CircleAvatar(child: IconButton(onPressed: (){

                          if(SportDressCounter<=0){
                            _onTapSportDressProductCounter.text='1'.toString();
                          }
                          if(SportDressCounter>1){
                            SportDressCounter--;
                            TotalSportDress=SportDressUnitPrice*SportDressCounter;
                            grandTotal-=SportDressUnitPrice;
                            _onTapSportDressProductCounter.text=SportDressCounter.toString();

                          }

                          setState(() {

                          });

                        }, icon: Icon(Icons.remove))),
                        SizedBox(

                            width: 30,
                            child: TextField(
                              controller: _onTapSportDressProductCounter,
                              textAlign: TextAlign.center,
                            )),
                        CircleAvatar(child: IconButton(onPressed: (){
                          if(SportDressCounter>=1) {
                            SportDressCounter++;
                            TotalSportDress = SportDressUnitPrice * SportDressCounter;
                            grandTotal+=SportDressUnitPrice;
                            _onTapSportDressProductCounter.text=SportDressCounter.toString();
                          }

                          setState(() {

                          });


                        }, icon: Icon(Icons.add))),

                      ],
                    )
                  ],
                ),
                Column(
                  children: [
                    SizedBox(

                      child:PopupMenuButton(itemBuilder: (context)=>[]),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text('$TotalSportDress\$', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),),

                  ],
                )
              ],
            ),

          ),
      Container(
          width: double.infinity,
          height: 50,
         // color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(

              children: [

                Text('Total Amount: ',style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),),
                SizedBox(
                  width: 180,
                ),
                Text('$grandTotal\$',style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),),
              ],
            ),
          ),
        ),
      ElevatedButton(
            onPressed: () {
              final message=SnackBar(content: Text("Congratulation...."));
              ScaffoldMessenger.of(context).showSnackBar(message);
            },
            child: Text(
              'CHECK OUT',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15)),
          ),
        ],
      ),


    );



  }



  @override
  void dispose(){
    _onTapPulloverProductCounter.dispose();
    _onTapTShirtProductCounter.dispose();
    super.dispose();


  }

  }


class ProductInformation{
 final ImageName;
 final ProductName;
 final ProductColor;
 final ProductSize;
  final UnitPrice;
ProductInformation(this.ImageName, this.ProductName, this.ProductColor, this.ProductSize, this.UnitPrice );
}