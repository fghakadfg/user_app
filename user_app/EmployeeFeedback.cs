using System;
using System.Collections.Generic;
using System.IO;

namespace user_app;

public partial class EmployeeFeedback
{
    public int IdFeedback { get; set; }

    public int EmployeeId { get; set; }

    public string Comment { get; set; } = null!;

    public DateOnly Date { get; set; }

    public virtual Employee Employee { get; set; } = null!;



    public void AddNote(String userComment)
    {


        using (var context = new PostgresContext())

        {
            int id;

            using (StreamReader reader = new StreamReader("example.txt"))
            {
                string line;

                line = reader.ReadLine();

                id = int.Parse(line);


            }


            EmployeeFeedback ef = new EmployeeFeedback();


            ef.EmployeeId = id;
            ef.Comment = userComment;
            ef.Date = DateOnly.FromDateTime(DateTime.Now);


            context.EmployeeFeedbacks.Add(ef);


            context.SaveChanges();

        }

    }


}
