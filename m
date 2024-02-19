Return-Path: <linux-efi+bounces-586-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7C185AF3D
	for <lists+linux-efi@lfdr.de>; Mon, 19 Feb 2024 23:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C650E2832AF
	for <lists+linux-efi@lfdr.de>; Mon, 19 Feb 2024 22:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8387B535D1;
	Mon, 19 Feb 2024 22:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iBW7/Aw8"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08B3524DD;
	Mon, 19 Feb 2024 22:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708383309; cv=fail; b=R25g77pzYKI7P37kjwqA8ZT4xAO/OYqMUKXQCmtVRPI96PPnrte5mWDPudC5cx+Ty2K6ztOKOxuYSDtzpIaO71sKwWHqd5zw+BxHdgLBAI6ielAFtlmajAjZhoDR431KRe5FgKASrdbChKvDOn40q6RzyQsQ35tMpHCKmjdsoFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708383309; c=relaxed/simple;
	bh=fdFOi0KVLm8DagGC6DvnAsKS7OqaZ3wZ4kte/OHjmyM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pvoKklJg4y6vJ433vs/cm6+ayjSKvodb7r+J+PKPB8797/amMWa503MdZK21ZuuDC/EZ2nrfjrUjwiFt2HA2NrUYN0nTd1F1Vq0zQtkqoUx0HQh6m1RfPcbPP41xnl8kpuflqFUGJ2gEGJM9pcCMJIv1UwNJHl/pUThBVTJTRWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iBW7/Aw8; arc=fail smtp.client-ip=40.107.220.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njBr592sd/Jcgjy33+k114RxaCm97CHUXBzAJdGWlaom2T2MxQbNFpR5IQO9S+UTVHAWAxyQxNtGg7rEcZgcSoHjvvaSFLFBCwFUh51I9G09K97zo9rpKVsjTaAZKtiAl81PrpBNELrcUQkK8igult9xKNuualXzqkkrtPyX6u8r3SgUnK1SztneIIhv/GHhaAcmNcZ70Coxabm4eubpVTtIIpSj5rsxLsCHtm2jNkrJO+IbTx5AyAASHz/aOWAOP362T90DcdanXg82xgCJveJoAVw/Qf4ru64KZ5VyTOMyLQD1RJjaiUp8UBbFWsWwgW9rOJD2Aoz69mp4nf0tPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7krmcbrX6fJrYRXKqedy70aof1EtOi279EOdlJzQ08U=;
 b=mTfLfeVlWkBqU/ZR6peIWVVm6B5l4AilM7M+cmdK5qpnWXX0gX8QDRku634y0RSHzLDU9zv8xop5orIel/xTqihUg7nb7MFWoK7dnGNfJKFEJvIZo7X7vwzD/dkaQ+Lzd9Jsqs62CRaGvjhzd+f9NTQUh+mLAVVfQfQo71WHOpmkPdf3fjj1/QBBZz/jnS3+iMG5gkDlorLADRPotApmewJs5wPPP1H0IRh/MrTthCAIpQ+NzKquDR/vUofvQMGwULChpR646AZ5AFhLQWq3aiAH9uHQ0/b/8+5DWCVx0TWzccht/nC7JQVLiHYMWdHfGOj5k2PwqEp6FR8Ql50ZXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7krmcbrX6fJrYRXKqedy70aof1EtOi279EOdlJzQ08U=;
 b=iBW7/Aw8MgiS0twKl1mcK8FtlfaUq+jJFm9PXs36ffyJGms19YP7Ibrd6MckOOPf2bT8t2Kjn3d8ra0oXIMvEjMUWFqa+5yQMEJTUoU7hmooOuUCuVc0AJzLzv2FH1ysQBG706eWQiI+Fw2NHrBgrhnvFuP66K2cSB22uV1mXXw=
