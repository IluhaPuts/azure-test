FROM web_app_build:32 as base

FROM mcr.microsoft.com/dotnet/core/sdk:3.1-buster AS unit-test

WORKDIR /app

COPY --from=base /app .

RUN mkdir test-results
RUN echo "testset" >> test.txt

RUN dotnet test test.webapp.tests.dll --results-directory:/app/test-results