Return-Path: <linux-efi+bounces-5682-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 91540C865BC
	for <lists+linux-efi@lfdr.de>; Tue, 25 Nov 2025 18:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1DD234E95D8
	for <lists+linux-efi@lfdr.de>; Tue, 25 Nov 2025 17:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C16F32B987;
	Tue, 25 Nov 2025 17:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XDUTyH4N"
X-Original-To: linux-efi@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010025.outbound.protection.outlook.com [52.101.46.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6077815ECD7;
	Tue, 25 Nov 2025 17:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764093500; cv=fail; b=pGnRyctta8elPLeDqIjP7KUscICsV8+nlOsFLTk74zgfLVKO6CE7129Y7U37GqEnbXN5ARpL3nLkCiCJev3FFT1WlwKo5gOI5c5ARBHiE43odsjujKkJHmlD2FRP+AE3+bANA7VOguPj6DZwwmgw5sTph6o45QSkKzSQ134lMeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764093500; c=relaxed/simple;
	bh=3sYe/aSYJySjfxzAjh2Tv3XFtely/aK+YaQ6w3vEUDg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GvsNJuXRbq/Y1zrdFdGctnK1VpkiodZJlxBG1s5KDdP+TiFxtEyXGPpMb6ZIg3knnfpuzrP3qVj7dasPvNCerw/9LMPY+Iv6BVg94lwg/B3n4YfJh9hdyK7C/HZIO3B6DyBycW+zcjZcHniDH4dD17RfrLWyRJxYwKopbzTo6ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XDUTyH4N; arc=fail smtp.client-ip=52.101.46.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qteVE4AG9zovUtC3vgl6hkBcaNNHRO8ZF5s7kRw2py3ru4SAVZbIHxnTUkANve5BVFdcM/y0NKqGa5anhyfIu/YMopkZycrJmBKvTvH7vm7wvMZS0l5BbYgCkHdCZ5E5e8Xe+jG/HGPVN7R0XoVqjNAiz/5JBipxP5WYsL1tK0wABdgwpuHZuz1kQCMBYMoDe4WhTMs86yN0bilHqKEBwKKVGs/gPn9qU05H1EtcNDM+EgS734V8lUA57bYfTJ3mZE1vmsHr+YMJoIMeLQEPr2YYOrevzmGz/zmFcyrGAbWqfx8DwqIAEc44J0P0wLtRkBVthmPrtpe6dPrdMMJnRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3f8IHmRNMRcRDN2JmsN7U0H2Rx50NzMLzFyKm26pac=;
 b=o1WsYMHP9qrUPl3A37cizNG4BDtqdSXDPNQbiTcHzp3ThLv/HUz36IcSHifIAsMB/X6jRfY2HWj/iQvka4nvWiave/Q3s9tqj7cXsG1ZvpdJI9DU3/Foc+hHlxZp4MnioC5lF059Idc5vBCDBRFaQle5ihz0Moe+AcUTxlYEeAHACOb1CfFKQbiSLAEV0+1EtSPSDoctrb8dbVIQpj67Ja0I9KxxvlId9wo0GldIhcWO2P93aAl5HKc5xTS/zt6VIcSsrggZY5aHZ2imtiagFp54h0AZBcnue41MuADGPPTSDLEURROOne6hDeMsmo7Gb8RZiqR9OtxGY09je8bTOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kvack.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3f8IHmRNMRcRDN2JmsN7U0H2Rx50NzMLzFyKm26pac=;
 b=XDUTyH4NNDzZKfaUtBWEpFgBm2KES9qeU8x944vOqTbcjIQeVk/jH+AbdyOkWDb1j89NLsmnVWENHz9szK+Mw9Dsd/kk+G945/a6Cnul90ttW02PLZ8ieTtheQY1MIg/5jLZal2xKWePo2O015Q0KkVf2PlRzoX89rrzpIxc77Q=
Received: from PH7P223CA0013.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::13)
 by SN7PR12MB7854.namprd12.prod.outlook.com (2603:10b6:806:32b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 17:58:12 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:510:338:cafe::c4) by PH7P223CA0013.outlook.office365.com
 (2603:10b6:510:338::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.18 via Frontend Transport; Tue,
 25 Nov 2025 17:58:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 17:58:11 +0000
Received: from ellora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 25 Nov
 2025 11:58:10 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <linux-mm@kvack.org>, <linux-coco@lists.linux.dev>,
	<linux-efi@vger.kernel.org>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <kas@kernel.org>, <ardb@kernel.org>,
	<akpm@linux-foundation.org>, <david@redhat.com>, <osalvador@suse.de>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <prsampat@amd.com>
Subject: [RFC PATCH 1/4] efi/libstub: Decouple memory bitmap from the unaccepted table
Date: Tue, 25 Nov 2025 11:57:50 -0600
Message-ID: <20251125175753.1428857-2-prsampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|SN7PR12MB7854:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d64bdaa-f58d-487c-29aa-08de2c4c32f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FzQRAK6+eEUF4t2XsSgiduOM5KYNEnPjxWaoWd0xtWdCX6TDRg31BrYbx4zy?=
 =?us-ascii?Q?S0EIc09MLCOBqLV8dj6tVA2GGVchDQOSoQp/sNoEeMp9CNvp20UghiU81ylr?=
 =?us-ascii?Q?oEWY+sqlYSIk4FU/0jlKN/PvqGkLDrKwa6K0oFV07oO21LOk7/DrjPUrxzNv?=
 =?us-ascii?Q?ClIVuR0v2DcdfO2EmZZE5dbkE6nKVxf3FPJ1+sdpSz2za1oZNmby+ka+OW2D?=
 =?us-ascii?Q?WjPk4l1VJRXy/8YTGg92PZI292nf9fBDu41iVjELq+Vh1UumQDfaodb1V70f?=
 =?us-ascii?Q?6+tYceijVAPjettsE88ly3iywDjGTe7AWUQZpYzCxb7f3IkNgyFuKfkGOMoA?=
 =?us-ascii?Q?9YdazU3OyDv82kC2d7efHSSgRn4QXlyryVzaGM7NG6BagYuxBiir1hEXXixs?=
 =?us-ascii?Q?Af+CVYAFF9gylCQoOwjqQl2vgC3QCbS4S2xEKwW8pzbx2lGoJVBSP4nZi4sP?=
 =?us-ascii?Q?dQYWFQJXwBWaARsSu9jemDszn3ldemo4EdMtvfRpttXOZ6Md/n5te96zOh58?=
 =?us-ascii?Q?g6Sxo2RjbYgncNPO0PJKV7EoTiIrVqIprtFGO7SKKvcIT3lri8icquYD9GM7?=
 =?us-ascii?Q?dpnkWzwaGqSlnPOyNNxz9/0S0xIBj7rvPHvUEGtABjFU+/nTHj4PeacyS89R?=
 =?us-ascii?Q?VfUGuxsmgzJs/eddQYCWQzsWdcRarawwZGcPO21xjq7Bsxt+w2OhUbVFdgGR?=
 =?us-ascii?Q?Xj+ixP7Tu9abLUB6aPvXe0OQTEPtSk/ZM8KLaMU45VdXnddjtwQoXG2Rg1EE?=
 =?us-ascii?Q?KwkzREbPbB/QLt9kiLXZH3hZf8/w2BsPKvnJwXw+D1IHgCASv0koVdK9NKQq?=
 =?us-ascii?Q?cMOGaTEpB7fTtZClKkpIda9ULO6Kj1EmaAUeG5siEjOnU0rdaE4QGB04KzWT?=
 =?us-ascii?Q?O/PqGyHQzoN4p6NfmSY7e66amKSBXoIkFQmbikgEmFDnau1SKPr9YJIntoSu?=
 =?us-ascii?Q?Z4tItM71+/Bf3qlqloLHCAq1YeJiGsDxrYbaqarN501NYSyd6yt9HCfGL93V?=
 =?us-ascii?Q?k1cKeVQdRQADWv+Lbp2z1lj5b+pkUS57xD02USuQJB1t4PkJQ3w349bsiILo?=
 =?us-ascii?Q?bj4WUXhYuqzh15kN3JzhpHN6nFx2h8JNcxYuhdlYKy4hEQfDzONrkGs2Jfte?=
 =?us-ascii?Q?o6uzcN6BlExeUAE0VYFzuzBi5CssYTVXXCEyOPkJ7Dm0t7HONnFxh+8co1mn?=
 =?us-ascii?Q?WA37bPKqEHrL5wUkggT+hE46FWaNVuIToiI1OpXobTiiJJyuUxA/STC0ik0f?=
 =?us-ascii?Q?1Je8OtDx7u+wlX/qP6ybMBWAOja/E/PWtL9pL/7/+EkAlAFv/tIAnrsz7tvH?=
 =?us-ascii?Q?gIrpM3xW9TO0kG+x8sftXOK3YuDHHFpNthVT0hCxVJphnE3NoqqXbeLxM0UP?=
 =?us-ascii?Q?BtNFHoMkMI9WOAoKdTt7Bg3Pu4O0HaR9vq/X6y/69bOk59fiOwE3KNhPOLP0?=
 =?us-ascii?Q?ypOZNnTBfzoEfWn5snvRUZe2VNhTT+kE6hhnUXhdsesHohd8UkeLpdJt5Zev?=
 =?us-ascii?Q?cZ1Ai02C9sgD1CvC2XIZjCyozRx1oCgisTOJra9oKq9oPYUhCCaK/y+gBiXC?=
 =?us-ascii?Q?iwUAA8GF50nZomTNvdw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 17:58:11.6590
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d64bdaa-f58d-487c-29aa-08de2c4c32f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7854

Memory hotplug in secure environments requires the unaccepted memory
bitmap to grow as new memory is added. Currently, the bitmap is
implemented as a flexible array member at the end of struct
efi_unaccepted_memory, which is reserved by memblock at boot and cannot
be resized without reallocating the entire structure.

Replace the flexible array member with a pointer. This allows the bitmap
to be allocated and managed independently from the unaccepted memory
table, enabling dynamic growth to support memory hotplug.

Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
 arch/x86/boot/compressed/efi.h                |  2 +-
 arch/x86/include/asm/unaccepted_memory.h      |  9 +++++++++
 .../firmware/efi/libstub/unaccepted_memory.c  | 11 ++++++++++-
 drivers/firmware/efi/unaccepted_memory.c      | 19 ++++++++++++++-----
 include/linux/efi.h                           |  2 +-
 5 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/arch/x86/boot/compressed/efi.h b/arch/x86/boot/compressed/efi.h
index b22300970f97..4f7027f33def 100644
--- a/arch/x86/boot/compressed/efi.h
+++ b/arch/x86/boot/compressed/efi.h
@@ -102,7 +102,7 @@ struct efi_unaccepted_memory {
 	u32 unit_size;
 	u64 phys_base;
 	u64 size;
-	unsigned long bitmap[];
+	unsigned long *bitmap;
 };
 
 static inline int efi_guidcmp (efi_guid_t left, efi_guid_t right)
diff --git a/arch/x86/include/asm/unaccepted_memory.h b/arch/x86/include/asm/unaccepted_memory.h
index f5937e9866ac..5da80e68d718 100644
--- a/arch/x86/include/asm/unaccepted_memory.h
+++ b/arch/x86/include/asm/unaccepted_memory.h
@@ -24,4 +24,13 @@ static inline struct efi_unaccepted_memory *efi_get_unaccepted_table(void)
 		return NULL;
 	return __va(efi.unaccepted);
 }
