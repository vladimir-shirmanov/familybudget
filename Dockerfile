ARG BASE_REPO=mcr.microsoft.com/dotnet/core
FROM ${BASE_REPO}/sdk:3.1 AS build-env
WORKDIR /FamilyBudget

COPY . ./
RUN dotnet restore
RUN dotnet publish -c Release -o out

FROM ${BASE_REPO}/aspnet:3.1
WORKDIR FamilyBudget
COPY --from=build-env /FamilyBudget/out .
ENTRYPOINT ["dotnet", "FamilyBudget.dll"]