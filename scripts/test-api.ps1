# Test MiniMax API v8 - Full messages
$token = "sk-cp-a0cZDZ2YqbbvoiwsEiPxMiVjGyo7vj3braB5oY_m8Ox2aBcSy6-wNyxiLefuQI8jiZ7JWvuPrqi8w6EIRnQfQOENT08hWBybl9TXAGo50ABG4B6EGdbnG10"
$url = "https://api.minimax.chat/v1/text/chatcompletion_pro"
$headers = @{
    "Authorization" = "Bearer $token"
    "Content-Type" = "application/json"
}
$body = @{
    model = "abab6.5s-chat"
    messages = @(
        @{
            role = "user"
            sender_type = "USER"
            sender_name = "User"
            content = "Hello"
        }
    )
    bot_setting = @(
        @{
            bot_name = "NUCNAS"
            content = "You are a helpful tech review assistant."
        }
    )
    reply_constraints = @{
        type = "text"
        sender_type = "BOT"
        sender_name = "NUCNAS"
    }
} | ConvertTo-Json -Depth 5

try {
    $response = Invoke-RestMethod -Uri $url -Headers $headers -Method Post -Body $body -TimeoutSec 30
    $response | ConvertTo-Json -Depth 5
} catch {
    Write-Host $_.Exception.Message
}
