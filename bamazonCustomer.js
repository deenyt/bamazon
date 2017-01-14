var mysql = require("mysql");
var inquirer = require("inquirer");
var tab = "\t";
var ret = "\n";

// ***** CONNECT TO THE DATABASE *****

var connection = mysql.createConnection({
  host: "localhost",
  port: 3306,
  user: "root",
  password: "cannonbr1",
  database: "Bamazon"
});

// show connected successfully
connection.connect(function(err) {
  if (err) throw err;
  // console.log("connected as id " + connection.threadId);
});

// ***** function start runs the program ******
function start() {
  displayProductInfo();
  beginOrder();
}

// *** get product info from the database and display
function displayProductInfo() {
  connection.query("SELECT * FROM products", function(err, res) {
    if (err) throw err;  
    console.log(ret + "ProdID\tProduct Name\tDepartment Name\tPrice\t# In Stock");
    console.log("-----------------------------------------------------------");

    for (var i = 0; i < res.length; i++) {
      console.log(res[i].product_id + tab + res[i].product_name + tab +
        res[i].product_department_name + tab + res[i].product_price + tab + res[i].product_stock_quantity);
    }
    console.log("-----------------------------------------------------------");
  
  });

// ** function to prompt the user to purchase product
function beginOrder() {
  inquirer.prompt({
    name: "product_id",
    type: "input",
    message: "Which product (id) to purchase?" + ret + ret
  }).then(function(answer) {
    if (parseInt(answer.product_id)) {
	  connection.query("SELECT product_stock_quantity FROM products WHERE product_id = "+answer.product_id, function(err, res) {
	     console.log("There are "+res[0].product_stock_quantity+" in stock. How many?");

		  inquirer.prompt({
		    name: "quantity",
		    type: "input",
		    message: "How many?" + ret + ret
		  }).then(function(answer2) {
		    if (res[0].product_stock_quantity >= answer2.quantity) {

		            connection.query(
		              "UPDATE products SET product_stock_quantity='" + (res[0].product_stock_quantity - answer2.quantity) +
		              "' WHERE product_id='" + parseInt(answer.product_id) + "'",
		              function(err, res2) {
		                if (err) {
		                  throw err;
		                }

		                console.log(ret + "You have purchased "+answer2.quantity+" of that item "+parseInt(answer.product_id)+"!"+ret+ret);
                    // begin purchasing again
		                start();
		              
		              });
		          }
		    else {
		      console.log(ret + "Not enough avaliable: "+answer2.quantity);
		    }
		  });

	  });
  }
    else {
        console.log(ret + "Not a number: "+answer.product_id);
    }
  });
};

// end begin order function
};


//  The beginning of the program
start();

