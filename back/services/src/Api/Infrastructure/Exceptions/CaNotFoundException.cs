using System;

namespace Api.Infrastructure.Exceptions
{
    public class CaNotFoundException : CaException
    {
        public CaNotFoundException()
        {
        }

        public CaNotFoundException(string code)
        {
            Code = code;
        }

        public CaNotFoundException(string message, params object[] args) : this(string.Empty, message, args)
        {
        }

        public CaNotFoundException(string code, string message, params object[] args) : this(null, code, message, args)
        {
        }

        public CaNotFoundException(Exception innerException, string message, params object[] args) : this(innerException,
          string.Empty, message, args)
        {
        }

        public CaNotFoundException(Exception innerException, string code, string message, params object[] args) : base(
          string.Format(message, args), innerException)
        {
            Code = code;
        }

        public CaNotFoundException(string message, Exception innerException) : base(message, innerException)
        {
        }
    }
}