Return-Path: <linux-efi+bounces-2174-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBDF9D1CA2
	for <lists+linux-efi@lfdr.de>; Tue, 19 Nov 2024 01:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 446ACB210EC
	for <lists+linux-efi@lfdr.de>; Tue, 19 Nov 2024 00:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C5A29D19;
	Tue, 19 Nov 2024 00:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tK8fMg8e"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44239C149;
	Tue, 19 Nov 2024 00:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731976774; cv=fail; b=jK/QlnOZiD0sJJ+9NJ/YpTXeUMxrqBqWZJ2gt6pOJ/UPH+eiRdUkZl9NdDoqWO72eWwe7V060SMc9qL9+gkN+TenXVVguxF/sxer9ydW/CpRle6GPatimW+74Dr868At787Jaf7cFbGO+fEK9eh9bqJGGk+3M2aouDtD75CXC5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731976774; c=relaxed/simple;
	bh=vGL8Unq2WkkBe9SugJeT0WtmOcmHhU+7i9quqLuUnSs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C3CKT6hnhbozLYOlPScG/TGpE3TMUNASJFvqseKUG4j/zZc0auY5aGtpHfPD2Dj1dR/ABdkL4nsvKZsPjuLtAemf3X9FAweYfC2cep/LbFvOWCWidsQ/LSXqQodZn/EoTUgTry1d9nrwe7LJWnhWZNI7hVGrHgHdetRjB3W9jko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tK8fMg8e; arc=fail smtp.client-ip=40.107.93.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b9Dg7+0iwbrDBt7ONXTADPzRzbmAXNed6PTarab/YggPlkf1cNKWzvczWU119LT5c1ufAfHtnCxpkSPeskm0nBheALn82iPHMAHXGvw9BlLfp5fKoKBKG3cq6n//xUvFf61h+OdCF8obaXQL/yRjMBTGRCXWicT4cf3q3FkMTZB9aCjBEIZDJLmTtaWG/mH4DPrfZYexNGvlgN9Vb39RVXNho7Ydq//4nfm8Shz8LiQ5JGgnnYxU+n2uX9i/wSdVXJD5Ex0/wIMbpmhJjXdDFxnMLO5lBME0oDIhYhNzEGskFhMs8c4SjVGQWjnWw/mqe5YBhU0wHa4PFpptzSu0qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iz3k6pUc/wF6Zqc5xdthELnrH+BhypjgxrsMEVJVLU0=;
 b=I+yto12+Yk6FXRKxhy9c/F2Ac1aeQK/uHHsJ+z9GDrwm6H6xifUVQjMoqRRmVTqWe3YVuXRCEtaDpf0QZL83B9nOKxb+qkDAXi173jRELm0LvduKrL9FJsrStmdXK4LbY+l11i6SzDQRpMe2vitsUfYNkzRjbb2ehGpHsAh4o+7zcaZ7J5L6RbAe4NE72xlRAinZk8/YaVZxXTMRinGMxFUaF9N7JGGyIGO/VQs5l/Uuyf0B3bzm3DxQbdMbEkpWZ8hi5api31kkQ4aUynWKHGAl7ZaunidfPHq7QcFB/CnRWZFASz9W8bqugKhoeIqZtxx9QaDG6BC8Oa2D1Ugyuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iz3k6pUc/wF6Zqc5xdthELnrH+BhypjgxrsMEVJVLU0=;
 b=tK8fMg8e7B3hsOXtkZcHSIbcN9oM9RRNSd/qhDOlpusD3kMdOR+gzyaUa8g1+Ccz/3JrciGe3NhRb/NBY9LkhzuAvCT1ltWhIDdpAaEKlUPMIUgNqDbUdYw6jj4mNOZweF/O7ebf8D4FXFbkSGOlFs/Nr9CQhAaHfMv0cvILbbc=
Received: from DM6PR10CA0022.namprd10.prod.outlook.com (2603:10b6:5:60::35) by
 SJ2PR12MB8977.namprd12.prod.outlook.com (2603:10b6:a03:539::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 00:39:28 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:60:cafe::e2) by DM6PR10CA0022.outlook.office365.com
 (2603:10b6:5:60::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Tue, 19 Nov 2024 00:39:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 00:39:27 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 18:39:25 -0600
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>, "Smita
 Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v3 2/7] efi/cper, cxl: Make definitions and structures global
