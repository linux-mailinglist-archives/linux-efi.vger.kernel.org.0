Return-Path: <linux-efi+bounces-1855-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 144F298B195
	for <lists+linux-efi@lfdr.de>; Tue,  1 Oct 2024 02:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A81A228229D
	for <lists+linux-efi@lfdr.de>; Tue,  1 Oct 2024 00:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483B34A28;
	Tue,  1 Oct 2024 00:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E22s3KcL"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F2A28F1;
	Tue,  1 Oct 2024 00:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727744009; cv=fail; b=GqSOI59EmbRBbrYS5tAZLQKOM3n3qrLx7wEwmkF0QLTACxIMh3HK1y8bUHPA6pcSpwGr4GEmstQEunm8Wg+d3vxd4FCaTBmJyZXKmdSDJ+UUhRAZHeqBc4BZpbroO4ETCV87lrq6pUy8b7qf5upkQ7Cw8Tj9r7KFikWmRsGjkMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727744009; c=relaxed/simple;
	bh=2OhSsZBzzsiupPXE6VJ1eh+gvywccEgT9UN8RH0csJU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OTSYpvlOLQXswAz+c54LQ1G4I+YiioPzlRhnfIQEAMzT9WgXeOedE5Swi3pFkdfNxQQFKjKAOj6AFPJap1IfNJGYpZLImMY26U53uVHZykKBT2ocgydNktJlZWRd0zhDhwXLUCp0SfPFlnoSbd4IWKJmDrAfMb9JJS3y1rL63sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E22s3KcL; arc=fail smtp.client-ip=40.107.93.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mwgOE7E4MoF9stksEvkUg/Oca85jvsZK2YaOPSq8KgRBqGbSt2z8F/WsShlK8M/Qjrduc+7nYhVtSCufZGBtQvp1N8UecP0TKSWe7LdSqXfo1bSomJyOkaXjdySuBGuebUU2VOeCuaQTPPgRYuOz0bJcYzpof9+QIwbMzbSAJ51EMXFPDdVKLa+HjZJ/yrhzdObZkRTc0wx2Vi8OXhXbGmgWtYl8/jKunASOKNI8wDYDSNz4njk4kPgWOI4mhTLXOaKOJNbicYO3niKZ/jM4oEOT9bjY5LjYxGopdJCopM0OtoCXxcSzEemT4EuuIDjtw3emz4qLUH57tb96iQisCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkEQBCSC3uuZvmSouHQt1STZB2viZ5THm+5/pL89Kns=;
 b=O6TGnXEf/iBYVlzl3o16oXdUWwDiXtukQ8wlJQ44l5CzUv96wBLB3A6+PLyEthfAjoYJ6SevnRpKvLO5u6sKJ/NVrUznxjLCiDVEOHZ3Z4bBogIh96Nir0ZTFxYMEZnpbm5gQbRyxziR8zloI17IEmjDEU9+3LFJjB2XaO5W4BoPKF5YkeU4PI8n/+ua+op1Wat3mXCQPo8dXFpJAmElvjSyTWLS2FkggeCERhHsv0ylDvBrIkf/12wBnf1Prkd61Ax2YLVttOGqgNUQoTGnvQZKWDKgdswsGkgpcTjQ+SWpX2a1ANLVrUM9i0fWjJl/dF58ffhA/s0N3f3OzAxq2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkEQBCSC3uuZvmSouHQt1STZB2viZ5THm+5/pL89Kns=;
 b=E22s3KcLH2Y1qSx5FEvG0sQaK0GGfZghV8KAOTx4joY2FhjkbvNGyTBCPkyXCs0P2SlkorllvExk67R+ez/k2PZ4g37Z/8T4UqpF/QwbemmUHZeRw1UEyw8Ct1wGHsegDfDIP+RXxT8m5/tkbz0rdVsQHlIona7VJn7nulYpZbY=
