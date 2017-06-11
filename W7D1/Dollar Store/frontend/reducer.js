const initialState = {
  baseCurrency: "Please select",
  rates: {}
};

const reducer = (state = initialState, action) => {
  switch (action.type) {
      case 'SWITCH_CURRENCY':
      state = {
        baseCurrency: action.baseCurrency,
        rates: action.rates
      }
      break;
  }

  return state;
};

export default reducer;
