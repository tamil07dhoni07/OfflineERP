# Chat

_Started 2026-08-24 17:44 UTC_

---

## User

<system-info comment="Only acknowledge these if relevant">
Project title is now "# Standalone Offline-First ERP — Master Development Prompt????You are a senior s"
The project currently has no files except possibly dotfiles — a `list_files` on the project root would return nothing else.
Current date is now August 24, 2026
</system-info>

<default aesthetic_system_instructions>
The user has not attached a design system. If they have ALSO not attached references or art direction, and the project is empty (the auto-managed _ds/ folder doesn't count), ask your opening questions with the ask_user tool. Whenever you ask opening questions in this project, include a design-system question in the form: the user's pick there sets the visual direction, so do NOT also ask about the visual aesthetic (no questions about vibe, colors or palette directions (including color-swatch svg-options questions), typography, mood, or art direction). Spend your other questions on everything else: audience, purpose, content, structure, scope, interactions, tone of copy. Exception: if the request already states the visual direction as a brand or concrete art direction, leave the design-system question out of your own questions (the app may still add one — it's skippable, and a skip doesn't change the stated direction) — but if they name a design system that isn't attached, keep the question: their pick there is what attaches it.

If the design-system question comes back unanswered — skipped without a pick (a "Not sure" / decide-for-me answer counts as a pick: it applies the effective default) — and no references or other art direction arrived either, THEN ask the visual-aesthetic questions before designing: a follow-up round (or one focused question) about vibe, colors, type, and mood is the right move once the design-system ask went unanswered. Do NOT just pick your own. Once you have a direction, use this guidance when creating designs:
- Choose a type pairing from web-safe set or Google Fonts. Helvetica is a good choice. Avoid hard-to-read or overly stylized fonts. Use 1-3 fonts only.
- Foreground and background: choose a color tone (warm, cool, neutral, something in-between). Use subtly-toned whites and blacks; avoid saturations above 0.02 for whites.
- Accents: choose 0-2 additional accent colors using oklch. All accents should share same chroma and lightness; vary hue.
- NEVER write out an SVG yourself that's more complicated than a square, circle, diamond, etc.
- For imagery, never hand-draw SVGs; use subtly-striped SVG placeholders instead with monospace explainers for what should be dropped there (e.g. “product shot”)

CRITICAL: ignore default aesthetic entirely if given other aesthetic instructions like reference images, design systems or guidance, or if there are user-authored files in the project already (the auto-managed _ds/ folder is not user-authored).
</default aesthetic_system_instructions>

<pasted_text name="Pasted text (985 lines)">
# Standalone Offline-First ERP — Master Development Prompt

You are a senior software architect and full-stack engineer. Design and build a production-ready **standalone, offline-first ERP system** using a single Flutter/Dart codebase targeting:

* Android
* iOS
* Windows Desktop
* Web

The system must be designed for long-term scalability, reliability, security, maintainability, and offline operation.

---

## 1. CORE ARCHITECTURE

Use this architecture:

```text
                         STANDALONE ERP
                              │
                         FLUTTER/DART
                              │
              ┌───────────────┼───────────────┐
              │               │               │
           Android           iOS           Windows
              │               │               │
              └───────────────┼───────────────┘
                              │
                        LOCAL DATABASE
                              │
                    SQLite + Drift
                              │
                       Backup Manager
                              │
                        Google Drive
                             
                              +
                             
                           WEB
                              │
                        Flutter Web
                              │
                    IndexedDB / Web DB
                              │
                     Offline Web Storage


                    INTERNET / OPTIONAL
                              │
                              ▼
                         FIREBASE
                              │
                ┌─────────────┼─────────────┐
                │             │             │
            Super Admin    Clients       Licensing
                             
```

The ERP's operational data must **NOT** be stored in Firebase.

Firebase is only for centralized management and control.

---

# 2. TECHNOLOGY STACK

Use:

### Frontend

* Flutter
* Dart
* Material 3
* Responsive/adaptive UI
* Flutter Web
* Flutter Windows
* Flutter Android
* Flutter iOS

### Local Database

Use:

* Drift
* SQLite for Android/iOS/Windows
* IndexedDB-compatible implementation for Web

Create a proper repository/data-access abstraction so business logic does not directly depend on a specific database implementation.

### Backend / Cloud Control

Use Firebase only for:

* Super Admin authentication
* Client management
* License management
* Device management
* Subscription information
* Application configuration
* Feature flags
* Remote application metadata

Do NOT store:

* Sales transactions
* Purchase transactions
* Inventory
* Accounting transactions
* Customers
* Suppliers
* Employees
* ERP operational data

inside Firebase.

---

# 3. OFFLINE-FIRST REQUIREMENT

The ERP must work without Internet.

After the initial installation and activation:

```text
Internet available
        │
        ▼
Firebase
        │
        ▼
License/configuration check
        │
        ▼
Local ERP
        │
        ▼
User can continue working offline
```

The ERP must not require continuous Internet access for normal ERP operations.

Users must be able to:

* Create customers offline
* Create suppliers offline
* Create products offline
* Create invoices offline
* Make sales offline
* Make purchases offline
* Update inventory offline
* Record payments offline
* Record expenses offline
* Use accounting offline
* Generate reports offline
* Print documents offline where supported

---

# 4. DATABASE ARCHITECTURE

Create a normalized relational database.

Use UUIDs for primary identifiers where appropriate.

Every important table should contain appropriate metadata such as:

* id
* created_at
* updated_at
* created_by
* updated_by
* deleted_at where soft deletion is appropriate
* sync/backup metadata where required

Design the database for:

* Multi-company
* Multi-branch
* Multi-warehouse
* Multi-user
* Role-based access control
* Audit history
* Tax support
* Financial accounting
* Future synchronization capability

---

# 5. ERP MODULES

Build the ERP using modular architecture.

## Company Management

* Companies
* Branches
* Departments
* Financial years
* Company settings
* Tax settings
* Numbering sequences
* Currency
* Units of measurement

## User Management

* Users
* Roles
* Permissions
* User groups
* Login history
* Device information
* Audit logs

## CRM

* Customers
* Customer groups
* Customer addresses
* Contacts
* Customer credit limits
* Customer balances
* Customer statements

## Supplier Management

* Suppliers
* Supplier groups
* Supplier contacts
* Supplier balances
* Supplier statements

## Product Management

* Products
* Categories
* Brands
* Units
* Product variants
* Barcodes
* SKU
* Purchase price
* Selling price
* Tax rate
* Reorder level

## Inventory

* Warehouses
* Stock locations
* Opening stock
* Stock movements
* Stock adjustments
* Stock transfers
* Stock valuation
* Batch management
* Serial numbers where required
* Expiry dates where required
* Reorder alerts

## Purchasing

* Purchase quotation
* Purchase order
* Goods receipt
* Purchase invoice
* Purchase return
* Supplier payment

## Sales

* Quotation
* Sales order
* Delivery note
* Sales invoice
* Sales return
* Customer receipt

## Finance

Implement proper double-entry accounting.

Include:

* Chart of accounts
* Account groups
* Journal entries
* General ledger
* Trial balance
* Profit &amp; loss
* Balance sheet
* Cash book
* Bank book
* Accounts receivable
* Accounts payable
* Payment vouchers
* Receipt vouchers
* Expense vouchers
* Contra entries
* Opening balances
* Financial periods

## Tax

Design tax functionality to be configurable.

Support:

* Tax rates
* Tax-inclusive pricing
* Tax-exclusive pricing
* Tax exemptions
* Tax reports
* Regional tax configuration

Do not hard-code the entire system around one country's tax system.

## HR

* Employees
* Departments
* Designations
* Attendance
* Leave
* Payroll
* Salary structures
* Employee documents

## Expenses

* Expense categories
* Expenses
* Expense approvals
* Payment methods
* Expense reports

## Reports

Create a reusable reporting framework.

Include:

* Sales reports
* Purchase reports
* Inventory reports
* Customer reports
* Supplier reports
* Tax reports
* Financial reports
* Profit &amp; loss
* Balance sheet
* Trial balance
* General ledger
* Cash flow
* Expense reports
* Employee reports

Reports should support:

* Date filters
* Company filters
* Branch filters
* Warehouse filters
* Export to PDF
* Export to Excel
* Print
* Search
* Pagination where appropriate

---

# 6. SUPER ADMIN SYSTEM

Create a separate Super Admin application/interface.

Super Admin must manage ERP clients.

Firebase should contain the control-plane data.

Super Admin capabilities:

* Create client
* Edit client
* Activate client
* Suspend client
* Delete/deactivate client
* View client details
* Manage subscriptions
* Generate licenses
* Renew licenses
* Revoke licenses
* Manage device limits
* View registered devices
* Revoke devices
* Configure feature availability
* Configure application version
* View client activity
* Manage application settings

The Super Admin must NOT have direct access to the client's private ERP transactions.

---

# 7. CLIENT / LICENSE SYSTEM

Each ERP installation belongs to a client.

Create:

```text
Client
 ├── Client ID
 ├── Company Name
 ├── License ID
 ├── License Status
 ├── Activation Date
 ├── Expiry Date
 ├── Maximum Devices
 └── Enabled Modules
```

Create a secure license validation mechanism.

The license should support:

* Initial activation
* Device registration
* Device limit
* Expiration
* Suspension
* Renewal
* Offline grace period
* Revalidation when Internet becomes available

Do NOT make the ERP unusable immediately when the Internet disappears.

---

# 8. LOCAL AUTHENTICATION

ERP users should be able to log in locally.

Authentication should work offline after initial client activation.

Store passwords securely using a strong password hashing mechanism.

Never store plaintext passwords.

Implement:

* Login
* Logout
* Password change
* PIN/quick login where appropriate
* Session timeout
* Role-based access
* Permission checks

---

# 9. GOOGLE DRIVE BACKUP

Implement a dedicated Backup Manager.

Features:

* Manual backup
* Automatic backup
* Scheduled backup
* Backup before restore
* Restore backup
* Backup history
* Backup verification
* Multiple backup versions
* Backup retention policy
* Failed-backup notification

Backup process:

```text
Local Database
      │
      ▼
Create Consistent Backup
      │
      ▼
Compress
      │
      ▼
Encrypt
      │
      ▼
Upload to Google Drive
```

Never upload sensitive ERP database data to Google Drive without encryption.

Use a secure encryption strategy.

The user must be able to restore the ERP from a valid backup.

---

# 10. WEB DATABASE

The Web application must also support offline operation.

Use an IndexedDB-compatible storage implementation.

Do not assume that browser filesystem access works like Windows.

Create a database abstraction:

```text
Repository
    │
    ├── SQLite/Drift implementation
    │       ├── Windows
    │       ├── Android
    │       └── iOS
    │
    └── Web implementation
            └── IndexedDB
```

Business logic must remain platform-independent.

---

# 11. RESPONSIVE UI

The application must adapt to:

### Mobile

* Bottom navigation
* Drawer navigation
* Mobile-friendly forms
* Large touch targets
* Responsive tables
* Mobile dashboards

### Windows

* Sidebar navigation
* Keyboard shortcuts
* Data grids
* Multi-column layouts
* Resizable panels
* Printing
* Barcode scanner support where possible

### Web

* Responsive dashboard
* Sidebar
* Data tables
* Filters
* Search
* Keyboard navigation
* Responsive forms

Do not simply stretch the mobile UI onto desktop.

Create adaptive layouts.

---

# 12. PROJECT STRUCTURE

Use clean architecture.

Prefer a structure similar to:

```text
lib/
├── core/
│   ├── database/
│   ├── security/
│   ├── licensing/
│   ├── backup/
│   ├── storage/
│   ├── networking/
│   ├── routing/
│   ├── theme/
│   ├── localization/
│   └── utils/
│
├── features/
│   ├── auth/
│   ├── dashboard/
│   ├── company/
│   ├── customers/
│   ├── suppliers/
│   ├── products/
│   ├── inventory/
│   ├── purchasing/
│   ├── sales/
│   ├── accounting/
│   ├── taxation/
│   ├── hr/
│   ├── payroll/
│   ├── expenses/
│   ├── reports/
│   ├── settings/
│   └── audit/
│
├── shared/
│   ├── widgets/
│   ├── models/
│   ├── services/
│   └── components/
│
└── main.dart
```

Use feature-based modularization.

Do not create one enormous file containing multiple modules.

---

# 13. STATE MANAGEMENT

Choose a mature Flutter state-management solution such as:

* Riverpod

Use dependency injection and keep UI, business logic, and database access separated.

Do not put business logic inside widgets.

---

# 14. SECURITY

Security is critical.

Implement:

* Secure local credential storage
* Password hashing
* Encryption for sensitive local data where appropriate
* Role-based authorization
* Permission checks
* Audit logs
* Secure Firebase rules
* Secure API communication
* License tamper resistance
* Input validation
* SQL injection protection
* Secure backup encryption
* Session management

Never trust the UI for authorization.

All permission checks must exist at the appropriate business/data layer.

---

# 15. AUDIT LOG

Record important operations:

```text
User
Action
Module
Record ID
Timestamp
Device
Old Value
New Value
```

Examples:

* Invoice created
* Invoice edited
* Invoice deleted
* Payment recorded
* Product price changed
* Stock adjusted
* User permission changed
* Backup restored

Audit logs must remain available offline.

---

# 16. DATA INTEGRITY

ERP accounting and inventory operations must be transactional.

For example, creating a sales invoice should correctly update:

```text
Sales Invoice
      +
Invoice Items
      +
Inventory Movement
      +
Customer Balance
      +
Accounting Journal
```

These related operations must succeed or fail together.

Never allow partial financial transactions.

---

# 17. BACKUP SAFETY

Before restoring a backup:

```text
Current Database
      │
      ▼
Automatic Safety Backup
      │
      ▼
Validate Selected Backup
      │
      ▼
Restore
      │
      ▼
Integrity Check
```

Never destroy the current database before verifying the backup.

---

# 18. PERFORMANCE

The ERP may eventually contain hundreds of thousands or millions of records.

Therefore:

* Use database indexes
* Avoid loading entire tables into memory
* Use pagination
* Use lazy loading
* Use database-level filtering
* Use transactions
* Optimize queries
* Avoid unnecessary rebuilds
* Cache appropriate reference data
* Use background processing for expensive tasks

The UI must remain responsive.

---

# 19. INTERNATIONALIZATION

Design the application for future localization.

Support:

* Multiple languages
* Currency
* Date formats
* Number formats
* Time zones
* Tax configuration
* RTL languages where required

Do not hard-code text directly into widgets.

---

# 20. PRINTING AND DOCUMENTS

Support:

* Invoice printing
* Purchase documents
* Receipts
* Quotations
* Delivery notes
* Reports

Create reusable document templates.

Support PDF generation.

Windows should support local printers.

Mobile should support PDF/share/print mechanisms available on the platform.

---

# 21. DEVELOPMENT RULES

Follow these rules strictly:

1. Use Dart null safety.
2. Keep code modular.
3. Follow SOLID principles.
4. Avoid duplicated business logic.
5. Use repository abstractions.
6. Use database transactions for financial operations.
7. Never put ERP transaction data in Firebase.
8. Never store plaintext passwords.
9. Never hard-code license secrets in the client.
10. Never rely on Internet availability for normal ERP operation.
11. Never couple business logic directly to Flutter widgets.
12. Write unit tests for financial calculations.
13. Write database tests for critical transactions.
14. Write integration tests for major workflows.
15. Document architectural decisions.
16. Keep platform-specific code isolated.
17. Use migrations for every database schema change.
18. Never silently delete production data.
19. Use soft deletion where appropriate.
20. Maintain a complete audit trail for sensitive operations.

---

# 22. DEVELOPMENT PHASES

Do not attempt to build every ERP module simultaneously.

Build in phases.

### Phase 1 — Foundation

* Flutter project
* Architecture
* Theme
* Routing
* Dependency injection
* Local database
* Database migrations
* Authentication
* User/roles/permissions
* Company setup
* Firebase connection
* Client activation
* License system

### Phase 2 — Master Data

* Customers
* Suppliers
* Products
* Categories
* Units
* Warehouses
* Tax configuration

### Phase 3 — Sales

* Quotations
* Sales orders
* Invoices
* Returns
* Receipts
* Inventory integration

### Phase 4 — Purchasing

* Purchase orders
* Goods receipt
* Purchase invoices
* Returns
* Supplier payments

### Phase 5 — Inventory

* Stock movements
* Transfers
* Adjustments
* Batches
* Serial numbers
* Stock valuation

### Phase 6 — Accounting

* Chart of accounts
* Journals
* Ledger
* Trial balance
* P&amp;L
* Balance sheet
* Receivables
* Payables
* Cash/bank

### Phase 7 — HR/Payroll

* Employees
* Attendance
* Leave
* Payroll

### Phase 8 — Backup

* Google authentication
* Google Drive integration
* Encryption
* Backup
* Restore
* Backup history

### Phase 9 — Reports

* Dashboards
* Reports
* PDF
* Excel
* Printing

### Phase 10 — Production

* Testing
* Performance optimization
* Security audit
* Migration testing
* Backup/restore testing
* Windows packaging
* Android release
* iOS release
* Web deployment

---

# 23. IMPORTANT DEVELOPMENT APPROACH

Before writing large amounts of code:

1. Create the complete architecture.
2. Create the database ER diagram.
3. Define all major entities and relationships.
4. Define the Firebase schema.
5. Define the license architecture.
6. Define the backup architecture.
7. Define the repository interfaces.
8. Define platform-specific database implementations.
9. Define the navigation structure.
10. Then implement module-by-module.

Do not make architectural decisions randomly during implementation.

Whenever a requirement is ambiguous, identify the ambiguity and propose the safest scalable solution before implementing it.

---

# 24. FINAL GOAL

The final application should behave as a professional standalone ERP:

```text
                    SUPER ADMIN
                         │
                      Firebase
                         │
          ┌──────────────┼──────────────┐
          │              │              │
       Client A       Client B       Client C
          │              │              │
      ┌───┴───┐      ┌───┴───┐      ┌───┴───┐
      │       │      │       │      │       │
    Mobile  Windows Mobile Windows Mobile Windows
      │       │      │       │      │       │
      └───┬───┘      └───┬───┘      └───┬───┘
          │              │              │
      Local DB       Local DB       Local DB
          │              │              │
       Drive          Drive          Drive
       Backup         Backup         Backup
```

The primary objective is:

**ONE CODEBASE + MOBILE + WEB + WINDOWS + OFFLINE-FIRST + LOCAL ERP DATA + FIREBASE SUPER ADMIN + GOOGLE DRIVE BACKUP.**

Build it as a production system, not as a prototype. Prioritize data integrity, offline reliability, security, maintainability, and future scalability.

</pasted_text>

<!-- The user explicitly selected the following skills for this project, as attachments to their message. These are not optional context — they define how you work. Use them. -->
<attached-skill name="Design Components">
This project uses Design Components: every design is a single streaming `Name.dc.html` file. The full authoring spec is in your system prompt under "Writing code — Design Components" — follow it. Author and edit `.dc.html` content with the `dc_write`, `dc_html_str_replace`, `dc_js_str_replace`, and `dc_set_props` tools (not `write_file`; `str_replace_edit` works but won't stream); template edits stream into the live preview as you type.
</attached-skill>


<system-reminder>Auto-injected reminder (ignore if not relevant): do not recreate copyrighted or branded UI unless the user's email domain matches that company. Create original designs instead.</system-reminder>

## Assistant



## Assistant

I can't compile a Flutter codebase here — what I *can* do is the design layer of this spec: the ERP screens as an interactive prototype, the Super Admin console, the architecture/ER diagrams as documents, or a spec deck for your dev team. A few calls before I start:

_[tool: ask_user]_

_[tool: ask_user]_

Form's up — waiting on your picks (deliverable, platform, modules) before I build.

## User

Answered — deliverable: Interactive ERP prototype (clickable screens, real-ish data), Design system + component library for the ERP UI; modules: Dashboard, Sales / invoicing, Purchasing, Inventory, Customers & suppliers, Products, Accounting / GL, Tax, HR / payroll, Reports, Company setup, Auth + licensing; audience: Developers implementing it; region: GST, SGST,CGST,IGST

## Assistant



## Assistant

Design direction came back unanswered — one quick round on look and feel, then I build.

_[tool: ask_user]_

Waiting on the four visual picks.

## User

Answered — vibe: Warm business software — soft off-white paper tones, muted ink, friendly forms; accent: #0f766e

## Assistant

_[tool: dc_write]_

_[tool: ready_for_verification]_

## User

Found issues — fixing…

## Assistant

_[tool: run_script]_

_[tool: ready_for_verification]_

Fixed the ampersands and the duplicate "Export" label.

The prototype covers all 12 modules: dashboard, sales (list + invoice composer with GST split and a double-entry posting preview), purchasing, inventory, master data, finance, GST/GSTR-1, HR/payroll, reports, company setup, license & devices, audit log, plus the offline login screen. Tweaks: density, offline state, and intra- vs inter-state tax regime.

Next, if you want it: the design system / component library file (tokens, controls, table and form patterns) as the second deliverable you picked.

