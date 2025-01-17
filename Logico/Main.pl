:- (initialization main).
:- style_check(-discontiguous).
:- style_check(-singleton).


:- include('Util.pl').
:- include('Texts.pl').
:- include('User.pl').
:- include('Info.pl').
:- include('Filme.pl').
:- include('DashBoard.pl').
:- include('Serie.pl').


main :-
    read_file_to_string('files/logo.txt',Logo,[]),
    writeln(Logo),
    menu_principal,
    halt.

menu_principal :- 
    opcoesMenuPrincipal,
    readStringInput(Opcao),
    escolheOpcoesMenuPrincipal(Opcao).

escolheOpcoesMenuPrincipal() :- invalidOptionMsg, menu_principal.
escolheOpcoesMenuPrincipal("1") :- update_user.
escolheOpcoesMenuPrincipal("2") :- tela_cadastro_midia.
escolheOpcoesMenuPrincipal("3") :- tela_assistir_midia.
escolheOpcoesMenuPrincipal("4") :- tela_busca.
escolheOpcoesMenuPrincipal("5") :- dashBoard.
escolheOpcoesMenuPrincipal("6") :- tela_recomendacoes.
escolheOpcoesMenuPrincipal("7") :- tela_lista_avaliacoes.
escolheOpcoesMenuPrincipal("8") :- read_file_to_string('files/xau.txt',Xau,[]),
                                   writeln(Xau),halt.

% Metodo responsavel por retornar a uma funcao especifica X, 
% ou persistir em caso de opcao invalida.
retorna("S", X) :- X.
retorna(_, X) :- msgDigiteS, readStringInput(Opcao), retorna(Opcao, X).

%Update do usuario
update_user :- 
    pedeNomeUsuarioMsg,
    readStringInput(Nome),
    recebeNomeUsuario(Nome).

recebeNomeUsuario("V") :- menu_principal.
recebeNomeUsuario(Nome) :- 
    pedeCPFUsuarioMsg,
    readStringInput(CPF),
    recebeCPFUsuario(Nome, CPF).

recebeCPFUsuario(_,"V") :- menu_principal.
recebeCPFUsuario(Nome, CPF) :- 
    pedeIdadeUsuarioMsg,
    readStringInput(Idade),
    recebeIdadeUsuario(Nome, CPF, Idade).

recebeIdadeUsuario(_,_,"V") :- menu_principal.
recebeIdadeUsuario(Nome, CPF, Idade) :- 
    pedeSexoUsuarioMsg,
    readStringInput(Sexo),
    recebeSexoUsuario(Nome, CPF, Idade, Sexo).

recebeSexoUsuario(_,_,_,"V") :- menu_principal.
recebeSexoUsuario(Nome, CPF, Idade, Sexo) :- 
    pedeGeneroFavoritoMsg,
    readStringInput(GeneroFavorito),
    recebeGeneroFavorito(Nome, CPF, Idade, Sexo, GeneroFavorito).

recebeGeneroFavorito(_,_,_,_,"V") :- menu_principal.
recebeGeneroFavorito(Nome, CPF, Idade, Sexo, GeneroFavorito) :- 
    pedeFilmeFavoritoMsg,
    readStringInput(FilmeFavorito),
    recebeFilmeFavorito(Nome, CPF, Idade, Sexo, GeneroFavorito, FilmeFavorito).

recebeFilmeFavorito(_,_,_,_,_,"V") :- menu_principal.
recebeFilmeFavorito(Nome, CPF, Idade, Sexo, GeneroFavorito, FilmeFavorito) :- 
    pedeSerieFavoritaMsg,
    readStringInput(SerieFavorita),
    %metodo q faz update
    fazUpdateUser(Nome, CPF, Idade, Sexo, GeneroFavorito, FilmeFavorito, SerieFavorita).

fazUpdateUser(Nome, CPF, Idade, Sexo, GeneroFavorito, FilmeFavorito, SerieFavorita):-
   atualizaUser(Nome, CPF, Idade, Sexo, GeneroFavorito, FilmeFavorito, SerieFavorita, Resumo),
   msgResumoUpdateUser(Resumo),
   readStringInput(Opcao),
   retorna(Opcao, menu_principal).

