# How to Set Up for Testing

## Setting Up the Postgres Database

> [!IMPORTANT]
> You need to have Postgres installed on your machine. Make sure to verify this before proceeding with the next steps.
> 
> If you are using Fedora or Rocky, for example, use the command below to install Postgres on your machine:
> ```
> sudo dnf in postgresql
> ```

First, the database access settings are in the `./config/database.yml` file, which contains the 3 types of `environment`. When running a Rails project, it will default to the `development` environment, so you can configure the access to your database either there or in `default`.

To provide the project with access to the `database`, you need to specify the database and `username` fields, and if necessary, the `password`.

## Bundle

This project is currently using Rails `7.2`, so make sure you have this version installed on your system.

After that, you'll need to run the following command to install the Rails "dependencies," also known as `gems`:

```shell
bundle install --local
```

If everything goes well, you should see a message like the following:

```
Bundle complete! 10 Gemfile dependencies, 83 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed
```

> [!NOTE]
> It’s possible that this process may not succeed on the first try. If necessary, try running the command again without the `--local` option.

## Running the Server

Once the above steps are completed, you can run your API using the following command:

```shell
rails server
```

This command should produce output similar to the following:

```text
=> Booting Puma
=> Rails 7.2.1 application starting in development 
=> Run `bin/rails server --help` for more startup options
Puma starting in single mode...
* Puma version: 6.4.3 (ruby 3.3.4-p94) ("The Eagle of Durango")
*  Min threads: 3
*  Max threads: 3
*  Environment: development
*          PID: 5569
* Listening on http://127.0.0.1:3000
* Listening on http://[::1]:3000
```

Now, if you access `http://127.0.0.1:3000,` your application should be up and running.

## Possible Requests

If you are using Postman (a desktop application that simplifies the process of creating HTTP requests), there is a collection of GET, POST, and PATCH/PUT requests for this project in the JSON file `testeeee.postman_collection.json`. You can import this file into Postman to have the exact same requests.