Received: from BYAPR11CA0052.namprd11.prod.outlook.com (2603:10b6:a03:80::29)
 by SJ1PR12MB6172.namprd12.prod.outlook.com (2603:10b6:a03:459::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.24; Tue, 1 Oct
 2024 00:53:24 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:80:cafe::ef) by BYAPR11CA0052.outlook.office365.com
 (2603:10b6:a03:80::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Tue, 1 Oct 2024 00:53:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 00:53:23 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Sep
 2024 19:53:05 -0500
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Bowman Terry <terry.bowman@amd.com>
Subject: [PATCH v2 1/4] efi/cper, cxl: Make definitions and structures global
Date: Tue, 1 Oct 2024 00:52:31 +0000
Message-ID: <20241001005234.61409-2-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241001005234.61409-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20241001005234.61409-1-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|SJ1PR12MB6172:EE_
X-MS-Office365-Filtering-Correlation-Id: c0cd7445-2970-4754-b11a-08dce1b373f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gsgqoeillXsSpxoBlu0fwmZYN3CAL4W5k/WZ09aeZeXjTp2hLTeuTzXp43E9?=
 =?us-ascii?Q?y53XxNi9GKYnGpYbuT7yRPUJmQcVcpYIUnBrkaVu/HYPsz4k98q8YNFFu6w+?=
 =?us-ascii?Q?TJ2CDtymDad/20WaxQdNe85fy2vQUEbQReVUM/dZTV141/inZzTOwm71CCfR?=
 =?us-ascii?Q?7MoY6r6BdRP2eEl9qPiqJityJajzFl+3lEcQIVPCLGcVIafwYOj0Vq+cDcL6?=
 =?us-ascii?Q?PRnHyOav0yFrzYgFJUcz+ADPYxZ1ljPw1NDFLsVM5RagpKAYBk3E3SAhEhaC?=
 =?us-ascii?Q?AJO2qgHrl0ButUgRtOWzi7xb2AmcX++mHRX2Qs59avjhhNDLrIRWel+4nLYa?=
 =?us-ascii?Q?L2rqLHM+3fUtzv9DEkeeCa6SFqQxrGK8yKtfW7a9Bm3yfBlcvL21kVhu2UbM?=
 =?us-ascii?Q?UfigNbKo+JVIyMS6Vp8ITQSbyDm7Sm8FD90lxep5LwcKUIO5ez73HvdbZQdy?=
 =?us-ascii?Q?CSTe0tQL/irQg6vVPP2j96FlT4KGhpoufgQSXmFmrqYfmU/huvXYV2zfx0Gh?=
 =?us-ascii?Q?r2Cfc6VHGv2lM0DxjNH9NMi5Pw9ARmRqeomWccB9frKsfygFv8DnFtO1baMB?=
 =?us-ascii?Q?rM+lSFs5VV4q5dCCwfbDzLfHqHUsXq3ZgXeFylstj/nXuDONI7a5K84gVmor?=
 =?us-ascii?Q?MFIR5ezl5LdeNDP9QZBAEj6HfZvNTWVozauepg6nXAMv1gQEwSVcCVWA59Y0?=
 =?us-ascii?Q?5R5ZFayx1hPO+FqdTtXTx8lWPKSDih0y+WWBez4yZvUQfVDl/fpGy/twVsrF?=
 =?us-ascii?Q?wYtl82VmvxM/AAlymajCc+/DO/mICVYYiWTl3ym8spkLyVVOA2ZDs0IqY4Pi?=
 =?us-ascii?Q?avL0GfAqB7+9kRNt96heh9n71RePTWX8UHksiuf8UvQeAgzet7HcUtqiKUZ3?=
 =?us-ascii?Q?15CbOgoXC0T2z79lRI3DDz8xaYrSfARGgxXkwsqzM1O+FGp1mxfIjkUqo9Zy?=
 =?us-ascii?Q?aQqT/xbZKG8utS6+gKzXpNdWQhTLrc/VYW0DKXJweK2P89ZkZbMxDnRWaBeq?=
 =?us-ascii?Q?hUbnzegHlFjgyLZ7YDWBBoILi2qHeGf4ResK4Y//YQ7qfGH0lO9e7X6D3REu?=
 =?us-ascii?Q?y7c0yGPYxZOjJdz7+XlS5T/vEcs63GxMZGm8mSqE8ns5FNKZn80YnzRLmBxz?=
 =?us-ascii?Q?pKzUKVEpShKGY21cyD3+qQlM8uRp6l//qyDswhTGDXhvgLivl5osV9Atrbv3?=
 =?us-ascii?Q?ChzwMsFDAC7nM1OQbGww9C1nKewNv/AeKVxgPQBb44/yNkBLObNfHsPx7j3e?=
 =?us-ascii?Q?M72KLQ2Z+JJIOEtQqsNJm8FmcMXrPGj9pis/O5ovChPI5DcocfId1PLox9Gs?=
 =?us-ascii?Q?SM4tD61bLISOYO+sfPkKWp7BG81Bl5JxPw9cpeL3icR77qCMiMfxwu+0R5JL?=
 =?us-ascii?Q?sAGrPTbFzyasNhOUDajshN3WwM/2?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 00:53:23.9435
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0cd7445-2970-4754-b11a-08dce1b373f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6172

In preparation to add tracepoint support, move protocol error UUID
definition to a common location and make CXL RAS capability struct
global for use across different modules.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v2:
	No functional change. CXL RAS Capability struct is now in
	include/cxl/event.h instead of include/linux/cxl-event.h
---
 drivers/firmware/efi/cper_cxl.c | 11 -----------
 drivers/firmware/efi/cper_cxl.h |  7 ++-----
 include/cxl/event.h             | 11 +++++++++++
 include/linux/cper.h            |  4 ++++
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
index 86bfcf7909ec..0d248ad888a1 100644
--- a/drivers/firmware/efi/cper_cxl.h
+++ b/drivers/firmware/efi/cper_cxl.h
@@ -7,14 +7,11 @@
  * Author: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
  */
 
+#include <cxl/event.h>
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
diff --git a/include/cxl/event.h b/include/cxl/event.h
index 0bea1afbd747..57b4630568f6 100644
--- a/include/cxl/event.h
+++ b/include/cxl/event.h
@@ -147,6 +147,17 @@ struct cxl_cper_event_rec {
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


