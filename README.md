# TermoAtiva — Infraestrutura e Sistemas Operacionais

**Global Solution 2026.2 | FIAP | CitizenTech**

## 1. Sobre o projeto

O TermoAtiva é uma solução voltada ao monitoramento de calor urbano, integrando dados de sensores, uma API REST e recursos de apoio à população em situações de calor intenso.

Este repositório documenta a implantação da aplicação em um ambiente Windows Server 2022, utilizando Active Directory, DNS, IIS, monitoramento de desempenho e mecanismos de recuperação automática.

## 2. Arquitetura

Windows 11 (Host)
        |
        | Rede Host-Only - 192.168.56.0/24
        |
Windows Server 2022
        |
        +-- Active Directory: termoativa.local
        +-- DNS interno
        +-- IIS 10
        |     +-- Site: TermoAtiva
        |     +-- Porta: 8080
        |     +-- App Pool: TermoAtivaPool
        |
        +-- ASP.NET Core / .NET 8
        +-- Banco de dados SQLite
        +-- Performance Monitor
        +-- Windows Event Viewer

## 3. Tecnologias utilizadas

- Windows Server 2022
- Oracle VirtualBox
- Active Directory Domain Services
- DNS Server
- Internet Information Services (IIS 10)
- ASP.NET Core / .NET 8
- SQLite
- Windows PowerShell
- Performance Monitor
- Windows Event Viewer

## 4. Configuração do servidor

| Parâmetro | Valor |
|---|---|
| Hostname | TERMOATIVA-SRV |
| Domínio | termoativa.local |
| IP Host-Only | 192.168.56.10 |
| Máscara | 255.255.255.0 |
| Porta HTTP | 8080 |
| Site IIS | TermoAtiva |
| Application Pool | TermoAtivaPool |
| Diretório da aplicação | C:\Sites\TermoAtiva |

## 5. Segurança

A infraestrutura utiliza:

- Application Pool dedicado à aplicação.
- Permissões NTFS específicas para leitura e execução.
- Permissão de modificação nas pastas App_Data e logs.
- Regra de firewall para a porta TCP 8080.
- DNS integrado ao Active Directory com atualizações dinâmicas seguras.

## 6. Monitoramento

Foi configurado um coletor de desempenho chamado
TermoAtiva-Monitoramento.

Contadores monitorados:

- CPU: Processor(_Total)\% Processor Time
- Memória: Memory\Available MBytes
- Disco: PhysicalDisk(_Total)\% Disk Time

Intervalo de coleta: 15 segundos.

Também foi criado o alerta TermoAtiva-Alerta-CPU, com limite superior a 80% de utilização da CPU.

## 7. Recuperação automática

O Application Pool utiliza:

- AutoStart: True
- StartMode: AlwaysRunning
- Rapid-Fail Protection habilitada.

Foi realizada uma simulação de falha encerrando o processo de trabalho do IIS.

Resultados:

| Indicador | Resultado |
|---|---|
| PID anterior | 6448 |
| Novo PID | 2268 |
| HTTP após recuperação | 200 |
| Evento de auditoria | WAS 5011 |

A aplicação voltou a responder após a substituição do processo.

## 8. Testes realizados

| Teste | Resultado |
|---|---|
| Serviços DNS, NTDS, W3SVC e WAS | Running |
| Site IIS | Started |
| Application Pool | Started |
| API HTTP | 200 |
| Conexão Windows 11 -> Windows Server | TCP 8080 acessível |
| DNS termoativa.local (IPv4) | 192.168.56.10 |
| Monitoramento de desempenho | Running |
| Alerta de CPU | Running |
| Recuperação após falha simulada | Aprovada |

## 9. Evidências

As capturas de tela e registros técnicos da infraestrutura estão organizados no diretório evidencias/.

A documentação complementar está disponível em docs/infraestrutura.md.

## 10. Scripts

O diretório scripts/ contém comandos PowerShell utilizados para verificar o funcionamento da infraestrutura.

## 11. Observações técnicas

A máquina virtual possui duas interfaces:

- Host-Only: 192.168.56.10
- NAT: 10.0.2.15

O DNS interno foi validado pelo Windows 11. Registros auxiliares do Active Directory associados à interface NAT ainda requerem revisão.

## 12. Aplicação

API TermoAtiva — SOA & Web Services:

https://github.com/Musashi-Mabuti/TermoAtiva-SOA-WebServices

## 13. Contexto acadêmico

Projeto desenvolvido para a Global Solution 2026.2 da FIAP, no contexto do desafio CitizenTech.
