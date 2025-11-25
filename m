Return-Path: <linux-efi+bounces-5685-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 25351C865F4
	for <lists+linux-efi@lfdr.de>; Tue, 25 Nov 2025 18:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A9A204E7F21
	for <lists+linux-efi@lfdr.de>; Tue, 25 Nov 2025 17:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9DC32B987;
	Tue, 25 Nov 2025 17:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PYpiy5qP"
X-Original-To: linux-efi@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012028.outbound.protection.outlook.com [52.101.48.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E4832A3CC;
	Tue, 25 Nov 2025 17:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764093537; cv=fail; b=p3gMv0JsH3jn7RPVQJ16k0YX/aloPUE9HV1yOXJ4z3sJMLASv/A/2hP3A8xuQBtr44wEWWpsiko8AAU9pKIq3jOETWbKkv3sqeBF8kmvmRGGPDqPOi8qpqhVWD5HKK2u9g3jrNk5Lf++r4bWHlBu+dATfzibRb4ecUQTIQLslMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764093537; c=relaxed/simple;
	bh=xJu9mNi1IjyLKbBz1ibZxTn8yaVipJfK6QmGERE/k4U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BCNVW0CyEOKJPCgg2qn6k/n0fbMO3/6EEiAvvWyAGqG4UFhtXOEi1Vmw+QIs59K0r9J1zMM+IlEaSdTlFav6lIbzDPXikwP4OlfeW+MMhUkV8wDqmoK4lcdd5e0OQ/r1tBixbHmo1WJA+mzbk6Lpv8RTygyP27L1GULCLAOTN98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PYpiy5qP; arc=fail smtp.client-ip=52.101.48.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ovpNufDk65tHbxDV1M4ePTV9DWNTD20TEN9UX3w5ADP/C6DiMGuoGQEFQll5bTXLOHqA+svDABDxd7rIyZWMMuhwQVqmxdHa+s0VmIQjulINtn3oj8pQJKPaK6OoCPMt4KFyMybZ+X6CGG8FiwFzH3tepNeDKvOJTwOyr9D7eKawlbpdCiiYpSF81U+Mle4y1o3ZS3r3B8dk71oo7vHLV5LA4AmieJ3Cbogpe7lAe7cWndx77oNVjY6D94UG9mU55v8JvjR8nGc4NOyQ5z2kVoI5cKq2qk84cF5NrTY0MM7QN9YGvP32MAKZPBiJUPTfH5z/glb7DQavg58h2h/HxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjvT3i5m6T8di9YVa9mKg/P2a8iZquN2ClEbnUdf0vA=;
 b=JUfMjy8r7g/vesEHblwYfdTf9Rm2k3Bmt1vvGwsr0ByLVuBvndi6WeNE73gOzDMghcQ1WTOCVivyKhus0lbOgHKa1SocceedP1xwvH3Pno5UtyA1mwiFu9fQ9yUy9ZiXCUdlZtIqw+wpO+rhK1UhXy57cwZbNr+aAY/Q7DkhpPa4q1Cxaoc2iviEDiIJf40GBO1oeb9Cnd+t2BoxloMxhKP4XGwtuZO8OQ2i9ZV5oYKkfG7ZYSCeHolFsiGyeHFqlqsDyH5Jgu1csTIyzYttYWxIaH8Oim4EFglE6ToM0h3rNE80zhmnXtJn7LtxRn//F/L2xJ5r54GaYyx7IqTGgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kvack.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjvT3i5m6T8di9YVa9mKg/P2a8iZquN2ClEbnUdf0vA=;
 b=PYpiy5qPje4jcbnHmpX+bI0SAIgUL8B4jMS+DirsKSZZW+QE84jvds1F/DYPv0quQ1GTt0vGdIkplRmnOfdMFHrG9pYhYU+nBDEN97cdOpXEdRybGD1PUR7GtC5JeA/56K/aA0bRzLV+jvatxbGl9TzqtBJXfNYCFH/00eEhFUw=
Received: from SA1PR03CA0001.namprd03.prod.outlook.com (2603:10b6:806:2d3::12)
 by SA0PR12MB4495.namprd12.prod.outlook.com (2603:10b6:806:70::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 17:58:47 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:2d3:cafe::d6) by SA1PR03CA0001.outlook.office365.com
 (2603:10b6:806:2d3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.12 via Frontend Transport; Tue,
 25 Nov 2025 17:58:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 17:58:46 +0000
Received: from ellora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 25 Nov
 2025 11:58:44 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <linux-mm@kvack.org>, <linux-coco@lists.linux.dev>,
	<linux-efi@vger.kernel.org>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <kas@kernel.org>, <ardb@kernel.org>,
	<akpm@linux-foundation.org>, <david@redhat.com>, <osalvador@suse.de>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <prsampat@amd.com>
Subject: [RFC PATCH 4/4] mm: Add support for unaccepted memory hot-remove
Date: Tue, 25 Nov 2025 11:57:53 -0600
Message-ID: <20251125175753.1428857-5-prsampat@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251125175753.1428857-1-prsampat@amd.com>
References: <20251125175753.1428857-1-prsampat@amd.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|SA0PR12MB4495:EE_
X-MS-Office365-Filtering-Correlation-Id: 11860673-63de-428b-9384-08de2c4c4793
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DMf16Gbni3xALdi4cu8fHjRUdOgju18DlQJft7bOAHQAlhUC4N0m4ssUIhtf?=
 =?us-ascii?Q?SuX2RUcTuUS3AfS8P/LYyuQUIYyh4+tNWanf94ZQVfTyLmdc7BdqxWtHpqB5?=
 =?us-ascii?Q?GP7Qf6H+AQBvOSR6QG0yf39sTsUIwdweFytGD1LBe5TnwPR9QayN6pfo+gCM?=
 =?us-ascii?Q?uDfWyQWlUZNNgT+kfKBpKtoyTqmgD/0Zz4OqyKo1OkSRIkCNBXhDsnhEEvD4?=
 =?us-ascii?Q?fcA85EMs5OmCbcET/pDkOq8InodM5uJ92kR/L/6pxtM1tGKLkKg1PPeRmW33?=
 =?us-ascii?Q?keNqKsc6pHqsmYn/h495e/6Wj9x8YOwADB+h9WwV6kFea4p6fv8km5X/Zena?=
 =?us-ascii?Q?f7dKMAMKrm1UumRIo2DtbI/0pQoNvi7/p+TvhPOf+TuS1k+bZ7FyPwDHlUWC?=
 =?us-ascii?Q?ZoPfvBn8FbGRfZK1a4XRujlXrY2pQP98uLaMIyOGBxGtAo7AVPgdwyT0rLzE?=
 =?us-ascii?Q?QlnBI74mKXCjATsbflkHiedLAkgXKvYnXJDYFmDffNdpINd/UFGyli9qgsfo?=
 =?us-ascii?Q?dHvLeaTZZ6KOV/DaFrxUI3VqozICQkfqcH7HXWIRiIz+4rauA/rz7jE65wFn?=
 =?us-ascii?Q?m/lOnY86/zMOVSIEfchjJo6U7Uh04dlLjvY60BX/Rd5BF0axzlanjFy/xALI?=
 =?us-ascii?Q?vBQZ0BI/d8yljJZg0AmVk0wDlobFesKaffuh5A4X+NhYeIiecI9DZlVZYDkL?=
 =?us-ascii?Q?Yil0uO+4+AvTzcwGa+FD6g6gd9l0etZDxnKiiESUWS+RRmrxY+9guFSsD9Lo?=
 =?us-ascii?Q?yZdzZv9i/7AWpVki8qTEVCOzTaUByZGcYqVqQfsN98l5/lsd4ON8kZFGO2jL?=
 =?us-ascii?Q?pED05kEArdrukNBzzi5p08jezyJ6sMOaNBRcm42lY6bfdLnbDManj/58ilMn?=
 =?us-ascii?Q?o0JFYZ5LtA0fAjqZIb+/SPMw1AGeRZd9iv+Ndp1OlFzUn8OL7CU50AuCFixF?=
 =?us-ascii?Q?97hNLjmrFGmM/ZfqF0GLUyuECJw0bJVlI9tHNmF+dKI/nxiLM9wZPz/cQAwj?=
 =?us-ascii?Q?zM9anRSPP9CjQk6JpLfHTUrJUcmkwq0HPLXKrYM2i5U7oXbG3BnE9CmjFhrJ?=
 =?us-ascii?Q?Rv+bGlGgtynixLbh9O5BKup0Zwqsx4fqVDJeJEV4u0WScyJXZOGqjoo0Qr+e?=
 =?us-ascii?Q?+J0mOM8RUutbREw6FgDQkAG9CPqu0zW7798aJq7zd27rC3dnNv8GPBWmGHV9?=
 =?us-ascii?Q?6tk6+4OvTa9Xs/lVzuvtfwNMdfFZJO0aqpby1TQBhKBuNQ9f3sja0SXSV/b2?=
 =?us-ascii?Q?4EsC6t1taQ//wDwVNeDrs4B05xpbtqKnQmAqSEMtFu6zExmyOje0Ho6eFWvl?=
 =?us-ascii?Q?tN76mMqK/806tk0+P3yJgoj3pKNJKZ+bRMhgQ6mKTYKNr9wAPC6Y3fYi3UEk?=
 =?us-ascii?Q?qAnTNhbetuyuYhRn4EP6VEQCuqqvDvk6NclUUygIWJZm0fgWWBYFG+0c/rSc?=
 =?us-ascii?Q?tlSWuRo2GYptboTvP2YPXIG5JYMI+bxL7OcwsY1FOKvjfSSzfkNzGAhZ1dBK?=
 =?us-ascii?Q?/ovqjSoCkkxBRzTczFcKqJsuZjCS5Y017RJuaAe8632qUnX24ZUZzDa/6aCH?=
 =?us-ascii?Q?yJ8Z5A8VyyoQ5K+sxj4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 17:58:46.2494
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11860673-63de-428b-9384-08de2c4c4793
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4495

Transition memory to shared during a hot-remove operation so that it can
be re-used by the hypervisor. During lazy acceptance, only memory that
was used has been accepted, therefore during hot-remove only mark pages
as shared that were previously accepted / made private.

Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
 arch/x86/coco/sev/core.c                 | 23 +++++++++++++++
 arch/x86/include/asm/sev.h               |  2 ++
 arch/x86/include/asm/unaccepted_memory.h |  9 ++++++
 drivers/firmware/efi/unaccepted_memory.c | 37 ++++++++++++++++++++++++
 include/linux/mm.h                       |  7 +++++
 mm/memory_hotplug.c                      |  2 ++
 6 files changed, 80 insertions(+)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index a5c9615a6e0c..c05fc91d10a1 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -621,6 +621,29 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end)
 	set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE, 0);
 }
 
