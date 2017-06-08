const DOMNodeCollection = require('./dom_node_collection.js');

Window.prototype.$l = function(selector) {

  const queue = [];

  if (typeof selector === 'function') {
    queue.push(selector);
  }

  document.addEventListener("DOMContentLoaded", function(event) {
    queue.forEach( func => func());
  });

  if (typeof selector === 'string') {
    let nodes = document.querySelectorAll(selector);
    return new DOMNodeCollection(Array.from(nodes));
  } else if (selector instanceof HTMLElement) {
    return new DOMNodeCollection([selector]);
  }
};

$l.ajax = function(options) {
  console.log('AJAX REQUEST SENT');
};

$l.extend = function(...objects) {
  return Object.assign(...objects);
};


$l( () => {
  $('li').addClass('fwarriors');
});
