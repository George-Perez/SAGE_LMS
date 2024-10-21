using System;
using System.IO;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;

namespace LMS.API
{
    public static class CourseFunction
    {
        [FunctionName("GetCourse")]
        public static async Task<IActionResult> GetCourse(
            [HttpTrigger(AuthorizationLevel.Function, "get", Route = "courses/{id}")] HttpRequest req,
            int id,
            ILogger log)
        {
            log.LogInformation($"Getting course with id: {id}");

            // Implement logic to fetch course from database
            var course = await GetCourseFromDatabase(id);

            if (course == null)
            {
                return new NotFoundResult();
            }

            return new OkObjectResult(course);
        }

        private static async Task<Course> GetCourseFromDatabase(int id)
        {
            // Implement database access logic here
            // This is just a placeholder
            return new Course { Id = id, Title = "Sample Course" };
        }
    }

    public class Course
    {
        public int Id { get; set; }
        public string Title { get; set; }
    }
}