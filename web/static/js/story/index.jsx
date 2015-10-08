
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
      <div className="col-md-10 story">
        <div className="row">
          <div className="col-xs-12 cover">
            <img src={ '/images/' + this.state.cover } />
          </div>
          <header className="col-md-8 col-md-offset-2">
            <p className="tag">{ this.state.tag }</p>
            <p className="author">{ this.state.author }</p>
            <h1 className="title">{ this.state.title }</h1>
          </header>
          <p className="col-md-8 col-md-offset-2 content">{ this.state.description }</p>
        </div>
      </div>
    );
  }
});

export default Story;