+void snp_unaccept_memory(phys_addr_t start, phys_addr_t end)
+{
+	unsigned long vaddr, npages;
+
+	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		return;
+
+	vaddr = (unsigned long)__va(start);
+	npages = (end - start) >> PAGE_SHIFT;
+
+	/*
+	 * Hotplugged memory can be set to shared externally. Attempting to
+	 * re-share the memory (during hot-remove) will cause the pvalidate
+	 * operation to not make any changes to the RMP table triggering the
+	 * PVALIDATE_FAIL_NOUPDATE condition
+	 *
+	 * Since the memory hotplug case is unique, specify this intent so that
+	 * if the page is part of hotplugged memory a pvalidate rescind
+	 * operation is not performed
+	 */
+	set_pages_state(vaddr, npages, SNP_PAGE_STATE_SHARED, SNP_PSC_SHARED_TO_SHARED);
+}
+
 int snp_extend_hotplug_memory_state_bitmap(phys_addr_t start,
 					   unsigned long size,
 					   uint64_t unit_size)
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index eb605892645c..8f3c5b878fd7 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -547,6 +547,7 @@ void __noreturn snp_abort(void);
 void snp_dmi_setup(void);
 int snp_issue_svsm_attest_req(u64 call_id, struct svsm_call *call, struct svsm_attest_call *input);
 void snp_accept_memory(phys_addr_t start, phys_addr_t end);
