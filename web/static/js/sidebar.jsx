
export var Sidebar = React.createClass({
  render: function () {
    return (
      <div className="col-md-2 sidebar">
        <div className="menu-title"><h3>Categories</h3></div>
        <ul>
          <li><i className="fa fa-500px"></i> 500px</li>
          <li><i className="fa fa-flickr"></i> Flickr</li>
          <li><i className="fa fa-500px"></i> 500px</li>
          <li><i className="fa fa-500px"></i> 500px</li>
          <li><i className="fa fa-500px"></i> 500px</li>
        </ul>
      </div>
    );
  }
});

export default Sidebar;
