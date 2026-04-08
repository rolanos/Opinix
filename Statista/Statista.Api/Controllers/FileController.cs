using System.Net.Mime;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Statista.Api.Controllers;
using Statista.Application.Features.Files.Commands.CreateFile;
using Statista.Application.Features.Files.Queries.GetFilesFromElementId;

[ApiController]
[Authorize]
[Route("files")]
public class FileController : BaseController
{
    [HttpGet()]
    [AllowAnonymous]
    public async Task<IActionResult> GetFilesByName([FromQuery] GetFileFromNameQuery request)
    {
        var result = await mediator.Send(request);
        return File(result.FileData, new ContentType().MediaType);
    }


    [HttpGet("element")]
    [AllowAnonymous]
    public async Task<IActionResult> GetFilesByElementId([FromQuery] GetFilesFromElementIdQuery request)
    {
        var result = await mediator.Send(request);
        return Ok(result);
    }

    [HttpPost]
    public async Task<IActionResult> UploadFile([FromForm] CreateFileCommand request)
    {
        var result = await mediator.Send(request);
        if (result == null)
            return NoContent();
        return Created(nameof(result), result);
    }

    [HttpDelete]
    public async Task<IActionResult> DeleteFile([FromQuery] DeleteFileCommand request)
    {
        var result = await mediator.Send(request);
        if (result == null)
            return NoContent();
        return Ok(result);
    }
}