Return-Path: <linux-efi+bounces-2176-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FB69D1CA4
	for <lists+linux-efi@lfdr.de>; Tue, 19 Nov 2024 01:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFB2D282CAC
	for <lists+linux-efi@lfdr.de>; Tue, 19 Nov 2024 00:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620A03B298;
	Tue, 19 Nov 2024 00:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FlT0VjI/"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDF71B813;
	Tue, 19 Nov 2024 00:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731976774; cv=fail; b=OmK9m556RXOiwWFoXRkSU1RIQ8Ji+P2h8uJrzV3a90AOwOEjDMfz2HlwfYMBlBuS6PNG5rKRxvXHzZC5Bnl9p3Se31c3muxe3/fdwEgM9yJx3EG4T4qs8gyNqgmYNY79XiSjuKTwr90nnzZSs/NQXCqdup6M48r6bGiIdD8aQ/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731976774; c=relaxed/simple;
	bh=vM3eYy/Z+VEBWavkbs8ERQvH8ZeVd1hob6BD4BlWXXQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gxt36tLhi/+gE/RgRoDDNrCl+JRz0gAjOZrbNjPT9r/90lvhEN0fWRQ3N6GZ/MMs8/B5LkAXQNU75tuSycTWgdjFs0huBLENwJWM8LQokn1446i9q79c2K7AtWC0T7VK7s91XMvafi6cHRz7gybZKEFBVCy0ftMVfFHO2eCInZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FlT0VjI/; arc=fail smtp.client-ip=40.107.92.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wc0Hql0RhiSF88zVJc2T46VRywVcCtyUGQr3dkiuLNnrX8DkXXKLdHdLOIQgQ091LlCo8JBVW82xKY9O9f4dOukP8MYv5csdz9ksRkrA1Pw1wT/urt+/wv56PrnZP9JDKY5r/SWSiesCqrOntMj0jUnVZEiHMFbmFqj9phMDlDTWQnNUeeWi/gzINNYGvxPXsU/x64iktjX2+ww0sC0uNE5kPJDlrsM5sh6dL/Te5Mpq8Vs80J243gQlhtRzdHhkIQUjO2ri6x43GBzGK6YDaJxZzSqTmlwF4qeG3NykFmW0IBlms66GvGENSLH2lTM94QZwTaBMx/4DIeY8SAIufw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65M8XrTr6xsyMeIaVWniIJ0CrgkrKpX/DF8w8B0PeuE=;
 b=kp0jK2NFD9QhU+7I40kSdx4/6M1ILf7GVwAE2Uevj5i+rVYKZqMef3zA+EVWKzsM/uIBmsVLXNouoUR/43+qffr/pCMBmDn1FkiGpw7qtKFcrBs+T3toKfsWMLpHIxM/vg4nWrhuXJ4Aj7KblF7RaY4ONg4UfFvGjwhBNR6VW3B29OppoOlMmAGYaCIswDi++gjB6gCbRh5edZJoQJZRAccUhLt2fdViGsAhLbZHAucNP2pENicLKYMEbhjnw17docsFJ0X/aiDLZ8+h018oThSd9n2XpjcLVRxfCuU/VihsvePMaRSCBbsYUxragvVi5BvulQ102pVe5GjVrQBxpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65M8XrTr6xsyMeIaVWniIJ0CrgkrKpX/DF8w8B0PeuE=;
 b=FlT0VjI/85KCiYRnwsZWPwpl7lPRg6UD7aCio1WTFdh2gzLgCyxdxLNxQjBQPXOoNKiSdWXMa1O9AOzG1rRerS5492Ie/td9BVy1od8NubXYjN2De/YiWrP+qrsMS4avEXwfhmRaUj1OSj5N0jqAxcjNNQvF9NIr8h27S3YiWIs=
