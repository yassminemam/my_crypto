# my_crypto

A new Flutter demo project for a simple crypto portfolio tracker where users can add, view, and
manage their cryptocurrency holdings.

## Key Features

1- Home Screen:
Display a list of all cryptocurrencies in the userʼs portfolio.
Each item shows the cryptocurrency symbol, quantity held, current price, and total value.
User can swipe from right to left to show delete and edit actions for each item in the list.

2-Add/Edit Holding Screen:
User can add a holding with fields for cryptocurrency symbol, and quantity.

## Used Flutter Pub Packages

flutter_riverpod: For state management and it's a reactive caching and data-binding framework.
Riverpod makes working with asynchronous code a breeze..

equatable: A Dart package that helps to implement value based equality without needing to explicitly
override == and hashCode.

dartz: Functional Programming in Dart. Purify your Dart code using efficient immutable data
structures, monads, lenses and other FP tools.

data_connection_checker_nulls: A pure Dart library that checks for internet by opening a socket to a
list of specified addresses, each with individual port and timeout. Defaults are provided for
convenience.

dio: A powerful HTTP networking package, supports Interceptors, Aborting and canceling a request,
Custom adapters, Transformers, etc.

pretty_dio_logger: Pretty Dio logger is a Dio interceptor that logs network calls in a pretty, easy
to read format.

git_it: For dependency injection and it's a simple direct Service Locator that allows to decouple
the interface from a concrete implementation and to access the concrete implementation from
everywhere in your App

flutter_screenutil: A flutter plugin for adapting screen and font size.Guaranteed to look good on
different models

go_router: A declarative router for Flutter based on Navigation 2 supporting deep linking,
data-driven routes and more

keyboard_actions: To add the Done button on iOS in case of numbers keyboard. Now you can add
features to the Android / iOS keyboard in a very simple way.

liquid_pull_to_refresh: A beautiful and custom refresh indicator with some cool animations and
transitions for flutter.

flutter_slidable: A Flutter implementation of slidable list item with directional slide actions that
can be dismissed.

hive: Lightweight and blazing fast key-value database written in pure Dart. Strongly encrypted using
AES-256.

hive_flutter: Extension for Hive. Makes it easier to use Hive in Flutter apps.

path_provider: Flutter plugin for getting commonly used locations on host platform file systems,
such as the temp and app data directories.

hive_generator: Extension for Hive. Automatically generates TypeAdapters to store any class.

## How To Build And Run Code
in debug mode
# Android
using terminal of flutter:

1- flutter clean
2- flutter pub get
3- flutter build apk --debug
4- flutter run

this will run the code on the device attached to your ide (android emulator or real device)

# iOS
(("only on mac machine"))
using terminal of flutter:

1- flutter clean
2- flutter pub get
3- flutter build ios --debug
4- flutter run

this will run the code on the iPhone simulator attached to your ide
