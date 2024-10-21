using System.Net.Http.Json;
using LMS.Models;

public interface ICourseService
{
    Task<List<Course>> GetCoursesAsync();
    Task<Course> GetCourseAsync(int id);
}

public class CourseService : ICourseService
{
    private readonly HttpClient _httpClient;

    public CourseService(HttpClient httpClient)
    {
        _httpClient = httpClient;
    }

    public async Task<List<Course>> GetCoursesAsync()
    {
        return await _httpClient.GetFromJsonAsync<List<Course>>("api/courses") ?? new List<Course>();
    }

    public async Task<Course> GetCourseAsync(int id)
    {
        return await _httpClient.GetFromJsonAsync<Course>($"api/courses/{id}") ?? new Course();
    }
}