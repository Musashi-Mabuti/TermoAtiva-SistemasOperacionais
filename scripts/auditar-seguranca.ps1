# TermoAtiva - Auditoria de seguranca
# Executar como administrador no Windows Server 2022

Import-Module WebAdministration

Write-Host "`n=== AUDITORIA DE SEGURANCA ===" -ForegroundColor Cyan

Write-Host "`n1. PERMISSOES DA APLICACAO"
icacls "C:\Sites\TermoAtiva"

Write-Host "`n2. PERMISSOES DO BANCO DE DADOS"
icacls "C:\Sites\TermoAtiva\App_Data"

Write-Host "`n3. PERMISSOES DOS LOGS"
icacls "C:\Sites\TermoAtiva\logs"

Write-Host "`n4. REGRA DO FIREWALL"
Get-NetFirewallRule -DisplayName "TermoAtiva API - HTTP 8080" |
    Format-List DisplayName, Enabled, Direction, Action, Profile

Write-Host "`n5. PROTECAO DO APPLICATION POOL"
Get-ItemProperty "IIS:\AppPools\TermoAtivaPool" |
    Format-List Name, State, AutoStart, StartMode,
        @{Name="RapidFailProtection";Expression={$_.failure.rapidFailProtection}}

Write-Host "`n=== AUDITORIA CONCLUIDA ===" -ForegroundColor Cyan
