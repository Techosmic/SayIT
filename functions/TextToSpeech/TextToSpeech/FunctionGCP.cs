using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using System;
using System.IO;
using System.Net.Http;
using System.Threading.Tasks;

namespace TextToSpeech
{
    public static class FunctionGCP
    {
        private static HttpClient _httpClient = new HttpClient();
        private static ILogger logger;
        [FunctionName("FunctionGCP")]
        public static async Task<IActionResult> Run(
            [HttpTrigger(AuthorizationLevel.Function, "get", "post", Route = null)] HttpRequest req,
            ILogger log)
        {
            logger = log;
            log.LogInformation("C# HTTP trigger function processed a request.");

            var text = await new StreamReader(req.Body).ReadToEndAsync();
            var data = await GetSpeechFromText(text);
            var url = await StorageAudio(data, DateTime.UtcNow.ToShortDateString()+DateTime.UtcNow.ToShortTimeString());
            return new OkObjectResult(url);
        }

        public static async Task<string> GetSpeechFromText(string text)
        {
            HttpContent httpContent = new StringContent("{\"input\": {\"text\":\"" + text + "\"},\"voice\": {\"languageCode\":\"en-US\",\"name\":\"en-US-Wavenet-A\"},\"audioConfig\": {\"audioEncoding\":\"Mp3\"}}");
            var response = await _httpClient.PostAsync("https://texttospeech.googleapis.com/v1beta1/text:synthesize?key=AIzaSyBCWZRUd_taeiigsKcTdLRnboPtsq2qnKs", httpContent);
            var resultString = await response.Content.ReadAsStringAsync();
            dynamic result = JsonConvert.DeserializeObject(resultString);
            return (string)result["audioContent"];
        }

        public static async Task<string> StorageAudio(string audio, string title)
        {
            
            title = title.Replace(" ", "");
            byte[] binaryData = Convert.FromBase64String(audio);
            HttpContent httpContent = new ByteArrayContent(binaryData);
            _httpClient.DefaultRequestHeaders.Add("x-ms-blob-type", "BlockBlob");
            //_httpClient.DefaultRequestHeaders.Add("Content-Type", "MP3");
            _httpClient.DefaultRequestHeaders.Add("x-ms-date", DateTime.UtcNow.ToString("U"));
            var url = "https://sayitaudio.blob.core.windows.net/audio/" + title +
                      ".mp3?sv=2019-02-02&ss=bfqt&srt=sco&sp=rwdlacup&se=2019-12-31T08:09:37Z&st=2019-11-24T00:09:37Z&sip=1.1.1.1-255.255.255.255&spr=https&sig=ME3%2Bza72l%2B0eSP64WNKuHBwuaV1GJOnihZmuQnELyp8%3D";
            var response = await _httpClient.PutAsync(url, httpContent);
            var resultString = await response.Content.ReadAsStringAsync();
            logger.LogInformation(resultString);
            _httpClient = new HttpClient();
            return url;
        }
    }
}
