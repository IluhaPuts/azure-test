FROM web_app_build:v1.0 as base

FROM mcr.microsoft.com/dotnet/core/sdk:3.1-buster AS unit-test

WORKDIR /app

COPY --from=base /app .

RUN mkdir test-results

VOLUME [ "/app/test-results" ]

RUN dotnet test test.webapp.tests.dll --results-directory /app/test-results --logger trx

RUN exit 0