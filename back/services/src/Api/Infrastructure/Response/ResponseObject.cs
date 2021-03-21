using Newtonsoft.Json;

namespace Api.Infrastructure.Response
{
    public enum HttpStatusCode
    {
        Ok = System.Net.HttpStatusCode.OK,
        Created = System.Net.HttpStatusCode.Created,
        Updated = System.Net.HttpStatusCode.Accepted,
        NoContent = System.Net.HttpStatusCode.NoContent,
        NotModified = System.Net.HttpStatusCode.NotModified,
        BadRequest = System.Net.HttpStatusCode.BadRequest,
        Unauthorized = System.Net.HttpStatusCode.Unauthorized,
        Forbidden = System.Net.HttpStatusCode.Forbidden,
        NotFound = System.Net.HttpStatusCode.NotFound,
        Conflict = System.Net.HttpStatusCode.Conflict,
        InternalServerError = System.Net.HttpStatusCode.InternalServerError
    }

    public class ResponseObject
    {
        [JsonIgnore]
        public HttpStatusCode Status { get; }

        [JsonProperty("code")]
        public string Code { get; }

        [JsonProperty("message")]
        public string Message { get; }

        [JsonProperty("data")]
        public object Data { get; set; }

        public ResponseObject(HttpStatusCode status) : this(status, StatusCodeToReadableString(status), StatusCodeToReadableString(status), null)
        {
        }

        public ResponseObject(HttpStatusCode status, string code, string message, object data)
        {
            Message = string.IsNullOrEmpty(message) ? StatusCodeToReadableString(status) : message;
            Status = status;
            Code = string.IsNullOrEmpty(code) ? StatusCodeToReadableString(status) : code;
            Data = data;
        }

        private static string StatusCodeToReadableString(HttpStatusCode statusCode)
        {
            return statusCode switch
            {
                HttpStatusCode.Ok => "ok",
                HttpStatusCode.Created => "created",
                HttpStatusCode.NoContent => "no_content",
                HttpStatusCode.Updated => "updated",
                HttpStatusCode.NotModified => "not_modified",
                HttpStatusCode.BadRequest => "bad_request",
                HttpStatusCode.Unauthorized => "unauthorized",
                HttpStatusCode.Forbidden => "forbidden",
                HttpStatusCode.NotFound => "not_found",
                HttpStatusCode.Conflict => "conflict",
                HttpStatusCode.InternalServerError => "internal_server_error",
                _ => "default_error"
            };
        }
    }

    public class ResponseObject<T> : ResponseObject
    {
        [JsonProperty("data")]
        public new T Data { get; set; }

        public ResponseObject(HttpStatusCode status, string code, string message, T data) : base(status, code, message, data)
        {
            Data = data;
        }
    }
}