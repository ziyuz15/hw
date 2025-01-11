using ApplicationCore.Contracts;
using ApplicationCore.Entities;
using Infrastructure.Data;

namespace Infrastructure.Repository;

public class CastRepository:BaseRepository<Cast>,ICastRepository
{
    public CastRepository(MovieDbContext movieDbContext): base(movieDbContext)
    {
    }
}