Received: from DM6PR10CA0033.namprd10.prod.outlook.com (2603:10b6:5:60::46) by
 SA3PR12MB8763.namprd12.prod.outlook.com (2603:10b6:806:312::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 00:39:28 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:60:cafe::13) by DM6PR10CA0033.outlook.office365.com
 (2603:10b6:5:60::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22 via Frontend
 Transport; Tue, 19 Nov 2024 00:39:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 00:39:28 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 18:39:26 -0600
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>, "Smita
 Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v3 3/7] efi/cper, cxl: Remove cper_cxl.h
Date: Tue, 19 Nov 2024 00:39:11 +0000
Message-ID: <20241119003915.174386-4-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241119003915.174386-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20241119003915.174386-1-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|SA3PR12MB8763:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f2c1f74-866e-4b8d-d4f3-08dd0832a02a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OE8f6zsXRTsXVSCdHhCSyeyZa1sMu/TeR4s1avEGB++HWt6RWnmDSytj/7OI?=
 =?us-ascii?Q?UL5GdX6WzXGNgQ7Yagq4FMNmqGFSFlINzUaKPOyKzGPQNUW0s4vtO3/gucH6?=
 =?us-ascii?Q?E0Kn5jGtKHQwbUn8VxjH+WkGrHBg0OlcgI7OYRZ+urhqbUpF/+OYf/W9lqo7?=
 =?us-ascii?Q?YK0Lc0wQnDV7ay0H/yEwzG/QmpWNUkqEKuYds1XhPc97AL5wP4ebZn5hW+O5?=
 =?us-ascii?Q?MBIYkeZyrIcroDvGPtGHrGwc0flGBKbpQowNVgUC7iQjX7fKZWc+BzxATerS?=
 =?us-ascii?Q?B/RqLvLXldbtFeSN/NWZhJxjR89/QSCe/Za86/v/MI5rDCS93Pi7oZtnhUie?=
 =?us-ascii?Q?z/RnIkZjasVJ+NlRdhp2zJ/98rEK5qw0W6D8bWp2pTMO3ignms5kv4VZpYay?=
 =?us-ascii?Q?lCXXajIvFA0e4x1F3rOm6KgIgsT03+4Meq/l1sQcIRSxozj/KaLQqIt+TA3M?=
 =?us-ascii?Q?Fqb8DnxE9JU6dKVrcg8GxK3Fbl/rOIpsLKnCc8/v5yX+5/knz7VJBvMBf1p8?=
 =?us-ascii?Q?lLS1b39A+PupN0hEikk06cKABwWjHPlEeo9zZqREOnJO4Xg4jsnPzZZRoR7L?=
 =?us-ascii?Q?ljqmEkCQ/e6nqce1GoL8XJcOjOuM8VcBKUe3osM5rK881w/74poFYSImyvDR?=
 =?us-ascii?Q?G7sEKcISXBVfh7ZfFZa6XKgtjqkkB9OrSGR1BJ7EHR1dArOLF8z5X8B3USBo?=
 =?us-ascii?Q?7+bFZIVw3c4EoYmf655D7Hh+m9PcAeRR9OmeXiVY4YdJq09JnamT22kuE+tQ?=
 =?us-ascii?Q?5S5W630LmsVdXWKrG6bGHklAD9pWZXCV13zOhpB518riqi8yASSl+mLFDYhf?=
 =?us-ascii?Q?6g1HrewMaRN7HVj7ye/Kt26EToz4Q/Jtb6xmz6/jbEz84vjjmKK656WI6wwn?=
 =?us-ascii?Q?ZcjM70Ewlt3sJ03oO4mdgx/o7ysaWRKDhjowVMjg1+Gw/TQH2CuOOcI2p61+?=
 =?us-ascii?Q?QvVyIrqb57HrrbP+RlZHXOcPWZy4uR31q/F7VkOCSqPcSUbtwM59VrAXFtki?=
 =?us-ascii?Q?prhmkGOASCAXbHf23pCG415JhCl8W3JbcpUrixfZblxFnjvifQTU7cXyI6d3?=
 =?us-ascii?Q?gXCCi60hdOJ/s8ekdFZ8svuMV3O1dGFihiFauPcE8I6szHRNOVg9+H05ISPn?=
 =?us-ascii?Q?ipGc/1HFCD9xwWSc7B5LbMvHDqa3gKQuntz/H0nIJEabhyNGoND22sIdqGHO?=
 =?us-ascii?Q?cCk22HW4+SDuhEQHLCpvU4mZ1J7aqdCOPQXG8dtFH9X5PHMK9ef59Y2AwAL9?=
 =?us-ascii?Q?+8Q9VNdq+XQAwh3XN7XciSS/cIbxLRYi77hj/YpwLfcxak1neioX9rZkeWpl?=
 =?us-ascii?Q?iMQkQFUtwZSQk34Rv8M6hh52XBb4QvY3TNnc7jQu7TtGYTLEiS+EcfODozNP?=
 =?us-ascii?Q?a82Re16dYAddikbk5o48wC7I4XqCHx+HU23RjSKI6iyEF2a0Yg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 00:39:28.4089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f2c1f74-866e-4b8d-d4f3-08dd0832a02a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8763

