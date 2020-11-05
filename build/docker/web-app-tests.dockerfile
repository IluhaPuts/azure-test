FROM web_app_build:v1.0 as base

FROM mcr.microsoft.com/dotnet/core/sdk:3.1-buster AS unit-test

WORKDIR /app

RUN echo "dotnet test test.webapp.tests.dll --results-directory /app/test-results --logger trx && exit 0 || exit 1" >> run-nunit-tests.sh

COPY --from=base /app .

RUN mkdir test-results

VOLUME [ "/app/test-results" ]


ENTRYPOINT [ "sh", "./run-nunit-tests.sh" ]