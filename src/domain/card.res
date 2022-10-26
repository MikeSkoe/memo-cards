type text = string;

type level = New | Familiar | Remember | Know | Done;

type t = {
    front: text,
    back: text,
    level: level,
};

let empty: t = { front: "", back: "", level: New };

let make = (~front, ~back, ~level): t => { front, back, level };

module Update = {
    let next = t => switch t.level {
        | New => { ...t, level: Familiar }
        | Familiar => { ...t, level: Remember }
        | Remember => { ...t, level: Know }
        | Know => { ...t, level: Done }
        | Done => t
    }

    let back = t => switch t.level {
        | New => t
        | Familiar => { ...t, level: New }
        | Remember => { ...t, level: Familiar }
        | Know => { ...t, level: Remember }
        | Done => { ...t, level: Know }
    }
}

