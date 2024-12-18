import 'dart:io';
import 'package:vania/vania.dart';
import 'package:store/database/migrations/create_customers_table.dart';
import 'package:store/database/migrations/create_orderitems_table.dart';
import 'package:store/database/migrations/create_orders_table.dart';
import 'package:store/database/migrations/create_products_table.dart';
import 'package:store/database/migrations/create_productsnotes_table.dart';
import 'package:store/database/migrations/create_vendors_table.dart';
import 'create_users.dart';
import 'create_personal_access_tokens.dart';

void main(List<String> args) async {
  await MigrationConnection().setup();
  if (args.isNotEmpty && args.first.toLowerCase() == "migrate:fresh") {
    await Migrate().dropTables();
  } else {
    await Migrate().registry();
  }
  await MigrationConnection().closeConnection();
  exit(0);
}

class Migrate {
  registry() async {
		 await CreateCustomersTable().up();
     await CreateOrdersTable().up();
     await CreateVendorsTable().up();
     await CreateProductsTable().up();
     await CreateProductsnotesTable().up();
     await CreateOrderitemsTable().up();
		 await CreateUsers().up();
		 await CreatePersonalAccesToken().up();
	}

  dropTables() async {
		 await CreatePersonalAccesToken().down();
		 await CreateUsers().down();
		 await CreateOrderitemsTable().down();
     await CreateProductsnotesTable().down();
     await CreateProductsTable().down();
     await CreateVendorsTable().down();
     await CreateOrdersTable().down();
     await CreateCustomersTable().down();
	 }
}
