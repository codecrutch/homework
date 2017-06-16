import React from 'react';


const GiphysIndexItem = ({giphy}) => (
  <li><img src={giphy.images.fixed_height.url}/></li>
);

export default GiphysIndexItem;
