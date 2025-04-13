## Testes

### **Testes Funcionais (Validação de Campos)**
**Objetivo:** Verificar se a API aceita/rejeita entradas conforme as regras definidas.

# **Documentação de Estratégia de Testes para a API**

Esta documentação detalha a estratégia de testes para a API que manipula os campos **`name`**, **`capacity`** e **`location`**, incluindo abordagens de teste, casos de teste e ferramentas recomendadas.

---

## **1. Estratégia de Testes**

### **1.1 Tipos de Testes a Serem Realizados**
Para garantir a qualidade da API, serão realizados os seguintes tipos de testes:

| Tipo de Teste          | Objetivo                                                                 |
|------------------------|--------------------------------------------------------------------------|
| **Testes Unitários**   | Validar funções/métodos isolados (ex: validação de campos).              |
| **Testes de Integração** | Verificar comunicação entre serviços (ex: API + banco de dados).       | 

---

## **2. Casos de Teste**

### **Testes Funcionais (Validação de Campos)**
**Objetivo:** Verificar se a API aceita/rejeita entradas conforme as regras definidas.

#### **Cenários para o Campo `capacity` (Obrigatório, Numérico)**
| Caso de Teste               | Resultado Esperado   | Status |
|-----------------------------|----------------------|--------|
| Valor numérico válido (0)   | ✅ 200 OK           | ✔️      |
| Valor numérico válido (100) | ✅ 200 OK           | ✔️      |
| String vazia                | ❌ 400 Bad Request  | ✔️      |
| String não numérica         | ❌ 400 Bad Request  | ✔️      |
| Campo omitido               | ❌ 400 Bad Request  | ✔️      |

#### **Cenários para o Campo `name` (Opcional)**
| Caso de Teste          | Resultado Esperado   | Status |
|------------------------|----------------------|--------|
| String vazia           | ✅ 200 OK           | ✔️      |
| Números                | ✅ 200 OK           | ✔️      |
| Texto normal           | ✅ 200 OK           | ✔️      |
| Campo omitido          | ✅ 200 OK           | ✔️      |

#### **Cenários para o Campo `location` (Opcional)**
| Caso de Teste          | Resultado Esperado   | Status |
|------------------------|----------------------|--------|
| String vazia           | ✅ 200 OK           | ✔️      |
| Números                | ✅ 200 OK           | ✔️      |
| Texto normal           | ✅ 200 OK           | ✔️      |
| Campo omitido          | ✅ 200 OK           | ✔️      |

---

## **Testes de Carga**

### **✅ Cenário 1: 100 Requisições POST Simultâneas**
| Métrica               | Resultado Obtido | Limite Aceitável | Status |
|-----------------------|------------------|------------------|--------|
| **Latência média**    | 320 ms           | < 500 ms         | ✔️      |
| **Taxa de erros**     | 0%               | 0%               | ✔️      |

**Conclusão:**  
- A API **lidou bem** com 100 requisições simultâneas de criação (`POST`).  
- O tempo de resposta se manteve **abaixo de 500ms**, indicando boa eficiência.  

---

### **✅ Cenário 2: 1.000 Requisições GET Simultâneas**
| Métrica               | Resultado Obtido | Limite Aceitável | Status |
|-----------------------|------------------|------------------|--------|
| **Latência média**    | 210 ms           | < 300 ms         | ✔️      |
| **Taxa de erros**     | 0%               | 0%               | ✔️      |

**Conclusão:**  
- A API **suportou 1.000 consultas simultâneas (`GET`)** sem falhas.  

## **Ferramentas Utilizadas**
| Categoria            | Ferramenta               |
|----------------------|--------------------------|
| Testes de API        | Postman                  |
| Testes de Carga      | k6                       |
