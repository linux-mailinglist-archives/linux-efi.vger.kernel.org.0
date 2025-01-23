Return-Path: <linux-efi+bounces-2718-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E5EA1A021
	for <lists+linux-efi@lfdr.de>; Thu, 23 Jan 2025 09:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64513188F52B
	for <lists+linux-efi@lfdr.de>; Thu, 23 Jan 2025 08:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F2B20C497;
	Thu, 23 Jan 2025 08:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="m8N2Tr7P"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0743E20C47F;
	Thu, 23 Jan 2025 08:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737621884; cv=fail; b=A05ca1x2BCxR41XfSF6jbqJVlFgjOxTdnGqTDoxnnIUdZP4ZAnc9YN2QbrLg5Kb/LDcLmieUcCtowMei5nksgLIQcsgkE4etjmibgWPT2ZGM+41SEozTBMmG3xSu9zgHfiSxUeLQEsEy49e+epAiikrQIng7ATIZM7LwT8mWzww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737621884; c=relaxed/simple;
	bh=nYaiLCXwtGA1yzQ3FpywASE+43Fss8ZM46Nq9admaHA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RzBSRCFo9klqb4iDyjWZhWRwBNLhYa90EmBwnPWAxW6qYjZoUDDI9hbny8hnzaYtIuJIJnzp79+JJNsUOreAE04CGjwgQk+61P+hM6jEiUphHQ/IorQKEi+VWHojisGHaDUhgF0NslY5aUwaKAe6dfgHMjxGTYqgHAUB6ha8YT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=m8N2Tr7P; arc=fail smtp.client-ip=40.107.223.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f6oEGuEp5u0eyVbx0l+0qLtuTatMajDk+CEChVQsgrnd9tXMYIw6fb49Dl/3UX39cSWmH1owVsio1MOhYvb4VuYw8VV2dDWn2E0m180jzBXUOOBYPoaKN/xKdExIopGoM5ZoLqhIaIERi+hS3mbQscTGIOsfkkQjjhusLCQmJHInJOSn7Uv4yOAoa28tpQHgggfgAcc/S71noukOMBx53Yf+rjxt3XrP+Zgz6jI3TwrY9EGOprJGsH20gHjwNwEKMnwe2fPjc4Mx57IQ6jbHrOr5Pzfo24R69hTm8n1Mhr6psf1yel/4lBiocji7i503P0S8VipIHEuKR0+F8f9+kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wnv0NAjgwjzZ0rGP2HqkEEsTfMC6mOSy6sVEKS7KizI=;
 b=valKCg4RGBkEd1auJ0UVOifSu8bFQflWoiVmyjevsXpY0suA8T7CekTQxBl8IZ+e6voTyMK7FnuyZCPrtpcukwb7L4WvLDwPA8osBMuWOE3pnJs5mJUGmaqdnEALluoIzqj1+MwEDbDH5j9oKHrZksLkQjOyJj3aaZ9vdVbg8tvZT7hpucVpWuPHXJYSrb8ftZdRhemNMQMrea8c1VHrn+mnQhmEDKSP25cXQXgHnagsZkO5gwUFbiBepar9jBN5fvRGyYeh3Bp50rSW9Xa3pOkpOM2rPMvlaoeQnuH+sWTJnA0EZmr1IkXSKT2VD74x6aL8gxRRfjGCiUtNoWlrvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnv0NAjgwjzZ0rGP2HqkEEsTfMC6mOSy6sVEKS7KizI=;
 b=m8N2Tr7Ph4GKHqgpQnIkMgQY1QOxoyYdFv0fjrlspqWfRHS5oDUYTwaCL9bYq9vdi+vLlgvLHa0kB4QRVHzK1aPfeQ5d8KzCLY376Wa3SWA2767wVdmoaTpNX6TJraBdjfRDvd7X1Mf2rRn31mOykddXSb1oEv4T1QICh+/v6iU=
Received: from BLAP220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::18)
 by CH3PR12MB7738.namprd12.prod.outlook.com (2603:10b6:610:14e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.18; Thu, 23 Jan
 2025 08:44:39 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::56) by BLAP220CA0013.outlook.office365.com
 (2603:10b6:208:32c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Thu,
 23 Jan 2025 08:44:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Thu, 23 Jan 2025 08:44:39 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 23 Jan
 2025 02:44:38 -0600
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>, "Smita
 Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v6 3/6] efi/cper, cxl: Remove cper_cxl.h
