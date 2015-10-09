
import React from 'react';
import ReactDOM from 'react-dom';



import Router from './router';
import Navbar from './navbar';
import Sidebar from './sidebar';
import Main from './main';
import Story from './story';

ReactDOM.render(<Navbar />, document.getElementById('navbar'));
ReactDOM.render(<Sidebar />, document.getElementById('sidebar'));

const router = new Router(document.getElementById('content'));
router
.route('/', Main)
.route('/stories/:id', Story)
.run();

