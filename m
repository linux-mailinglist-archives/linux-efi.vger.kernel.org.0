Return-Path: <linux-efi+bounces-2383-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C22A9F40A9
	for <lists+linux-efi@lfdr.de>; Tue, 17 Dec 2024 03:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBFCF168F9A
	for <lists+linux-efi@lfdr.de>; Tue, 17 Dec 2024 02:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C271459E0;
	Tue, 17 Dec 2024 02:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x7Vz7HHl"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C7813B2BB;
	Tue, 17 Dec 2024 02:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734402147; cv=fail; b=KOB7tNY2iRufRpTOGID9CEU5pqfWgyo/K2gUlCpQqmbUacZKop9LhgfOhYgFx8ZdzFQpHMGvA4A1xavU9uP63UqL9EfQPRg8C9wXnZ9NER74Cy2oHamX2iOZVVSCagX7VNa9ZZSd3BB4hFu4omOxsOFW+hAtYGQ/dkKPASaonBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734402147; c=relaxed/simple;
	bh=PS4lUV9NFxkqDWJZUQ+BaHlnOzKZAlMaalb7vtI/Wzk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aDETrrIns7oGsT5WIddvhU8o/Ss+CEmXEFOdP6Y/taLwW5QoFlmNstSJ7M5jUfVFMpsc01m7/jM1QFfhsfIb4bgRhKjs1IQjGuK7muGA6NeaaFWn90hBlm1QyXPjyk2Toiq4sphjm0RDcwXNs6vyoykbv/Ia9p3eZ4HACvNFMqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x7Vz7HHl; arc=fail smtp.client-ip=40.107.223.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q5i68bD6Q1XOlnWZoDNRZuHRXYH+TPzDB1R/FcI6lthxd44mHmVHuMnPyIc6r26CL3mjUgObai97ADdWV9sjhNNFxL6UuZJFPv119cZDbidxf0d/R6fMoepm5gwiB24KXjRKr9DQGKe6Nw/GiA7/I6kw0TtSdEKVpCwja2kTefjFF7W9plvyG1084dIuC0u4cqn1biL170Z2QHApR8OZ8bSuW6+gGtvQyPx5gOL+LSfFgHKxr7RI7bmigHalsyCcEERNRfGM4aZ5AdrtI9ycogKN2pgLk4KFFVygngyQstsu2uSXAIv9hKEanlQTNU+NQVEtv5h6Xwgk5RSLKI206g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vwh0Y8h7Qi5kZU+4PJgSGPvhFoQkZ/QQrgLMuEw+DPc=;
 b=CH+TkcVeU8c0JSBUq9KJUVkDypTvvW9R0EtWXQkMUoQaNaMAD+ybIfew5Qx97ceXARlxOFAbyAlLbVYugzT28k9dxiba8ryyVU/+A//Fkrs5dMvWJRJzJGl6zfFXc/ukj92tGUkgZb+gV3eOce3dnxcy92zb6RhIWB5qd/WemzfKP74jYen91VW1H7waojqValwqUYWu2AbYuMamNr3/MfS4ggJO+E859w+bnMLuO0KhdwD3X63ugCih2a8UES7fojLNC0blyOzF6HTiic2TPIhpHzUU74Y23ht4TDdwp6FJwOzHr+P82rP26nCvrzj9Yw5+bngrf6nCq1qTpt5Xzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vwh0Y8h7Qi5kZU+4PJgSGPvhFoQkZ/QQrgLMuEw+DPc=;
 b=x7Vz7HHl6Rm6JDonPm0WqxaMsUp1X4sA62dkUPztHaoJyZH9rt5MrKrGRZ8ojmdFXNgnJOeHORfessGluSBryS6BD4UhL0EUX2q9DpkUFmgIUv/3rq5u9mHIM1GG0WBXWYCo7HHU2f137yNsW4a8h/CHJg347AjhAAISYfrOVgE=
Received: from MW2PR2101CA0034.namprd21.prod.outlook.com (2603:10b6:302:1::47)
 by MW3PR12MB4362.namprd12.prod.outlook.com (2603:10b6:303:5d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 17 Dec
 2024 02:22:22 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:302:1:cafe::89) by MW2PR2101CA0034.outlook.office365.com
 (2603:10b6:302:1::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.5 via Frontend Transport; Tue,
 17 Dec 2024 02:22:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 17 Dec 2024 02:22:22 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 20:20:49 -0600
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>, "Smita
 Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v4 1/5] efi/cper, cxl: Prefix protocol error struct and function names with cxl_