Date: Tue, 19 Nov 2024 00:39:10 +0000
Message-ID: <20241119003915.174386-3-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|SJ2PR12MB8977:EE_
X-MS-Office365-Filtering-Correlation-Id: 35124d49-8458-4d66-db29-08dd08329fae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kjgu7a2JY1VtzkT3k7R73nOthmpuO+Apg7NdtiCm4+sp9rDWAM6wwyJngUKX?=
 =?us-ascii?Q?okUxzLXDA30i5PKZh44bcNdCZaS2NL0YDACE4lLST2BKCHmdhlh68eEEFVAk?=
 =?us-ascii?Q?N5n8zTm9paTe09zHGaigljJce/b8O/223sAmzzNbmSDEu9M3kqsQQeus30s9?=
 =?us-ascii?Q?xeKn+AJJcf2t0Ghp2I1vZRPI9TAdQ6afWXlTFkG/ZDagGRe2HE7+Vzrq0+7r?=
 =?us-ascii?Q?afnwE2PCtN3HFSH9kXPFEzjyHgN4kK4Rfef5ROdYelqakZh604gcdrb8qIK5?=
 =?us-ascii?Q?n9vq/hFg7C85YgurDMmG3jcI6i/+BhM2sGnkzIXEFjA+c6IXxCn0eIuHwbP/?=
 =?us-ascii?Q?2dMImg82Lfq5xgrDFRx/gSrT3BZiEjEWwFcJoNQeuUI2QP9538qODWDc1R0l?=
 =?us-ascii?Q?nIaSZB0ItGgZPFtEg43RBy82KcE1Rz7TlZk2+T+Tb6VjiIsAMTpMGCl+PzGV?=
 =?us-ascii?Q?ugfdoTsbGNAzAPd56GT5tbJ6I2JMVPpK5kvl3U04rAPE2xzvnGCKyyNSII0Y?=
 =?us-ascii?Q?HUGb2AtRcxlBHwZ99PyfrFpXYO92h0o+l04S+2UPREtkyxpCLrAYEPMIVkCV?=
 =?us-ascii?Q?VhDXlZVZGj4VFMtr06GYQ1mozTv++BOJBXAzgT4hangYhdX0Mf9ucb2QB7cK?=
 =?us-ascii?Q?8OB6EaXcH9HUcpAUrRyyhiwaLg1jjw2PSotPalb9ZWgs6ABDJc4/GlFcSOh+?=
 =?us-ascii?Q?f5ph0Ho3T6k4RoC0+XWz/WsgrELyigv3l8XUFe8JMJKvt+9GWtkpd8hWpUmq?=
 =?us-ascii?Q?ex4Uxfb5fWhNsY6Vv0ZcSEOGzf+NUg+wH3Onfw4qSNYY7uu0lae7OiOls9An?=
 =?us-ascii?Q?x/aYV87buKHmoZZ2UQjgW2PPQO5VP1mUqoRMQFxLmaPIcf5BE+HJavXlVkrz?=
 =?us-ascii?Q?KjUaMsLOSBrfY+2MNoRkhlLLpA3+oX2i679e7q7a+/zNLxiNe0+a+E/wfDut?=
 =?us-ascii?Q?LBI4qF0Lpx0bYsQYvk8TqbRpSsOhkRAVLwEecsVukUTgVv7jApe7kHrzbA+8?=
 =?us-ascii?Q?I1Y300afnXM/mRdxliZFscsnTQ8XGLhr7tak+s7X0OIwiL9rDmxdsnTeoGue?=
 =?us-ascii?Q?00oUA9zRbZgIbKRNZaq6F4Uo1ycK9V5BmWrBi6ojb9/DSya5lg3O4Zzim/2N?=
 =?us-ascii?Q?yjwfYejEPmax7N5Mh9b+c3/gjV5PdlaoytWF1I2e3Gy/ZmxF84LjM/XgAWGk?=
 =?us-ascii?Q?mIgV3e0Dz2s5r88EPrObd5SpC7CjUvQvC59+vTist2saIo37fbDox76fMw/W?=
 =?us-ascii?Q?77tOMVaYUnJCiSiC83+R4yqzTnjWCavzGjQn3hiGpzkEWr1II414ELc5zx3M?=
 =?us-ascii?Q?IB1rsDQyZnhzrH7lYg86rzG2ZlswJ1AepXFh1vuTRTrYUsi2TEtyWK6OblVa?=
 =?us-ascii?Q?kVfH7aM8Eh80W82JhsRakW4XO/G9dfKnm5XeV1kSJXLzAZKuCg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 00:39:27.5808
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35124d49-8458-4d66-db29-08dd08329fae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8977

