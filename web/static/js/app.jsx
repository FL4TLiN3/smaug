import Main from './main';
import Navbar from './navbar';
import Sidebar from './sidebar';

const App = React.createClass({
  getInitialState: function () {
    return {};
  },

  render: function () {
    return (
      <div className="row">
        <Sidebar />
        <Main />
      </div>
    );
  }
});

React.render(<App />, document.getElementById('content'));
React.render(<Navbar />, document.getElementById('navbar'));