+
+static inline unsigned long *efi_get_unaccepted_bitmap(void)
+{
+	struct efi_unaccepted_memory *unaccepted = efi_get_unaccepted_table();
+
+	if (!unaccepted)
+		return NULL;
+	return __va(unaccepted->bitmap);
+}
 #endif
diff --git a/drivers/firmware/efi/libstub/unaccepted_memory.c b/drivers/firmware/efi/libstub/unaccepted_memory.c
index 757dbe734a47..c1370fc14555 100644
--- a/drivers/firmware/efi/libstub/unaccepted_memory.c
+++ b/drivers/firmware/efi/libstub/unaccepted_memory.c
@@ -63,13 +63,22 @@ efi_status_t allocate_unaccepted_bitmap(__u32 nr_desc,
 				   EFI_UNACCEPTED_UNIT_SIZE * BITS_PER_BYTE);
 
 	status = efi_bs_call(allocate_pool, EFI_ACPI_RECLAIM_MEMORY,
-			     sizeof(*unaccepted_table) + bitmap_size,
+			     sizeof(*unaccepted_table),
 			     (void **)&unaccepted_table);
 	if (status != EFI_SUCCESS) {
 		efi_err("Failed to allocate unaccepted memory config table\n");
 		return status;
 	}
 
+	status = efi_bs_call(allocate_pool, EFI_ACPI_RECLAIM_MEMORY,
+			     bitmap_size,
+			     (void **)&unaccepted_table->bitmap);
+	if (status != EFI_SUCCESS) {
+		efi_bs_call(free_pool, unaccepted_table);
+		efi_err("Failed to allocate unaccepted memory bitmap\n");
+		return status;
+	}
+
 	unaccepted_table->version = 1;
 	unaccepted_table->unit_size = EFI_UNACCEPTED_UNIT_SIZE;
 	unaccepted_table->phys_base = unaccepted_start;