In preparation to add tracepoint support, move protocol error UUID
definition to a common location, Also, make struct CXL RAS capability,
cxl_cper_sec_prot_err and CPER validation flags global for use across
different modules.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/firmware/efi/cper.c     |  1 +
 drivers/firmware/efi/cper_cxl.c | 35 +--------------
 drivers/firmware/efi/cper_cxl.h | 51 ---------------------
 include/cxl/event.h             | 80 +++++++++++++++++++++++++++++++++
 include/linux/cper.h            |  4 ++
 5 files changed, 86 insertions(+), 85 deletions(-)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 8e5762f7ef2e..ae1953e2b214 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -24,6 +24,7 @@
 #include <linux/bcd.h>
 #include <acpi/ghes.h>
 #include <ras/ras_event.h>
+#include <cxl/event.h>
 #include "cper_cxl.h"
 
 /*
diff --git a/drivers/firmware/efi/cper_cxl.c b/drivers/firmware/efi/cper_cxl.c
index cbaabcb7382d..64c0dd27be6e 100644
--- a/drivers/firmware/efi/cper_cxl.c
+++ b/drivers/firmware/efi/cper_cxl.c
@@ -8,27 +8,9 @@
  */
 
 #include <linux/cper.h>
+#include <cxl/event.h>
 #include "cper_cxl.h"
 