Received: from BN0PR03CA0045.namprd03.prod.outlook.com (2603:10b6:408:e7::20)
 by PH0PR12MB8149.namprd12.prod.outlook.com (2603:10b6:510:297::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Mon, 19 Feb
 2024 22:55:03 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:e7:cafe::2c) by BN0PR03CA0045.outlook.office365.com
 (2603:10b6:408:e7::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38 via Frontend
 Transport; Mon, 19 Feb 2024 22:55:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7339.0 via Frontend Transport; Mon, 19 Feb 2024 22:55:02 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 19 Feb
 2024 16:55:00 -0600
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>
CC: <ardb@kernel.org>, <hpa@zytor.com>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <rafael@kernel.org>, <peterz@infradead.org>,
	<adrian.hunter@intel.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<elena.reshetova@intel.com>, <jun.nakajima@intel.com>,
	<rick.p.edgecombe@intel.com>, <thomas.lendacky@amd.com>, <seanjc@google.com>,
	<kai.huang@intel.com>, <bhe@redhat.com>, <kexec@lists.infradead.org>,
	<linux-coco@lists.linux.dev>, <kirill.shutemov@linux.intel.com>,
	<anisinha@redhat.com>, <michael.roth@amd.com>, <bdas@redhat.com>,
	<vkuznets@redhat.com>
Subject: [PATCH v2] efi/x86: skip efi_arch_mem_reserve() in case of kexec.
Date: Mon, 19 Feb 2024 22:54:51 +0000
Message-ID: <20240219225451.787816-1-Ashish.Kalra@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|PH0PR12MB8149:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bc7059e-eb5a-427c-37f7-08dc319dceab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	irKuAdDcW6m7ves3rSRgiQxmzr/l0WJQlVeWt/BJ4cex4vB9Pbno1v6fbKwTeVqNw2etE866KLgpcf46mHBkyWHQOrnRD1s/ABJXCMCR9kZ7mp/G/P5pQKQR5rNRFbOeVivsWMbydZ3JTBqw11ypP0W+p6VioELHC6H2OKcK8sFsnWefKQhmRsN31SuaNJU7ypPPfK4HL3KXqhxaiVUJVxtx9ZXiQJMxBMWj6X3TJKku7UykX00ZpdrHyemT5751O0vph0P3l5Pbb/ueBHmVF2XzpN7/g6Bvio5q3mgJ3rZGkSkO544oSBsRlSp8HfftQqw/5XqgrLwBbgRiRJw04b75YAyHnDhRwqXGt8BjSZ70zzsjxANNZ9UiZQ+MEs/peYLWUWP+zKzxNlicfd2AEQCmYLBwof6wSLradVwhoUOafLXMSHBW+2PEHCrw4alTZSZNa9BxVFMs3v31D9Idq6Aw1zTLQ7voXpKU1/96c6AHy7XgFlIXt+zvKdWFYqtoAade+4YemjTB4GuUr6jb1YF3+7gylDfZ3tkOo8dXOOw1LmVlZrKDnf7QoiYsQD/hsFrtk7jEfoVgVFeEVBKhM4mfSZxfsYnjs6Esid/GNEWfpHwr90bsPT8ZkRZPEuY2U1RKI4FpqHRyflJP56GTd+exer649teTLFbsHaxGvJE=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(40470700004)(46966006);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 22:55:02.6252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc7059e-eb5a-427c-37f7-08dc319dceab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8149

From: Ashish Kalra <ashish.kalra@amd.com>

For kexec use case, need to use and stick to the EFI memmap passed
from the first kernel via boot-params/setup data, hence,
skip efi_arch_mem_reserve() during kexec.

Additionally during SNP guest kexec testing discovered that EFI memmap
is corrupted during chained kexec. kexec_enter_virtual_mode() during
late init will remap the efi_memmap physical pages allocated in
efi_arch_mem_reserve() via memblock & then subsequently cause random
EFI memmap corruption once memblock is freed/teared-down.

Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/platform/efi/quirks.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index f0cc00032751..d4562d074371 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -258,6 +258,16 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
 	int num_entries;
 	void *new;
 
+	/*
+	 * For kexec use case, need to use the EFI memmap passed from the first
+	 * kernel via boot-params/setup data and need to skip this.
+	 * Additionally kexec_enter_virtual_mode() during late init will remap
+	 * the efi_memmap physical pages allocated here via memblock & then
+	 * subsequently cause random EFI memmap corruption once memblock is freed.
+	 */
+	if (efi_setup)
+		return;
+
 	if (efi_mem_desc_lookup(addr, &md) ||
 	    md.type != EFI_BOOT_SERVICES_DATA) {
 		pr_err("Failed to lookup EFI memory descriptor for %pa\n", &addr);
-- 
2.34.1


