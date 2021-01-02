import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:convert' show json;

class ChinaPage extends StatefulWidget {
  @override
  _ChinaPageState createState() => _ChinaPageState();
}

class _ChinaPageState extends State<ChinaPage> {
  final String url = 'https://geo.datav.aliyun.com/areas_v2/bound/100000_full.json'; //全国点位详细信息
  Root data;

  @override
  void initState() {
    // getMapData();
    super.initState();
  }

  Future<void> getMapData() async {
    data = Root.fromJson((await Dio().get(url)).data);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('china'),
      ),
      body: Center(
        child: data == null
            ? SizedBox.shrink()
            : CustomPaint(
                painter: _ChinaPainter(data),
              ),
      ),
    );
  }
}

class _ChinaPainter extends CustomPainter {
  _ChinaPainter(this.data);

  Root data;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Rect.fromPoints(Offset.zero, Offset(size.width, size.height)));
    canvas.translate(size.width / 2, size.height / 2);
    print(data.features[0].geometry.coordinates[0][0][0][0]);
    print(data.features[0].geometry.coordinates[0][0][0][1]);
    canvas.translate(-data.features[0].geometry.coordinates[0][0][0][0], -data.features[0].geometry.coordinates[0][0][0][1]);
    canvas.translate(-560, 250);
    canvas.scale(6.5, -7.5);
    canvas.drawCircle(Offset.zero, 2, Paint()..color = Colors.redAccent);
    drawMap(canvas, size);
  }

  void drawMap(Canvas canvas, Size size) {}

  @override
  bool shouldRepaint(covariant _ChinaPainter oldDelegate) {
    return oldDelegate.data != data;
  }
}

void tryCatch(Function f) {
  try {
    f?.call();
  } catch (e, stack) {
    debugPrint('$e');
    debugPrint('$stack');
  }
}

T asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  if (value != null) {
    final String valueS = value.toString();
    if (0 is T) {
      return int.tryParse(valueS) as T;
    } else if (0.0 is T) {
      return double.tryParse(valueS) as T;
    } else if ('' is T) {
      return valueS as T;
    } else if (false is T) {
      if (valueS == '0' || valueS == '1') {
        return (valueS == '1') as T;
      }
      return bool.fromEnvironment(value.toString()) as T;
    }
  }
  return null;
}

class Root {
  Root({
    this.type,
    this.name,
    this.features,
  });

  factory Root.fromJson(Map<String, dynamic> jsonRes) {
    if (jsonRes == null) {
      return null;
    }
    final List<Features> features = jsonRes['features'] is List ? <Features>[] : null;
    if (features != null) {
      for (final dynamic item in jsonRes['features']) {
        if (item != null) {
          tryCatch(() {
            features.add(Features.fromJson(asT<Map<String, dynamic>>(item)));
          });
        }
      }
    }

    return Root(
      type: asT<String>(jsonRes['type']),
      name: asT<String>(jsonRes['name']),
      features: features,
    );
  }

  String type;
  String name;
  List<Features> features;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'type': type,
        'name': name,
        'features': features,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Features {
  Features({
    this.type,
    this.properties,
    this.geometry,
  });

  factory Features.fromJson(Map<String, dynamic> jsonRes) => jsonRes == null
      ? null
      : Features(
          type: asT<String>(jsonRes['type']),
          properties: Properties.fromJson(asT<Map<String, dynamic>>(jsonRes['properties'])),
          geometry: Geometry.fromJson(asT<Map<String, dynamic>>(jsonRes['geometry'])),
        );

  String type;
  Properties properties;
  Geometry geometry;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'type': type,
        'properties': properties,
        'geometry': geometry,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Properties {
  Properties({
    this.adcode,
    this.name,
    this.center,
    this.centroid,
    this.childrenNum,
    this.level,
    this.parent,
    this.subFeatureIndex,
    this.acroutes,
  });

  factory Properties.fromJson(Map<String, dynamic> jsonRes) {
    if (jsonRes == null) {
      return null;
    }
    final List<double> center = jsonRes['center'] is List ? <double>[] : null;
    if (center != null) {
      for (final dynamic item in jsonRes['center']) {
        if (item != null) {
          tryCatch(() {
            center.add(asT<double>(item));
          });
        }
      }
    }

    final List<double> centroid = jsonRes['centroid'] is List ? <double>[] : null;
    if (centroid != null) {
      for (final dynamic item in jsonRes['centroid']) {
        if (item != null) {
          tryCatch(() {
            centroid.add(asT<double>(item));
          });
        }
      }
    }

    final List<int> acroutes = jsonRes['acroutes'] is List ? <int>[] : null;
    if (acroutes != null) {
      for (final dynamic item in jsonRes['acroutes']) {
        if (item != null) {
          tryCatch(() {
            acroutes.add(asT<int>(item));
          });
        }
      }
    }

    return Properties(
      adcode: asT<String>(jsonRes['adcode']),
      name: asT<String>(jsonRes['name']),
      center: center,
      centroid: centroid,
      childrenNum: asT<int>(jsonRes['childrenNum']),
      level: asT<String>(jsonRes['level']),
      parent: Parent.fromJson(asT<Map<String, dynamic>>(jsonRes['parent'])),
      subFeatureIndex: asT<int>(jsonRes['subFeatureIndex']),
      acroutes: acroutes,
    );
  }

  String adcode;
  String name;
  List<double> center;
  List<double> centroid;
  int childrenNum;
  String level;
  Parent parent;
  int subFeatureIndex;
  List<int> acroutes;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'adcode': adcode,
        'name': name,
        'center': center,
        'centroid': centroid,
        'childrenNum': childrenNum,
        'level': level,
        'parent': parent,
        'subFeatureIndex': subFeatureIndex,
        'acroutes': acroutes,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Parent {
  Parent({
    this.adcode,
  });

  factory Parent.fromJson(Map<String, dynamic> jsonRes) => jsonRes == null
      ? null
      : Parent(
          adcode: asT<int>(jsonRes['adcode']),
        );

  int adcode;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'adcode': adcode,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Geometry {
  Geometry({
    this.type,
    this.coordinates,
  });

  factory Geometry.fromJson(Map<String, dynamic> jsonRes) {
    if (jsonRes == null) {
      return null;
    }
    final List<List<List<List<double>>>> coordinates = jsonRes['coordinates'] is List ? <List<List<List<double>>>>[] : null;
    if (coordinates != null) {
      for (final dynamic item0 in asT<List<dynamic>>(jsonRes['coordinates'])) {
        if (item0 != null) {
          final List<List<List<double>>> items1 = <List<List<double>>>[];
          for (final dynamic item1 in asT<List<dynamic>>(item0)) {
            if (item1 != null) {
              final List<List<double>> items2 = <List<double>>[];
              for (final dynamic item2 in asT<List<dynamic>>(item1)) {
                print(item2);
                if (item2 != null) {
                  final List<double> items3 = <double>[];
                  for (final dynamic item3 in asT<List<dynamic>>(item2)) {
                    if (item3 != null) {
                      tryCatch(() {
                        items3.add(asT<double>(item3));
                      });
                    }
                  }
                  items2.add(items3);
                }
              }
              items1.add(items2);
            }
          }
          coordinates.add(items1);
        }
      }
    }

    return Geometry(
      type: asT<String>(jsonRes['type']),
      coordinates: coordinates,
    );
  }

  String type;
  List<List<List<List<double>>>> coordinates;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'type': type,
        'coordinates': coordinates,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
