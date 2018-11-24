---
title: Configurando seu Emacs com Literate Programming
date: 2017-03-25T20:39:33
tags: emacs
---

Para quem ainda não ouviu falar, [Org-mode](http://orgmode.org/) é um mode para [Emacs](https://www.gnu.org/software/emacs/) que permite que você faça uma série de tarefas em texto puro, como por exemplo: manter TODO lists, planejar projetos, criar documentos e muito mais. Além disso você pode exportar para vários formatos, como PDF, HTML, txt, tex e outros. Sério, você pode fazer QUASE tudo com isso. O suporte a tabelas é simplesmente animal, de uma olhada.

Esse post irá abordar como podemos executar código dentro de um documento .org e como usar isso para organizar as configurações do nosso Emacs.

<!-- more -->

Para começar vamos dando uma olhada em um documento .org:

```
* Introdução (tipo h1 no HTML)
  Esse capítulo tem como objectivo explicar como
  lançar um foguete para o *espaço*
```

** Contextualização (tipo h2 no HTML)
Como você pode ver, é bem similar a um arquivo no formato Markdown. Assim como nesse formato, podemos introduzir um trecho de código:


```
   #+BEGIN_SRC ruby
	 def fac(n)
	   (1..n).inject(:*) || 1
	 end
   #+END_SRC
```

Veja um exemplo em execução:

![](https://www.dropbox.com/s/80ir5bcw1qrza21/org-mode-code.gif?raw=1)

Para inserir um novo bloco de código você pode digitar `<s <TAB>` que será completado o restante para você. Após isso é preciso informar a linguagem, por exemplo, Ruby. Uma vez com o cursor dentro do bloco de código você pode ativar `C-'` para ir para o modo de inserção, e novamente `C-'` para salvar e sair.

Isso é possível graças ao pacote [babel](http://orgmode.org/worg/org-contrib/babel/). Com ele você pode adicionar código (várias linguagens) dentro de um documento .org. Esse tipo de capacidade torna, forneceida pelo babel, torna Org-mode uma ferramenta poderosa para Literate Programming e Reproducible Research.

O que nos leva a forma como vamos organizar a configuração do Emacs.

## Literate Emacs Initialization

Babel fornece uma função chamada org-babel-load-file que recebe um arquivo .org e processa os códigos em Emacs Lisp encontrados no mesmo.

Dessa forma, tornando nossas configurações mais fáceis de entender e manter. Além disso, temos todas as funcionalidades presentes no Org-mode, como formatações, exportações, tags e muito mais.

Algumas pessoas preferem separar em vários arquivos a configuração do Emacs, eu fazia isso até semana passada. Na realidade, existem algumas coisas onde o melhor mesmo é um único arquivo.

Para começar usar isso na sua configuração, primeiro faça um backup do estado atual do seu .emacs.d (mv .emacs.d emacs.d.bkp) Feito isso, crie novamente o diretório, e adicione o arquivo init.d.

```
cd ~
mkdir .emacs.d
cd .emacs.d
touch init.el
```

Aadicione a seguninte linha de Emacs Lisp no init.el

```emacs-lisp
(org-babel-load-file "~/.emacs.d/configurations.org")
```

Agora criei o arquivo configurations.org, dentro de .emacs.d, e adicione o seguinte:

```org-mode
#+TITLE: My Emacs configurations

* Basic UI Configurations
  These customizations change the way emacs looks and disable/enable
  some user interface elements.

** Turn off the menu bar at the top of each frame because it's distracting

 #+BEGIN_SRC emacs-lisp
   (menu-bar-mode -1)
 #+END_SRC

** Don't show native OS scroll bars for buffers because they're redundant

 #+BEGIN_SRC emacs-lisp
   (when (fboundp 'tool-bar-mode)
	 (tool-bar-mode -1))
 #+END_SRC
* Org-mode
** Display preferences

*** Bullets instead of a list of asterisks.

   #+BEGIN_SRC emacs-lisp
	  (add-hook 'org-mode-hook
				(lambda ()
				  (org-bullets-mode t)))
   #+END_SRC

*** A pretty arrow instead of the usual ellipsis (...)

   #+BEGIN_SRC emacs-lisp
	 (setq org-ellipsis "⤵")
   #+END_SRC

*** Babel
   Enable languages

   #+BEGIN_SRC emacs-lisp
	 (org-babel-do-load-languages
	  'org-babel-load-languages '((ruby . t)))
   #+END_SRC
```

Após salvar e reiniciar o emacs, você verá algo como:

![](https://www.dropbox.com/s/rxvvdbj5yas5tqc/conforg.png?raw=1)

OBS: Lembrando que na configuração acima usei um pacote que precisa estar instalados: org-bullets-mode.

Seguindo esse padrão você pode estruturar sua configuração de uma forma muito descritiva e organizada. O arquivo configurations.org pode crescer bastante, dependendo de o quanto você customiza e configura novas coisas dentro do Emacs. Eu não vejo problema nisso, uma fez que no Org-mode podemos esconder as seções e deixar visível somente o necessário.

Era isso, meu .emacs.d pode ser encontrado [aqui](https://github.com/edipofederle/emacs.d), caso lhe interesse. Se você gostou desse post, ou tiver qualquer colocação a fazer, fique a vontade em deixar um comentário ou enviar uma mensagem no Twitter (@edipofederle).

= paz
