#[macro_use]
extern crate rustler;
// extern crate parquet;
// Including this causes a massive error that starts with: error: linking with `cc` failed: exit code: 1

use rustler::{Encoder, Env, Error, Term};

mod atoms {
    rustler_atoms! {
        atom ok;
        //atom error;
        //atom __true__ = "true";
        //atom __false__ = "false";
    }
}

rustler::rustler_export_nifs! {
    "Elixir.Wrangler.ParquetSerializer",
    [
        ("add", 2, add),
        ("write_parquet", 2, write_parquet)
    ],
    None
}

fn add<'a>(env: Env<'a>, args: &[Term<'a>]) -> Result<Term<'a>, Error> {
    let num1: i64 = args[0].decode()?;
    let num2: i64 = args[1].decode()?;

    Ok((atoms::ok(), num1 + num2).encode(env))
}

fn write_parquet<'a>(env: Env<'a>, args: &[Term<'a>]) -> Result<Term<'a>, Error> {
    // let path: String = args[0].decode()?;
    let path_str: String = args[0].decode()?;
    let _num2: i64 = args[1].decode()?;
    println!("{}", path_str);


    Ok((atoms::ok(), 0).encode(env))
}
