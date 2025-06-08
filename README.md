# 📚 Portal do Aluno - Avaliação A2

Este repositório contém o projeto de um aplicativo acadêmico desenvolvido em Flutter, como parte das atividades da disciplina. O app simula funcionalidades típicas de um portal do aluno, permitindo visualizar boletim, grade curricular, realizar rematrícula, entre outros.

---

## 📁 Estrutura do Repositório

- escopo/ # Telas prototipadas
- json-api/ # Arquivo db.json que simula uma API REST com JSON Server
- portal_do_aluno/ # Projeto Flutter completo
  
---

## 🧩 Funcionalidades

O aplicativo contempla as seguintes telas e recursos:

- **Login**
  - Campos: e-mail e senha
- **Home**
  - Seis cards com navegação para:
    - Boletim (semestre atual)
    - Grade Curricular
    - Rematrícula Online
    - Situação Acadêmica
    - Análise Curricular
- **Boletim**
  - Exibição de disciplinas com notas, frequência e status
- **Grade Curricular**
  - Dropdown de cursos
  - Lista de períodos e suas disciplinas
- **Rematrícula**
  - Seleção de disciplinas disponíveis
  - Confirmação de matrícula
- **Situação Acadêmica**
  - Documentos entregues/pedentes e status da matrícula
- **Análise Curricular**
  - Progresso do curso em porcentagem
  - Lista de disciplinas concluídas e pendentes

---

## 🚀 Tecnologias Utilizadas

- **Flutter** (Dart)
- **JSON Server** para simular a API
- **Figma** para prototipação

---

## 🛠️ Como executar o projeto
API Fake (JSON Server):

Instale o json-server:

```
npm install -g json-server
```

Acesse a pasta json-api/
Rode:

```
json-server --watch db.json --port 3000
```

A API estará disponível em http://localhost:3000.

Flutter App:

Acesse a pasta portal_do_aluno/
Rode:
```
flutter pub get
flutter run
```

📌 Observações
As funcionalidades foram implementadas conforme o guia repassado pelo professor.
Este projeto é uma simulação acadêmica e não possui backend real.
