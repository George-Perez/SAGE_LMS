using Microsoft.EntityFrameworkCore;
using LMS.API.Data;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// Determine the environment
var environment = builder.Environment;

// Configure the database context based on the environment
if (environment.IsDevelopment())
{
    builder.Services.AddDbContext<ApplicationDbContext>(options =>
        options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));
}
else
{
    var productionConnectionString = Environment.GetEnvironmentVariable("PRODUCTION_CONNECTION_STRING");
    if (string.IsNullOrEmpty(productionConnectionString))
    {
        throw new InvalidOperationException("Production connection string is not set.");
    }
    builder.Services.AddDbContext<ApplicationDbContext>(options =>
        options.UseSqlServer(productionConnectionString));
}

// Rest of your Program.cs code...