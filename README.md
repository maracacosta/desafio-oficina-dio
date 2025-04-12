
🛒 # **Projeto: Banco de Dados Oficina - Desafio Bootcamp Heineken**

📌## **Visão Geral**
Este projeto simula um banco de dados para a gestão de uma oficina mecânica, onde é possível registrar **clientes**, **veículos**, **ordens de serviço**, **funcionários**, **serviços realizados**, **pecas utilizadas** e **pagamentos**. O modelo relacional abrange todos os aspectos necessários para o controle das atividades e análises financeiras da oficina.

---

🧠 ## **Esquema Lógico do Banco de Dados**

O banco de dados foi desenvolvido com as seguintes **tabelas principais**:

- **Cliente**: Informações sobre os clientes (Pessoa Física e Jurídica) da oficina.
- **Veiculo**: Informações sobre os veículos dos clientes.
- **Funcionario**: Funcionários da oficina, incluindo suas especialidades.
- **Servico**: Detalhamento dos serviços oferecidos pela oficina.
- **Peca**: Peças utilizadas nos serviços de manutenção.
- **OrdemServico**: Registra as ordens de serviço criadas, incluindo status e datas.
- **OS_Servico**: Relaciona as ordens de serviço aos serviços realizados.
- **OS_Peca**: Relaciona as ordens de serviço às peças utilizadas.
- **Pagamento**: Registra os pagamentos efetuados pelos clientes.

---

🧪 ## **Consultas SQL Avançadas**

O banco de dados inclui consultas SQL avançadas para análise das operações da oficina. Algumas das principais consultas incluem:

1. **Quais ordens de serviço estão em aberto ou em andamento?**
   - Consulta as ordens de serviço que ainda não foram concluídas ou canceladas.

2. **Total de ordens por status com mais de 1 ocorrência (usando GROUP BY e HAVING).**
   - Agrupa e filtra os status das ordens de serviço, exibindo apenas aqueles com mais de uma ocorrência.

3. **Lista das peças utilizadas em cada ordem de serviço com seus custos totais (atributo derivado).**
   - Calcula o custo total das peças utilizadas em cada ordem de serviço.

4. **Funcionários que mais participaram de ordens de serviço (com soma de horas estimadas).**
   - Identifica os funcionários mais ativos na execução de serviços, somando as horas estimadas para cada ordem.

5. **Faturamento por forma de pagamento.**
   - Apresenta o total faturado por cada forma de pagamento.

6. **Valor estimado dos serviços por ordem de serviço (usando expressão derivada).**
   - Calcula o valor total estimado para cada ordem de serviço com base nos serviços realizados.

7. **Clientes PJ com veículos cadastrados.**
   - Filtra clientes do tipo PJ (Pessoa Jurídica) e lista seus respectivos veículos cadastrados.

---
👩‍💻 Sobre mim
Desenvolvido por Mara Costa como parte do aprendizado prático no bootcamp da DIO.

