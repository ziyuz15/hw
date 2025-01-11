using ApplicationCore.Contracts;
using ApplicationCore.Entities;
using Microsoft.AspNetCore.Mvc;

namespace MovieShopApplication.Controllers;

public class GenreController : Controller
{
    private readonly IGenreRepository _genreRepository;
    
    public GenreController(IGenreRepository genreRepository)
    {
        this._genreRepository = genreRepository;
    }
    
    // GET
    public IActionResult Index()
    {
        var result = _genreRepository.GetAll().OrderByDescending(x=>x.Id);
        return View(result);
    }
    
    [HttpGet]
    public IActionResult Create()
    {
        return View();
    }

    [HttpPost]
    public IActionResult Create(Genre genre)
    {
        if (ModelState.IsValid)
        {
            _genreRepository.Insert(genre);
            return RedirectToAction("Index");
        }
        return View(genre);
    }

    public IActionResult Detail(int id)
    {
        var g = _genreRepository.GetById(id);
        return View(g);
    }
    
    public IActionResult Edit(int id)
    {
        var g = _genreRepository.GetById(id);
        return View(g);
    }
    
    [HttpPost]
    public IActionResult Edit(Genre g)
    {
        if (ModelState.IsValid)
        {
            _genreRepository.Update(g, g.Id);
            return RedirectToAction("Index");
        }
        return View(g);
    }
    
    public IActionResult Delete(int id)
    {
        var g = _genreRepository.GetById(id);
        return View(g);
    }
    
    [HttpPost]
    public IActionResult Delete(Genre g)
    {
        var result = _genreRepository.GetById(g.Id);
        if (_genreRepository.Delete(g.Id) > 0)
        {
            return RedirectToAction("Index");
        }
        return View(result);
    }
    
    
}