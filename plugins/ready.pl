:- module(
     ready,
     [plugin/2]
   ).

:- use_module(prolord(config)).
:- use_module(prolord(util), [dbg/2, dbg/3]).


:- use_module(library(http/json)).
:- use_module(library(yall)).

plugin(raw("READY"), ready:ready_handler).

ready_handler(Msg) :-
    dbg(plugin(ready), "READY plugin, saving user id"),
    set_config(id, Msg.d.user.id),
    dbg(plugin(ready), "Guilds: ~w", [Guilds]),
    set_config(guilds, Guilds).
