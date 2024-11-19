Return-Path: <linux-efi+bounces-2175-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5D99D1CA3
	for <lists+linux-efi@lfdr.de>; Tue, 19 Nov 2024 01:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B0D71F221AA
	for <lists+linux-efi@lfdr.de>; Tue, 19 Nov 2024 00:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3F933998;
	Tue, 19 Nov 2024 00:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BGZMeJM4"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2088.outbound.protection.outlook.com [40.107.212.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B43CDDD9;
	Tue, 19 Nov 2024 00:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731976774; cv=fail; b=DXYEql0Y+L5yD4Q+j+42MexdXLmCsJjAt7wbcxxHCYi5t9c25PYVhL0XuMKiOjnoLy6zE0YcBRRJG8guGZuiuPiqqS5IsKxzX7jherNmNBZg95Xew4rdHcMVRVft2OA9Qkpiwmi3KaeDSRFzIuEHD07K/JE2/RTjpV9srXDHPTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731976774; c=relaxed/simple;
	bh=36yDoWeDM96SHaAGYVEkJGHm23x5D1rO96WYtImk3e8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rbYqjoL6MSvwEmvvmpTwqN8dQkh2xfXpE3yVFEB5Wyj/uotMs6luGlNWE1JFiZn5wR9KhZnAcUNxmFeMbgj5/k+yFSEmepeH3yyOVqHg5Kcd2rR56PYbAVrrb/2BGKwwuuztv9RhZM3mQY+J3qNHsKUEcCZL/V7JTR6wEC2SEk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BGZMeJM4; arc=fail smtp.client-ip=40.107.212.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PfbTStn3lC0Kf7lzQHUa3sgMzpOlL8l3VbBL6Z6kfyF0jmkPdeRPMwgtccHGfHT/pqmbBUKK2IIOlLkfFTOfcBuCOaAtgvyKJfYFOzM5hIc5xJes59f9cmovb6r7rKws8Vj8+qAii/PCZ6GcmZ+2Az+AO9UEmf7DWh9nBi37DxH9yF2ZL9QR67u3ODczQ7zPz6sboA9YrfX/RTGsHgsVPmfC5NaLpZSRe1qbSrZHGv6NqZa7820NdINTb++8/NPj2Q+dEvpPlGNYute6mZ8vW5aFpFVdvDkGoHBUcLx5TxXmhTGM/bJnnC8xE/bTNV9LueOA+EM1ZEwXS5dEsYmCxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSf1xRYBSF4bsCI076/XpD5Wes1OgImzDLxY1bYM0g8=;
 b=IEgANRUCLGwT5AHeGZ6c+BEGF8ETks2cGS42iVCfOOntqzIcQSQmXNNIUWukK7Dv3/1bQM8JArKLgVf/8Dv/0kqyU5Dj7UNdmAh8tGJQQVHaAMFH7pM9yhRt5uW7unAivgLFQLZFzibxFDWI+uGWhxHsGJ+MbP5PsN6CJsaw335t9L0ztwicPsFPwS8sNrarjhALvORZbETtqMRD9GNBq5Ur0ohXKPNa7poD8D7ncrnTG/JQDcDdWeknWuwl5RKutRURgfFNOQ67Kx6BiGvhbjvE9DSYZ8aeaQoif+861ft94pcBanzvDKCbpgPcwoxrXWVbunr5tw9TlTX06tvG+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSf1xRYBSF4bsCI076/XpD5Wes1OgImzDLxY1bYM0g8=;
 b=BGZMeJM4Mx4sbhiUhh+FWQbuLAsjfxcZAYa/GyoJ2J87DTTZg5Tey47oljBp7v6na/yRXpou6+WW8WaMPGA0+8HaxNSwZV+7Zb/OAkkw4Pe8MiaZ7s8ViUcPRUkPftd+nJbjtifMOb+DviKXx/hWhq8YlgdmxmfboDU6ooSAYRU=
