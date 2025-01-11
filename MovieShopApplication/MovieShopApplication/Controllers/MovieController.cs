using ApplicationCore.Contracts;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace MovieShopApplication.Controllers;

public class MovieController : Controller
{
    private readonly IMovieRepository _movieRepository; 
    
    private readonly IGenreRepository _genreRepository;
    
    public MovieController(IMovieRepository movieRepository, IGenreRepository genreRepository)
    {
        this._movieRepository = movieRepository;
        this._genreRepository = genreRepository;
    }
    
    // GET
    public IActionResult Index()
    {
        var result = _movieRepository.GetAll();
        return View(result);
    }
    
    public IActionResult Create()
    {
        ViewBag.GenreList = new SelectList(_genreRepository.GetAll(),"Id","Name");
        return View();
    }
    
}