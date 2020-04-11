:- [http_client].
:- [user_plugins/xkcd].
:- [user_plugins/reload].

:- use_module(library(http/json)).
:- use_module(library(http/json_convert)).
:- use_module(library(http/http_client)).
:- use_module(library(http/http_json)).
:- use_module(library(interpolate)).

:- multifile user_plugin/2.

handle_user_command(Msg) :-
    string_concat("::", Rest, Msg.d.content),
    split_string(Rest, " ", "", [Cmd|Args]),
    run_user_plugin(Cmd, Args, Msg).

run_user_plugin(Command, _, Msg) :-
    \+ user_plugin(Command, _),
    format(atom(Reply), "~s is not a valid command(run_user_plugin).", [Command]),
    reply(Msg, Reply).
run_user_plugin(Command, Args, Msg) :-
    user_plugin(Command, Handler),
    format("Calling plugin ~a\n", [Handler]),
    call(Handler, Args, Msg).