Move the declaration of cxl_cper_print_prot_err() to include/linux/cper.h
to avoid maintaining a separate header file just for this function
declaration. Remove drivers/firmware/efi/cper_cxl.h as its contents have
been reorganized.

Eliminate its corresponding #include directives from source files that
previously included it, since the header file has been removed.

No functional changes.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/firmware/efi/cper.c     |  1 -
 drivers/firmware/efi/cper_cxl.c |  1 -
 drivers/firmware/efi/cper_cxl.h | 16 ----------------
 include/linux/cper.h            |  4 ++++
 4 files changed, 4 insertions(+), 18 deletions(-)
 delete mode 100644 drivers/firmware/efi/cper_cxl.h

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index ae1953e2b214..928409199a1a 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -25,7 +25,6 @@
 #include <acpi/ghes.h>
 #include <ras/ras_event.h>
 #include <cxl/event.h>
-#include "cper_cxl.h"
 
 /*
  * CPER record ID need to be unique even after reboot, because record
diff --git a/drivers/firmware/efi/cper_cxl.c b/drivers/firmware/efi/cper_cxl.c
index 64c0dd27be6e..8a7667faf953 100644
--- a/drivers/firmware/efi/cper_cxl.c
+++ b/drivers/firmware/efi/cper_cxl.c
@@ -9,7 +9,6 @@
 
 #include <linux/cper.h>
 #include <cxl/event.h>
-#include "cper_cxl.h"
 
 static const char * const prot_err_agent_type_strs[] = {
 	"Restricted CXL Device",
diff --git a/drivers/firmware/efi/cper_cxl.h b/drivers/firmware/efi/cper_cxl.h
deleted file mode 100644
index 5ce1401ee17a..000000000000
--- a/drivers/firmware/efi/cper_cxl.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * UEFI Common Platform Error Record (CPER) support for CXL Section.
- *
- * Copyright (C) 2022 Advanced Micro Devices, Inc.
- *
- * Author: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
- */
-
-#ifndef LINUX_CPER_CXL_H
-#define LINUX_CPER_CXL_H
-
-void cxl_cper_print_prot_err(const char *pfx,
-			     const struct cxl_cper_sec_prot_err *prot_err);
-
-#endif //__CPER_CXL_
diff --git a/include/linux/cper.h b/include/linux/cper.h
index 5c6d4d5b9975..0ed60a91eca9 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -605,4 +605,8 @@ void cper_estatus_print(const char *pfx,
 int cper_estatus_check_header(const struct acpi_hest_generic_status *estatus);
 int cper_estatus_check(const struct acpi_hest_generic_status *estatus);
 
+struct cxl_cper_sec_prot_err;
+void cxl_cper_print_prot_err(const char *pfx,
+			     const struct cxl_cper_sec_prot_err *prot_err);
+
 #endif
-- 
2.17.1


