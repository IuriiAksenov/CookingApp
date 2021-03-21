using System;

namespace Api.Infrastructure.Exceptions
{
    public class CaForbiddenException : CaException
    {
        public CaForbiddenException()
        {
        }

        public CaForbiddenException(string code)
        {
            Code = code;
        }

        public CaForbiddenException(string message, params object[] args) : this(string.Empty, message, args)
        {
        }

        public CaForbiddenException(string code, string message, params object[] args) : this(null, code, message, args)
        {
        }

        public CaForbiddenException(Exception innerException, string message, params object[] args) : this(innerException,
          string.Empty, message, args)
        {
        }

        public CaForbiddenException(Exception innerException, string code, string message, params object[] args) : base(
          string.Format(message, args), innerException)
        {
            Code = code;
        }

        public CaForbiddenException(string message, Exception innerException) : base(message, innerException)
        {
        }
    }
}