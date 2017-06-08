class DOMNodeCollection {
  constructor(elements) {
    this.elements = elements;
  }

  html(html) {
   if (typeof html === "string") {
     this.forEach(node => node.innerHTML = html);
   } else {
     if (this.elements.length > 0) {
       return this.elements[0].innerHTML;
     }
   }
  }
  empty() {
    this.html('');
  }

  append(children) {
    if (this.elements.length === 0) return;

    if (typeof children === 'object' &&
        !(children instanceof DOMNodeCollection)) {
      // ensure argument is coerced into DomNodeCollection
      children = $l(children);
    }

    if (typeof children === "string") {
      this.forEach(node => node.innerHTML += children);
    } else if (children instanceof DOMNodeCollection) {
      // You can't appe  nd the same child node to multiple parents,
      // so we must duplicate the child nodes here.
      this.forEach(node => {
        // The argument to cloneNode indicates whether or not
        // all children should be cloned.
        children.forEach(childNode => {
          node.appendChild(childNode.cloneNode(true));
        });
      });
    }
  }

  attr(attribute, val) {
    if (val === undefined) {
      return this.elements[0].getAttribute(attribute);
    } else {
      for (var i = 0; i < this.elements.length; i++) {
        this.elements[i].setAttribute(attribute, val);
      }
    }
  }

  addClass(klass) {
    for (var i = 0; i < this.elements.length; i++) {
      this.elements[i].classList.add(klass);
    }
  }

  removeClass(klass) {
    for (var i = 0; i < this.elements.length; i++) {
      this.elements[i].classList.remove(klass);
    }
  }

  toggleClass(klass) {
    for (var i = 0; i < this.elements.length; i++) {
      this.elements[i].classList.toggle(klass);
    }
  }

  // TRAVERSAL, LIKE WHEN CURRY DBL DRIBBLES

  children() {
    let nodesList = [];
    for (let i = 0; i < this.elements.length; i++) {
      if (this.elements[i].children) {
        nodesList.push(this.elements[i].children);
      }
    }

    return new DOMNodeCollection(Array.from(nodesList[0]));
  }

  parent() {
    let nodesList = [];
    for (let i = 0; i < this.elements.length; i++) {
      console.log(this.elements[i].parentNode);
      if (this.elements[i].parentNode) {
        nodesList.push(this.elements[i].parentNode);
      }
    }

    return new DOMNodeCollection(nodesList);
  }

  find(selector) {
    let nodesList = [];
    for (var i = 0; i < this.elements.length; i++) {
      let child = this.elements[i].querySelectorAll(selector);
      if (child.length > 0) nodesList.push(child);
    }

    return new DOMNodeCollection(Array.from(nodesList[0]));
  }

  remove() {
    // PRODUCTION READY
    for (var i = 0; i < this.elements.length; i++) {
      this.elements[i].parentNode.removeChild(this.elements[i]);
    }

    this.elements = new DOMNodeCollection();
  }

  on(eventName, callback) {
   this.forEach(node => {
     node.addEventListener(eventName, callback);
     const eventKey = `jqliteEvents-${eventName}`;
     if (typeof node[eventKey] === "undefined") {
       node[eventKey] = [];
     }
     node[eventKey].push(callback);
   });
  }

  off(eventName) {
   this.forEach(node => {
     const eventKey = `jqliteEvents-${eventName}`;
     if (node[eventKey]) {
       node[eventKey].forEach(callback => {
         node.removeEventListener(eventName, callback);
       });
     }
     node[eventKey] = [];
   });
  }

  forEach(cb) {
    this.elements.forEach(cb);
  }
}




module.exports = DOMNodeCollection;
