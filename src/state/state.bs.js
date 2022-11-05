// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Remember from "../domain/remember.bs.js";
import * as Remporium from "remporium/src/Remporium.bs.js";

function reducer(t, action) {
  if (typeof action === "number") {
    return Remember.startReview(t);
  } else if (action.TAG === /* AddCard */0) {
    return Remember.addCard(t, action._0);
  } else {
    return Remember.next(t, action._0);
  }
}

var store = Remporium.makeStore(Remember.empty, reducer);

var AppState = Remporium.CreateModule({});

export {
  reducer ,
  store ,
  AppState ,
  
}
/* store Not a pure module */
