Return-Path: <linux-efi+bounces-2624-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE64A10628
	for <lists+linux-efi@lfdr.de>; Tue, 14 Jan 2025 13:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40367169AF0
	for <lists+linux-efi@lfdr.de>; Tue, 14 Jan 2025 12:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F112234CF4;
	Tue, 14 Jan 2025 12:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wUzG8uQI"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2089.outbound.protection.outlook.com [40.107.95.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7BB3DAC10;
	Tue, 14 Jan 2025 12:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736856297; cv=fail; b=oRuDAW1vtuNHnaomikriynnEeu12MX0zGi08nX6pvyyKNvylRUJFvLE6vpRaxTh1e0w0/ZJ0wgYw3QQwGRvB8ybZOkyuAD9xXBcoaZ78KUeErL4YCLN1fmM9+Y7w/C4gMdQbUjuEl9DtW546fvrSUdh3oDYFz2eLu8Ksg0Dn15Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736856297; c=relaxed/simple;
	bh=nYaiLCXwtGA1yzQ3FpywASE+43Fss8ZM46Nq9admaHA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o87E6rpIdioXIOo9bp6pw9A16OiMwFADzJARmVB+r4r4MCvMPDN62TYIX0qWOp33qvsxQe/VOMRt2GKJXLBT0TG35Q512C3mO+eLPuu8Se/l+3PT8boi6PMt97Rbpuo76GnegjtNqXMKwoquHBF2nrFroXdaufoyiywe5+U6oMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wUzG8uQI; arc=fail smtp.client-ip=40.107.95.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gsZWj0JiHa9lYUVUGSacZfz0HefHZUp7yp0AhaT70rAHwuZgL1cANaNK7Ea7KQg1Xc5MnSe+4N6yT1/7TpmAY/4WEe8HG9Jn4gltzOtdHkYie01984PG6U8jC1iYxLi0Vu854AEV9FFZhmLIp+YSJG+t96YTECH1r2K/mMVPY4xAGn27zJGSi7iiJXOLYwTnHVZcL42/QzwV1CoCwpurtgnbBEuGEm0keO9ryht37IRXKxs347xm65WJk4wT0BjO/Yj+hok+Kh5kBY44WrYRVomCNPKtxKJIURWzQeUD7Og7dYzC2wH1gjKyOYPKco82Ns2Rypkx7iyV/PUZ03ifQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wnv0NAjgwjzZ0rGP2HqkEEsTfMC6mOSy6sVEKS7KizI=;
 b=u9r6fNKioqhJj0MY9dXnGaGexIXtoaaAqov7PXI8Vi+6FlQpZbae54WVzX8IuN8tnzcyD+mKvY4pkvCl6pCW6qCZAEgNV8r/f2XMvdfUb7VgpKE2iLseJE+nT9cG7rY9EqvjEXCNXPAVSPdMofTeNSs04Y8KNRX1vZa5Aqo6zEos+8T9uk9nuz1iscq0QOOMRGw87BvVx9KGMgx+e86U2qxOR6lx49pVGvvBliovjgiwg6qV2F47IHqQmJjaObE0c3zZUyi4OfBSNSqDhvuD7wCLZwWHgg+CgsTP5rhg70d03prMxAskQ0G1JDp2KKb6zzETFffeDHsTxoTGcjSGPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnv0NAjgwjzZ0rGP2HqkEEsTfMC6mOSy6sVEKS7KizI=;
 b=wUzG8uQIBbd+Vt3NyMNFXP9vBiEfpHRKXBi7884LnV4fWlOW2/afOx++Z2A96EbiwiQ3tPmeb68TT5UDVKP7XbUXUuU0KcbKQUGiUwjT8lkHMl1M+asgCgDyiLXQKkWq72Rf79BtS6HKXEevIrewYiw7U59wZRdaJ1Ogv6lDLA8=
Received: from SA1P222CA0124.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::12)
 by DM4PR12MB8559.namprd12.prod.outlook.com (2603:10b6:8:17d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 12:04:43 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:3c5:cafe::d9) by SA1P222CA0124.outlook.office365.com
 (2603:10b6:806:3c5::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.13 via Frontend Transport; Tue,
 14 Jan 2025 12:04:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Tue, 14 Jan 2025 12:04:43 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 14 Jan
 2025 06:04:41 -0600
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>, "Smita
 Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v5 3/5] efi/cper, cxl: Remove cper_cxl.h
