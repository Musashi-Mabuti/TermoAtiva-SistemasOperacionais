# TermoAtiva — Infraestrutura Windows Server 2022

## Servidor
- Sistema operacional: Windows Server 2022
- Hostname: TERMOATIVA-SRV
- Dominio Active Directory: termoativa.local
- IP da rede Host-Only: 192.168.56.10

## Aplicacao
- Tecnologia: ASP.NET Core / .NET 8
- Servidor web: IIS 10
- Site: TermoAtiva
- Application Pool: TermoAtivaPool
- Porta HTTP: 8080
- Banco de dados: SQLite
- Resultado do teste local: HTTP 200

## Seguranca
- Firewall: porta TCP 8080 liberada
- Application Pool dedicado
- Permissoes NTFS especificas para aplicacao, banco e logs
- DNS integrado ao Active Directory com atualizacoes seguras

## Monitoramento
- CPU: Processor Time
- Memoria: Available MBytes
- Disco: Disk Time
- Intervalo de coleta: 15 segundos
- Alerta de CPU: acima de 80%

## Recuperacao automatica
- Processo anterior: PID 6448
- Processo apos falha: PID 2268
- Resposta apos recuperacao: HTTP 200
- Evento de auditoria: WAS 5011

## Comunicacao de rede
- Windows 11: 192.168.56.1
- Windows Server: 192.168.56.10
- Test-NetConnection: True
- Resolucao DNS IPv4: 192.168.56.10

## Observacao
A interface NAT utiliza 10.0.2.15. Registros DNS auxiliares
do Active Directory ainda devem ser revisados.
