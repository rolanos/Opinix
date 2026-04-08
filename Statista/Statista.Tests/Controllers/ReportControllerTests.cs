// using Moq;
// using Statista.Application.Common.Interfaces.Persistence;
// using Statista.Domain.Entities;

// namespace ReportTests;

// public class ReportControllerTests
// {
//     private readonly Mock<IReportRepository> _reportRepository = new Mock<IReportRepository>();
//     [Fact]
//     public async Task GetReportById_ShouldReturnReport_WhenReportExists()
//     {
//         //Arrange
//         var reportId = Guid.NewGuid();
//         var mockReport = new Report()
//         {
//             Id = reportId,
//         };
//         _reportRepository.Setup(x => x.GetReportById(reportId)).ReturnsAsync(mockReport);

//         //Act
//         var report = await _reportRepository.Object.GetReportById(reportId);

//         //Assert
//         Assert.Equal(reportId, report?.Id);
//     }
// }