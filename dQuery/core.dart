#library('core');

#import('dart:html');

// All dQuery objects should point back to these
var _rootdQuery;

dQuery $(selector, [context]) => new dQuery(selector, context, _rootdQuery);

class dQuery {

  // The current version of dQuery being used
  static String dquery = "0.1";

  // A simple way to check for HTML strings or ID strings
  // Prioritize #id over <tag> to avoid XSS via location.hash (#9521)
  static RegExp quickExpr = const RegExp(@'^(?:[^#<]*(<[\w\W]+>)[^>]*$|#([\w\-]*)$)');

  // Match a standalone tag
  static RegExp singleTag = const RegExp(@'^<(\w+)\s*\/?>(?:<\/\1>)?$');

  var context;

  // this[0] in jQuery
  var zero;

  List<Element> elements;

  String selector;

  int get length() {
    return elements.length;
  }

  Element operator [](int index) {
    return elements[index];
  }

  operator []=(int index, value) {
    if(elements.isEmpty() || index > elements.length)
      elements.add(value);
    else
      elements[index] = value;
  }

  static bool _initialized;

  _init() {
    if(_initialized == true)
      return;

    _initialized = true;
    _rootdQuery = new dQuery(document, null);
  }

  dQuery(selector, [context, rootjQuery]) :
    elements = new List<Element>()
  {
    _init();

    var match, elem, ret, doc;

    // Handle $(""), $(null), or $(undefined)
    if (selector == null || selector == "") {
      return;
    }

    // Handle $(DOMElement)
    if ( selector is Element ) {
      this[0] = this.context = selector;
      return;
    }

    // The body element only exists once, optimize finding it
    if ( selector === "body" && context == null && document.body != null) {
      this.context = document;
      this[0] = document.body;
      this.selector = selector;
      return;
    }

    // Handle HTML strings
    if (selector is String) {
      // Are we dealing with HTML string or an ID?
      if (selector.startsWith('<') && selector.endsWith('>') && selector.length >= 3 ) {
        // Assume that strings that start and end with <> are HTML and skip the regex check
        throw new NotImplementedException();
      } else {
        match = quickExpr.firstMatch(selector);
      }

      if ( match != null && match[2] != null) {
        // HANDLE: $("#id")
        this[0] = document.query(selector);
        this.context = document;
        this.selector = selector;
        return;

      // HANDLE: $(expr, $(...))
      } else if ( context is dQuery ) {
          elements = _queryAll(selector);
          this.context = context.context;
          this.selector = selector;
          return;

      // no context
      } else {
        this.context = document;
        this.selector = selector;
        this.elements = _queryAll(selector);
      }

    // HANDLE: $(function)
    // Shortcut for document ready
    } else if ( selector is Function) {
      ready(selector);
      return;
    }
  }

  List<Element> _queryAll(String querystr)
  {
    var nodes= document.queryAll(querystr);
    var list = new List<Element>();

    nodes.forEach((n) { if(n is Element) list.add(n); });
    return list;
  }

  ready(void handler(Event e)) {
    window.on.contentLoaded.add((e) => window.alert("hi"));
  }
}