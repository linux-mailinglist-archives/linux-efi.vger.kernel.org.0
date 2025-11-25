Return-Path: <linux-efi+bounces-5684-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F1AC865EE
	for <lists+linux-efi@lfdr.de>; Tue, 25 Nov 2025 18:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6A8E3B6291
	for <lists+linux-efi@lfdr.de>; Tue, 25 Nov 2025 17:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B32532ABFB;
	Tue, 25 Nov 2025 17:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="frYqGrB4"
X-Original-To: linux-efi@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010014.outbound.protection.outlook.com [52.101.201.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4A032B9B8;
	Tue, 25 Nov 2025 17:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764093524; cv=fail; b=NB212kRVPXKEtr/pFt+nfqnfZuk+mf7zKqvQXN4dImdTh4q0A8zKYotxKHhOXltHGJnXne4rTwqkMvYT0V/WDa3SQj1VDZgGdpKMs1Q/7JF/5SOlH/CO+BcZkhj6LygOKptDWEQbA18Bw9GgDbMumXKnZKM56yq0w2XAKp27LvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764093524; c=relaxed/simple;
	bh=SCp6B3o2UvYhhtpZj+ZUt+Ok56Fkit61Cyp2WAu+W+I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cRBQCsVaIcQXNZuMTSjv3b0SR7IQKGJf9Oxz5tAFiIV3CPyQDJysBzr4hsyPR+unagbS9ov7C2i/C9vgJaDP0WN4sH4Tj8VNQG18N9htBAuimsnJVWhvM6HuPpxiFFdjrZoKQAdtRvvk0i24aVNiFUVPXiVlLW4RgyuFw96qRyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=frYqGrB4; arc=fail smtp.client-ip=52.101.201.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BGzo1YKAnZFqcgEl5QhlmBE06S6kYtV/p6/x3VqM2FS6mr5Sk++21SCaPSxm05gDmTKFKjsPydQN7RHOZyXZuLn5Vryvm7p/Q1pbYlpN3gPzU+ul7JfM/0HTrynMTATb2PDMnfjyzXJay0IaL1mZiPGX+quob7KZ0MXPdLwZI5USu78LmVZda4RtOU681B2KWbEd2APNnqYbWJRcYNu9hy8Y0roQk1d9dqFQTYtdgVpYL/IkFU3Z3aiYmzIIkhu9XaTwn8ewbPOEoMBFGjyKdQ8CNtuyBcUhzqR/cw3EjszwGiHuGn+6DLxDSQ2LHjeSVlAE89wABM74jWnwsbIxAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYcxaV/0BIoYUz+X4xYCAdgjO1ThW+FLadL/OuqHDO8=;
 b=cQrA7Y+K02RC/+dsmLnqulHsml/csmfgVQ0TVeDPU4Im+RTqOXTT4xH+wTPPi/9cRUsbQn4edOwwPJMLeTTn0q4+o3DgR+LMNkmLQUnx3fb9ypBKIFA+JB4kcUjdtkRNmkyuBAfiwFQ5NMCc45G5cIy51ypdDl7cCaVAxtooFbMey6SIRppkZBhTs3pUsjpI0UuL57MEs7OGUGN4uKaE2dXATYLntWRXfNa+5r6R5R4K4gv2GYgeQQyc0/GD/1pOweTBqtUPu3h8t4vXc9qezzXOQHTbXB5RyB9T6HLWBZnaQ7fq/Fawc4f6MW4zYBaDt820Se0kJ/DzSIb5pA3lZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kvack.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYcxaV/0BIoYUz+X4xYCAdgjO1ThW+FLadL/OuqHDO8=;
 b=frYqGrB49N5g38Sg2wsS/POY0N9N22Pmd/HnQHZKeyV+pKah4fwqCraF9ZsykGQHuDgDYuoH+qTmLR+OWzcEqas2Lb8xvy+JlF9GxHqo2ZIoHReIIUrHuub1SlcANlMo/Lfbje0tLkFi3asT2AajvBbJFm2dJ0AwmvCznKmcLSI=
Received: from PH0PR07CA0092.namprd07.prod.outlook.com (2603:10b6:510:4::7) by
 CH3PR12MB8281.namprd12.prod.outlook.com (2603:10b6:610:128::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Tue, 25 Nov
 2025 17:58:35 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:510:4:cafe::bb) by PH0PR07CA0092.outlook.office365.com
 (2603:10b6:510:4::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Tue,
 25 Nov 2025 17:58:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 17:58:33 +0000
Received: from ellora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 25 Nov
 2025 11:58:33 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <linux-mm@kvack.org>, <linux-coco@lists.linux.dev>,
	<linux-efi@vger.kernel.org>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <kas@kernel.org>, <ardb@kernel.org>,
	<akpm@linux-foundation.org>, <david@redhat.com>, <osalvador@suse.de>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <prsampat@amd.com>
Subject: [RFC PATCH 3/4] x86/sev: Introduce hotplug-aware SNP page state validation
Date: Tue, 25 Nov 2025 11:57:52 -0600
Message-ID: <20251125175753.1428857-4-prsampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|CH3PR12MB8281:EE_
X-MS-Office365-Filtering-Correlation-Id: 18b30cd2-23f7-45ec-ccf0-08de2c4c4045
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N93Fudi/h0LS1F302TWmG1CM1Asqhft9s+BaFE3B5B9y78aFY4A9o8DHcDUh?=
 =?us-ascii?Q?uKDWRLVNR0YwhAipOr6X9pwQy29BdTA4Nge8LcuBljdPa2fRZEcvEHcmLX9j?=
 =?us-ascii?Q?GUfJVRXUM158i7xpn2n1zpqQkbgZy/AOpNIM4bsKxBumdVASyfuuwH9wkrFG?=
 =?us-ascii?Q?sSgAqw5mGoq0ruhfLdEQFzUtLceE5nOrYc2VC8gFYk3I3yybfWeYZYzpHUUd?=
 =?us-ascii?Q?JHlbzsn5qMP+cO88JTH29owEWUdcGVIQZoTKEMg72ytV+qcsyXXuNYv8AWEg?=
 =?us-ascii?Q?Zu7/T+X93eBfrRYOyok/YF3opBmFqv45uMA/JUrfJwEVpObjhZV+iSwD3p/v?=
 =?us-ascii?Q?wBfyhqT7FMVXMNp03K1fwQZYg56AskZ/5V1keE/BaIXNQKIRrYp543VRjs4r?=
 =?us-ascii?Q?dB6o/YImRq1fmSZyAB6RAFOyYHURR660GPOmrFYTe3+WQxCg8nIvE28suBg6?=
 =?us-ascii?Q?SgOkrDp3CAnCKKA69X+aipVRaVIfm3g6G4b9m6lEjvVIORemVPxhnayG/nVA?=
 =?us-ascii?Q?djwgIrMhDlN7V32b0trujo4D1Oyl0p1QFYDKtV5/OfuB6wUFXMwxIc8VkjJv?=
 =?us-ascii?Q?E8jVzzHuBc6wrHP6yG9g1PBIBiUXhjSFVqZjf+t8JsJrQoevi9zS8cnxAUd9?=
 =?us-ascii?Q?g3UyDLIZfrpryfj2MIf5Wm+zLW0EE/F1cnTwrYOLPpOsSup5a6n3dZl+mdrv?=
 =?us-ascii?Q?ZLu1/T/83sftaggWX8Ef7ogzwY/GmWvVm+X5tNHEYtYQEsJQSXL2sKQcFNf8?=
 =?us-ascii?Q?W7Slg3Fw0JrKGTEAIVutGdalkmVFDmhcAVu4qkcME9VI+tsRZ52YuksU46kh?=
 =?us-ascii?Q?yV2DCYl3QsW3VXnDtEKAdy+EiZIwVzaEQl7VnyM2rHCMOIX0EnJEvlV8Ewqf?=
 =?us-ascii?Q?CB348UGEwV+8fQPSg5O/1/3oQUhh2qmz7U9Wsru4k+Ch56zVKzJw/eUc8gUz?=
 =?us-ascii?Q?bzglQph6PuDG0txxP4ZrH80viptTckR7aL4f5v7QvQ5O8uiiEhhw+s9dVKkT?=
 =?us-ascii?Q?cKFtal4xbl8gSBKbLfShHWc5clzCjnT8NWc71VegFF9AR5JRKKGvNrBZsVRW?=
 =?us-ascii?Q?PHey/6dZshrv7aawnay+cbpE5q0s7KLUiVv0SfSGAggXosQbM0WCyzx+DxPc?=
 =?us-ascii?Q?1zGDnL8qOwPmebgh2FRRKNfuj0q9fuzksHxJEl3x22Xz4fTzCmFqb4zSEzyR?=
 =?us-ascii?Q?9hFAh21ZHHgeG+hlaifPse5lRtH9uUcNl46EbaTuZw1iMJNKtW35uDKEJGyO?=
 =?us-ascii?Q?x4jk4bAMNmQk0/BgljPpvrJSG3BBn6MdZDrueBqpltJxMdYSn+hE0Y8mL7zu?=
 =?us-ascii?Q?uNCmFZK8BvS6nLB62UDIXbRUDx90kD+LarwcItohyAKPIhpiNTTDCnTQ4M2f?=
 =?us-ascii?Q?DtzWHg5DG1qU1uXkeZQuQMkYrCvgP60s3iPX4eUIp5ZV3/U0qeWc5TYcrtXo?=
 =?us-ascii?Q?imB8RVh5RBebIT52CZcEyNClLWkGgZjtOKbRxBnTtvqrKpHTZ0/FJz6n0NmM?=
 =?us-ascii?Q?jBcZP7viI3mw/N0JG6IIU+jQEsOugCiMt8Ds3ubyPVPaqbjzK8pnjXQKg5Et?=
 =?us-ascii?Q?F7v/LRW20ObO1ICo3iw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 17:58:33.9980
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18b30cd2-23f7-45ec-ccf0-08de2c4c4045
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8281

When hot-removing memory in a SEV-SNP environment, pages must be set to
shared state so they can be reused by the hypervisor. This also applies
when memory is intended to be hotplugged back in later, as those pages
will need to be re-accepted after crossing the trust boundary.

However, memory can already be set to shared state externally. In such
cases, the pvalidate rescind operation will not change the validated bit
in the RMP table, setting the carry flag and causing the guest to
terminate.

Since memory hotplug is arguably unique, introduce a guest-maintained
memory state tracking structure that maintains a bitmap to track the
state (private vs shared) of all hotplugged memory supplemented with a
flag to indicate intent. This allows for memory that is already marked
as shared in the hotplug bitmap to avoid performing the pvalidate
rescind operation. Additionally, tracking page state changes from the
guest's perspective, enables the detection of inconsistencies if the
hypervisor changes states unexpectedly. For example, if the guest bitmap
reports memory as private but the hypervisor has already changed the RMP
state to shared, the guest detects this inconsistency when attempting to
share the memory and terminate rather than skipping over the pvalidate
rescind operation.

Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
 arch/x86/coco/sev/core.c                 | 104 +++++++++++++++++++++--
 arch/x86/include/asm/sev.h               |  32 +++++++
 arch/x86/include/asm/unaccepted_memory.h |  13 +++
 drivers/firmware/efi/unaccepted_memory.c |   2 +-
 4 files changed, 143 insertions(+), 8 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 14ef5908fb27..a5c9615a6e0c 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -46,6 +46,8 @@
 #include <asm/cmdline.h>
 #include <asm/msr.h>
 
+struct snp_hotplug_memory *snp_hp_mem;
+
 /* AP INIT values as documented in the APM2  section "Processor Initialization State" */
 #define AP_INIT_CS_LIMIT		0xffff
 #define AP_INIT_DS_LIMIT		0xffff
@@ -453,9 +455,54 @@ static int vmgexit_psc(struct ghcb *ghcb, struct snp_psc_desc *desc)
 	return ret;
 }
 
+static bool snp_hotplug_state_shared(unsigned long vaddr)
+{
+	phys_addr_t paddr = __pa(vaddr);
+	u64 hotplug_bit;
+
+	if (!snp_is_hotplug_memory(paddr))
+		return false;
+
+	hotplug_bit = (paddr - snp_hp_mem->phys_base) / snp_hp_mem->unit_size;
+
+	return !test_bit(hotplug_bit, snp_hp_mem->bitmap);
+}
+
+static void snp_set_hotplug_bit(unsigned long vaddr, bool private)
+{
+	phys_addr_t paddr = __pa(vaddr);
+	u64 hotplug_bit;
+
+	if (!snp_is_hotplug_memory(paddr))
+		return;
+
+	hotplug_bit = (paddr - snp_hp_mem->phys_base) / snp_hp_mem->unit_size;
+	if (private)
+		set_bit(hotplug_bit, snp_hp_mem->bitmap);
+	else
+		clear_bit(hotplug_bit, snp_hp_mem->bitmap);
+}
+
+static void set_hotplug_pages_state(struct snp_psc_desc *desc)
+{
+	struct psc_entry *e;
+	unsigned long vaddr;
+	bool op;
+	int i;
+
+	for (i = 0; i <= desc->hdr.end_entry; i++) {
+		e = &desc->entries[i];
+		vaddr = (unsigned long)pfn_to_kaddr(e->gfn);
+		op = e->operation == SNP_PAGE_STATE_PRIVATE;
+
+		snp_set_hotplug_bit(vaddr, op);
+	}
+}
+
 static unsigned long __set_pages_state(struct snp_psc_desc *data, unsigned long vaddr,
-				       unsigned long vaddr_end, int op)
+				       unsigned long vaddr_end, int op, u8 psc_flags)
 {
+	unsigned long vaddr_base;
 	struct ghcb_state state;
 	bool use_large_entry;
 	struct psc_hdr *hdr;
@@ -465,6 +512,7 @@ static unsigned long __set_pages_state(struct snp_psc_desc *data, unsigned long
 	struct ghcb *ghcb;
 	int i;
 
+	vaddr_base = vaddr;
 	hdr = &data->hdr;
 	e = data->entries;
 
@@ -499,7 +547,8 @@ static unsigned long __set_pages_state(struct snp_psc_desc *data, unsigned long
 	}
 
 	/* Page validation must be rescinded before changing to shared */
-	if (op == SNP_PAGE_STATE_SHARED)
+	if (op == SNP_PAGE_STATE_SHARED &&
+	    !(snp_hotplug_state_shared(vaddr_base) && (psc_flags & SNP_PSC_SHARED_TO_SHARED)))
 		pvalidate_pages(data);
 
 	local_irq_save(flags);
@@ -522,10 +571,12 @@ static unsigned long __set_pages_state(struct snp_psc_desc *data, unsigned long
 	if (op == SNP_PAGE_STATE_PRIVATE)
 		pvalidate_pages(data);
 
+	set_hotplug_pages_state(data);
+
 	return vaddr;
 }
 
-static void set_pages_state(unsigned long vaddr, unsigned long npages, int op)
+static void set_pages_state(unsigned long vaddr, unsigned long npages, int op, u8 psc_flags)
 {
 	struct snp_psc_desc desc;
 	unsigned long vaddr_end;
@@ -538,7 +589,7 @@ static void set_pages_state(unsigned long vaddr, unsigned long npages, int op)
 	vaddr_end = vaddr + (npages << PAGE_SHIFT);
 
 	while (vaddr < vaddr_end)
-		vaddr = __set_pages_state(&desc, vaddr, vaddr_end, op);
+		vaddr = __set_pages_state(&desc, vaddr, vaddr_end, op, psc_flags);
 }
 
 void snp_set_memory_shared(unsigned long vaddr, unsigned long npages)
@@ -546,7 +597,7 @@ void snp_set_memory_shared(unsigned long vaddr, unsigned long npages)
 	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
 		return;
 
-	set_pages_state(vaddr, npages, SNP_PAGE_STATE_SHARED);
+	set_pages_state(vaddr, npages, SNP_PAGE_STATE_SHARED, 0);
 }
 
 void snp_set_memory_private(unsigned long vaddr, unsigned long npages)
@@ -554,7 +605,7 @@ void snp_set_memory_private(unsigned long vaddr, unsigned long npages)
 	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
 		return;
 
-	set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE);
+	set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE, 0);
 }
 
 void snp_accept_memory(phys_addr_t start, phys_addr_t end)
