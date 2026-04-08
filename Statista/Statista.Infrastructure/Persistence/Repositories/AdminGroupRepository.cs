using Microsoft.EntityFrameworkCore;
using Statista.Application.Common.Interfaces.Persistence;

namespace Statista.Infrastructure.Persistence.Repositories;

class AdminGroupRepository : IAdminGroupRepository
{
    private readonly PostgresDbContext _dbContext;

    public AdminGroupRepository(PostgresDbContext dbContext)
    {
        _dbContext = dbContext;
    }

    public async Task<AdminGroup?> CreateAdminGroup(AdminGroup adminGroup)
    {
        await _dbContext.AddAsync(adminGroup);

        await _dbContext.SaveChangesAsync();

        return await _dbContext.AdminGroup.FirstOrDefaultAsync(i => i.SurveyId == adminGroup.SurveyId
                                                                     && i.UserId == adminGroup.UserId);
    }

    public async Task<AdminGroup?> DeleteAdminGroup(AdminGroup adminGroup)
    {
        var adminGroupDb = await _dbContext.AdminGroup.AsNoTracking()
                                                    .FirstOrDefaultAsync(a => a.UserId == adminGroup.UserId && a.SurveyId == adminGroup.SurveyId);
        if (adminGroupDb is not null)
        {
            _dbContext.AdminGroup.Remove(adminGroup);
            await _dbContext.SaveChangesAsync();
            return adminGroupDb;
        }
        return null;
    }

    public async Task<ICollection<AdminGroup>> GetAdminGroupBySurveyId(Guid surveyId)
    {
        var adminGroups = await _dbContext.AdminGroup.AsNoTracking()
                                          .Where(a => a.SurveyId == surveyId)
                                          .Include(a => a.User)
                                          .ThenInclude(u => u.UserInfo)
                                          .Include(a => a.Role)
                                          .ToListAsync();

        for (int i = 0; i < adminGroups.Count; i++)
        {
            if (adminGroups[i] != null && adminGroups[i]?.User.UserInfo != null)
            {
                var file = await _dbContext.Files.AsNoTracking()
                                                 .Where(f => f.ElementId == adminGroups[i]!.User!.UserInfo.Id)
                                                 .FirstOrDefaultAsync();
                adminGroups[i]!.User!.UserInfo.PhotoId = file?.Id;
                adminGroups[i]!.User!.UserInfo.Photo = file;
            }

        }

        return adminGroups;
    }

    public async Task<AdminGroup?> UpdateAdmin(AdminGroup adminGroup)
    {
        _dbContext.AdminGroup.Update(adminGroup);

        await _dbContext.SaveChangesAsync();

        return await _dbContext.AdminGroup.FirstOrDefaultAsync(a => a.UserId == adminGroup.UserId && a.SurveyId == adminGroup.SurveyId);
    }
}