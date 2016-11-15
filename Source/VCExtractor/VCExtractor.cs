using Microsoft.Boogie;
using System;
using System.Linq;

namespace VCExtractor
{
    public class Extractor
    {
        public static void extract(Implementation impl,Program prog)
        {
            Console.WriteLine("============Boogie extractor {0} - start", impl.Name);
            var types = prog.TopLevelDeclarations.OfType <TypeCtorDecl>();
            var typeAliases = prog.TopLevelDeclarations.OfType<TypeSynonymDecl>();
            Console.WriteLine("   Types: {0} a:{1}", types.Count(), typeAliases.Count());

            var consts = prog.Constants;
            var uConstants = from c in consts where c.Unique select c;
            Console.WriteLine("   Constants: u:{0} a:{1}", uConstants.Count(), consts.Count());
            var gVars = prog.Variables;
            var lVars = impl.LocVars;
            var iVars = impl.InParams;
            var oVars = impl.OutParams;
            Console.WriteLine("   Variables: g:{0} l:{1} i:{2} o:{3}", gVars.Count(), lVars.Count, iVars.Count, oVars.Count);

            var axioms = prog.Axioms;
            Console.WriteLine("   Axioms: {0}", axioms.Count());
            var blocks = impl.Blocks;
            Console.WriteLine("   Blocks:     {0}", blocks.Count);
            Console.WriteLine("   Statements: {0}", (from b in blocks from c in b.Cmds select c).Count());

            Console.WriteLine("============Boogie extractor {0} - end", impl.Name);
        }
    }
}
