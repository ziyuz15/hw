using Microsoft.AspNetCore.Mvc;

namespace MovieShopApplication.Controllers;

public class CastController : Controller
{
    // GET
    public IActionResult Index()
    {
        return View();
    }
}