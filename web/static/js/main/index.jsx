
export var Main = React.createClass({
  getInitialState: function () {
    return {
      stories: []
    };
  },

  componentDidMount: function () {
    let stories = [];
    for (var i = 0; i < 20; i++) {
      stories.push({
        tag: 'Awesome Tag',
        title: 'foo',
        author: 'buzz',
        cover: 'story-cover-' + (i+1) + '.jpg'
      });
    }

    this.setState({ stories: stories });
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