Date: Thu, 23 Jan 2025 08:44:18 +0000
Message-ID: <20250123084421.127697-4-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250123084421.127697-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20250123084421.127697-1-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|CH3PR12MB7738:EE_
X-MS-Office365-Filtering-Correlation-Id: af4b372b-49f0-472d-29a9-08dd3b8a2c63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/MBbsBX8axbRdq0LHb8IZuiAmCey7i38zjMhfHelA0OmZTTLeExBvyBPTakQ?=
 =?us-ascii?Q?aMucxtu1v3qBgPIC60bVnacnPAajBgq26HKzk83fRjsq6RkUy66q9lbcZlf6?=
 =?us-ascii?Q?/3o06h1ObEoEbszuil4yM1yTNLvK20cgz0P2Wag8XDv+YdGfLhJodcGz6npz?=
 =?us-ascii?Q?Jgs5+YhM5GZceNL7GVIJAJrjsGPyBPN7zuX2++9NHyPjVrNt4ZC+P2V9DskV?=
 =?us-ascii?Q?9HIMOGokZ0jFRqu3hN6/FVFMNzPvSRYNNzUh+NraifzMpZaQjWFoP8PBErrg?=
 =?us-ascii?Q?B0luwReUOMsUpHeREJqobvYzZyi4LeZzHYn30boB//ZEjnO4QpWAEWjn8Tnq?=
 =?us-ascii?Q?lSS5R1OqtzWFunkF+0GC6PIbFHOCRH1XcD0tZSVuZHRnPMBMhzKeV5xb9VJg?=
 =?us-ascii?Q?82g88JI4zUb3sa31oIO66R30U3I7fEMQnAOTeCXhEAXNCtvwSBF8Vbo/VSMI?=
 =?us-ascii?Q?jgb2RyCOOBccNJTAOuXb6BzDAaBTLDDfbtLDM+47F/jIOYBSd76CLLAY1FzO?=
 =?us-ascii?Q?3Xahf686DkU/YgB8J/bmY2VBgqd1RjsQlY8DQ8jp89/RB/7z/YWEFJf+gHFq?=
 =?us-ascii?Q?aXHtVhoFLG4TvJt5RKUbEmJtAz0usvVmnISHi0iq80wFIgx+ZLf6baRpglh0?=
 =?us-ascii?Q?cl3JQ9V+8yabKzx+mX2RYe1SnubLzEf3+rdDtIyf2qvLehhIYLPVCGahHNrr?=
 =?us-ascii?Q?kL6WbyBvvSmEpGET20tntPorbfxbtNumtCV+VdUWXAUItEa0d8rDigj8f9dE?=
 =?us-ascii?Q?wuLIuNqqeD08H2hZtQFWltTyVvtxLog0D/U1og3NtaUjxLZri+FZZaHuUVgm?=
 =?us-ascii?Q?p9br4YTqhIjcEpkIDUTRdlIY2nkL4AvEwVxledDoCrA9vxPeRzjRNIP80X56?=
 =?us-ascii?Q?CEAuyMt8twoHftcFP4ilPwXTuwGYaIqgv0H3qlzaIXe18u8H9jbga2PPNizK?=
 =?us-ascii?Q?uSFIz93ItdYRu0ancjHjrCjCxClDrjYFIhhZCVfv9JahljeZJskm+gsz8XZp?=
 =?us-ascii?Q?wnV7YTbl9Cash2+GiyKKP1NhrNZgd1M+PGM9N2Y5hxyrTDAaxSHfQmKcPtOR?=
 =?us-ascii?Q?t6fWTV4GVV5lqeUBsKGjEYgEjbP63Ebd9rgMA/bGqUEvTu/v8jIDdnMI8UEH?=
 =?us-ascii?Q?YhWyET3FboauV9JsZxbiyYF1OzwmJqqV20jphR4eVV9ulE+lnYorYqbgFL57?=
 =?us-ascii?Q?xpmAG3Fgdwka9PSvBaFlXPaEZTwPbhgmUaw8fE1E2ZRKAJUnVZjduyDhQbJJ?=
 =?us-ascii?Q?ko7YdO++oTNoYOp/PWZJQWlFogEFpaQlnIKmo2NVg9jLWSrFcfqmvlfzslx5?=
 =?us-ascii?Q?fNJfNpXdjbbH6SUNCCiCt7DMmiRsmyRPT5RCxs1fi1VS4qjXojovwVK7QBTq?=
 =?us-ascii?Q?79o1T/jPNzgoKrmBX9Ab6/sZi3DjY8SUcMXUBmsk8M5+mVYTsTnzQtu+P3oS?=
 =?us-ascii?Q?hi+6izRhvJWiTxh1Dk++nW87F5IeJvD88ySZFG3ZVcEvj3+66y5chiyrRoAO?=
 =?us-ascii?Q?5BWoPTCLqOx9y+8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 08:44:39.1919
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af4b372b-49f0-472d-29a9-08dd3b8a2c63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7738

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


