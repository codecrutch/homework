import React from 'react';


// NOT REALLY inflation, just used for example

const Inflated = ({name}) => {
  let url = `https://www.google.com/search?q=${name}+currency`
  return (
    <a href={url} className='inflated'>{name}</a>
  );
};

export default Inflated;
