/*
 * This module handles high level data manipulations that manage the state consistency and integrity
 */

type t = {
    stack: Stack.t,
    view: View.t,
    iteration: Stack.iteration,
};

let empty: t = {
    stack: Stack.empty,
    view: View.empty,
    iteration: 0,
};

module Update = {
    let addCard = (t, card): t => {
        ...t,
        stack: t.stack->Stack.Update.addCard(card),
    }

    let startReview = t => {
        ...t,
        view: 
            t.stack
            ->Stack.Selectors.getCards(t.iteration)
            ->cards => switch cards {
                | list{} => View.empty
                | list{head, ...tail} => View.make(head, tail)
            }
    }

    let next = (t, known: bool) => switch t.view {
        | View.Review(review) => {
            let newReview = View.Update.next(review, known);

            switch newReview.reviewing {
                | Some(_) => {
                    ...t,
                    view: View.Review(newReview)
                }
                | None => {
                    iteration: t.iteration + 1,
                    stack: t.stack
                        ->Stack.Update.updateCards(newReview.remember)
                        ->Stack.Update.updateCards(newReview.forget),
                    view: View.Overview,
                }
            }
        }
        | View.Overview => t
    }
}

