import 'package:flutter/cupertino.dart';
import "package:dynamic_widget/dynamic_widget.dart";
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockBuildContext extends Mock implements BuildContext {}
void main() {
  MockBuildContext _mockContext = MockBuildContext();

  test('test ContainerWithoutClickEvent', () {
    String json = '''
{
  "type": "Container",
  "color": "#FF00FF",
  "alignment": "center",
  "child": {
    "type": "Text",
    "data": "Flutter dynamic widget",
    "maxLines": 3,
    "overflow": "ellipsis",
    "style": {
      "color": "#00FFFF",
      "fontSize": 20.0
    }
  }
}
  ''';


    var container = DynamicWidgetBuilder.build(json, _mockContext, null);


    expect(container is Container, true);
    container = container as Container;

    expect(container.alignment, Alignment.center);
    expect(container.color, const Color(0xFFFF00FF));
    expect(container.child is Text, true);

  });














}
