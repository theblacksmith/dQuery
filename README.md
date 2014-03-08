This is officially ABANDONED!
======
dQuery - jQuery for Dart
------

The aim of this project is to provide a jQuery like interface for [Dart](http://www.dartlang.org/)

For now there's only the $ function, but it does a lot! It's the basement for great things to come.

You already can do things like:

```
$('#alist li').forEach((Element e) window.alert(e.toString()));
```
So, stay tuned for more!

NOTE
----
To run the tests you'll need to edit the following lines in dQuery/tests.dart

```
#import("/projects/frameworks/dart/lib/unittest/unittest.dart");
#import("/projects/frameworks/dart/lib/unittest/html_enhanced_config.dart");
```

Change it to match the location of your dart lib folder
