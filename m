Return-Path: <linux-efi+bounces-2384-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E33A59F40AC
	for <lists+linux-efi@lfdr.de>; Tue, 17 Dec 2024 03:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDAE9165426
	for <lists+linux-efi@lfdr.de>; Tue, 17 Dec 2024 02:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6361E14831E;
	Tue, 17 Dec 2024 02:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1IyFOz72"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2046.outbound.protection.outlook.com [40.107.102.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A79C146A7A;
	Tue, 17 Dec 2024 02:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734402150; cv=fail; b=nJuYTBPxzNNNGFc53cwd7Sl35phKU6zLpSS481V05XUxdiYTgD2GaUafkDxbkjnScMRmx7RgtBDVZ5tqvihzMeHXX3TTYdzz1lt3KdzjAQE6iA7Yt5wLWUbkulLlBjzrbX3Penp6ijQdb5LR3pdv668sI77jfjoG8DGbexQoauk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734402150; c=relaxed/simple;
	bh=GWo/9DorJaPod4+gw1rGeKNaSSlTI1JWKV8qbVseAys=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Stj8fxjmFlB/xrEBhQe3Hck/A3kzUsIXC5y6ypFvglF5ihC146CF9K3pSUmbR2l1a/RPuEycJR5sJQD5LMO1GglvbSlG97Uq7yZ+ADeZw3iO866QkRNxhwMBciNEbs5lFxItlzRyJmbvvWE2OasVNXgP8yYPmjIiEVL0uGIeh/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1IyFOz72; arc=fail smtp.client-ip=40.107.102.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tHG0JxSvMpVIagaEzht1yzr13fy/UNSVrrktI5Z/q0z3wX1q9AhnC7W9NDU5Cbf4NtO9IMeSXCSxzUA+idueeJh0+t+xg8H8YrUGy1pLqhSv88G1Pa4VVnw6u0/u8Cf2Sl0qLTnZb1JPTxTQLsXa9pKiZr4Bv4i99FOsTflZhd/pR8luTtWxdH2YN+L2ltylncVOpvBr6X+3Qux64JNCHwhk8/buOpReyH7WFLJ3+ObEhJegN9zz28zigT0MI9mNnYm73/LUv9bfDtQPlVnKLyKVct8Mii3rviUXr8LrT76iXBpoR96M/pLY3HzG7V8j5pVZxczXEskzaH6c5TSxGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TzdtfhU6WviOVSrFkLxh8vx/Oe7Cvz3BOMq4sII4rD8=;
 b=RZKSI2AZ0JRCdZ7Ajs9Xw/HxkDKB2Kj8t6MyUZ/8p3oMZCFRw9GEiFWXiEn8oiAOgsQENZZKYSPw6ZGHYr4hEdOanfv8p90D/ekVAI7V0iMQ/x4a8gpaQ2Um4evsKglFbKmiH/lN6ntdR4jDbiRI9VMzssuSkHY03AW72GFf06hQkKr9yYsFoBKXKJP54tksIZRRBhb5c+dWJyykwTfdgJJ7hDLmtK6Y2xNaNw/zqKcRW/vPn6Dg/QCmSqH9Di0BP+Gt5GoIqhpemCpCT7V5t7Gfx5Aq9qHS1+XE6dJArSgAlPT+aadoEoCLna4/2e5DUP/LPa9tD2GNuSLYOm+JDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzdtfhU6WviOVSrFkLxh8vx/Oe7Cvz3BOMq4sII4rD8=;
 b=1IyFOz72cNr+aOs9SMgY928CqHHe9++ryeDipaPARNlQqrPpgkYpf75oHF8rMT+iP9P+YFkEUbV3T8aSp30P59AFtGxwr0c0M9H7RB2gNH1YeWVrnTLqw3hqBSLuKapZdZo3oj4SzylMKaqL/lWEeeYl8MjdNnTMUwR3gIlPBdE=
Received: from MW4PR03CA0218.namprd03.prod.outlook.com (2603:10b6:303:b9::13)
 by SA1PR12MB8844.namprd12.prod.outlook.com (2603:10b6:806:378::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Tue, 17 Dec
 2024 02:22:23 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:303:b9:cafe::d0) by MW4PR03CA0218.outlook.office365.com
 (2603:10b6:303:b9::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.21 via Frontend Transport; Tue,
 17 Dec 2024 02:22:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 17 Dec 2024 02:22:23 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 20:21:20 -0600
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>, "Smita
 Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v4 3/5] efi/cper, cxl: Remove cper_cxl.h
