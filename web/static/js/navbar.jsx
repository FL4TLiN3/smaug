
import React from 'react';
import Modal from './ui/modal';
import Login from './login';

const Navbar = React.createClass({
  getInitialState: function () {
    return {};
  },

  showLoginModal: function () {
    Modal.show(
      Login,
      { modal: true },
      {
        className: 'login',
        top: 100
      }
    );
  },

  render: function () {
    return (
      <nav className="navbar navbar-inverse">
        <div className="container-fluid">
          <div className="navbar-header">
            <button type="button" className="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
              <span className="sr-only">Toggle navigation</span>
              <span className="icon-bar"></span>
              <span className="icon-bar"></span>
              <span className="icon-bar"></span>
            </button>
            <a className="navbar-brand" href="/">The News</a>
          </div>

          <div className="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul className="nav navbar-nav navbar-right">
              <li><a onClick={ this.showLoginModal }>Login</a></li>
            </ul>
          </div>
        </div>
      </nav>
    );
  }
});

export default Navbar;
