namespace ApplicationCore.Entities;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

public class Cast
{
    public int Id { get; set; }
    [Required(ErrorMessage = "Name is required")]
    [Column(TypeName = "varchar(100)")]
    public string Name { get; set; }
    [Required(ErrorMessage = "Gender is required")]
    [Column(TypeName = "varchar(10)")]
    public string Gender { get; set; }
    [Column(TypeName = "varchar(2000)")]
    public string ProfilePath { get; set; }
}