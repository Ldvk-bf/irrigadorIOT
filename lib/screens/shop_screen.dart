import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:irrigador/models/plant_model.dart';
import 'package:http/http.dart' as http;

class ShopScreen extends StatefulWidget {
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen>
    with SingleTickerProviderStateMixin {

  TimeOfDay selectedTime = TimeOfDay.now();
  bool isSwitched = true;
  late PageController _pageController;
  int _selectedPage = 0;
  int plantaIndex=0;


  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
  }

  _plantSelector(int index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = (_pageController.page! - index);
          value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 500.0,
            width: Curves.easeInOut.transform(value) * 400.0,
            child: widget,
          ),
        );
      },
      child: GestureDetector(
        onTap: () {},
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF32A060),
                borderRadius: BorderRadius.circular(20.0),
              ),
              margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 30.0),
              child: Stack(
                children: <Widget>[

                  Positioned(
                    left: 20.0,
                    top: 40.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          plants[index].name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      SizedBox(height: 20,),
                      Container(
                        width: 250,
                        decoration: BoxDecoration(
                          color: Colors.white30,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Automático",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Expanded(child: Container()),
                                  Switch(
                                    value: plants[index].automatico,
                                    onChanged: (value) async {
                                      String url  = 'http://192.168.0.132/gpio';
                                      http.Response response = await http.get(Uri.parse(url));
                                      setState(() {
                                        plants[index].automatico = value;
                                        print(plants[index].automatico);
                                      });
                                    },
                                    activeTrackColor: Colors.lightGreenAccent,
                                    activeColor: Colors.green,
                                  ),
                                ],
                              ),
                              if (plants[index].automatico) Row(
                                children: [
                                  Positioned(
                                    child: RawMaterialButton(
                                      padding: EdgeInsets.all(15.0),
                                      shape: CircleBorder(),
                                      elevation: 2.0,
                                      fillColor: Colors.black,
                                      child: Icon(
                                        Icons.access_time,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _selectTime(context);
                                        });
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 100,
                                      child: ListView.separated(
                                        padding: const EdgeInsets.all(8),
                                        itemCount: plants[index].horario.length,
                                        itemBuilder: (BuildContext context, int index2) {
                                          return Container(
                                            height: 30,
                                            color: Colors.white,
                                            child: Center(child: Text('Horário ${plants[index].horario[index2]}')),
                                          );
                                        },
                                        separatorBuilder: (BuildContext context, int index) => const Divider(),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ),
                      SizedBox(height: 20,),
                      Container(
                        width: 250,
                        decoration: BoxDecoration(
                          color: Colors.white30,
                          borderRadius: BorderRadius.circular(5)
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width*0.2,
                                  child: Text(
                                    "Tempo de regagem",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                TextButton(
                                  onPressed: ()=>{
                                    setState(() {
                                      plants[index].intervalo = (plants[index].intervalo! - 1);})
                                    },
                                  child: const Text(
                                    "-",
                                    style: TextStyle(fontSize: 15, color: Colors.white),
                                  ),
                                ),
                                Text(
                                  plants[index].intervalo.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextButton(
                                  onPressed: ()=>{
                                    setState(() {
                                      plants[index].intervalo = (plants[index].intervalo! + 1);
                                    })
                                  },
                                  child: Text(
                                    "+",
                                    style: TextStyle(fontSize: 15, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(0),
                            child: TextButton(
                              onPressed: ()=>{},
                              child: const Text(
                                "REGAR AGORA",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Text('Irrigador da Vovó Tereza'),
      ),
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 60.0),
          children: <Widget>[
            SizedBox(height: 20.0),
            Container(
              height: 600.0,
              width: double.infinity,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (int index) {
                  setState(() {
                    _selectedPage = index;
                  });
                },
                itemCount: plants.length,
                itemBuilder: (BuildContext context, int index) {
                  plantaIndex = index;
                  return _plantSelector(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      helpText: "Selecione a data desejada",
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,

    );
    if(timeOfDay != null && timeOfDay != selectedTime)
    {
      setState(() {
        selectedTime = timeOfDay;
        plants[plantaIndex-1].horario.add( selectedTime.hour>10 ? selectedTime.hour.toString() : "0"+selectedTime.hour.toString()+":"+(selectedTime.minute > 10 ? selectedTime.minute.toString() : "0"+selectedTime.minute.toString()));
        print(plants[plantaIndex-1].horario);
      });
    }
  }
}
