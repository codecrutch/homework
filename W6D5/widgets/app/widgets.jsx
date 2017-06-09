import React from 'react';
import ReactDOM from 'react-dom';
import Main from './components/main';

document.addEventListener("DOMContentLoaded", () => {
	const root = document.getElementById("main");
	ReactDOM.render(<Main />, root);
});
