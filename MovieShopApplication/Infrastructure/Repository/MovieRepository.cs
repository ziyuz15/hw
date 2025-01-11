using ApplicationCore.Entities;
using Infrastructure.Data;
using Infrastructure.Repository;

namespace ApplicationCore.Contracts;

public class MovieRepository: BaseRepository<Movie>, IMovieRepository
{
    public MovieRepository(MovieDbContext movieDbContext): base(movieDbContext)
    {
    }
}