%Cadastro de midia 

tela_cadastro_midia :-
    opcoesCadastroMidia,
    readStringInput(Opcao),
    escolheOpcoesCadastroMidia(Opcao).

escolheOpcoesCadastroMidia("1") :- tela_cadastro_filme.
escolheOpcoesCadastroMidia("2") :- tela_cadastro_serie.
escolheOpcoesCadastroMidia("3") :- menu_principal.

%Cadastro de filme
tela_cadastro_filme :- 
    cadastroTituloFilmeMsg,
    readStringInput(Titulo),
    recebeTituloFilme(Titulo).

recebeTituloFilme("V") :- menu_principal.
recebeTituloFilme(Titulo) :- 
    cadastroDiretorFilmeMsg,
    readStringInput(Diretor),
    recebeDiretorFilme(Titulo, Diretor).

recebeDiretorFilme(_,"V") :- menu_principal.
recebeDiretorFilme(Titulo, Diretor) :- 
    cadastroLancamentoFilmeMsg,
    readStringInput(AnoDeLancamento),
    recebeLancamentoFilme(Titulo, Diretor, AnoDeLancamento).

recebeLancamentoFilme(_,_,"V") :- menu_principal.
recebeLancamentoFilme(Titulo, Diretor , AnoDeLancamento) :- 
    cadastroGeneroFilmeMsg ,
    readStringInput(Genero),
    recebeGeneroFilme(Titulo, Diretor, AnoDeLancamento, Genero).

recebeGeneroFilme(_,_,_,"V") :- menu_principal.
recebeGeneroFilme(Titulo, Diretor , AnoDeLancamento, Genero) :- 
    cadastroDuracaoFilmeMsg ,
    readStringInput(Duracao),
    recebeDuracaoFilme(Titulo, Diretor, AnoDeLancamento, Genero, Duracao).

recebeDuracaoFilme(_,_,_,_,"V") :- menu_principal.
recebeDuracaoFilme(Titulo, Diretor , AnoDeLancamento, Genero, Duracao) :- 
    cadastroProdutoraFilmeMsg ,
    readStringInput(Produtora),
    fazCadastroFilme(Titulo, Diretor, AnoDeLancamento, Genero, Duracao, Produtora).

fazCadastroFilme(Titulo, Diretor, AnoDeLancamento, Genero, Duracao,  Produtora):-
    %atualizaFilme( Titulo, Diretor, AnoDeLancamento, Genero, Duracao, 0 , 0, Produtora, 0, "Sem comentário", Resumo),
    cadastraFilme( Titulo, Diretor, AnoDeLancamento, Genero, Duracao, 0 , 0, Produtora, 0, "Sem comentário", Resumo),
    msgResumoCadastroFilme(Resumo),
    readStringInput(Opcao),
    retorna(Opcao, menu_principal).
%Cadastro de serie

tela_cadastro_serie :- 
    cadastroTituloSerieMsg,
    readStringInput(Titulo),
    recebeTituloSerie(Titulo).

recebeTituloSerie("V") :- menu_principal.
recebeTituloSerie(Titulo) :- 
    cadastroDuracaoEpisodioMsg,
    readStringInput(DuracaoMediaEpisodio),
    recebeDuracaoSerie(Titulo, DuracaoMediaEpisodio).

recebeDuracaoSerie(_,"V") :- menu_principal.
recebeDuracaoSerie(Titulo, DuracaoMediaEpisodio) :- 
    cadastroGeneroSerieMsg,
    readStringInput(Genero),
    recebeGeneroSerie(Titulo, DuracaoMediaEpisodio, Genero).
   
recebeGeneroSerie(_,_,"V") :- menu_principal.
recebeGeneroSerie(Titulo, DuracaoMediaEpisodio, Genero) :- 
    cadastroProdutoraSerieMsg ,
    readStringInput(Produtora),
    fazCadastroSerie(Titulo, DuracaoMediaEpisodio, Genero, Produtora).

