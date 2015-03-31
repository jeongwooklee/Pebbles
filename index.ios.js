/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */
'use strict';

var React = require('react-native');
var {
  AppRegistry,
  StyleSheet,
  NavigatorIOS,
} = React;

var IndexView = require('./IndexView.ios');

var Pebbles = React.createClass({
  render: function() {
    return (
      <NavigatorIOS
        style={styles.navigatorIOS}
        initialRoute={{
          component: IndexView,
          title: 'Pebbles'
        }}
      />
    );
  }
});

var styles = StyleSheet.create({
  navigatorIOS: {
    flex: 1,
  },
});

AppRegistry.registerComponent('Pebbles', () => Pebbles);
