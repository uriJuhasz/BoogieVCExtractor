using Microsoft.Boogie;
using System;

namespace VCExtractor
{
    public class Extractor
    {
        public static void extract(Implementation impl)
        {
            Console.WriteLine("============Boogie extractor - start");
            Console.WriteLine("   Implementation: {0}", impl.Name);
            Console.WriteLine("============Boogie extractor - end");
        }
    }
}
