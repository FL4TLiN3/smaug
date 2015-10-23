
import React from 'react';

const Story = React.createClass({
  getInitialState: function () {
    return {};
  },

  componentDidMount: function () {
    $.ajax({
      method: 'GET',
      url: '/api/stories/' + this.props[0],
      dataType: 'json'
    }).done((res, status) => {
      this.setState(res.data);
    });
  },

  render: function () {
    if (!this.state.id) {
      return (
        <div className="col-md-10 story">
        </div>
      );
    }

    return (
      <div className="col-md-10 story">
        <div className="row">
          <div className="col-xs-12 cover">
            <img src={ '/images/' + this.state.cover } />
          </div>
          <header className="col-md-8 col-md-offset-2">
            <p className="tag">{ this.state.tag }</p>
            <h1 className="title">{ this.state.title }</h1>
          </header>
          <p
            className="col-md-8 col-md-offset-2 content"
            dangerouslySetInnerHTML={{ __html: this.state.description.replace(/(\r\n|\r|\n)/g, '<br />') }}>
          </p>
        </div>
      </div>
    );
  }
});

export default Story;
