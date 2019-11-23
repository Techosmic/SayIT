using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SayIT_API.Model;
using System.Collections.Generic;
using System.Text.Json;
using System.Linq;

namespace SayIT_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [AllowAnonymous]
    public class LevelController : ControllerBase
    {
        // GET: api/Level
        [HttpGet]
        public IActionResult Get()
        {
            var options = new JsonSerializerOptions
            {
                PropertyNamingPolicy = JsonNamingPolicy.CamelCase,
                WriteIndented = true,
                IgnoreNullValues = true
            };

            var jsonString = System.IO.File.ReadAllText("DB\\Levels.json");
            var jsonModel = JsonSerializer.Deserialize<IEnumerable<Level>>(jsonString, options);

            return Ok(jsonModel);
        }

        [HttpPost("Unlock/{id}")]
        public IActionResult UnlockLevel(int id)
        {
            var options = new JsonSerializerOptions
            {
                PropertyNamingPolicy = JsonNamingPolicy.CamelCase,
                WriteIndented = true,
                IgnoreNullValues = true
            };

            var jsonString = System.IO.File.ReadAllText("DB\\Levels.json");
            var jsonModel = JsonSerializer.Deserialize<IEnumerable<Level>>(jsonString, options);
            var test = jsonModel.Where(a => a.LevelNumber == id).FirstOrDefault();
            test.Unlocked = true;
            var newJsonString = JsonSerializer.Serialize(jsonModel, options);

            System.IO.File.WriteAllText("DB\\Levels.json", newJsonString);

            return Ok();
        }

        [HttpPost("Lock/{id}")]
        public IActionResult LockLevel(int id)
        {
            var options = new JsonSerializerOptions
            {
                PropertyNamingPolicy = JsonNamingPolicy.CamelCase,
                WriteIndented = true,
                IgnoreNullValues = true
            };

            var jsonString = System.IO.File.ReadAllText("DB\\Levels.json");
            var jsonModel = JsonSerializer.Deserialize<IEnumerable<Level>>(jsonString, options);
            var test = jsonModel.Where(a => a.LevelNumber == id).FirstOrDefault();
            test.Unlocked = false;
            var newJsonString = JsonSerializer.Serialize(jsonModel, options);

            System.IO.File.WriteAllText("DB\\Levels.json", newJsonString);

            return Ok();
        }
    }
}
