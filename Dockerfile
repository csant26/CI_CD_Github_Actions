FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src
COPY . .
RUN dotnet restore "/CICDPractice/CICDPractice.csproj" --disable-parallel
RUN dotnet build "/CICDPractice/CICDPractice.csproj" -c Release --no-restore
RUN dotnet publish "/CICDPractice/CICDPractice.csproj" -c Release --no-build -o /app

FROM mcr.microsoft.com/dotnet/aspnet:9.0
WORKDIR /app
COPY --from=build /app ./
EXPOSE 5000
ENTRYPOINT ["dotnet","CICDPractice.dll"]

