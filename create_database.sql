-- Create the Bariatric LMS database
CREATE DATABASE BariatricLMS;
GO

USE BariatricLMS;
GO

-- Create Users table
CREATE TABLE Users (
    UserId INT PRIMARY KEY IDENTITY(1,1),
    Username NVARCHAR(50) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    Role NVARCHAR(20) NOT NULL,
    AvatarUrl NVARCHAR(255),
    CreatedAt DATETIME2 NOT NULL DEFAULT GETDATE(),
    LastLogin DATETIME2
);

-- Create Courses table
CREATE TABLE Courses (
    CourseId INT PRIMARY KEY IDENTITY(1,1),
    Title NVARCHAR(100) NOT NULL,
    Description NVARCHAR(MAX),
    PassRate INT NOT NULL,
    CreatedAt DATETIME2 NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME2 NOT NULL DEFAULT GETDATE()
);

-- Create Videos table
CREATE TABLE Videos (
    VideoId INT PRIMARY KEY IDENTITY(1,1),
    CourseId INT NOT NULL,
    Title NVARCHAR(100) NOT NULL,
    Description NVARCHAR(MAX),
    Url NVARCHAR(255) NOT NULL,
    Duration INT NOT NULL, -- Duration in seconds
    OrderInCourse INT NOT NULL,
    CreatedAt DATETIME2 NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (CourseId) REFERENCES Courses(CourseId)
);

-- Create Quizzes table
CREATE TABLE Quizzes (
    QuizId INT PRIMARY KEY IDENTITY(1,1),
    CourseId INT NOT NULL,
    Title NVARCHAR(100) NOT NULL,
    Description NVARCHAR(MAX),
    PassScore INT NOT NULL,
    CreatedAt DATETIME2 NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (CourseId) REFERENCES Courses(CourseId)
);

-- Create Questions table
CREATE TABLE Questions (
    QuestionId INT PRIMARY KEY IDENTITY(1,1),
    QuizId INT NOT NULL,
    Text NVARCHAR(MAX) NOT NULL,
    OrderInQuiz INT NOT NULL,
    CreatedAt DATETIME2 NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (QuizId) REFERENCES Quizzes(QuizId)
);

-- Create Answers table
CREATE TABLE Answers (
    AnswerId INT PRIMARY KEY IDENTITY(1,1),
    QuestionId INT NOT NULL,
    Text NVARCHAR(MAX) NOT NULL,
    IsCorrect BIT NOT NULL,
    CreatedAt DATETIME2 NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (QuestionId) REFERENCES Questions(QuestionId)
);

-- Create UserCourseProgress table
CREATE TABLE UserCourseProgress (
    UserCourseProgressId INT PRIMARY KEY IDENTITY(1,1),
    UserId INT NOT NULL,
    CourseId INT NOT NULL,
    LastVideoWatched INT,
    LastQuizTaken INT,
    CompletionPercentage DECIMAL(5,2) NOT NULL DEFAULT 0,
    StartedAt DATETIME2 NOT NULL DEFAULT GETDATE(),
    CompletedAt DATETIME2,
    FOREIGN KEY (UserId) REFERENCES Users(UserId),
    FOREIGN KEY (CourseId) REFERENCES Courses(CourseId),
    FOREIGN KEY (LastVideoWatched) REFERENCES Videos(VideoId),
    FOREIGN KEY (LastQuizTaken) REFERENCES Quizzes(QuizId)
);

-- Create UserVideoProgress table
CREATE TABLE UserVideoProgress (
    UserVideoProgressId INT PRIMARY KEY IDENTITY(1,1),
    UserId INT NOT NULL,
    VideoId INT NOT NULL,
    WatchedPercentage DECIMAL(5,2) NOT NULL DEFAULT 0,
    LastWatchedAt DATETIME2 NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (UserId) REFERENCES Users(UserId),
    FOREIGN KEY (VideoId) REFERENCES Videos(VideoId)
);

-- Create UserQuizResults table
CREATE TABLE UserQuizResults (
    UserQuizResultId INT PRIMARY KEY IDENTITY(1,1),
    UserId INT NOT NULL,
    QuizId INT NOT NULL,
    Score INT NOT NULL,
    PassedQuiz BIT NOT NULL,
    CompletedAt DATETIME2 NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (UserId) REFERENCES Users(UserId),
    FOREIGN KEY (QuizId) REFERENCES Quizzes(QuizId)
);

-- Create DailyLogs table
CREATE TABLE DailyLogs (
    DailyLogId INT PRIMARY KEY IDENTITY(1,1),
    UserId INT NOT NULL,
    LogDate DATE NOT NULL,
    WorkoutStatus NVARCHAR(MAX),
    Meals NVARCHAR(MAX),
    CreatedAt DATETIME2 NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (UserId) REFERENCES Users(UserId)
);

-- Create index for faster queries
CREATE INDEX IX_UserCourseProgress_UserId_CourseId ON UserCourseProgress(UserId, CourseId);
CREATE INDEX IX_UserVideoProgress_UserId_VideoId ON UserVideoProgress(UserId, VideoId);
CREATE INDEX IX_UserQuizResults_UserId_QuizId ON UserQuizResults(UserId, QuizId);
CREATE INDEX IX_DailyLogs_UserId_LogDate ON DailyLogs(UserId, LogDate);

GO

-- Insert sample data (optional)
INSERT INTO Users (Username, PasswordHash, Email, Role)
VALUES 
('patient1', 'hashedpassword1', 'patient1@example.com', 'Patient'),
('admin1', 'hashedpassword2', 'admin1@example.com', 'Admin'),
('contentadmin1', 'hashedpassword3', 'contentadmin1@example.com', 'ContentAdmin');

INSERT INTO Courses (Title, Description, PassRate)
VALUES 
('Pre-Op Preparation', 'Learn about preparing for your bariatric surgery.', 80),
('Post-Op Recovery', 'Understand the recovery process and what to expect after surgery.', 80),
('Nutrition Basics', 'Learn about proper nutrition before and after bariatric surgery.', 75);

-- Add more sample data as needed

GO