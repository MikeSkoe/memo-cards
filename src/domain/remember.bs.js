// Generated by ReScript, PLEASE EDIT WITH CARE

import * as View from "./view.bs.js";
import * as Stack from "./stack.bs.js";
import * as Belt_List from "rescript/lib/es6/belt_List.js";

var empty = {
  stack: Stack.empty,
  view: View.empty,
  iteration: 0
};

function addCard(t, card) {
  return {
          stack: Stack.Update.addCard(t.stack, card),
          view: t.view,
          iteration: t.iteration
        };
}

function startReview(t) {
  return {
          stack: t.stack,
          view: View.make(Stack.Selectors.getCards(t.stack, t.iteration)),
          iteration: t.iteration
        };
}

function next(t, known) {
  var review = t.view;
  if (!review) {
    return t;
  }
  var review$1 = review._0;
  var newReview = View.Update.next(review$1, known);
  var review$2 = review$1.reviewing;
  if (review$2 !== undefined) {
    return {
            stack: t.stack,
            view: /* Review */{
              _0: newReview
            },
            iteration: t.iteration
          };
  } else {
    return {
            stack: Stack.Update.updateCards(t.stack, Belt_List.concat(newReview.remember, newReview.forget)),
            view: /* Overview */0,
            iteration: t.iteration + 1 | 0
          };
  }
}

var Update = {
  addCard: addCard,
  startReview: startReview,
  next: next
};

export {
  empty ,
  Update ,
  
}
/* No side effect */
