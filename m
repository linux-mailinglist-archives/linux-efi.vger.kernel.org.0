Return-Path: <linux-efi+bounces-1057-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 095128CC3D7
	for <lists+linux-efi@lfdr.de>; Wed, 22 May 2024 17:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79D361F24611
	for <lists+linux-efi@lfdr.de>; Wed, 22 May 2024 15:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FBD3BBD5;
	Wed, 22 May 2024 15:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="la7flwna"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55D71C6A8;
	Wed, 22 May 2024 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716390539; cv=fail; b=NUWqtVdNpTT1CqlMZ2W6apHUGH00xUnPn7PFTzm6LRSo+W1laxqI3azEMcv1Tnkc44dsSHCNvDhviaKTdMLUe+Zr8yf5LQONH58eq6sONVKWxR4lqAXIeh6Atw51JQsYMCY1BivGbQQtILduUtSL3EuZy5bAYXrv6tuNgn92i3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716390539; c=relaxed/simple;
	bh=vO2TbioJjxDu26YJYfcgUlan8O2vuLLaYMxeTelu3ic=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S+D2YX3D6WByF+5MPGbMF6BuQ+2etB2rf+B7iTBx3AxhG4cLHRL40KEmZpxMZDiLKifkbL+pBv25mEf/OVEJaNmH/Gh6/K+fOgWnzQv5cIMQUu6txqguUKtQuCASznHQh+DVXOQ+sO/lf/sdZ8+kQORaWKWOIvmdhxtcJ3ahqWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=la7flwna; arc=fail smtp.client-ip=40.107.237.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S57vGabs9o85ZfqSap5u4BVGz6L3YJWIbTR+7kZAe/hWPq4QynCFuj2So2ut8z6teRKPeUj16KeLH66cvo7QHQm+pVmYqUvW8erRDSTycRVONMrPIEAAd5yIfOJnk9zEuaJoHqPrZu0lmRCc00auodv9H6stX1Nr8OB/3DzlOw7llK4Y/SD1Ekaz0/4Etg4xpND8KQ3N6kog4A9ZD4vm214Yhla3Gom0LkL034IZl0WYsfnK1dUNovsfld4QB7gsI4whj9FJ27KOqv4PYQPZxnzBab9Ka/jlRxNcCynDb8dXwMcuH35bHkHglrdt/B5eFpOVNnjp5uqD4nB1htYUlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOYjt/PcD3GJ0nOC/CCrN2qpKzaGVQyitWForKPZejY=;
 b=WkWSR/IIvRuyWkAjybmAjLDxsGdPHvQILE6jNVXema5mZmk6wgXhhVA1H2lJnY0QNpoeWufBoBXJuOszSYynzgiSaraqwcYQpaVq9G8fRFmmQpmNpzRnhQ4jg2KtuUuB75D2i3+wBfn863s0Y5c5/CzmA6ZsY9nGLB78TFmPBACQNNjpaMuw1IVvPWOJOlwuoZnnKTqgghknAxxhWFPR0BmfE5nb3AssQJBxq85tQvu9INKImQCjT+Fg6Hd1fcyoW1fA4ttcASkDLcAPhsDmcFvm8LUfTQyyT9Rr+W3YlrvmvYwl90Gh5ri8rRVV1qa36tjE9qODNF8n8dsLborfUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOYjt/PcD3GJ0nOC/CCrN2qpKzaGVQyitWForKPZejY=;
 b=la7flwnaGyizIUfe2IS2DfM2VANXIANazhFMy1SqPKo17Vw/5qcZztiBS3Wlq0GmQYPPnRz9YQLC/jqNX31OHJxH+B5EqIENvdZE+Wg4nAcrMQaUwluFTXr/oJW5izSGvfqyvK8ce+lcWEZf2AM+Gwk90rdS9ve/tRXc1wCgl7I=
