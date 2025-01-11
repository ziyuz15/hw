using ApplicationCore.Entities;
using Microsoft.EntityFrameworkCore;

namespace Infrastructure.Data;

public class MovieDbContext: DbContext
{
    public MovieDbContext(DbContextOptions<MovieDbContext> context): base(context)
    {
    }

    public DbSet<Genre> Genres { get; set; }
    public DbSet<Cast> Casts { get; set; }
}