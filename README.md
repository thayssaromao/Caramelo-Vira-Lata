Este README descreve a implementação técnica do projeto **"Qual Vira-Lata é Você?"**, um quiz interativo desenvolvido em Swift. O foco deste documento é detalhar a arquitetura baseada em **View Code** e os desafios superados na transição para o framework **UIKit**.

---

## 🛠 Tecnologias e Arquitetura

O projeto foi construído utilizando **UIKit** de forma totalmente programática (sem o uso de Storyboards ou XIBs), seguindo o padrão de projeto **MVC (Model-View-Controller)** para garantir a separação de responsabilidades.

* **Linguagem:** Swift 5
* **Interface:** View Code com Auto Layout (`NSLayoutConstraint`)
* **Navegação:** `UINavigationController`
* **Persistência de Dados/Lógica:** `QuizManager` e `QuizResultManager`

---

## ✨ Features Implementadas

### 1. Fluxo de Quiz Dinâmico

A aplicação gerencia um conjunto de perguntas e respostas através do `QuizManager`. A interface se adapta automaticamente ao conteúdo de cada pergunta:

* **Geração Dinâmica de UI:** Em `DinamicView`, os botões de opção são criados e organizados programaticamente dentro de `UIStackViews` aninhadas (HStacks dentro de uma VStack) com base no número de opções fornecidas.
* **Feedback Visual:** Ao selecionar uma opção, o botão altera sua cor de fundo para verde, enquanto os demais sofrem um efeito de *dimming* (redução de opacidade para 0.5) antes de avançar para a próxima tela.

### 2. Sistema de Pontuação e Perfis

O `QuizResultManager` processa as escolhas do usuário para determinar um dos perfis: **Caramelo**, **Neguinho** ou **Chico**.

* **Lógica de Desempate:** Caso as respostas sejam muito variadas ou ocorra um empate, o sistema retorna o perfil **"Coitadolandia"**, incentivando o usuário a refazer o quiz.

### 3. Experiência de Usuário e Animações

* **Transições de Estado:** O `QuestionViewController` atua como uma tela de "transição/carregamento" entre as perguntas, utilizando um card animado que surge da parte inferior da tela com efeito de mola (`usingSpringWithDamping`).
* **Progressão:** Uma `UIProgressView` customizada acompanha o avanço do usuário ao longo das 10 perguntas.
* **Feedback Sonoro:** Integração com um `SoundManager` para tocar sons específicos ao clicar em botões e manter uma trilha de fundo em loop.
* **Animações Contínuas:** Uso de `CABasicAnimation` para criar rotações infinitas em elementos visuais (como o cachorro em espiral na tela inicial e de resultados).

### 4. Detalhamento de Resultados (Sheet Presentation)

Ao finalizar o quiz, o usuário pode clicar em um botão de seta para abrir uma `InfoSheetViewController`. Esta tela utiliza o `UISheetPresentationController` (detents `.medium()` e `.large()`) para exibir informações históricas e curiosidades sobre o vira-lata sorteado.

---

---

## 🚀 O Desafio do UIKit (View Code)

Este projeto marcou a transição do desenvolvimento declarativo (SwiftUI) para o imperativo com **UIKit**. Os principais desafios técnicos superados foram:

* **Ciclo de Vida da View:** Gerenciar corretamente o `loadView()` e `viewDidLoad()` para garantir que a hierarquia de views fosse montada antes das restrições de layout serem aplicadas.
* **Gerenciamento da Pilha de Navegação:** Implementação de lógica no `navigationController` para substituir view controllers (`setViewControllers`) em momentos específicos, evitando que o usuário voltasse para telas de carregamento intermediárias ao usar o botão "Back".
* **Reutilização de Componentes:** Criação de métodos como `configure(question:options:)` para permitir que a mesma `DinamicView` renderizasse conteúdos distintos sem a necessidade de múltiplas classes de view.

---

## 📁 Estrutura de Arquivos Principais

| Arquivo | Responsabilidade |
| --- | --- |
| `InitialViewController.swift` | Ponto de entrada, gerencia a animação inicial e início do som. |
| `QuestionViewController.swift` | Controla a animação do card de pergunta e o timer de transição. |
| `DinamicViewController.swift` | Gerencia a lógica de seleção de respostas e atualização da view. |
| `ResultViewController.swift` | Exibe o resultado final e coordena a apresentação do InfoSheet. |
| `QuizManager.swift` | Contém o modelo de dados e a lógica de cálculo de resultados. |
