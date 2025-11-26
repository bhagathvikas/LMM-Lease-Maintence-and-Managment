# LMM-Lease-Maintence-and-Managment
A full-stack SAP BTP ABAP RAP application for managing Lease Contracts, Invoices, and Analytics, built entirely on the SAP BTP ABAP Environment (Trial). The solution exposes OData V4 services and a Fiori Elements UI for contract processing, invoice generation, and analytical insights.

🚀 Project Overview

This project demonstrates a complete RAP scenario with:

Contract Management (Create, View, Update, Delete)

Invoice Generation (action-based processing)

Contract Analytics (aggregated rent, contract count, average rent, etc.)

Fiori Elements UI using List Report + Object Page

Fully deployable on SAP BTP ABAP Environment (Trial)

🛠️ Tech Stack
Layer	Technology
Backend	ABAP RAP, CDS Views, Behavior Definition/Implementation
Services	OData V4 (Managed Scenario)
Frontend	SAP Fiori Elements (List Report/Object Page)
Tools	SAP BAS, ADT in Eclipse, SAP BTP ABAP Trial
Storage	Custom DB Tables (Contracts, Invoices)
📦 Features
1️⃣ Contract Management

Create/Update/Delete Contracts

Automatic default values + validation checks

Business actions:

Activate Contract

Generate Invoice

2️⃣ Invoice Management

Auto-generate invoice entries from RAP action

Stores date range, amounts, tenant details

Includes PDF URL field for future enhancements

3️⃣ Contract Analytics

Aggregated insights per asset

Contract count, total rent, average rent

Delivered through a CDS analytical view

4️⃣ Fiori Elements UI

List Report for contract overview

Object Page for contract details

Auto-binding with OData V4 service
