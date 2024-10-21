using Microsoft.EntityFrameworkCore;
using LMS.API.Models;

namespace LMS.API.Data
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
            : base(options)
        {
        }

        public DbSet<User> Users { get; set; }
        public DbSet<Course> Courses { get; set; }
        public DbSet<Video> Videos { get; set; }
        public DbSet<Quiz> Quizzes { get; set; }
        public DbSet<Question> Questions { get; set; }
        public DbSet<Answer> Answers { get; set; }
        public DbSet<UserCourseProgress> UserCourseProgresses { get; set; }
        public DbSet<UserVideoProgress> UserVideoProgresses { get; set; }
        public DbSet<UserQuizResult> UserQuizResults { get; set; }
        public DbSet<DailyLog> DailyLogs { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // Add any additional configuration for your entities here
        }
    }
}