Received: from BN6PR17CA0026.namprd17.prod.outlook.com (2603:10b6:405:75::15)
 by BL1PR12MB5876.namprd12.prod.outlook.com (2603:10b6:208:398::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Wed, 22 May
 2024 15:08:52 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:405:75:cafe::2d) by BN6PR17CA0026.outlook.office365.com
 (2603:10b6:405:75::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19 via Frontend
 Transport; Wed, 22 May 2024 15:08:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Wed, 22 May 2024 15:08:52 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 22 May
 2024 10:08:50 -0500
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Bowman Terry <terry.bowman@amd.com>
Subject: [PATCH 1/4] efi/cper, cxl: Make definitions and structures global
Date: Wed, 22 May 2024 15:08:36 +0000
Message-ID: <20240522150839.27578-2-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240522150839.27578-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20240522150839.27578-1-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|BL1PR12MB5876:EE_
X-MS-Office365-Filtering-Correlation-Id: abc9bbf6-24e3-499b-2989-08dc7a711752
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PelAI5Y+XfU/vtb+5DArulk+tj6gkqh9IR7yRwzoCLeKqy+ufSd10Tw5vuJM?=
 =?us-ascii?Q?T+POUlXK+cvYehO8qz3WzM1NYG66czDE7CqGqazJ91LUD/7Rlde66Qm8aAtG?=
 =?us-ascii?Q?bndvs68lIgiHazvVpOyvf55u+jXzSg41yV/2LeKN4RZQ5UmCLhStjT5NJJP6?=
 =?us-ascii?Q?WQvhgXh0oTG8paKJmTc3X2XIueKUgRa9D2Ui8DGDZhgk/jzLqzwKHyb/CjAP?=
 =?us-ascii?Q?Kb/g2XT1r0QfqQodQRA7N8CVNNTcs7yrpw7fpHLJddNhrQ/Fym4tlXHS1F2D?=
 =?us-ascii?Q?CkVsrmJIxdxtZMI0ITwnYmEB3Yr05mB5jlmrX9zGu7Pq8p4ZVF/WrV+gbZ9O?=
 =?us-ascii?Q?bjc/Vc9L9oglwfKsIvFrQ/G+lf8+0Ybs806SNi123j3MLsGAw8rr8/3V3Sm2?=
 =?us-ascii?Q?AxdPlIv8ecSK5fLq7O1btRJAgj2gQicyUZIy7gDLVcKpXB6Z0wwkUzkb4SqC?=
 =?us-ascii?Q?HBN7lgnwxydNL/KZx5gRVDg0TVFYcmh30lMy3xIhaf3JnkWSshBvUI6ZOunz?=
 =?us-ascii?Q?V+EUkg97ztaNjMoaUkAtOynjFn1saZ4yfAXOMGI48U5vz5GewgvrPI0UdKnY?=
 =?us-ascii?Q?TOIzeVYsjn7mkTJJXW6bu5oQY37MSJ5qngBMafeLmlhsj6+JzgH8bDS0yOGE?=
 =?us-ascii?Q?qLoUShh8X1Uv2X+9s+4N4L7L7AS2bytGuKGlO6aHSKeEFU2LsHy+/HxXBhkP?=
 =?us-ascii?Q?Dh5WNePhMFi7S02bMMbg/uPMccbazaN0ElneJy5fuYXmbEFBbAL6zZTSO9t8?=
 =?us-ascii?Q?cHhABms0gZlfGvNCjCX5ENsdSYwr/PieE1bl4y5YPJbDWRyvlStUvKXBYj+H?=
 =?us-ascii?Q?KsKRHWUZwyVGjg3+g41Au8htFwtZcGOSYzeuLiVMwTFpfWQXa+rO4I+Gj1ox?=
 =?us-ascii?Q?j5P/eTNQhtNS/Lsstq9C9e+yowUh5iGs5yELIPH7cU0GcA/WwfoNcIPhlBt4?=
 =?us-ascii?Q?AJwKKkv8S3zrqWqk8WRXT4ErUsWdbBlOQlXFULSEQyZ0QqUHjKjgItJfjCPb?=
 =?us-ascii?Q?ANbGLzYbfqnKHlt03OrUmgPSWT+0aPH0EJ7eTBaTv1hn86rrZGaBTfDpnxzx?=
 =?us-ascii?Q?d3r5qGIBvt9PXUCXz3T4SWgiMIGm7s1jk9P7sWHGuAhSbhFKqdkdVdBItoaa?=
 =?us-ascii?Q?1iiyyVHTlD7WXdoRM7xMrMqCX/E6Hy0uQZx9We+mL4m2tu7JBraoMl9C/Bzo?=
 =?us-ascii?Q?bTCskQMD7hmqGPUaXnOUIpPU2fm14d+8Kf2GAjqEseF3F9/ia6dgzx+vg/Rq?=
 =?us-ascii?Q?ZVXznXEz7ALt//C+Lp+HSqER5++DTLZQWw3qQnKnpAmY3J3IthxfvzBD5vr3?=
 =?us-ascii?Q?k859Um0AqSXKxXDII5A5YzhWJ4E31bRazVQVcvwLcNgCm2aaZQTY+WkzbYUC?=
 =?us-ascii?Q?e/OVcSSmTlFRHqPEBW73yuH7Ohp4?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 15:08:52.0452
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abc9bbf6-24e3-499b-2989-08dc7a711752
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5876

In preparation to add tracepoint support, move protocol error UUID
definition to a common location and make CXL RAS capability struct
global for use across different modules.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/firmware/efi/cper_cxl.c | 11 -----------
 drivers/firmware/efi/cper_cxl.h |  7 ++-----
 include/linux/cper.h            |  4 ++++
 include/linux/cxl-event.h       | 11 +++++++++++
 4 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/firmware/efi/cper_cxl.c b/drivers/firmware/efi/cper_cxl.c
index a55771b99a97..4fd8d783993e 100644
--- a/drivers/firmware/efi/cper_cxl.c
+++ b/drivers/firmware/efi/cper_cxl.c
@@ -18,17 +18,6 @@
 #define PROT_ERR_VALID_DVSEC			BIT_ULL(5)
 #define PROT_ERR_VALID_ERROR_LOG		BIT_ULL(6)
 
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
diff --git a/drivers/firmware/efi/cper_cxl.h b/drivers/firmware/efi/cper_cxl.h
index 86bfcf7909ec..6f8c00495708 100644
--- a/drivers/firmware/efi/cper_cxl.h
+++ b/drivers/firmware/efi/cper_cxl.h
@@ -7,14 +7,11 @@
  * Author: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
  */
 
+#include <linux/cxl-event.h>
+
 #ifndef LINUX_CPER_CXL_H
 #define LINUX_CPER_CXL_H
 
-/* CXL Protocol Error Section */
-#define CPER_SEC_CXL_PROT_ERR						\
-	GUID_INIT(0x80B9EFB4, 0x52B5, 0x4DE3, 0xA7, 0x77, 0x68, 0x78,	\
-		  0x4B, 0x77, 0x10, 0x48)
-
 #pragma pack(1)
 
 /* Compute Express Link Protocol Error Section, UEFI v2.10 sec N.2.13 */
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
diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
index 60b25020281f..f11e52ff565a 100644
--- a/include/linux/cxl-event.h
+++ b/include/linux/cxl-event.h
@@ -154,6 +154,17 @@ struct cxl_cper_event_rec {
 	union cxl_event event;
 } __packed;
 
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
 struct cxl_cper_work_data {
 	enum cxl_event_type event_type;
 	struct cxl_cper_event_rec rec;
-- 
2.17.1


