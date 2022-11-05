// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Curry from "rescript/lib/es6/curry.js";
import * as State from "../state/state.bs.js";
import * as React from "react";
import * as Review from "./Review.bs.js";
import * as BoxComp from "./BoxComp.bs.js";
import * as Overview from "./Overview.bs.js";

import './app.css'
;

function classnames(_list, _acc) {
  while(true) {
    var acc = _acc;
    var list = _list;
    if (!list) {
      return acc;
    }
    var match = list.hd;
    if (match[1]) {
      _acc = acc + " " + match[0];
      _list = list.tl;
      continue ;
    }
    _list = list.tl;
    continue ;
  };
}

function App$Root(Props) {
  var view = Curry._1(State.AppState.useSelector, (function (param) {
          return param.view;
        }));
  if (typeof view === "number") {
    return React.createElement(Overview.make, {});
  } else if (view.TAG === /* InProgress */0) {
    return React.createElement(Review.make, {
                review: view._0
              });
  } else {
    return React.createElement(BoxComp.make, {
                cards: view._0,
                label: "Done"
              });
  }
}

var Root = {
  make: App$Root
};

function App(Props) {
  return React.createElement(State.AppState.Provider.make, {
              store: State.store,
              children: React.createElement(App$Root, {})
            });
}

var AppState;

var make = App;

export {
  AppState ,
  classnames ,
  Root ,
  make ,
  
}
/*  Not a pure module */
