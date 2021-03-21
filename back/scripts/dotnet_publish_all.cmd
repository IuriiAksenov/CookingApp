:: Front group (10101-10113)
:: 15001
dotnet publish ../services/src/Api --framework netcoreapp3.1 --output ../../release/Api --runtime ubuntu.16.04-x64

echo "All services were built. Check logs for errors, if need. Press any key to exit..."
pause