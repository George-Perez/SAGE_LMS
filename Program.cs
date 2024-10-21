using Microsoft.AspNetCore.Components.Web;
using Microsoft.AspNetCore.Components.WebAssembly.Hosting;
using LMS;

var builder = WebAssemblyHostBuilder.CreateDefault(args);
builder.RootComponents.Add<App>("#app");
builder.RootComponents.Add<HeadOutlet>("head::after");

// Determine the environment
var environment = builder.HostEnvironment;

// Configure the HttpClient based on the environment
if (environment.IsDevelopment())
{
    builder.Services.AddScoped(sp => new HttpClient { BaseAddress = new Uri("https://localhost:7001") }); // Update with your local API URL
}
else
{
    var apiUrl = Environment.GetEnvironmentVariable("API_URL") ?? "https://your-production-api-url.com";
    builder.Services.AddScoped(sp => new HttpClient { BaseAddress = new Uri(apiUrl) });
}

builder.Services.AddScoped<ICourseService, CourseService>();
// Add other services as needed

await builder.Build().RunAsync();