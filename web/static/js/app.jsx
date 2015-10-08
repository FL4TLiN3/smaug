
import Navbar from './navbar';
import Sidebar from './sidebar';
React.render(<Navbar />, document.getElementById('navbar'));
React.render(<Sidebar />, document.getElementById('sidebar'));


import Router from './router';
import Main from './main';
import Story from './story';

const router = new Router(document.getElementById('content'));
router
.route('/', Main)
.route('/stories/:id', Story)
.run();


