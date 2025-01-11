namespace ApplicationCore.Entities;

public class Movie
{
    public int MovieId { get; set; }
    public string Title { get; set; }
    public double Rating { get; set; }
    public double Duration { get; set; }
    public string ImageUrl { get; set; }
    public List<Genre> Genres { get; set; }
}