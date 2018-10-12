import React, {Component} from 'react';
import moment from 'moment';
import {DatetimePickerTrigger} from 'rc-datetime-picker';
import * as ReactDOM from 'react-dom';

class App extends Component {
  constructor() {
    super();
    this.state = {
      moment: moment()
    };
  }

  handleChange = (moment) => {
    this.setState({
      moment
    });
  }

  render() {
    const shortcuts = {
      'Today': moment(),
      'Yesterday': moment().subtract(1, 'days'),
      'Clear': ''
    };

    let e = document.getElementById('popup-picker');
    const resource = e.getAttribute('data-type');

    return (
      <DatetimePickerTrigger
        shortcuts={shortcuts}
        moment={this.state.moment}
        onChange={this.handleChange}>
        <input className="form-control"
               type="text"
               name={`${resource}[occurred_at]`}
               value={(this.state.moment) ? this.state.moment.format('YYYY/MM/DD HH:mm') : ''}
               onChange={this.handleChange} />
      </DatetimePickerTrigger>
    );
  }
}

ReactDOM.render(
  <App />, document.getElementById('popup-picker')
);
