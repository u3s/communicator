# communicator
Educational web communicator project for learning Erlang. The purpose is to provide some exercise for students wishing to practice what they learned about Erlang and OTP.

# assumptions
1. main branch should contain excercise description and support materials but not solutions
2. excercise will be divided in parts (e.g. P1, P2) with different requirements on student knowledge
3. P1 requirements: Erlang syntax, writing and compiling simple programs, shell I/O handling, basic concurrency programs including message sending and receiving
4. P2 requirements: distributed Erlang, some Erlang build tool like rebar, OTP behavior, test framework: EUnit or CommonTest, TDD concept, 
5. P2 optional requirements: GUI creation in Erlang

# realization
## P1
1. write not yet a communicator
2. but a shell program capable of receiving user input and displaying some response
3. just a stub - program could be echoing back the user input or returning a some interesting variant of it
4. distribute work between more than 1 process - communicate succesfully between them
5. learn to share source code with others
6. optional: implement the simplest chatbot

DoD:
communicator can:
1. be started
2. receive input message sample format {recipient :: pid()|atom(), message}
3. respond with something (e.g. echo server, simple chatbot)
4. communicator:add_user(adrian)
5. communicator:send_message(Recipient, Message)
6. communicator:receive_next_message()

## P2 - Erlang distributed
1. start with adding tests for P1 implementation
2. add selected build tool to project
2. extend P1 further by adding conectivity with other Erlang nodes
3. communicator should enable talking between different machines running Erlang
4. discuss the plan for achieving that communicator capability (using OTP behaviors and Erlang distribution is recommended)
   - how the program should be started on each machines? can you automize that somehow?
   - how the programs shall discover each other?
   - do you want to handle named/identifable users anyhow? this will reassemble real communicator but will bring complexity to the project, because you will need to maintain user database somehow
   - how many users will supported in single chats?
   - how many chats will be supported in parallel?
5. optional: add GUI for web communicator

## P3 - communication over sockets
1. TBD

# references
1. https://web.njit.edu/~ronkowit/eliza.html

# tasks
- [x] @u3s draft of README
- [ ] discuss test driven approach - if YES, what tests should be provide - write test slogans, write tests?
- [ ] review README
- [ ] discuss where solutions could be stored: definetely not main, but maybe a fork or a branch ?
- [ ] discuss - testing with distributed Erlang might not be trivial - probably would require a skeleton for writing tests
