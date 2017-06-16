import React from 'react';

import GiphysIndexItem from './giphys_index_item';

const GiphysIndex = ({giphys}) => {
  return (
    <div>
      <ul>
        { giphys.map( (giphy,idx) => <GiphysIndexItem giphy={giphy} key={idx} />) }
      </ul>
    </div>
  );
};

export default GiphysIndex;
