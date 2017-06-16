import { RECEIVE_SEARCH_GIPHYS } from '../actions/giphy_actions';

let defaultState = [];

const giphyReducer = function(state = defaultState, action) {
  switch (action.type) {
    case RECEIVE_SEARCH_GIPHYS:
      return action.giphys;
    default:
      return state;
  }

};

export default giphyReducer;