diff --git a/drivers/firmware/efi/unaccepted_memory.c b/drivers/firmware/efi/unaccepted_memory.c
index c2c067eff634..4479aad258f8 100644
--- a/drivers/firmware/efi/unaccepted_memory.c
+++ b/drivers/firmware/efi/unaccepted_memory.c
@@ -36,7 +36,7 @@ void accept_memory(phys_addr_t start, unsigned long size)
 	unsigned long range_start, range_end;
 	struct accept_range range, *entry;
 	phys_addr_t end = start + size;
-	unsigned long flags;
+	unsigned long flags, *bitmap;
 	u64 unit_size;
 
 	unaccepted = efi_get_unaccepted_table();
@@ -124,8 +124,12 @@ void accept_memory(phys_addr_t start, unsigned long size)
 	list_add(&range.list, &accepting_list);
 
 	range_start = range.start;
-	for_each_set_bitrange_from(range_start, range_end, unaccepted->bitmap,
-				   range.end) {
+
+	bitmap = efi_get_unaccepted_bitmap();
+	if (!bitmap)
+		return;
+
+	for_each_set_bitrange_from(range_start, range_end, bitmap, range.end) {
 		unsigned long phys_start, phys_end;
 		unsigned long len = range_end - range_start;
 
@@ -147,7 +151,7 @@ void accept_memory(phys_addr_t start, unsigned long size)
 		arch_accept_memory(phys_start, phys_end);
 
 		spin_lock(&unaccepted_memory_lock);
-		bitmap_clear(unaccepted->bitmap, range_start, len);
+		bitmap_clear(bitmap, range_start, len);
 	}
 
 	list_del(&range.list);
@@ -197,7 +201,12 @@ bool range_contains_unaccepted_memory(phys_addr_t start, unsigned long size)
 
 	spin_lock_irqsave(&unaccepted_memory_lock, flags);
 	while (start < end) {
-		if (test_bit(start / unit_size, unaccepted->bitmap)) {
+		unsigned long *bitmap = efi_get_unaccepted_bitmap();
+
+		if (!bitmap)
+			break;
+
+		if (test_bit(start / unit_size, bitmap)) {
 			ret = true;
 			break;
 		}
diff --git a/include/linux/efi.h b/include/linux/efi.h
index a98cc39e7aaa..a74b393c54d8 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -545,7 +545,7 @@ struct efi_unaccepted_memory {
 	u32 unit_size;
 	u64 phys_base;
 	u64 size;
-	unsigned long bitmap[];
+	unsigned long *bitmap;
 };
 
 /*
-- 
2.51.1