-#define PROT_ERR_VALID_AGENT_TYPE		BIT_ULL(0)
-#define PROT_ERR_VALID_AGENT_ADDRESS		BIT_ULL(1)
-#define PROT_ERR_VALID_DEVICE_ID		BIT_ULL(2)
-#define PROT_ERR_VALID_SERIAL_NUMBER		BIT_ULL(3)
-#define PROT_ERR_VALID_CAPABILITY		BIT_ULL(4)
-#define PROT_ERR_VALID_DVSEC			BIT_ULL(5)
-#define PROT_ERR_VALID_ERROR_LOG		BIT_ULL(6)
-
-/* CXL RAS Capability Structure, CXL v3.0 sec 8.2.4.16 */
-struct cxl_ras_capability_regs {
-	u32 uncor_status;
-	u32 uncor_mask;
-	u32 uncor_severity;
-	u32 cor_status;
-	u32 cor_mask;
-	u32 cap_control;
-	u32 header_log[16];
-};
-
 static const char * const prot_err_agent_type_strs[] = {
 	"Restricted CXL Device",
 	"Restricted CXL Host Downstream Port",
@@ -40,21 +22,6 @@ static const char * const prot_err_agent_type_strs[] = {
 	"CXL Upstream Switch Port",
 };
 
-/*
- * The layout of the enumeration and the values matches CXL Agent Type
- * field in the UEFI 2.10 Section N.2.13,
- */
-enum {
-	RCD,	/* Restricted CXL Device */
-	RCH_DP,	/* Restricted CXL Host Downstream Port */
-	DEVICE,	/* CXL Device */
-	LD,	/* CXL Logical Device */
-	FMLD,	/* CXL Fabric Manager managed Logical Device */
-	RP,	/* CXL Root Port */
-	DSP,	/* CXL Downstream Switch Port */
-	USP,	/* CXL Upstream Switch Port */
-};
-
 void cxl_cper_print_prot_err(const char *pfx,
 			     const struct cxl_cper_sec_prot_err *prot_err)
 {
diff --git a/drivers/firmware/efi/cper_cxl.h b/drivers/firmware/efi/cper_cxl.h
index 0e3ab0ba17c3..5ce1401ee17a 100644
--- a/drivers/firmware/efi/cper_cxl.h
+++ b/drivers/firmware/efi/cper_cxl.h
@@ -10,57 +10,6 @@
 #ifndef LINUX_CPER_CXL_H
 #define LINUX_CPER_CXL_H
 
-/* CXL Protocol Error Section */
-#define CPER_SEC_CXL_PROT_ERR						\
-	GUID_INIT(0x80B9EFB4, 0x52B5, 0x4DE3, 0xA7, 0x77, 0x68, 0x78,	\
-		  0x4B, 0x77, 0x10, 0x48)
-
-#pragma pack(1)
-
-/* Compute Express Link Protocol Error Section, UEFI v2.10 sec N.2.13 */
-struct cxl_cper_sec_prot_err {
-	u64 valid_bits;
-	u8 agent_type;
-	u8 reserved[7];
-
-	/*
-	 * Except for RCH Downstream Port, all the remaining CXL Agent
-	 * types are uniquely identified by the PCIe compatible SBDF number.
-	 */
-	union {
-		u64 rcrb_base_addr;
-		struct {
-			u8 function;
-			u8 device;
-			u8 bus;
-			u16 segment;
-			u8 reserved_1[3];
-		};
-	} agent_addr;
-
-	struct {
-		u16 vendor_id;
-		u16 device_id;
-		u16 subsystem_vendor_id;
-		u16 subsystem_id;
-		u8 class_code[2];
-		u16 slot;
-		u8 reserved_1[4];
-	} device_id;
-
-	struct {
-		u32 lower_dw;
-		u32 upper_dw;
-	} dev_serial_num;
-
-	u8 capability[60];
-	u16 dvsec_len;
-	u16 err_len;
-	u8 reserved_2[4];
-};
-
-#pragma pack()
-
 void cxl_cper_print_prot_err(const char *pfx,
 			     const struct cxl_cper_sec_prot_err *prot_err);
 
diff --git a/include/cxl/event.h b/include/cxl/event.h
index 0bea1afbd747..66d85fc87701 100644
--- a/include/cxl/event.h
+++ b/include/cxl/event.h
@@ -152,6 +152,86 @@ struct cxl_cper_work_data {
 	struct cxl_cper_event_rec rec;
 };
 
+#define PROT_ERR_VALID_AGENT_TYPE		BIT_ULL(0)
+#define PROT_ERR_VALID_AGENT_ADDRESS		BIT_ULL(1)
+#define PROT_ERR_VALID_DEVICE_ID		BIT_ULL(2)
+#define PROT_ERR_VALID_SERIAL_NUMBER		BIT_ULL(3)
+#define PROT_ERR_VALID_CAPABILITY		BIT_ULL(4)
+#define PROT_ERR_VALID_DVSEC			BIT_ULL(5)
+#define PROT_ERR_VALID_ERROR_LOG		BIT_ULL(6)
+
+/*
+ * The layout of the enumeration and the values matches CXL Agent Type
+ * field in the UEFI 2.10 Section N.2.13,
+ */
+enum {
+	RCD,	/* Restricted CXL Device */
+	RCH_DP,	/* Restricted CXL Host Downstream Port */
+	DEVICE,	/* CXL Device */
+	LD,	/* CXL Logical Device */
+	FMLD,	/* CXL Fabric Manager managed Logical Device */
+	RP,	/* CXL Root Port */
+	DSP,	/* CXL Downstream Switch Port */
+	USP,	/* CXL Upstream Switch Port */
+};
+
+#pragma pack(1)
+
+/* Compute Express Link Protocol Error Section, UEFI v2.10 sec N.2.13 */
+struct cxl_cper_sec_prot_err {
+	u64 valid_bits;
+	u8 agent_type;
+	u8 reserved[7];
+
+	/*
+	 * Except for RCH Downstream Port, all the remaining CXL Agent
+	 * types are uniquely identified by the PCIe compatible SBDF number.
+	 */
+	union {
+		u64 rcrb_base_addr;
+		struct {
+			u8 function;
+			u8 device;
+			u8 bus;
+			u16 segment;
+			u8 reserved_1[3];
+		};
+	} agent_addr;
+
+	struct {
+		u16 vendor_id;
+		u16 device_id;
+		u16 subsystem_vendor_id;
+		u16 subsystem_id;
+		u8 class_code[2];
+		u16 slot;
+		u8 reserved_1[4];
+	} device_id;
+
+	struct {
+		u32 lower_dw;
+		u32 upper_dw;
+	} dev_serial_num;
+
+	u8 capability[60];
+	u16 dvsec_len;
+	u16 err_len;
+	u8 reserved_2[4];
+};
+
+#pragma pack()
+
+/* CXL RAS Capability Structure, CXL v3.0 sec 8.2.4.16 */
+struct cxl_ras_capability_regs {
+	u32 uncor_status;
+	u32 uncor_mask;
+	u32 uncor_severity;
+	u32 cor_status;
+	u32 cor_mask;
+	u32 cap_control;
+	u32 header_log[16];
+};
+
 #ifdef CONFIG_ACPI_APEI_GHES
 int cxl_cper_register_work(struct work_struct *work);
 int cxl_cper_unregister_work(struct work_struct *work);
diff --git a/include/linux/cper.h b/include/linux/cper.h
index 265b0f8fc0b3..5c6d4d5b9975 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -89,6 +89,10 @@ enum {
 #define CPER_NOTIFY_DMAR						\
 	GUID_INIT(0x667DD791, 0xC6B3, 0x4c27, 0x8A, 0x6B, 0x0F, 0x8E,	\
 		  0x72, 0x2D, 0xEB, 0x41)
+/* CXL Protocol Error Section */
+#define CPER_SEC_CXL_PROT_ERR						\
+	GUID_INIT(0x80B9EFB4, 0x52B5, 0x4DE3, 0xA7, 0x77, 0x68, 0x78,	\
+		  0x4B, 0x77, 0x10, 0x48)
 
 /* CXL Event record UUIDs are formatted as GUIDs and reported in section type */
 /*
-- 
2.17.1


