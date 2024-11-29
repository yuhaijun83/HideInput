using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HideInput
{
    internal class Program
    {
        private const string CON_SQLPLUS = "SQLPLUS";
        private const string CON_EXPDP = "EXPDP";

        static void Main(string[] args)
        {
            string strFlg = string.Empty;

            if (args.Length > 0)
            {
                strFlg = args[0];
            }

            StringBuilder input = new StringBuilder();
            while (true)
            {
                var key = Console.ReadKey(intercept: true); // intercept=true 入力内容を非表示
                if (key.Key == ConsoleKey.Enter)
                {
                    break;
                }
                else if (key.Key == ConsoleKey.Backspace && input.Length > 0) // backspaceを対応
                {
                    input.Remove(input.Length - 1, 1);
                }
                else if (!char.IsControl(key.KeyChar)) // 制御文字を対象外
                {
                    char chrKeyTmp = key.KeyChar;

                    if (strFlg == CON_SQLPLUS) // sqlplus
                    {
                        if (chrKeyTmp == '%')
                        {
                            input.Append('%');
                            input.Append(chrKeyTmp);
                        } 
                        else if (chrKeyTmp == '=')
                        {
                            input.Append('\\');
                            input.Append(chrKeyTmp);
                        }
                        else
                        {
                            input.Append(chrKeyTmp);
                        }
                    }
                    else if (strFlg == CON_EXPDP) // expdp
                    {
                        if (chrKeyTmp == '=')
                        {
                            input.Append('\\');
                            input.Append(chrKeyTmp);
                        }
                        else
                        {
                            input.Append(chrKeyTmp);
                        }
                    }
                    else // common
                    {
                        input.Append(chrKeyTmp);
                    }
                }
            }

            Console.WriteLine(input.ToString());
        }
    }
}
