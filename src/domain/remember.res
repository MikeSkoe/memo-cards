/*
 * This module handles high level data manipulations that manage the state consistency and integrity
 */

type t = {
    boxes: Stack.t,
    view: Selected.t,
    iteration: Stack.iteration,
};

let empty: t = {
    boxes: Stack.empty,
    view: Selected.empty,
    iteration: 0,
};

module Update = {
    let addCard = (t, card): t => {
        ...t,
        boxes: t.boxes->Stack.Update.addCard(card),
    }

    let startReview = t => {
        ...t,
        view: 
            t.boxes
            ->Stack.Selectors.getBoxes(t.iteration)
            ->Selected.make,
    }

    let next = (t, known: bool) => {
        ...t,
        view: Selected.Update.next(t.view, known),
    }
}

