var React = require('react-native');
var {
  StyleSheet,
  Text,
  TouchableHighlight,
} = React;

var PrimaryButton = React.createClass({
  render: function() {
    return (
      <TouchableHighlight
        style={styles.button}
        underlayColor='#2d918a'
        onPress={this.props.onPress}
      >
        <Text style={styles.buttonText}>{this.props.text}</Text>
      </TouchableHighlight>
    );
  }
});

var styles = StyleSheet.create({
  button: {
    padding: 10,
    borderWidth: 1,
    borderRadius: 2,
    borderColor: '#00aaa0',
    backgroundColor: '#00aaa0',
  },
  buttonText: {
    color: '#ffffff',
  },
});

module.exports = PrimaryButton;