@@ -567,7 +618,46 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end)
 	vaddr = (unsigned long)__va(start);
 	npages = (end - start) >> PAGE_SHIFT;
 
-	set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE);
+	set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE, 0);
+}
+
+int snp_extend_hotplug_memory_state_bitmap(phys_addr_t start,
+					   unsigned long size,
+					   uint64_t unit_size)
+{
+	u64 hp_mem_size = DIV_ROUND_UP(size, unit_size * BITS_PER_BYTE);
+
+	if (snp_hp_mem) {
+		u64 old_size = snp_hp_mem->size;
+		unsigned long *bitmap;
+
+		bitmap = krealloc(snp_hp_mem->bitmap, hp_mem_size, GFP_KERNEL);
+		if (!bitmap)
+			return -ENOMEM;
+
+		memset(bitmap + old_size, 0, hp_mem_size - old_size);
+		snp_hp_mem->size = hp_mem_size;
+		snp_hp_mem->bitmap = bitmap;
+
+		return 0;
+	}
+
+	snp_hp_mem = kzalloc(sizeof(*snp_hp_mem), GFP_KERNEL);
+	if (!snp_hp_mem)
+		return -ENOMEM;
+
+	snp_hp_mem->bitmap = kzalloc(hp_mem_size, GFP_KERNEL);
+	if (!snp_hp_mem->bitmap) {
+		kfree(snp_hp_mem);
+		return -ENOMEM;
+	}
+
+	snp_hp_mem->phys_base = start;
+	snp_hp_mem->phys_end = start + hp_mem_size;
+	snp_hp_mem->size = hp_mem_size;
+	snp_hp_mem->unit_size = unit_size;
+
+	return 0;
 }
 
 static int vmgexit_ap_control(u64 event, struct sev_es_save_area *vmsa, u32 apic_id)
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 465b19fd1a2d..eb605892645c 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -464,6 +464,38 @@ static __always_inline void sev_es_nmi_complete(void)
 extern int __init sev_es_efi_map_ghcbs_cas(pgd_t *pgd);
 extern void sev_enable(struct boot_params *bp);
 
