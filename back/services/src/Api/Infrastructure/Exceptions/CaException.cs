using System;

namespace Api.Infrastructure.Exceptions
{
    public class CaException : Exception
    {
        public string Code { get; protected set; }

        public CaException()
        {
        }

        public CaException(string code)
        {
            Code = code;
        }

        public CaException(string message, params object[] args) : this(string.Empty, message, args)
        {
        }

        public CaException(string code, string message, params object[] args) : this(null, code, message, args)
        {
        }

        public CaException(Exception innerException, string message, params object[] args) : this(innerException,
          string.Empty, message, args)
        {
        }

        public CaException(Exception innerException, string code, string message, params object[] args) : base(
          string.Format(message, args), innerException)
        {
            Code = code;
        }

        public CaException(string message, Exception innerException) : base(message, innerException)
        {
        }
    }
}