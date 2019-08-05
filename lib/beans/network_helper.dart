import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url,this.locale);
  final String url,locale ;
  Future<List<Category>> getProducts() async {
    var response = await http.get(url,headers: {"lang": locale});
    if(response.statusCode == 200){
      String data = response.body;
      var jsonData= jsonDecode(data)['data']['categories'];
      List<Category> products = [];
      for(var p in jsonData){
        Category product = Category(p["id"], p["name"], p["image"] );
        products.add(product);

      }
      return products;

    }
    else{
      print('Error Occurs${response.statusCode}');
      return null;
    }
}
  Future<List<SliderHome>> getSlider()  async {
    var response = await http.get(url,headers: {"lang": locale});
    if(response.statusCode == 200){
      String data = response.body;
      var jsonData= jsonDecode(data)['data']['slider'];
      List<SliderHome> sliders = [];
      for(var s in jsonData){
        SliderHome slide = SliderHome(s["title"], s["details"],s["link"] ,s["image"] );
        sliders.add(slide);
      }
      return sliders;

    }
    else{
      print('Error Occurs${response.statusCode}');
      return null;
    }
  }
}

class AboutUsNetwork {
  AboutUsNetwork (this.url,this.locale);
  final String url,locale ;
  Future<List<PageAboutUs>> getPages() async {
    var response = await http.get(url,headers: {"lang": locale});
    if(response.statusCode == 200){
      String data = response.body;
      var jsonData= jsonDecode(data)['data']['pages'];
     // print(jsonData);
      List<PageAboutUs> pages = [];
      for(var p in jsonData){
        PageAboutUs page = PageAboutUs(p["id"], p["title"], p["desc"] );
        pages.add(page);

      }
      return pages;

    }
    else{
      print('Error Occurs${response.statusCode}');
      return null;
    }
  }
}
class ContactUsNetwork {
  ContactUsNetwork (this.url,this.locale);
  final String url,locale ;
  Future<List<PageContactUs>> getPages() async {
    var response = await http.get(url,headers: {"lang": locale});
    if(response.statusCode == 200){
      String data = response.body;
      //var jsonData= jsonDecode(data)['data']['site'];
      var jsonEmail= jsonDecode(data)['data']['site']["email"];
      var jsonPhone= jsonDecode(data)['data']['site']["phone"];
      var jsonMobile= jsonDecode(data)['data']['site']["mobile"];
      //print(jsonData);
      List<PageContactUs> pages = [];
      PageContactUs page = PageContactUs(jsonEmail,jsonPhone,jsonMobile );

      pages.add(page);
      //print('pages is $pages');

      return pages;
    }
    else{
      print('Error Occurs${response.statusCode}');
      return null;
    }
  }
}
class BranchesMapNetwork {
  BranchesMapNetwork (this.url,this.locale);
  final String url,locale ;
  Future<List<BranchInfo>> getPages() async {
    var response = await http.get(url,headers: {"lang": locale});
    if(response.statusCode == 200){
      String data = response.body;
      var jsonData= jsonDecode(data)['data']['branches'];
     // print('data is $jsonData');
      List<BranchInfo> pages = [];
      for(var p in jsonData){
        BranchInfo page = BranchInfo(p["name"], p["address"], p["phone"], p["lat"], p["lng"] );
        pages.add(page);

      }
      //print(pages);
      return pages;

    }
    else{
      print('Error Occurs${response.statusCode}');
      return null;
    }
  }
}
  class Category {
  final int id;
  final String name;
  final String image;

  Category(
  this.id,
  this.name,
  this.image,

  );
  }
class SliderHome{
  final String title;
  final String details;
  final String link;
  final String image;

  SliderHome(
      this.title,
      this.details,
      this.link,
      this.image
      );
}

class PageAboutUs {
  final int id;
  final String title;
  final String desc;

  PageAboutUs(
      this.id,
      this.title,
      this.desc,
      );
}

class PageContactUs {
  final String email;
  final String phone;
  final String mobile;

  PageContactUs(
      this.email,
      this.phone,
      this.mobile,
      );
}
class BranchInfo {

  final String name,address,phone ,lat,lng;

  BranchInfo(
     this.name,
      this.address,
      this.phone,
      this.lat,
      this.lng,
      );
}