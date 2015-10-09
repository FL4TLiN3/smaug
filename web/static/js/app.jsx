
import React from 'react';
import ReactDOM from 'react-dom';

import Navbar from './navbar';
import Sidebar from './sidebar';
ReactDOM.render(<Navbar />, document.getElementById('navbar'));
ReactDOM.render(<Sidebar />, document.getElementById('sidebar'));


import Router from './router';
import Main from './main';
import Story from './story';

const router = new Router(document.getElementById('content'));
router
.route('/', Main)
.route('/stories/:id', Story)
.run();


