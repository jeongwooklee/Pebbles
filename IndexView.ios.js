'use strict';

var React = require('react-native');
var {
  StyleSheet,
  View,
} = React;

var RestaurantsView = require('./RestaurantsView.ios');
var PrimaryButton = require('./PrimaryButton.ios');

var IndexView = React.createClass({
  _onPressButton: function() {
    this.props.navigator.push({
      title: 'Restaurants',
      component: RestaurantsView,
    });
  },
  render: function() {
    return (
      <View style={styles.container}>
        <PrimaryButton text='오늘 뭐먹지?' onPress={this._onPressButton} />
      </View>
    );
  }
});

var styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#f8f8f8',
  },
});

module.exports = IndexView;
