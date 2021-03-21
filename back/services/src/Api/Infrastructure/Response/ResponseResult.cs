using System;
using System.Linq;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ModelBinding;

namespace Api.Infrastructure.Response
{
    public abstract class ResponseResult : ObjectResult
    {
        protected ResponseResult(HttpStatusCode status, string code, string message) : this(status, code, message, null)
        {
        }

        protected ResponseResult(HttpStatusCode status, string code, string message = null, object data = null) : base(
            new ResponseObject(status, code, message, data))
        {
            Response = (ResponseObject) Value;
        }

        public ResponseObject Response { get; protected set; }

        public override void OnFormatting(ActionContext context)
        {
            context.HttpContext.Response.StatusCode = (int) ChangeStatusCodeToSaveBody(Response.Status);
        }

        private static HttpStatusCode ChangeStatusCodeToSaveBody(HttpStatusCode httpStatusCode)
        {
            return httpStatusCode switch
            {
                HttpStatusCode.NoContent => HttpStatusCode.Ok,
                HttpStatusCode.NotModified => HttpStatusCode.Ok,
                _ => httpStatusCode
            };
        }
    }

    public class OkResponseResult : ResponseResult
    {
        public OkResponseResult(string message, object data = null) : this(nameof(HttpStatusCode.Ok), message, data)
        {
        }

        public OkResponseResult(string code, string message, object data = null) : base(HttpStatusCode.Ok, code,
            message, data)
        {
        }
    }

    public class ForbiddenResponseResult : ResponseResult
    {
        public ForbiddenResponseResult(string message, object data = null) : this(nameof(HttpStatusCode.Forbidden),
            message, data)
        {
        }

        public ForbiddenResponseResult(string code, string message, object data = null) : base(HttpStatusCode.Forbidden,
            code, message, data)
        {
        }
    }

    public class CreatedResponseResult : ResponseResult
    {
        public CreatedResponseResult(string message, object data = null) : this(nameof(HttpStatusCode.Created), message,
            data)
        {
        }

        public CreatedResponseResult(string code, string message, object data = null) : base(HttpStatusCode.Created,
            code, message, data)
        {
        }
    }

    public class UpdatedResponseResult : ResponseResult
    {
        public UpdatedResponseResult(string message, object data = null) : this(nameof(HttpStatusCode.Updated), message,
            data)
        {
        }

        public UpdatedResponseResult(string code, string message, object data = null) : base(HttpStatusCode.Updated,
            code, message, data)
        {
        }
    }

    public class NoContentResponseResult : ResponseResult
    {
        public NoContentResponseResult(string message, object data = null) : this(nameof(HttpStatusCode.NoContent),
            message, data)
        {
        }

        public NoContentResponseResult(string code, string message, object data = null) : base(HttpStatusCode.NoContent,
            code, message, data)
        {
        }
    }

    public class NotFoundResponseResult : ResponseResult
    {
        public NotFoundResponseResult(string message, object data = null) : this(nameof(HttpStatusCode.NotFound),
            message, data)
        {
        }

        public NotFoundResponseResult(string code, string message, object data = null) : base(HttpStatusCode.NotFound,
            code, message, data)
        {
        }
    }

    public class BadResponseResult : ResponseResult
    {
        public BadResponseResult(string message, object data = null) : base(HttpStatusCode.BadRequest,
            nameof(HttpStatusCode.BadRequest), message, data)
        {
        }

        public BadResponseResult(string code, string message, object data = null) : base(HttpStatusCode.BadRequest,
            code, message, data)
        {
        }

        public BadResponseResult(ModelStateDictionary modelState) : base(HttpStatusCode.BadRequest,
            nameof(HttpStatusCode.BadRequest))
        {
            if (modelState.IsValid)
            {
                throw new ArgumentException("ModelState must be invalid", nameof(modelState));
            }

            var errors = modelState.Select(x => new
                {
                    x.Key,
                    Message = string.Join('\n', x.Value.Errors.Select(error => error.ErrorMessage))
                })
                .ToList();
            Response = new ResponseObject(Response.Status, Response.Code, Response.Message, new {Errors = errors});
        }
    }
}