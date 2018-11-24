---
title: Começando com Clojure e Emacs
date: 2017-03-25T20:39:33
tags: clojure, emacs, programming
---

Ei, tudo bem ?

Esse post tem como objetivo expor um passo-a-passo para quem tiver interesse em começar a utilizar a linguagem [Clojure](https://clojure.org) com o editor [Emacs](https://www.gnu.org/s/emacs/).

Esse post não requer nenhum conhecimento prêvio em nenhum dos dois topícos. Se você apenas ouviu falar em Clojure e Emacs e deseja começar a olhar para esses assunto, quem sabe esse conteúdo pode lhe ajude.

<!-- more -->

Antes de tudo vamos fazer uma lista do que você precisa instalar em seu computador para seguir:

## JVM - Java Virtual Machine

Pense nisso como o software que roda os programas escritos em Clojure. Caso você esteja usando Linux ou OS X é provável que você já tenha isso instalado. Verifique usando o seguinte comando:

`which java`

Se o comando anterior retornar algo como:

`/usr/bin/java`

Então você já tem o que precisa para seguir. Se você ver algo como java not found você precisa instalar a JDK na sua máquina. Siga esse link para isso.

## Leinigen - Ferramenta de build para Clojure

Você pode acessar a página do leinigen e ver as instruções de instalação para seu ambiente. O lein vai instalar a linguagem Clojure para você. Após isso você terá um novo comando disponível chamado lein.

Agora com tudo configurado podemos ir adiante e criar nosso primeiro projeto Clojure. Para isso, em seu terminal, execute o seguinte comando:

```
lein new hello-world
cd hello-world
```

O que o comando lein new hello-world faz é criar a estutura básica de um projeto clojure.

```
.
├── LICENSE
├── README.md
├── doc
│   └── intro.md
├── project.clj
├── resources
├── src
│   └── hello_world
│       └── core.clj
└── test
└── hello_world
└── core_test.clj
```

O primeiro arquivo importante é o project.clj. Seu conteúdo é o seguinte:

```clojure
(defproject hello-world "0.1.0-SNAPSHOT"
  :description "FIXME: write description"
  :url "http://example.com/FIXME"
  :license {:name "Eclipse Public License"
  :url "http://www.eclipse.org/legal/epl-v10.html"}
  :dependencies [[org.clojure/clojure "1.7.0"]])
```

Primeiramente temos o nome do nosso projeto e a versão, sem seguida algumas informações relavantes como uma descrição, url e a licença que seu projeto usa. O mais importante aqui, que você deve tomar atenção agora, é a última linha, dependencies: ela faz justamente o que você pensa, especifica quais as dependências seu projeto utiliza, até o momento temos apenas a própria linguagem Clojure na versão 1.7.0.

Vamos seguir em frente e dar uma olhada no próximo arquivo relevante para nós nesse ponto: `src\hello_world\core.clj`.

```clojure
(ns hello-world.core

(defn foo
 "I don't do a whole lot."
 [x]
 (println x "Hello, World!"))
```

Quando criamos o projeto `hello-world` a ferramenta `lein` já adicionou um código em nosso arquivo `core.clj`. Na linha `1` temos a definição do que chamamos de *namespace*. Se você vem do mundo Java pense nisso como um pacote. Nesse caso nosso namespacese chama-se `hello-world.core`.

Entre as linhas `3` e `6` temos a definição de uma função em Clojure. Na linha `3` nomeamos a função como `foo`. A linha `4` se chama **docstring** e é onde você descreve o que a função faz.

A linha `5` é onde especificamos os argumentos que a função vai receber, nesse caso apenas um: `x`. Por fim a linha `6` é o corpo da função propriamente dito. Aqui apenas estamos exibindo em tela o valor de `x` juntamente com a frase “Hello, World”.

Certo, entendi! Mas como faço para executar isso? Boa pergunta! Ainda lembra do **lein** certo? Agora vamos usar algo chamado **REPL**, que significa **READ**, **EVAL**, **PRINT**, **LOOP**. Vamos usar o **lein** para vermos na prática. No terminal:

`lein repl`

Após alguns segundos, você irá ver algo como:

```clojure
Clojure 1.7.0
Java HotSpot(TM) 64-Bit Server VM 1.7.0_79-b15
Docs: (doc function-name-here)
(find-doc "part-of-name-here")
Source: (source function-name-here)
Javadoc: (javadoc java-object-or-class-here)
Exit: Control+D or (exit) or (quit)
Results: Stored in vars *1, *2, *3, an exception in *e

user=>
```

Pense no **REPL** como um prompt onde você pode interagir com a linguagem e também com seu programa. Está vendo esse `user=>` ? É o *namespace* chamado `user`. Você pode confirmar isso executando e seguinte no **REPL**:

```
user=> *ns*
#namespace[user]
user=>
```

Nossa função `foo` encontra-se em outro *namespace* precisamos usar o `require` agora:

```
user=> (require 'hello-world.core)
nil
user=> (hello-world.core/foo "Jhon")
Jhon Hello, World!
nil
user=>
```

Agora teste usar o seguinte comando:

`user=> (doc map)`

Agora você já sabe como olhar para a documentação de um função que esteja com dúvidas.

Ótimo, conseguimos! Podemos parar por aqui, já que esse artigo não é sobre aprender a linguagem Clojure, de fato. O próximo arquivo que vamos olhar é o `test/hello_word/core_test.clj`.

```clojure
(ns hello-world.core-test
   (:require [clojure.test :refer :all]
			 [hello-world.core :refer :all]))

(deftest a-test
   (testing "FIXME, I fail."
   (is (= 0 1))))
```

Novamente, não vamos focar em detalhes, olhe para a linha `7`. Você pode ler essa linha como `0` É igual a `1`?. Vamos voltar para o terminal e novamente usar o **lein**, dessa vez para executar o(s) teste(s):

```
✝  ~/hello-world > lein test

lein test hello-world.core-test

lein test :only hello-world.core-test/a-test

FAIL in (a-test) (core_test.clj:7)
FIXME, I fail.
expected: (= 0 1)
actual: (not (= 0 1))

Ran 1 tests containing 1 assertions.
1 failures, 0 errors.
Tests failed.
Olhe para as seguintes linhas:

expected: (= 0 1)
actual: (not (= 0 1))
```

Por incrível que parece `0` não É igual a `1` :D. Você já sabe como fazer esse teste passar né? Abra o arquivo `test/hello_word/core_test.clj` modifique o teste de modo que ele passe e rode **lein** test novamente:

```
✘ ✝  ~/hello-world > lein test

lein test hello-world.core-test

Ran 1 tests containing 1 assertions.
0 failures, 0 errors.
```

Parabéns, você acaba de fazer seu primeiro teste em Clojure passar!

## Hora do Emacs

Até agora não utilizamos nenhuma editor de texto ou IDE para trabalhar em nosso projeto. Bem, isso não é totalmente verdade, afinal você usou algo para corrigir o teste anteriror, certo?. Agora vamos configurar um ambiente mínimo para trabalhar com clojure utilizando o editor Emacs. Vamos utilizar o Emacs juntamente com o **CIDER** (Clojure Interactive Development Environment that Rocks).

Primeiramente você precisa instalar o Emacs, claro. Novamente, se você estiver no OS X, baixe e instale usando esse link. Se estiver no Linux, Ubuntu por exemplo, você pode dar uma olhada aqui. Por fim, se estiver no Windows olhe aqui.

Aqui estarei usando OS X, o que deve servir igualmente para o Linux. Infelizmente não sei como isso tudo se comporta em Windows, então, me desculpe. Ao iniciar o Emacs você irá ver a seguinte tela:

![](https://www.dropbox.com/s/bt9qlg4goyo56ml/emacs-initial.png?raw=1)


Em destaque na imagem acima temos:

**Nome do Buffer** - Todo trabalho feito dentro do Emacs ocorre em Buffers. Ao iniciar o emacs somos automaticamente postos no buffer chamado GNU Emacs.

**mode** - Buffers possui um modo (mode), esse modo determina o comportamento do editor enquanto está no buffer atual. O modo mais básico e menos especializado é o Fundamental.

**minibuffer** - É de onde o Emacs lê comando mais complexo, como nomes de arquivos, comandos do próprio Emacs ou expresões Lisp.

### Comandos básicos

Abaixo uma pequena lista de alguns poucos comandos para você começar no Emacs:

**C-x b** - Mudar entre buffers. Utilize esse comando e o nome do buffer desejado (o mesmo para criar um novo)

**C-x b** - Para abrir um arquivo. Use TAB para autocompletar

**C-x C-s** - Para salvar um buffer, criando assim um arquivo

**C-X C-f** - Para criar um arquivo novo. Utilize esse comando e entre com o caminho para o novo arquivo. Use TAB para autocompletar

**M-w**   - Copiar (Kill-ring-save) onde M é a tecla Option no OS X ou Alt. Entretanto você pode usar o tradicional C-c

**C-y**   - Colar (Yank). Entretanto você pode usar o tradicional C-v

**C-X C-c** - Para sair

Por hora esses comandos são o suficiente.

### Configurações básicas

Agora vamos partir para a parte mais legal do Emacs: customizações. Mesmo o que vamos fazer aqui parecer extremamente simples, é um começo para você ter uma ideia do que é possível ser feito.

```emacs-lisp
;; Inibe tela 'inicial', *scratch* buffer será exibido
(setq inhibit-startup-screen t)

;; Remover a barra superior.
(when (fboundp 'tool-bar-mode)
(tool-bar-mode -1))

;; Removendo scroolbars nativas do OS, redundantes
(when (fboundp 'scroll-bar-mode)
(scroll-bar-mode -1))

;; Aumentar a fonte um pouco
(set-face-attribute 'default nil :height 130)

;; Fazer cursor parar de piscar
(blink-cursor-mode 0)

;; Mostrar o path completo para o arquivo na barra superior
(setq-default frame-title-format "%b (%f)")
```

Crie o arquivo ~/.emacs.d/init.el, use o próprio Emacs, utilize os comandos que você acabou de aprender, e adicione o conteúdo acima. Esse código é Emacs-Lisp e com ele você pode configurar tudo o que desejar no Emacs. Emacs-Lisp também é a linguagem usada para estender o editor com mais funcionalidades, como por exemplo outros modos (modes). Agora feche e abra novamente o Emacs. Ele vai se parecer com isso:

![](https://www.dropbox.com/s/igg6hkhu70s3zij/emacs-initial-2.png?raw=1)

Essas são apenas algumas configurações básicas, com o tempo você pode explorar mais e fazer as customizações que desejar. Vamos seguir em frente e configurar o CIDER em nosso Emacs.

Volte para o arquivo`~/.emacs.d/init.el`e adicione o seguinte no final do arquivo:

```emacs-lisp
;; ;; Packages

(require 'package)
(package-initialize)

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
	("marmalade" . "http://marmalade-repo.org/packages/")
	("melpa" . "http://melpa.org/packages/")))

;; instala o CIDER se ainda não estiver instalado
(unless (package-installed-p 'cider)
(package-install 'cider))
```

Reinicie o Emacs ou execute `M-x eval-buffer`. Esse comando irá avaliar o conteúdo completo do buffer atual.

Agora vamos acessar nosso projeto Clojure e iniciar o REPL usando o CIDER. Para isso, no Emacs, navegue até o diretório raiz do projeto `hello-world`. Utilize o comando `C-x f` para isso. Uma vez no diretório raiz, você verá algo assim:

![](https://www.dropbox.com/s/v1ohzc4wyecr5o4/emacs-project-files.png?raw=1)

Agora vamos finalmente conectar nosso projeto ao **REPL** utilizando o CIDER. Para isso utilize `M-x cider-jack-in`. Você deve ver algo assim:

![](https://www.dropbox.com/s/yll8nho9gvtiz43/emacs-cider-1.png?raw=1)


Agora que configuramos o CIDER em nosso Emacs, vamos navegar até o arquivo core.clj. Após isso vamos ajustar um pouco os buffers, para deixar do lado esquerdo o código fonte e do lado direito o REPL. Utilize `C-X 3` para dividir o editor em dois buffers verticais e `C-X` o para alternar para o buffer da direita. Por fim, `C-x b *cider-repl hello-world*` para abrir o buffer contendo o **REPL**.

![](https://www.dropbox.com/s/0l2rs7ei8v2hqxf/emacs-cider-2.png?raw=1)

Antes de continuar, vamos adicionar mais uma configuração ao arquivo `init.el`:


`(setq cider-repl-display-help-banner nil)`


Isso desabilita a exibição de ajuda ao inicial o CIDER.

Agora temos o REPL e nosso código em um mesmo local. Vá em frente e tente executar o seguinte no REPL.

```clojure
(+ 10 10 10) ; mesmo que 10 + 10 + 10
(apply + `[10 10 10]) ; soma todos os valores do vector
```

Altere para o código fonte, lembra como faz isso né? Vamos dar uma olhada em alguns comandos básicos que são essenciais para começar:

**C-C C-e**  - avaliar a expressão imediatamente após o cursor. O resultado será mostrado no *minibuffer* e também ao lado da expressão avaliada, como:

```clojure
(map (fn [x] (* 2 x)) `[2 4 6]) => (4 8 12)
```

**C-C M-e**  - mesmo que o comando acima, porém o resultado é enviado para o REPL

**C-c C-k**   - avalia todo o conteúdo do buffer

**C-c C-d d** - exibe a documentação para para a função sobre o cursor, o mesmo que (doc function). Posicione o cursor sobre a funcão que deseja visualizar a documentação e execute o comando. Você pode executar isso tanto em um buffer quanto no REPL

![](https://www.dropbox.com/s/74oj2wecswvnx65/emacs-cider-docs.png?raw=1)

**C-c M-n** - Mudar o namespace no REPL. Lembre-se que mudar para um namespace não avalia o conteúdo do mesmo. Para isso use o comando que você aprendeu anteriormente.

**C-c C-t p** - Para rodar os testes do projeto inteiro

**C-c C-t n** - Para rodar os testes apenas do namespace atual

**C-c C-q** - E claro, você precisa sair do CIDER um dia. Isso fecha o REPL

## Seguindo em frente

Esse post deu uma visão geral sobre como começar usar Clojure juntamente com o Emacs. Inicialmente foi mostrado como rodar Clojure em sua máquina, introduzindo o Leingen. Vimos como usar o lein para criar um projeto básico Clojure. Aprendemos o que é o **REPL** e o básico para utilizá-lo para explorar a linguagem e seu programa. Também introduzimos o editor Emacs, aprendendo alguns comandos básicos para sobrivivência nos primeiros dias. Realizamos algumas customizações no editor e instalamos o **CIDER**. Por fim aprendemos alguns comandos essenciais do **CIDER**

Você pode seguir olhando para os seguintes recursos:

[Why Functional Programming Matters](https://www.cs.kent.ac.uk/people/staff/dat/miranda/whyfp90.pdf)
[Emacs Rocks](http://emacsrocks.com)
[Clojure for the Brave and True](http://www.braveclojure.com)
[ClojureDocs](https://clojuredocs.org)

## Referências

http://leiningen.org
https://clojure.org
https://www.gnu.org/software/emacs/
https://github.com/clojure-emacs/cider
https://www.gnu.org/software/emacs/manual/eintr.htmlr