fazCadastroSerie(Titulo, DuracaoMediaEpisodio, Genero,  Produtora):-
    cadastraSerie( Titulo, DuracaoMediaEpisodio, Genero, 0, 1, 0, "false", Produtora, -1, "Sem comentário", Resumo),
    msgResumoCadastroSerie(Resumo),
    readStringInput(Opcao),
    retorna(Opcao, menu_principal).

%Assistir mídia

tela_assistir_midia :-
    opcoesAssistirMsg,
    readStringInput(Opcao),
    escolheOpcoesAssistir(Opcao).

escolheOpcoesAssistir("1") :- tela_assiste_filme.
escolheOpcoesAssistir("2") :- tela_assiste_serie.
escolheOpcoesAssistir("3") :- menu_principal.

tela_assiste_filme:-
    listaFilmes,
    pedeIdFilmeMsg,
    readStringInput(Id),
    recebeIdFilme(Id).

recebeIdFilme("V") :- menu_principal.
recebeIdFilme(Id) :- 
    avaliacaoFilmeMsg,
    readStringInput(Avaliacao),
    recebeAvaliacaoFilme(Id, Avaliacao).

recebeAvaliacaoFilme(_,"V") :- menu_principal.
recebeAvaliacaoFilme(Id,Avaliacao) :- 
    pedeComentarioFilmeMsg,
    readStringInput(Comentario),
    concluiFilme(Id, Avaliacao, Comentario,R),
    writeln(R),
    tela_assistir_midia.
    

%concluiFilme(Id) :-
   %confirmacaoAssistirFilmeMsg.

 tela_assiste_serie:-
    listaSeries,
    pedeIdSerieMsg,
    readStringInput(Id),
    recebeIdSerie(Id).

recebeIdSerie("V") :- menu_principal.
recebeIdSerie(Id) :- 
    opcoesAssistirSerieMsg,
    readStringInput(Opcao),
    escolheOpcoesAssistirSerie(Id, Opcao).

escolheOpcoesAssistirSerie(Id,"1") :- finaliza_episodio(Id).
escolheOpcoesAssistirSerie(Id,"2") :- finaliza_temporada(Id).
escolheOpcoesAssistirSerie(Id,"3") :- finaliza_serie(Id).

finaliza_episodio(Id) :-
    concluiEpisodio(Id),
    episodioFinalizadoMsg,
    menu_principal.
    

finaliza_temporada(Id) :-
    concluiTemporada(Id),
    temporadaFinalizadaMsg,
    menu_principal.

finaliza_serie(Id) :-
    avaliacaoSerieMsg,
    readStringInput(AvaliacaoSerie),
    recebeAvaliacaoSerie(Id,AvaliacaoSerie).

recebeAvaliacaoSerie(_,"V") :- menu_principal.
recebeAvaliacaoSerie(Id,AvaliacaoSerie):- 
    pedeComentarioSerieMsg,
    readStringInput(ComentarioSerie),
    recebeComentarioSerie(Id,AvaliacaoSerie,ComentarioSerie).

recebeComentarioSerie(_,_,"V") :- menu_principal.
recebeComentarioSerie(Id,AvaliacaoSerie, ComentarioSerie) :-
    concluiSerie(Id, AvaliacaoSerie, ComentarioSerie),
    serieConcluidaMsg,
    menu_principal.


%Busca
tela_busca :-
    opcoesBuscaMsg,
    readStringInput(Opcao),
    escolheOpcoesBusca(Opcao).

escolheOpcoesBusca("1") :- tela_busca_filme.
escolheOpcoesBusca("2") :- tela_busca_serie.
escolheOpcoesBusca("3") :- menu_principal.

tela_busca_filme :-
    opcoesBuscaFilmeMsg,
    readStringInput(Opcao),
    escolheOpcoesBuscaFilme(Opcao).