Date: Tue, 14 Jan 2025 12:04:25 +0000
Message-ID: <20250114120427.149260-4-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250114120427.149260-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20250114120427.149260-1-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|DM4PR12MB8559:EE_
X-MS-Office365-Filtering-Correlation-Id: a5df755d-a057-4d22-e683-08dd3493a1b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SPjQEBZ7yEd9UpIDb0asq3cPnoM/0Mwt+xdyrf1NTGUMk7VeKeqA56fxRxnw?=
 =?us-ascii?Q?7RbQrwUBV9DAXg69PLeHD22QutgjY2/TTIcUREBtztKUnuXA13cyf37asIiM?=
 =?us-ascii?Q?4alJvJYN+Ot5cnQxLC5uJQhiT5sMxMEb+wPOyDbB8g/wmJt/QtS5eI9ktlDq?=
 =?us-ascii?Q?VCb760c2XUf+B1Q63xjp/NMzjIS/zPrTb2U3FBtf0YRigcCAyl1QDMrnDllq?=
 =?us-ascii?Q?q1zkk6WnXTIO3OncpnY1k8QsGNlqRNHVL2G4WaKUI28a9aiUyHTwOX85FHcn?=
 =?us-ascii?Q?3Dk0giepnQfLsjt79VjNCjWAN5c043DYP1SxGY8Mq0wV8zs5dyWLJIkiHiLA?=
 =?us-ascii?Q?KTkodeJGO2weMuBXFLU7xZjwgFiKIcS5TSG3nM15SppzLTjTRRzwjdClwLOX?=
 =?us-ascii?Q?vzpRVa3+Qcz9LxuJcKURvRNc5ftzTBhhTlAjIPyfQXqha8vErJCaF4nT/UPh?=
 =?us-ascii?Q?NGcVxIOwx1uli/rzoeYN/IJt5HO9IyW1nRVd+A/B3xmOnWNnYgNuxFCkdtAi?=
 =?us-ascii?Q?LlZomSheI7TonPJhgNW/Awk0Wm+yvXazzGZ3tPyZV0jHKd13PLWd8cgvLdeJ?=
 =?us-ascii?Q?G/3S9E29nNCIz+qFPlNkjN4Hpwqeho30//WRohmdBhE+D6otVXXK72OAowJT?=
 =?us-ascii?Q?5uGCXm9LRCnBZaJ7wZgiWT3nXVuoEo61YtJpyqhl/wQuvYygtfHZ0PjpjEhk?=
 =?us-ascii?Q?5l26ABvR12YQYwXn5FM9FdsOKT93G1BfKmjy8O6XA8VoPUzxuPj/mZXPwppH?=
 =?us-ascii?Q?Tmndx8OGd/hvUzPCno9WPqEBytllWWas4eUGLvdhjjJ9IocT7ksos94mQayN?=
 =?us-ascii?Q?CSVUFOBeOQ9eBvtegVVTQFI4yftz2ouapvoT69kPCJxSKBBjQfgn5uodIWHP?=
 =?us-ascii?Q?3bR8DT5v9MVoY7UFwiTDVHxZoXkJJuBNbsAJo48/as2naug4JXVt2TabYXYc?=
 =?us-ascii?Q?dpaBEyxDHa55kc/V6lx4ykPhmpRYNTw3Iq0lC+k16NL/mXpYjPfhwnO0TFEB?=
 =?us-ascii?Q?tOS5j7RGSq7FvpW5i7ZnQ9fUwy/q99qX9kPfjOSEU8xwoc8PTaHGjOrkCydU?=
 =?us-ascii?Q?E4chU7Cxn1jvcqRYAnrgcjMueCY1JpxSHEKg/oGLtlEgbTC2D/SwjOSMhl6A?=
 =?us-ascii?Q?q1WlCLlAE2XS36T4RSn+MAU7+SOKEynC2sDeJUfzPnI+u/oDBygJrlVGaNWO?=
 =?us-ascii?Q?nTwAsGfnrNt/0CUCpWsAWAuE8PTmwpIqp233zL6J1XiXy2q/Y07ZxjcVSkSy?=
 =?us-ascii?Q?ouhNkAGtbXFFI981Wk/iluyGNwgFGHSyx+xlhYpsDoctfoYH05IZc6G+POV9?=
 =?us-ascii?Q?t4hcK5NGxoo7CvpcIQ5pU+dXvl+ZZP+1kZdCuWaO/0ELGVm2/FWE8+cDoZ4W?=
 =?us-ascii?Q?7Wf5S3WOdCEdcBxiIW4mCG/3nyXqKW/nJqbo0trrLyxe0ZkhjzP/oWyBGHsu?=
 =?us-ascii?Q?rNLraoP1dxYM+Z3FtyZ+mTIjHty0+i485C83NyNBA24NUV+BEAoPikJbG134?=
 =?us-ascii?Q?qqkQ/vuudM4UKB4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 12:04:43.3849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5df755d-a057-4d22-e683-08dd3493a1b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8559

Move the declaration of cxl_cper_print_prot_err() to include/linux/cper.h
to avoid maintaining a separate header file just for this function
declaration. Remove drivers/firmware/efi/cper_cxl.h as its contents have
been reorganized.

No functional changes.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
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


