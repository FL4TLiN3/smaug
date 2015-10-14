
import React from 'react';
import Story from '../main/story';

const StoryList = React.createClass({
  getInitialState: function () {
    let state = {};
    state.stories = [];
    if (this.getQueryParams().category) {
      state.category = this.getQueryParams().category;
    }

    return state;
  },

  getQueryParams: function () {
    let vars= [];
    let max = 0;
    let hash = "";
    let array = "";
    let url = window.location.search;

    hash  = url.slice(1).split('&');
    max = hash.length;
    for (var i = 0; i < max; i++) {
      array = hash[i].split('=');
      vars.push(array[0]);
      vars[array[0]] = array[1];
    }

    return vars;
  },

  componentDidMount: function () {
    let url;
    if (this.state.category) {
      url = '/api/stories?category=' + this.state.category;
    } else {
      url = '/api/stories';
    }

    $.ajax({
      method: 'GET',
      url: url,
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

export default StoryList;
