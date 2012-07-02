class TestResultsPanel {

  Element panel;
  Element progress;
  Element progressFill;
  Element resultList;

  int numberOfTests;
  int runnedTests;

  String _html = '''
    <div id="test-result-panel">
      <div id="test-progress">
        <h4>Progress</h4>
        <div id="progress-bar">
          <div id="progress-fill"></div>
        </div>
      </div>
      <h4>Results</h4>
      <ul id="result-list">
      </ul>
    </div>''';

  String _resultTemplate = '''
      <li class="test-result">
      <span class="test-name">{{name}}</span>
      <span class="test-result">{{result}}</span>
    </li>
    ''';

  TestResultsPanel(int numberOfTests)
  {
    panel = new Element.html(_html);
    progress = panel.query('#progress-bar');
    progressFill = progress.query('#progress-fill');
    resultList = panel.query('#result-list');
    runnedTests = 0;
    this.numberOfTests = numberOfTests;
  }

  void addResult(TestCase tcase) {
    runnedTests++;

    progressFill = document.query('#progress-fill');
    window.alert(progressFill.toString());
    progressFill.style.setProperty('width', '${(runnedTests / numberOfTests)*100} %');

    if(tcase.result == '_FAIL')
      progress.classes.add('error');

    resultList = document.query('#result-list');

    var resHtml = _resultTemplate
        .replaceFirst('{{name}}', '${tcase.description} ${tcase.message}' )
        .replaceFirst('{{result}}', tcase.result);
    window.alert(resHtml);
    var resEl = new Element.html(resHtml);

    resultList.elements.add(resEl);
  }
}