'use strict';

var React = require('react-native');
var {
  NativeModules,
  ActivityIndicatorIOS,
  StyleSheet,
  Text,
  View,
} = React;

var PrimaryButton = require('./PrimaryButton.ios');
var TimerMixin = require('react-timer-mixin');

var INTERVAL = 50;
var STOP_BUTTON_TEXT = '결정하기';
var RESET_BUTTON_TEXT = '다시하기';

var Menupicker = React.createClass({
  mixins: [TimerMixin],
  getInitialState: function() {
    return {
      loaded: false,
      storeIndex: 0,
      selected: false,
      buttonText: STOP_BUTTON_TEXT,
    };
  },
  componentDidMount: function() {
    NativeModules.ParseManager.getRestaurants((response) => {
      this.setState({
        storeList: response,
        loaded: true,
      });
      this.setTimeout(this.changeStoreIndex, INTERVAL);
    });
  },
  changeStoreIndex: function() {
    var index = this.state.storeIndex + 1
    if (index >= this.state.storeList.length) {
      index = 0;
    }
    this.setState({
      storeIndex: index,
    });
    if (!this.state.selected) {
      this.setTimeout(this.changeStoreIndex, INTERVAL);
    }
  },
  getKeywordString: function() {
    var keywords = '';
    var index = this.state.storeIndex;
    var keywordArray = this.state.storeList[index][1];
    for (var word of keywordArray) {
      if (word !== this.state.storeList[index][1][0]) {
        word = ', ' + word;
      }
      keywords += word;
    }
    return keywords;
  },
  _onPressButton: function() {
    var _selected = !this.state.selected;
    var _buttonText = '';
    if (_selected) {
      _buttonText = RESET_BUTTON_TEXT;
    } else {
      _buttonText = STOP_BUTTON_TEXT;
      this.setTimeout(this.changeStoreIndex, INTERVAL);
    }
    this.setState({
      selected: _selected,
      buttonText: _buttonText,
    });
  },
  render: function() {
    if (!this.state.loaded) {
      return (
        <ActivityIndicatorIOS style={styles.container} />
      );
    } else {
      return (
        <View style={styles.container}>
          <Text style={styles.name}>{this.state.storeList[this.state.storeIndex][0]}</Text>
          <Text style={styles.keywords}>{this.getKeywordString()}</Text>
          <View style={styles.footer}>
            <PrimaryButton text={this.state.buttonText} onPress={this._onPressButton} />
          </View>
        </View>
      );
    }
  }
});

var styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#f8f8f8',
  },
  name: {
    fontSize: 20,
    marginBottom: 10,
  },
  keywords: {
    fontSize: 11,
    color: '#666666',
  },
  footer: {
    marginTop: 20,
  },
});

module.exports = Menupicker;
