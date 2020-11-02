FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-buster-slim AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/core/sdk:3.1-buster AS build
WORKDIR /src
COPY . .
RUN dotnet restore "./TestWebApp.sln"
COPY . .
WORKDIR "/src/."
RUN dotnet build "TestWebApp.sln" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "TestWebApp.sln" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "TestWebApp.dll"]

RUN mkdir /app/test-results

RUN dotnet test test.webapp.tests.dll --results-directory:/app/test-results