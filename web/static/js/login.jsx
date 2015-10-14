
import React from 'react';

const Login = React.createClass({
  getInitialState: function () {
    return {
      email: '',
      password: ''
    };
  },

  hide: function () {
    Modal.hide();
  },

  handleChange: function (event) {
    var state = this.state;
    Object.keys(state).forEach(function (key) {
      if (key == event.target.name) state[key] = event.target.value;
    });
    this.setState(state);
  },

  handleKeyDown: function (event) {
    if (event.keyCode == 13) { this.submit(); }
  },

  loginViaGitHub: function () {
    location.href = '/auth/github';
  },

  submit: function () {
    if (this.isValid()) {
      $('#login-form').submit();
    }
  },

  render: function () {
    return (
      <div className="modal-content">
        <div className="modal-header">
          <button type="button" className="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 className="modal-title">Login</h4>
        </div>
        <div className="modal-body">
          <div className="login-body">
            <form id="login-form" action="/login" method="post">
              <div className="form-group">
                <label for="email">Email</label>
                <input
                  id="email"
                  type="email"
                  name="email"
                  className="form-control"
                  placeholder="Email"
                  value={ this.state.screenName }
                  onChange={ this.handleChange }
                  onKeyDown={ this.handleKeyDown } />
              </div>

              <div className="form-group">
                <label for="password">Password</label>
                <input
                  id="password"
                  type="password"
                  name="password"
                  className="form-control"
                  placeholder="Password"
                  value={ this.state.password }
                  onChange={ this.handleChange }
                  onKeyDown={ this.handleKeyDown } />
              </div>

              <button type="submit" className="btn btn-default">
                <i className="fa fa-sign-in"></i> GO
              </button>

              <p className="forget-password">
                <a href="#"><i className="fa fa-key"></i> パスワードを忘れた方</a>
              </p>
            </form>

            <div className="form-group signup">
              <a className="btn btn-default" href="/signup">
                <i className="fa fa-user-plus"></i> アカウント登録
              </a>
            </div>
          </div>
        </div>
      </div>
    );
  }
});

export default Login;


