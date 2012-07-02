#import('dart:html');
#import('dQuery/core.dart');
#import('dQuery/tests.dart');

void main() {

  var resultCont = document.query('#results-container');
  var htmlCont = document.query('#testhtml-container');

  var trunner = new dQueryTests(resultCont, htmlCont);
  trunner.run();

}