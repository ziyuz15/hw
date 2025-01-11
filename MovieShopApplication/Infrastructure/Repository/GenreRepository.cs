using ApplicationCore.Contracts;
using ApplicationCore.Entities;
using Infrastructure.Data;

namespace Infrastructure.Repository;

public class GenreRepository : BaseRepository<Genre>, IGenreRepository
{
    public GenreRepository(MovieDbContext movieDbContext):base(movieDbContext)
    {
    }
}