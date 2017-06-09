import React from 'react';
import Clock from './clock/clock';
import Weather from './weather/weather';
import AutoComplete from './autocomplete/autocomplete';
import Tab from './tab/tab';

class Main extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    const names = ["Gino", "Dino", "Rick", "Morty",
  "Doc Martin", "Feelgood Smith"];

  const tabs = [
    {title: "One", content: "Bacon ipsum dolor amet beef ribs salami swine frankfurter cow burgdoggen boudin sirloin short ribs alcatra fatback ham hock brisket picanha meatball. Pork fatback swine salami hamburger. "},
    {title: "Two", content: "Leberkas t-bone pastrami fatback porchetta tenderloin jerky. Kevin pancetta tri-tip biltong meatloaf venison doner short ribs bresaola tongue."},
    {title: "Three", content: "Spare ribs chuck biltong flank corned beef beef ribs tail leberkas bacon brisket venison."}
  ];

    return (
      <div>
        <Clock />
        <Weather />
        <AutoComplete names={names} setParentState={this.setState.bind(this)} />
        <Tab tabs={tabs} />
      </div>
    );
  }
}

export default Main;