escolheOpcoesBuscaFilme("1") :- busca_filme_titulo.
escolheOpcoesBuscaFilme("2") :- busca_filme_genero.
escolheOpcoesBuscaFilme("3") :- busca_filme_diretor.
escolheOpcoesBuscaFilme("4") :- busca_filme_produtora.
escolheOpcoesBuscaFilme("5") :- menu_principal.

busca_filme_titulo :-
    buscaTituloMsg,
    readStringInput(Titulo),
    buscaFilmePeloTitulo(Titulo),
    tela_busca.

busca_filme_genero :-
    buscaGeneroMsg,
    readStringInput(Genero),
    buscaFilmePeloGenero(Genero),
    tela_busca.

busca_filme_diretor :-
    buscaDiretorMsg,
    readStringInput(Diretor),
    buscaFilmePeloDiretor(Diretor),
    tela_busca.

busca_filme_produtora:-
    buscaProdutoraMsg,
    readStringInput(Produtora),
    buscaFilmePelaProdutora(Produtora),
    tela_busca.


tela_busca_serie :-
    opcoesBuscaSerieMsg,
    readStringInput(Opcao),
    escolheOpcoesBuscaSerie(Opcao).

escolheOpcoesBuscaSerie("1") :- busca_serie_titulo.
escolheOpcoesBuscaSerie("2") :- busca_serie_genero.
escolheOpcoesBuscaSerie("3") :- busca_serie_produtora.
escolheOpcoesBuscaSerie("4") :- menu_principal.

busca_serie_titulo :-
    buscaTituloMsg,
    readStringInput(Titulo),
    buscaSeriePeloTitulo(Titulo),
    tela_busca.

busca_serie_genero :-
    buscaGeneroMsg,
    readStringInput(Genero),
    buscaSeriePeloGenero(Genero),
    tela_busca.

busca_serie_produtora:-
    buscaProdutoraMsg,
    readStringInput(Produtora),
    buscaSeriePelaProdutora(Produtora),
    tela_busca.

%Recomendacoes

tela_recomendacoes :-
    opcoesRecomendacoes,
    readStringInput(Opcao),
    escolheOpcoesRecomendacao(Opcao).

escolheOpcoesRecomendacao("1") :- recomendacao_filme.
escolheOpcoesRecomendacao("2") :- recomendacao_serie.
escolheOpcoesRecomendacao("3") :- menu_principal.

recomendacao_filme :-
    recomendacaoDeFilmeMsg.
    %lista os filmes aqui.

recomendacao_serie :-
    recomendacaoDeSerieMsg.
    %lista as series aqui.

% Método que converte a entrada para string
readStringInput(Opcao) :- read_line_to_string(user_input, Entrada),
                                   string_chars(Entrada, Chars),
                                   delete(Chars, '.', Result),
                                   string_chars(String, Result),
                                   Opcao = String.
%DashBoard
dashBoard :- 
    dashBoardMainScreen(),
    readStringInput(Opcao),
    (Opcao == "1" -> dashBoardFilmes();
        Opcao == "2" -> dashBoardSeries();
            Opcao = "3" -> menu_principal; 
                invalidOptionMsg, dashBoard),
    
    writeln("\nOBS: Para voltar ao menu, digite qualquer tecla.\n"),
    readStringInput(Entrada),
    menu_principal.

%Lista de Avaliações

tela_lista_avaliacoes :-
    opcoesListaMsg,
    readStringInput(Opcao),
    escolheOpcoesListas(Opcao).

escolheOpcoesListas("1") :- avaliacoes_filme.
escolheOpcoesListas("2") :- avaliacoes_serie.
escolheOpcoesListas("3") :- menu_principal.

avaliacoes_filme:-
    listaDeFilmeMsg,
    % %lista film,
    % pedeIdFilmeAvaliacaoMsg,
    % readStringInput(Id).
    listaAvaliacoesFilmes,
    tela_lista_avaliacoes.

avaliacoes_serie:-
    listaDeSerieMsg,
    % %lista series,
    % pedeIdSerieAvaliacaoMsg,
    % readStringInput(Id).
    listaAvaliacoesSeries,
    tela_lista_avaliacoes.