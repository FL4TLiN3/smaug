
import React from 'react';
import Story from './story';

const Main = React.createClass({
  getInitialState: function () {
    return {
      stories: []
    };
  },

  componentDidMount: function () {
    $.ajax({
      method: 'GET',
      url: '/api/stories',
      dataType: 'json'
    }).done((res, status) => {
      this.setState({ stories: res.data });
    });
  },

  render: function () {
    return (
      <div className="col-md-10 main-stories row">
        { this.state.stories.map(function (story, i) {
          return <Story story={ story } key={ i } />
        })}
      </div>
    );
  }
});

export default Main;

