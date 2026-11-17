# TermoAtiva - Verificacao da infraestrutura
# Executar no Windows Server 2022 como administrador

Import-Module WebAdministration
Import-Module ActiveDirectory

Write-Host "`n=== TERMOATIVA - INFRAESTRUTURA ===" -ForegroundColor Cyan

Write-Host "`n1. SERVIDOR E DOMINIO"
hostname
Get-ADDomain | Select-Object DNSRoot, NetBIOSName

Write-Host "`n2. ENDERECO IP"
Get-NetIPAddress -InterfaceAlias "Ethernet" -AddressFamily IPv4 |
    Select-Object IPAddress, PrefixLength

Write-Host "`n3. SERVICOS"
Get-Service DNS, NTDS, W3SVC, WAS |
    Format-Table Name, Status -AutoSize

Write-Host "`n4. SITE IIS"
Get-Website -Name "TermoAtiva" |
    Select-Object Name, State, PhysicalPath

Write-Host "`n5. APPLICATION POOL"
Get-ItemProperty "IIS:\AppPools\TermoAtivaPool" |
    Select-Object Name, State, AutoStart, StartMode

Write-Host "`n6. MONITORAMENTO"
logman query "TermoAtiva-Monitoramento"

Write-Host "`n7. ALERTA DE CPU"
logman query "TermoAtiva-Alerta-CPU"

Write-Host "`n8. TESTE HTTP"
try {
    $resposta = Invoke-WebRequest `
        "http://localhost:8080/" `
        -UseBasicParsing `
        -TimeoutSec 15

    Write-Host "HTTP:" $resposta.StatusCode -ForegroundColor Green
}
catch {
    Write-Host "Falha HTTP:" $_.Exception.Message -ForegroundColor Red
}

Write-Host "`n=== VERIFICACAO CONCLUIDA ===" -ForegroundColor Cyan
