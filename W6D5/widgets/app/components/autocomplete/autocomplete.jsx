import React from 'react';

class AutoComplete extends React.Component {
  constructor(props) {
    super(props);

    this.state = { inputVal: "", filteredNames: this.props.names };
    this.changeInput = this.changeInput.bind(this);
  }

  clickName(name){
    this.filterNames(inputVal);
  }

  changeInput(e) {
    let inputVal = e.currentTarget.value;
    this.filterNames(inputVal);
  }

  filterNames(inputVal) {
    this.setState({ inputVal, filteredNames: this.props.names.filter((name) => name.toLowerCase().includes(inputVal.toLowerCase())) });
  }

  render() {
    let names = this.state.filteredNames.map( (name, idx) => <li onClick={() => this.clickName(name)} key={idx}>{name}</li>);

    return (
      <ul className="widget autocomp">
      <input onChange={this.changeInput} type="text" value={this.state.inputVal} />
        {names}
      </ul>
    );
  }
}

export default AutoComplete;
