# Testes e Validação de Funcionalidades - Frontend

---

## 1. Objetivo dos Testes

Garantir que a interface web do sistema Belo Space atenda aos requisitos funcionais e não funcionais definidos, validando a experiência do usuário, a integração com o backend e a consistência dos dados exibidos na interface.

---

## 2. Estratégia de Testes

Os testes do frontend foram realizados manualmente, simulando o comportamento real do usuário. Foram validados aspectos de navegação, validação de campos, integração com API (Swagger) e persistência no banco de dados.

| Tipo de Teste             | Objetivo                                                                 |
|---------------------------|--------------------------------------------------------------------------|
| Testes Funcionais         | Validar se os componentes e funcionalidades funcionam conforme esperado |
| Testes de Integração      | Verificar se as interações entre frontend e backend estão corretas       |
| Testes de Navegação       | Confirmar que os fluxos de tela estão acessíveis e coerentes             |
| Testes de Validação       | Conferir tratamento de campos obrigatórios e mensagens de erro           |
| Testes de Carga (manual)  | Verificar o comportamento da interface sob múltiplas interações rápidas |

---

## 3. Cenários de Testes Funcionais

### 3.1. Registrar e realizar Login com Usuário válido

| Item                       | Descrição                                      |
|----------------------------|-----------------------------------------------|
| Tela                      | Login                                          |
| Funcionalidade Testada    | Registro e autenticação de usuário com dados válidos |
| Requisito Relacionado     | [RF01] Permitir que o usuário se registre e faça login no site |
| Resultado Esperado        | Pop up de sucesso e redirecionamento para a tela principal |
| Resultado Obtido          | Sucesso                                        |
| Observações               | Token JWT gerado e armazenado no navegador     |

#### Evidências

- **1. Cadastro de usuário:**

  ![register-form](img/Register_front_ok.png)
  
- **2. Login do usuário:**

  ![login-form](img/Login_front_ok.png)

- **3. Pop up Login bem sucedido:**

  ![login-popup](img/Login_front_pop_up.png)

- **4. Evidência Swagger Backend:**

  ![login-swagger](img/Login_swagger_ok.png)
  
- **5. Evidência Banco de Dados:**

  ![login-database](img/Login_bd_ok.png)

---

### 3.2. Reservar sala e gerenciar reservas

| Item                       | Descrição                                      |
|----------------------------|-----------------------------------------------|
| Tela                      | Agendar reserva e gerenciamento de reservas    |
| Funcionalidade Testada    | Realizar o agendamento e gerenciar as reservas |
| Requisito Relacionado     | [RF02] Permitir que o usuário consiga agendar e gerenciar suas reservas |
| Resultado Esperado        | Pop up de sucesso e redirecionamento           |
| Resultado Obtido          | Sucesso                                        |

#### Evidências

- **1. Reservar:**

  ![reservation-form](img/Reservation_front_form.png)
  
- **2. Gerenciar reserva:**

  ![reservation-management](img/Reservation_manage.png)

- **3. Pop up reserva bem sucedida:**

  ![reservation-popup](img/Reservation_pop_up.png)

- **4. Evidência Swagger Backend:**

  ![reservation-swagger](img/Reservation_swagger_ok.png)
  
- **5. Evidência Banco de Dados:**

  ![reservation-database](img/Reservation_bd_ok.png)

---

### 3.3. Reagendamento de reserva

| Item                       | Descrição                                      |
|----------------------------|-----------------------------------------------|
| Tela                      | Gerenciamento de reservas                      |
| Funcionalidade Testada    | Realizar o reagendamento da reserva           |
| Requisito Relacionado     | [RF03] Permitir que o usuário edite ou cancele suas reservas antes do horário agendado |
| Resultado Esperado        | Pop up de sucesso e redirecionamento para a tela de gerenciamento reservas |
| Resultado Obtido          | Sucesso                                        |

#### Evidências

- **1. Reagendar:**

  ![manage-form](img/Manage_front_form.png)

- **2. Reangedado:**

  ![manage-ok](img/Manage_front_ok.png)

- **3. Pop up reagendamento bem sucedido:**

  ![manage-popup](img/Manage_front_pop_up.png)

- **4. Evidência Swagger Backend:**

  ![manage-swagger](img/Manage_swagger_ok.png)
  
- **5. Evidência Banco de Dados:**

  ![manage-database](img/Manage_bd_ok.png)

---
### 3.4. Cancelamento de reserva

| Item                       | Descrição                                      |
|----------------------------|-----------------------------------------------|
| Tela                      | Gerenciamento de reservas                      |
| Funcionalidade Testada    | Realizar o cancelamento da reserva           |
| Requisito Relacionado     | [RF03] Permitir que o usuário edite ou cancele suas reservas antes do horário agendado |
| Resultado Esperado        | Pop up de sucesso e redirecionamento para a tela de reserva vazia |
| Resultado Obtido          | Sucesso                                        |

#### Evidências

- **1. Cancelar:**

  ![cancel-form](img/Cancel_front_form.png)

- **2. Pop up cancelamento bem sucedido:**

  ![cancel-popup](img/Cancel_front_pop_up.png)

- **3. Evidência Swagger Backend:**

  ![cancel-swagger](img/Cancel_swagger_ok.png)
  
- **4. Evidência Banco de Dados:**

  ![cancel-database](img/Cancel_bd_ok.png)

---

## 4. Estrutura de Evidências

Para cada funcionalidade testada, foram coletadas evidências em três momentos:

| Etapa Validada        | Evidência                                |
|------------------------|-------------------------------------------|
| Interface              | Print da ação ou estado na tela          |
| Integração             | Print do Swagger com a requisição        |
| Persistência           | Print do banco de dados                  |

---

## 5. Teste de Carga (Manual)

Foi realizada uma simulação manual de múltiplas interações rápidas com o frontend, acessando telas, preenchendo formulários e navegando entre componentes, com foco em:

- Verificar travamentos ou falhas de renderização
- Garantir que componentes são reativos
- Validar se chamadas à API se mantêm estáveis sob uso contínuo

**Observações:**
- A aplicação manteve o desempenho estável durante uso intenso local.
- Recomendado futuramente utilizar ferramentas como Lighthouse ou k6 para testes automatizados.

---

## 6. Considerações Finais

Todos os testes manuais realizados foram satisfatórios para as funcionalidades desenvolvidas até o momento.  
A integração entre frontend, backend e banco de dados foram evidenciados.  
Os fluxos principais (login, reserva, gerenciamento) apresentaram comportamento estável e coerente com os requisitos do projeto.
