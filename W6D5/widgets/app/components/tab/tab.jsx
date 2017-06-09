import React from 'react';

class Tab extends React.Component {
  constructor(props) {
    super(props);

    this.state = { tabs: this.props.tabs, content: "" };
  }

  displayContent(tab) {
      this.setState({ content: tab.content});
  }

  render() {
    let tabs = this.state.tabs.map( (tab, idx) => <h2 key={idx} onClick={() => this.displayContent(tab)}>{tab.title}</h2>);

    return (
      <div className="widget tab">
        <div className="tab-headers">
          {tabs}
        </div>
      <article>
        {this.state.content}
      </article>
      </div>
    );
  }
}

export default Tab;
