
const Story = React.createClass({
  getInitialState: function () {
    return {};
  },

  componentDidMount: function () {
    console.log(this.props);
    $.ajax({
      method: 'GET',
      url: '/api/stories/' + this.props[0],
      dataType: 'json'
    }).done((res, status) => {
      this.setState(res.data);
    });
  },

  render: function () {
    return (
      <div className="col-md-10 ">
        <div className="story" onClick={ this.showStory }>
          <div className="tag">{ this.state.tag }</div>
          <div className="info">
            <p className="author">{ this.state.author }</p>
            <p className="title">{ this.state.title }</p>
          </div>
        </div>
      </div>
    );
  }
});

export default Story;