Date: Tue, 17 Dec 2024 02:20:28 +0000
Message-ID: <20241217022032.87298-2-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|MW3PR12MB4362:EE_
X-MS-Office365-Filtering-Correlation-Id: f5eda74b-ed6b-4e2a-411e-08dd1e41a38a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?24TI8Pm1Kwzu4mrNnIJ36V1nUd/JctPNPGv4p/U8BQ+SBBZLmynePpYgtLqt?=
 =?us-ascii?Q?HMtKqKySNU1r6kCJwV0L7pKB66+DN53XCXpeZOj5cBo+hlb9hxuw16ePR7xW?=
 =?us-ascii?Q?dQEhk8o2tVyuoS8GVEVFwk0Tx9fVaIveb8nA5k8vPFAVmSOciTLgE/B/wFT8?=
 =?us-ascii?Q?fSbY/DlyNzW0JLtxNRE4eD4puvTLz+s0NlQ2sciOQQPUO79SAp/PPTE6HLRo?=
 =?us-ascii?Q?IsAIslPus2CK+zeXpBQwZShpMJ/axhTFpfLLG36AA02rgNps7xl8DhMbJjcG?=
 =?us-ascii?Q?zwl1514713dCO5IRKog12oLvqo90vcWiDSLHy2Fr/25uVoqV1NqvRUSyDtft?=
 =?us-ascii?Q?rmER3x2IgjYDdLrIT6H7CtHYu4OJWdfvOP/AZwdq6PzLgaatgAP/Ydd5mSei?=
 =?us-ascii?Q?WbGYhXTKovi7eOrR6oiaQGcdx/4bS/zinMc6IEeRA/2ZgwGdTusZs8nEebWG?=
 =?us-ascii?Q?3TMh1lTNaaRz+PHLawlgAnsbosxKhAaQQC/QYyFLgiepPpwDJ7GtnD9PS4kn?=
 =?us-ascii?Q?gQ2S6GPkcVGHuZLvnC7kqtCSe1mleFATyJu3SDeBqwgQ/ccxK2aDJ40zcchJ?=
 =?us-ascii?Q?NVkbbWpKLoGaOty/DKcj6ekev3lI5S8PDW0g1AuSSdS7PgIlbJyB+MUDvRBZ?=
 =?us-ascii?Q?Lmjm68xS/ysSWEefp8U4G9SDeAOxD//tcmVZWiaxrEyiwUliZ6GEom4kut0u?=
 =?us-ascii?Q?XfPSq5UA18isXT5TBH4dZ29n8o1i4ljtDG26ymzsKquTsnjefTqVTS8p8BgI?=
 =?us-ascii?Q?4pLyR+oWUtTF5ub7CgdEBZljBYSt5SPhaWobEffsuEk/+jubSN6kF4L96D4a?=
 =?us-ascii?Q?ECDjjjFxzkBmECzLZyJss8NuCaKPxRfZ8+L0XG0hpEBf30w5zrg3PwfptA7d?=
 =?us-ascii?Q?WTpHhYWoE/wDOpoPjENIuqR08phixj5aZG+3KadP/fM/mnTnlVbLKLQhnFh5?=
 =?us-ascii?Q?8Y3ny3QbF3bpuwTAk25Zx/y2JQaUjDgo+eke1dbOl2xDJJiqmTDddgQV1sZp?=
 =?us-ascii?Q?bkwrYlhFUoXwoZztwJqVCbf3FfGp/HSEQLDi+5u3MQmQZl45rzViA0lcpJ93?=
 =?us-ascii?Q?RB2vaR14pUZdRKHgDkLjpHo688prVYVDSD4x1OJMjGxTPFvMrupigKi/A3LV?=
 =?us-ascii?Q?rfEm3AmvmhftgEaVxyGr031fBGMMfhwu3IrBj8Ke7gkszovnRd9rNpxaOhE6?=
 =?us-ascii?Q?We8b7aSQiZ+2ag1vz6EEPm/hAD3uubeF++aKBgFalTPD9WN1zW444eSLqsoF?=
 =?us-ascii?Q?6Sx/l7x4ix13StnaSx4tKzTVWrlnFBwN0o3qMx6PXm+ibAcbngQtOvgvWc92?=
 =?us-ascii?Q?vbi2DySjrrouRvCu86U5YbBIupKQ0yxFD6vLAG7NrROQFrmpodJV+DjFwO56?=
 =?us-ascii?Q?DNF2nD63Pn81YaWpbHslFgj9jHOQmhcZGDrlj0swXVnezw9WyC47a1ZTM7VU?=
 =?us-ascii?Q?rPQ6TM8Q0lsB2ZRnPn1QquigbWbJuGQVT4U0orBhEQIQnPTpEgyvtQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 02:22:22.0370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5eda74b-ed6b-4e2a-411e-08dd1e41a38a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4362

Rename the protocol error struct from struct cper_sec_prot_err to
struct cxl_cper_sec_prot_err and cper_print_prot_err() to
cxl_cper_print_prot_err() to maintain naming consistency. No
functional changes.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
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