Received: from DM6PR10CA0018.namprd10.prod.outlook.com (2603:10b6:5:60::31) by
 PH7PR12MB9103.namprd12.prod.outlook.com (2603:10b6:510:2f5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Tue, 19 Nov
 2024 00:39:27 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:60:cafe::13) by DM6PR10CA0018.outlook.office365.com
 (2603:10b6:5:60::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Tue, 19 Nov 2024 00:39:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 00:39:26 +0000
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
Subject: [PATCH v3 1/7] efi/cper, cxl: Prefix protocol error struct and function names with cxl_
Date: Tue, 19 Nov 2024 00:39:09 +0000
Message-ID: <20241119003915.174386-2-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|PH7PR12MB9103:EE_
X-MS-Office365-Filtering-Correlation-Id: 23c2dff0-7c5d-4006-934d-08dd08329f24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zjun3qKuMrySWg7F/Grw6qbWdrq3xta80OX/hxQeRX8MBLAMJ65Vx2AH4js0?=
 =?us-ascii?Q?SdFjDZ1KxrMl+aY0PG1Ko1eSm7fz7tV72gAULD8nCpfs1oB7jcvBTrcfQqWN?=
 =?us-ascii?Q?H4hZQp8obOcej9xl2G3WDbVWnpVJUW3oHMEUY5oc7Ft3C8XSb34YnUxT5QSl?=
 =?us-ascii?Q?5XgkpG8+Hnc0rzWByM2g/SkKOjB6ZuTEcQsAfIHfUvrn0jOUKkjsPIYcTMuM?=
 =?us-ascii?Q?/vEFiq241ECyo6rh3nN6A6VmhpcbEpgDnfqbe7eipD1bAQ6R4l5HMt5p2rsf?=
 =?us-ascii?Q?GmqvBJP2JDTOvjy5T7wfTdu7hs9eA6HRYCSZXOCD1xCLx75GblzBacjO/ju1?=
 =?us-ascii?Q?TCuuSSR/rgW1c6+kXO2Ra6kM/Hz6x4rqvCHdueyRlv2bCpnGlaAkrZ6chepz?=
 =?us-ascii?Q?VY8WBsOB715fuLqcXM8Iu+xrJSCCbg94l+dPE5OqIvFDh0+K01tvWvLy6flk?=
 =?us-ascii?Q?iKEXXNBYT8yMzkcoy3MGqM4xhpdyx1ny/QMIUd4Y16kap06QRJY8CbLgVo15?=
 =?us-ascii?Q?Lu7lZOusn/HVC65m8kbnmocziONLs7v8bK1wk1c+N2qG9hGJH+txeF0EiB9H?=
 =?us-ascii?Q?9YpOO79JBM0FrZC261mlckhlxLRaDO4TKKYs6uEiEE0nkrD57UVp0nPofyp6?=
 =?us-ascii?Q?woaBvdcVo0PK4AVqZkk0vlGnF1jtSZQmHKKM+K48bV+/B11m+SG64wmkcvT4?=
 =?us-ascii?Q?n0uXxD4y3fLWSCpfQLRgGgTXSmD3A08+HbzJqIomG95YYjxXoC4ybdGB/PnT?=
 =?us-ascii?Q?DTCigCSlHcBb2CSn7KZ1GZZQqCN8wbhkjCxevkrGjsjmIDLghibWFHHBvOiy?=
 =?us-ascii?Q?VZCsMLyP87zgusNQUMHCasXekRHo2JypuXg0Vhr4Wsnioh6GU8NZnS788z/O?=
 =?us-ascii?Q?OychRopZoEoHCyJx/s2/Qd03OwK9Y4XuZKlZ5chtkVbTG4XC+zIwRJHevy4B?=
 =?us-ascii?Q?x67zhhQXiCr1LTjD7kH3FoGkayXylDUv9SX3Q134b+hVmlVj9uc+HnMLVlOd?=
 =?us-ascii?Q?IqoHTn177Y9i8HvGt2NyyVkipGr8eUF+9YxIIWtX9IEc+bpTygjnxeXX6At1?=
 =?us-ascii?Q?1kECwJljEmF8JObRsb0S2/phlvStZCfpVifldls9pCog0OO29uxq3XXFaD3M?=
 =?us-ascii?Q?IqxXd0UhPFP0SSf5xFjVf4LJfux44Zm4LaUFSxdSFnT94bh2frP0VyANSWc1?=
 =?us-ascii?Q?AAOAb+I0/RTI/3kwsNHms+NPIBBUuOxmk7a3Oo4fmjRqp5Yn6ljrXnq6ZXoC?=
 =?us-ascii?Q?79mzdoEPJzIua2qud0pTaOuPlVaHnmipSvFAH8fVlHKl6xkK+nsliR2j4ig2?=
 =?us-ascii?Q?fR3gENhaFSklKoBnfJjpKVYBonHm3UoWT3q07z8VRcWVrpQsTM3umUF6foPq?=
 =?us-ascii?Q?u4DSZXZeEOH0SWea4eT2zFhxde6OoAoozZW36FvVEiNdqeUg8g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 00:39:26.6902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c2dff0-7c5d-4006-934d-08dd08329f24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9103

Rename the protocol error struct from struct cper_sec_prot_err to
struct cxl_cper_sec_prot_err and cper_print_prot_err() to
cxl_cper_print_prot_err() to maintain naming consistency. No
functional changes.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/firmware/efi/cper.c     | 4 ++--
 drivers/firmware/efi/cper_cxl.c | 3 ++-
 drivers/firmware/efi/cper_cxl.h | 5 +++--
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index b69e68ef3f02..8e5762f7ef2e 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -624,11 +624,11 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
 		else
 			goto err_section_too_small;
 	} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
