type action =
    | AddCard(Card.t)
    | Review
    | Remember
    | Forget;

let reducer = (t, action) => switch action {
    | AddCard(card) => t->Remember.Update.addCard(card)
    | Review => t->Remember.Update.startReview
    | Remember => t->Remember.Update.next(true)
    | Forget => t->Remember.Update.next(false)
}

let store = Remporium.makeStore(Remember.empty, reducer);

module AppState = Remporium.CreateModule({
    type action = action;
    type state = Remember.t;
});