Date: Tue, 17 Dec 2024 02:20:30 +0000
Message-ID: <20241217022032.87298-4-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241217022032.87298-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20241217022032.87298-1-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|SA1PR12MB8844:EE_
X-MS-Office365-Filtering-Correlation-Id: 3deb7628-41c2-4c9b-57b8-08dd1e41a451
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AQQv0pkmvMt9WAg6exyiiBIlK5R8hrVNOwiVBq6KZ71SvlwCj62d5DQbm8nX?=
 =?us-ascii?Q?1sgaOVKkUrnEJLWXjUenzPLrw2dm29C5o4nCzIq4h2QNblVETMkCdhH98f+e?=
 =?us-ascii?Q?BvchI6x1aZuKeV2C6/kv7m0MiLiQ8c6fMfuu2o2M5xLOgKaefi3qxToTCWJ5?=
 =?us-ascii?Q?X6Dn/GJyhdjvVCO2cgd7N/WlQIJiZd/wv873zCNBkZQmEROV9JzIDVY4+/BN?=
 =?us-ascii?Q?xSPZpC9Ys2bMJVphueiSNVsQ5b+BS6rL+5eRzbwOBWwwBYY4nWXkHkl7J649?=
 =?us-ascii?Q?AyJllm+ERw6yiHNL2iCZ7umhyYh1G/lWftCl6IWOAm/uSX0EuhfZZg9DIhMk?=
 =?us-ascii?Q?2XORPVvWGkQQSGjvpLCbUYf+LgZmpqnjkc89vwCNS1y/+mmlvEwIDgrglatq?=
 =?us-ascii?Q?kKQMhMR5d+rBeUHFzNjXHBcJHNcF4UF6x65+LjsvKZvHuyRtL/8Hzi9uMo7O?=
 =?us-ascii?Q?9HxSvtDNFNvm+DKy0P3CI0NLoO10r3CQ/eI2NaNJrckjn/HenhtuAMZbrACM?=
 =?us-ascii?Q?uEuUnNn8XsIxHWmJH9BEQF+z/MnSNKu4vEJFWx8V6qsOwKJUGcQ/AgztkA3E?=
 =?us-ascii?Q?CoaWf4OPZ+LnalcZEhnLISD9WtpWK/QIbsCm0dUxu7ctKmRpp1Qi/DiYc46p?=
 =?us-ascii?Q?26fan3TyXcAQgLLRpThVCUay8RlQC5C112411zN/8M/poLXmwBOon2WlNBWR?=
 =?us-ascii?Q?8mNuMXdSbpkErNSjvcy5FrTJ0KwQKQN0U6L9QcU1GhYa4jsODsxe3ETn4iSl?=
 =?us-ascii?Q?+alp/4N2PrMiiinw3ktGvje61XgdodjbvVS1HTNfYs6ceJKVSr2NWvDeDsJn?=
 =?us-ascii?Q?fW3d63g5Thgio1toBfRiVM0YNqz3yM9iJsIduoNDF+/lL4MmfHKdYhQkDBSI?=
 =?us-ascii?Q?qyU9AiAZBgagrEZiaBdFgqPQcM2eM9pUH/E341C1wL1AVN1847x8RbrMRRKx?=
 =?us-ascii?Q?HxtXOx98BYx77m83BvhRWWAZTaccF8LuCn8+w9Sx1hcqidjf9jWsmUpQUjJG?=
 =?us-ascii?Q?C8qAojA5H+bI49KqmqPzSxfIvMjIIuDapK+b4zlq7W317Sg6q96qjYXaY82/?=
 =?us-ascii?Q?1krhmt/fGUIK5f0LkhJVVJzc+pQzyoGF8hP5TTUzqG8oirOZrczqGuQejfHN?=
 =?us-ascii?Q?OdIP5FrR/da/ixBbN930B+yjCwkUf+2y8bWgVezNBoHutieeRw8/3HJtW+P+?=
 =?us-ascii?Q?eh4MoX2BT4MkGnFcfshy2US4eDQlncLz0yBftOezC4JgtnZP08xqZX4+Fvu2?=
 =?us-ascii?Q?DaqlLKfAsC5P0TUy/CIA1xyH/1YNxoMm1ivpabKfdHkAKLWm9a0wPEjxtiy8?=
 =?us-ascii?Q?0TWTmY08o4JtNOWSHdMSYdHOWx49o3lvf/qLN6ui7w+IUOkp8XGcaGqg3DLQ?=
 =?us-ascii?Q?YecGG94YIOVl3vbRFz63f6P9CZ6nn+RChPHZ4CyD5OjqMARrc6XXTVY90iXk?=
 =?us-ascii?Q?r3psMrdhgafQ3Z5lzWZM8BDr187U4cPmQ3X+/dPqkVt//24KC+umTA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 02:22:23.3261
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3deb7628-41c2-4c9b-57b8-08dd1e41a451
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8844

Move the declaration of cxl_cper_print_prot_err() to include/linux/cper.h
to avoid maintaining a separate header file just for this function
declaration. Remove drivers/firmware/efi/cper_cxl.h as its contents have
been reorganized.

No functional changes.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
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


