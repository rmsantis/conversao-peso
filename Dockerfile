FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build-env
WORKDIR /app

COPY ConversaoPeso.Web/*.csproj ./
RUN dotnet restore


COPY . .
RUN dotnet publish ConversaoPeso.sln -c Release -o out


FROM mcr.microsoft.com/dotnet/aspnet:5.0
EXPOSE 80:80
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "ConversaoPeso.Web.dll"]
