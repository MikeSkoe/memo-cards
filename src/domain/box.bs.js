// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Belt_List from "rescript/lib/es6/belt_List.js";

function make(cards) {
  return {
          cards: cards
        };
}

function add(t, card) {
  return {
          cards: Belt_List.add(t.cards, card)
        };
}

var Update = {
  add: add
};

var empty = {
  cards: /* [] */0
};

export {
  empty ,
  make ,
  Update ,
  
}
/* No side effect */