+#define SNP_PSC_SHARED_TO_SHARED	0x1
+
+struct snp_hotplug_memory {
+	u64 phys_base;
+	u64 phys_end;
+	u32 unit_size;
+	u64 size;
+	/* bitmap bit unset: shared, set: private */
+	unsigned long *bitmap;
+};
+
+extern struct snp_hotplug_memory *snp_hp_mem;
+
+#ifdef CONFIG_UNACCEPTED_MEMORY
+int snp_extend_hotplug_memory_state_bitmap(phys_addr_t start,
+					   unsigned long size,
+					   uint64_t unit_size);
+static inline bool snp_is_hotplug_memory(phys_addr_t paddr)
+{
+	return snp_hp_mem && paddr >= snp_hp_mem->phys_base && paddr < snp_hp_mem->phys_end;
+}
+#else /* !CONFIG_UNACCEPTED_MEMORY */
+static inline int snp_extend_hotplug_memory_state_bitmap(phys_addr_t start,
+							 unsigned long size,
+							 uint64_t unit_size)
+{
+	return 0;
+}
+
+static inline bool snp_is_hotplug_memory(phys_addr_t paddr) { return false; }
+#endif
+
 /*
  * RMPADJUST modifies the RMP permissions of a page of a lesser-
  * privileged (numerically higher) VMPL.
diff --git a/arch/x86/include/asm/unaccepted_memory.h b/arch/x86/include/asm/unaccepted_memory.h
index 5da80e68d718..abdf5472de9e 100644
--- a/arch/x86/include/asm/unaccepted_memory.h
+++ b/arch/x86/include/asm/unaccepted_memory.h
@@ -33,4 +33,17 @@ static inline unsigned long *efi_get_unaccepted_bitmap(void)
 		return NULL;
 	return __va(unaccepted->bitmap);
 }
+
+static inline int arch_set_unaccepted_mem_state(phys_addr_t start, unsigned long size)
+{
+	struct efi_unaccepted_memory *unaccepted = efi_get_unaccepted_table();
+
+	if (!unaccepted)
+		return -EIO;
+
+	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		return snp_extend_hotplug_memory_state_bitmap(start, size, unaccepted->unit_size);
+
+	return 0;
+}
 #endif
diff --git a/drivers/firmware/efi/unaccepted_memory.c b/drivers/firmware/efi/unaccepted_memory.c
index 8537812346e2..6796042a64aa 100644
--- a/drivers/firmware/efi/unaccepted_memory.c
+++ b/drivers/firmware/efi/unaccepted_memory.c
@@ -281,7 +281,7 @@ static int extend_unaccepted_bitmap(phys_addr_t mem_range_start,
 	unacc_tbl->bitmap = (unsigned long *)__pa(new_bitmap);
 	spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
 
-	return 0;
+	return arch_set_unaccepted_mem_state(mem_range_start, mem_range_size);
 }
 
 int accept_hotplug_memory(phys_addr_t mem_range_start, unsigned long mem_range_size)
-- 
2.51.1