-		struct cper_sec_prot_err *prot_err = acpi_hest_get_payload(gdata);
+		struct cxl_cper_sec_prot_err *prot_err = acpi_hest_get_payload(gdata);
 
 		printk("%ssection_type: CXL Protocol Error\n", newpfx);
 		if (gdata->error_data_length >= sizeof(*prot_err))
-			cper_print_prot_err(newpfx, prot_err);
+			cxl_cper_print_prot_err(newpfx, prot_err);
 		else
 			goto err_section_too_small;
 	} else {
diff --git a/drivers/firmware/efi/cper_cxl.c b/drivers/firmware/efi/cper_cxl.c
index a55771b99a97..cbaabcb7382d 100644
--- a/drivers/firmware/efi/cper_cxl.c
+++ b/drivers/firmware/efi/cper_cxl.c
@@ -55,7 +55,8 @@ enum {
 	USP,	/* CXL Upstream Switch Port */
 };
 
-void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_err)
+void cxl_cper_print_prot_err(const char *pfx,
+			     const struct cxl_cper_sec_prot_err *prot_err)
 {
 	if (prot_err->valid_bits & PROT_ERR_VALID_AGENT_TYPE)
 		pr_info("%s agent_type: %d, %s\n", pfx, prot_err->agent_type,
diff --git a/drivers/firmware/efi/cper_cxl.h b/drivers/firmware/efi/cper_cxl.h
index 86bfcf7909ec..0e3ab0ba17c3 100644
--- a/drivers/firmware/efi/cper_cxl.h
+++ b/drivers/firmware/efi/cper_cxl.h
@@ -18,7 +18,7 @@
 #pragma pack(1)
 
 /* Compute Express Link Protocol Error Section, UEFI v2.10 sec N.2.13 */
-struct cper_sec_prot_err {
+struct cxl_cper_sec_prot_err {
 	u64 valid_bits;
 	u8 agent_type;
 	u8 reserved[7];
@@ -61,6 +61,7 @@ struct cper_sec_prot_err {
 
 #pragma pack()
 
-void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_err);
+void cxl_cper_print_prot_err(const char *pfx,
+			     const struct cxl_cper_sec_prot_err *prot_err);
 
 #endif //__CPER_CXL_
-- 
2.17.1