+void snp_unaccept_memory(phys_addr_t start, phys_addr_t end);
 u64 snp_get_unsupported_features(u64 status);
 u64 sev_get_status(void);
 void sev_show_status(void);
@@ -639,6 +640,7 @@ static inline int snp_issue_svsm_attest_req(u64 call_id, struct svsm_call *call,
 	return -ENOTTY;
 }
 static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
+static inline void snp_unaccept_memory(phys_addr_t start, phys_addr_t end) { }
 static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
 static inline u64 sev_get_status(void) { return 0; }
 static inline void sev_show_status(void) { }
diff --git a/arch/x86/include/asm/unaccepted_memory.h b/arch/x86/include/asm/unaccepted_memory.h
index abdf5472de9e..ad392294b71b 100644
--- a/arch/x86/include/asm/unaccepted_memory.h
+++ b/arch/x86/include/asm/unaccepted_memory.h
@@ -18,6 +18,15 @@ static inline void arch_accept_memory(phys_addr_t start, phys_addr_t end)
 	}
 }
 
+static inline void arch_unaccept_memory(phys_addr_t start, phys_addr_t end)
+{
+	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
+		snp_unaccept_memory(start, end);
+	} else {
+		panic("Cannot accept memory: unknown platform\n");
+	}
+}
+
 static inline struct efi_unaccepted_memory *efi_get_unaccepted_table(void)
 {
 	if (efi.unaccepted == EFI_INVALID_TABLE_ADDR)
diff --git a/drivers/firmware/efi/unaccepted_memory.c b/drivers/firmware/efi/unaccepted_memory.c
index 6796042a64aa..662cf0d6715f 100644
--- a/drivers/firmware/efi/unaccepted_memory.c
+++ b/drivers/firmware/efi/unaccepted_memory.c
@@ -301,6 +301,43 @@ int accept_hotplug_memory(phys_addr_t mem_range_start, unsigned long mem_range_s
 	return 0;
 }
 
+void unaccept_hotplug_memory(phys_addr_t mem_range_start, unsigned long mem_range_size)
+{
+	u64 unit_size, phys_base, bit_start, bit_end, addr;
+	struct efi_unaccepted_memory *unacc_tbl;
+	unsigned long flags, *bitmap;
+	phys_addr_t start, end;
+	int i;
+
+	unacc_tbl = efi_get_unaccepted_table();
+	if (!unacc_tbl)
+		return;
+
+	phys_base = unacc_tbl->phys_base;
+	unit_size = unacc_tbl->unit_size;
+
+	start = mem_range_start - phys_base;
+	end = (mem_range_start + mem_range_size) - phys_base;
+
+	bit_start = start / unit_size;
+	bit_end = end / unit_size;
+
+	/* Only unaccept memory that was previously accepted in the range */
+	for (i = bit_start; i < bit_end; i++) {
+		spin_lock_irqsave(&unaccepted_memory_lock, flags);
+		bitmap = efi_get_unaccepted_bitmap();
+		if (!bitmap || test_bit(i, bitmap)) {
+			spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
+			continue;
+		}
+
+		addr = phys_base + i * unit_size;
+
+		arch_unaccept_memory(addr, addr + unit_size);
+		spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
+	}
+}
+
 #ifdef CONFIG_PROC_VMCORE
 static bool unaccepted_memory_vmcore_pfn_is_ram(struct vmcore_cb *cb,
 						unsigned long pfn)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index bb43876e6c47..34d48693dc86 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4079,6 +4079,8 @@ bool range_contains_unaccepted_memory(phys_addr_t start, unsigned long size);
 void accept_memory(phys_addr_t start, unsigned long size);
 int accept_hotplug_memory(phys_addr_t mem_range_start,
 			  unsigned long mem_range_size);
+void unaccept_hotplug_memory(phys_addr_t mem_range_start,
+			     unsigned long mem_range_size);
 bool mm_lazy_accept_enabled(void);
 
 #else
@@ -4099,6 +4101,11 @@ static inline int accept_hotplug_memory(phys_addr_t mem_range_start,
 	return 0;
 }
 
+static inline void unaccept_hotplug_memory(phys_addr_t mem_range_start,
+					   unsigned long mem_range_size)
+{
+}
+
 static inline bool mm_lazy_accept_enabled(void) { return false; }
 
 #endif
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index bf8086682b66..0b14b14e53fe 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -2254,6 +2254,8 @@ static int try_remove_memory(u64 start, u64 size)
 
 	mem_hotplug_begin();
 
+	unaccept_hotplug_memory(start, size);
+
 	rc = memory_blocks_have_altmaps(start, size);
 	if (rc < 0) {
 		mem_hotplug_done();
-- 
2.51.1


