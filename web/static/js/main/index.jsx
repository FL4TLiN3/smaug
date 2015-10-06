
export var Main = React.createClass({
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
      <div>
        <div className="stories row">
          { this.state.stories.map(this.renderStory) }
        </div>
      </div>
    );
  },

  renderStory: function (story, i) {
    let background = {
      'backgroundImage': 'url("/images/' + story.cover + '")'
    };

    return (
      <div className="story-col-item col-md-6" key={ i }>
        <div className="story-wrapper">
          <div className="story" style={ background }>
            <div className="tag">{ story.tag }</div>
            <div className="info">
              <p className="author">{ story.author }</p>
              <p className="title">{ story.title }</p>
            </div>
          </div>
        </div>
      </div>
    );
  }
});

export default Main;

