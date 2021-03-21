using System;

namespace Api.Infrastructure.Exceptions
{
    public class CaValidationException : CaException
    {
        public CaValidationException()
        {
        }

        public CaValidationException(string code)
        {
            Code = code;
        }

        public CaValidationException(string message, params object[] args) : this(string.Empty, message, args)
        {
        }

        public CaValidationException(string code, string message, params object[] args) : this(null, code, message,
            args)
        {
        }

        public CaValidationException(Exception innerException, string message, params object[] args) : this(
            innerException,
            string.Empty, message, args)
        {
        }

        public CaValidationException(Exception innerException, string code, string message, params object[] args) :
            base(
                string.Format(message, args), innerException)
        {
            Code = code;
        }

        public CaValidationException(string message, Exception innerException) : base(message, innerException)
        {
        }
    }
}