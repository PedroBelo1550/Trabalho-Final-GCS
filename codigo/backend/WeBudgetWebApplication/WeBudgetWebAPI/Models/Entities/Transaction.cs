using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.AspNetCore.Identity;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using WeBudgetWebAPI.Models.Enums;

namespace WeBudgetWebAPI.Models.Entities;

[Table("Transaction")]
public class Transaction
{
    [Column("Id")]
    public int Id { get; set; }
    [Column("TransactionDescription")]
    public string Description { get; set; }
    [Column("PaymentValue")]
    public double PaymentValue { get; set; }
    [Column("PaymentType")]
    public string PaymentType { get; set; }
    [Column("TansactionType")]
    [JsonConverter(typeof(StringEnumConverter))]
    public TansactionType  TansactionType{ get; set; }
    [Column("TansactionDate")]
    public DateTime TansactionDate{ get; set; }
    [Column("Latitude")]
    public double Latitude { get; set; }
    [Column("Longitude")]
    public double Longitude { get; set; }
    [Column("Address")]
    public string Address { get; set; }
    [ForeignKey("Category")]
    public int CategoryId { get; set; }
    
    public virtual Category Category { get; set; }
    
    [ForeignKey("ApplicationUser")]
    [Column(Order = 1)]
    public string UserId { get; set; }

    public virtual ApplicationUser ApplicationUser { get; set; }
}
