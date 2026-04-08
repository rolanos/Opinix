using Microsoft.AspNetCore.Http.Features;
using Microsoft.AspNetCore.HttpOverrides;
using Microsoft.AspNetCore.Mvc;
using Microsoft.OpenApi.Models;
using Statista.Api.GraphQL.Queries;
using Statista.Infrastructure.Persistence;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer(); 
builder.Services.AddSwaggerGen(c =>
{
  c.SwaggerDoc("v1", new OpenApiInfo { Title = "My API", Version = "v1" });
  c.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
  {
    Description = @"JWT Authorization header using the Bearer scheme. \r\n\r\n 
                      Enter 'Bearer' [space] and then your token in the text input below.
                      \r\n\r\nExample: 'Bearer 12345abcdef'",
    Name = "Authorization",
    In = ParameterLocation.Header,
    Type = SecuritySchemeType.ApiKey,
    Scheme = "Bearer"
  });

  c.AddSecurityRequirement(new OpenApiSecurityRequirement()
      {
        {
          new OpenApiSecurityScheme
          {
            Reference = new OpenApiReference
              {
                Type = ReferenceType.SecurityScheme,
                Id = "Bearer"
              },
              Scheme = "oauth2",
              Name = "Bearer",
              In = ParameterLocation.Header,

            },
            new List<string>()
          }
        });
});
builder.Services.Configure<ForwardedHeadersOptions>(options => options.ForwardedHeaders = ForwardedHeaders.XForwardedFor | ForwardedHeaders.XForwardedProto);
builder.Services.AddInfrastructure(builder.Configuration);
builder.Services.AddApplication();
builder.Services.AddControllers();

// CORS for local development: allow common localhost ports and emulator addresses
builder.Services.AddCors(options =>
{
  options.AddPolicy("DevCors", policy =>
  {
    policy.WithOrigins(
        "http://localhost:3000",
        "http://localhost:3001",
        "http://localhost:5173",
        "http://localhost",
        "http://localhost:80",
        "https://localhost:7287",
        "http://10.0.2.2:80"
      )
      .AllowAnyHeader()
      .AllowAnyMethod()
      .AllowCredentials();
  });
});

builder.Services.AddGraphQLServer()
                .RegisterDbContextFactory<PostgresDbContext>()
                .AddQueryType<Query>()
                // .AddMutationType<>()
                .AddProjections()
                .AddFiltering()
                .AddSorting();

builder.Services.Configure<FormOptions>(options =>
    {
        options.ValueCountLimit = int.MaxValue;
    });

AppContext.SetSwitch("Npgsql.EnableLegacyTimestampBehavior", true);
AppContext.SetSwitch("Npgsql.DisableDateTimeInfinityConversions", true);

var app = builder.Build();

//Только для Debug, в Production грузим из Docker
var load = DotNetEnv.Env.Load("../.env");

app.UseForwardedHeaders(new ForwardedHeadersOptions
{
  ForwardedHeaders = ForwardedHeaders.XForwardedFor | ForwardedHeaders.XForwardedProto
});

app.UseForwardedHeaders();
app.UseRouting();
app.UseMiddleware<ErrorHandlingMiddleware>();
// app.UseHttpsRedirection();
// app.UseHsts();
// Enable CORS (use the DevCors policy during development)
app.UseCors("DevCors");
app.UseAuthentication();
app.UseAuthorization();
app.MapControllers();
app.MapGraphQL("/graphql");
app.ApplyMigrations();
app.UseStaticFiles();
app.AddSeeds().GetAwaiter().GetResult();


app.UseSwagger(c =>
    {
      c.PreSerializeFilters.Add((swagger, httpReq) =>
          {
            var postfix = "";
            if (app.Environment.IsProduction())
            {
              postfix = "api/";
            }
            swagger.Servers = new List<OpenApiServer> { new OpenApiServer { Url = $"https://{httpReq.Host.Value}/{postfix}" } };
          });
    });
app.UseSwaggerUI(c =>
{
  c.SwaggerEndpoint("v1/swagger.json", "My API V1");
});



app.ApplyMigrations();

app.Run();

