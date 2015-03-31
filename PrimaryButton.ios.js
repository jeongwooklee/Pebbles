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
        underlayColor='#bbd0e8'
        onPress={this.props.onPress}
      >
        <Text style={styles.buttonText}>{this.props.text}</Text>
      </TouchableHighlight>
    );
  }
});

var styles = StyleSheet.create({
  button: {
    paddingTop: 10,
    paddingBottom: 10,
    paddingLeft: 28,
    paddingRight: 28,
    borderWidth: 1,
    borderRadius: 4,
    borderColor: '#1e65b3',
  },
  buttonText: {
    color: '#1e65b3',
  },
});

module.exports = PrimaryButton;
