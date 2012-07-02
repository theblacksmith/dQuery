#library("dQuery:tests");
#import("/projects/frameworks/dart/lib/unittest/unittest.dart");
#import("/projects/frameworks/dart/lib/unittest/html_enhanced_config.dart");
#import("/projects/frameworks/dart/lib/unittest/html_config.dart");
#import("dart:html");
#import("core.dart");

#source("ResultEnum.dart");
#source("TestResultsPanel.dart");
#source("test_config.dart");

class dQueryTestConfig extends Configuration
{
  TestResultsPanel resultsPanel;

  dQueryTestConfig(TestResultsPanel panel)
  {
    resultsPanel = panel;
  }

  void onTestResult(TestCase testCase)
  {
    resultsPanel.addResult(testCase);
  }

  void onDone(int passed, int failed, int errors, List results, String uncaughtError)
  {
    results.forEach((r) => onTestResult(r));
  }
}

class dQueryTests
{
  TestResultsPanel resultsPanel;

  String testHtml = '''
    <div id="content">
      <div id="text"></div>
    </div>
    
    <ul>
      <li>This</li>
      <li>is</li>
      <li>a</li>
      <li>simple</li>
      <li>list.</li>
    </ul>
    
    <span class='uniqClass'>This span has a unique class</span>
    
    <span class='repeatedClass'>These on the other hand, all have the same class</span>
    <span class='repeatedClass'>These on the other hand, all have the same class</span>
    <span class='repeatedClass'>These on the other hand, all have the same class</span>
''';

  dQueryTests(Element resultsContainer, Element testHtmlContainer) {
    resultsPanel = new TestResultsPanel(2);
    resultsContainer.elements.add(resultsPanel.panel);

    testHtmlContainer.innerHTML = testHtml;
    configure(new dQueryTestConfig(resultsPanel));
    useMyHtmlConfiguration();
  }

  void run()
  {
    test('Find by Id', (){
      var res = $('#content');
      expect(res.length, equals(1));
      expect(res[0].id, equals('content'));
      expect(res[0].tagName.toLowerCase(), equals('div'));
    });

    test('Find by Tag', (){
      var res = $('li');
      expect(res.length, equals(5));
      expect(res[0].tagName.toLowerCase(), equals('li'));
    });

    test('find by Class', (){
      var res = $('.uniqClass');
      expect(res.length, equals(1));

      res = $('.repeatedClass');
      expect(res.length, equals(3));
    });
  }
}