import 'package:flutter/material.dart';
import 'model/catrgory.dart';
import 'dart:math';
import 'detail.dart';

const Color greenColor = const Color(0xffB5DE7F);
const Color orangeColor = const Color(0xffFFC729);
const Color redColor = const Color(0xffFF826E);
class DashboardPage extends StatefulWidget {

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  List<Category> category = [];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 2,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          drawer: new Drawer(),
          appBar: AppBar(

            bottom: TabBar(
              tabs: [
                Tab( child: new Text("خلال ٢٤ ساعة"),),
                Tab( child: new Text("خلال أسبوع"),),
              ],
            ),
            title: Text('لوحة التحكم'),
          ),
          body: TabBarView(
            children: [
              buildList(),
              buildList(),
            ],
          ),
        ),
      ),
    );

  }

  
  Widget buildList(){
    
    List<Widget> list = [];
    var rng = new Random();
    category.forEach((section){
      list.add(new ListTile(
        onTap: (){
          Navigator.of(context).push(new MaterialPageRoute(builder: (context)=>new DetailsPage(category: section,)));
        },
        leading: new Image.asset(section.icon),
        title: new Text(section.title),
        trailing: new Text( rng.nextInt(100).toString() + "%"),
      ));
      list.add(new Divider());
    });
    
    return new Container(
      padding: new EdgeInsets.all(16),
      child: new ListView(
        children: <Widget>[]..addAll(list),
      ),
    );
    
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initCategorys();
  }

  void initCategorys() {

    setState(() {
      category = [];
    });

    category.add(new Category(id: 1, title: "نوم", icon: "assets/category/sleeping.png", info: "النوم هو حالة طبيعية من الاسترخاء عند الكائنات الحية، وتقل خلاله الحركات الإرادية والشعور بما يحدث في المحيط، ولايمكن اعتبار النوم فقدانا للوعي, بل تغيرا لحالة الوعي ولا تزال الأبحاث جارية عن الوظيفة الرئيسية للنوم إلا أن هناك اعتقادا شائعا ان النوم ظاهرة طبيعية لإعادة تنظيم نشاط الدماغ والفعاليات الحيوية الأخرى في الكائنات الحية"));
    category.add(new Category(id: 2, title: "عمل", icon: "assets/category/network.png", info: "العمل أو الشغل مجهود إرادي واع يستهدف منه العامل أو المشتغل إنتاج السلع والخدمات لإشباع حاجاته، ومن هذا التعريف يتضح لنا أن مجهود الحيوانات أو مجهود الإنسان بغير هدف لا يعتبر عملا. ويحتاج العمل الناجح مجموعة من المعارف التي تتطلب تحصيلها تعليماً خاصاً تساعد في ادائه بطريقة صحيحة مناسبة لقبولهِ في المجتمع."));
    category.add(new Category(id: 3, title: "تنقل", icon: "assets/category/cityscape.png"));
    category.add(new Category(id: 4, title: "رعاية", icon: "assets/category/social-care.png"));
    category.add(new Category(id: 5, title: "عبادة", icon: "assets/category/worship.png"));
    category.add(new Category(id: 6, title: "تعلم", icon: "assets/category/think.png"));
    category.add(new Category(id: 7, title: "رياضة", icon: "assets/category/running.png"));
    category.add(new Category(id: 8, title: "تسوق", icon: "assets/category/cart.png"));
    category.add(new Category(id: 9, title: "التواصل", icon: "assets/category/video-conference.png"));
    category.add(new Category(id: 10, title: "صحة", icon: "assets/category/heart.png"));
    category.add(new Category(id: 11, title: "أخرى", icon: "assets/category/test.png"));
    setState(() {
      
    });
  }


}
