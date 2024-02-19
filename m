Return-Path: <linux-efi+bounces-585-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA28285AD8E
	for <lists+linux-efi@lfdr.de>; Mon, 19 Feb 2024 22:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A83A91C22237
	for <lists+linux-efi@lfdr.de>; Mon, 19 Feb 2024 21:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B31553E03;
	Mon, 19 Feb 2024 21:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HwD0a/z7"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2078.outbound.protection.outlook.com [40.107.95.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F452E40C;
	Mon, 19 Feb 2024 21:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708377135; cv=fail; b=b55KAFZQnp9RjGhIh0AiL8YcAWm9l9IUZH/arMe6FS9nNHgLth+57WdKy7XxaI23XjX2XZagIILCHZzAiUGZObNYPf0nJdckcV/c7Aohkpt+A+opz0IV569aH2hJpcTlAdvWaQgLGSCqp6y8zRteDYJJMZTRvUX3UjYOd87H8xI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708377135; c=relaxed/simple;
	bh=eV9PVuyzpZ70I/pu9Z3stgOdL4n4O5Q3lijY/WMVqA0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HJR3MZ3DwKwvtuxfdBxCoMKLQuuYSsb1x7IzDkk/t21LZ7sQvu2M77+LZrH8ymycnDfYRaYA4Yh5MlglR3J59nbWuQkZMMSknb2u1/3D1g3XGIrjr0zPioVC5jFzE9/MBD+tdTNNymFfU8LHu11Xe3Pbgw02BZ0UNKQ64IIfD9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HwD0a/z7; arc=fail smtp.client-ip=40.107.95.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGXR/RFgHIwl55y2sSHxH5H7WZICoZh1sdRsVuZCjLIWvC5TUOu0VNz85wENCL1GUajwUXc0yXqUhloZUt28kzqRproM7Zt+g7P1dH7z9Z59Nidirm/EhMvoCuCyvwceI9ff+bydvQUKTKUdjxiW20WHlryIIy92DSrqT7Z1t2NTFlGncL+t/Y1hPKEcQeVJ2lShMugs19GFxRvvESBRp50u+BZSAM+feS+NuG5Upkx9YU/L3vc0GF6rT0eqQCBGPlBsLjfvKUz/0i/WCnO1HHF2zGOQ68nqXuDtzgjz6TsmJMqAq2YAJK9d7Wff8Gb+Jsqzll5uPVeSyWGD3obiEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6PG7rDVf4cEk4RqzZVKG6iYnAzchQ1zPvQVV5Q2L+4=;
 b=Qr8R4pxaY1LxSb5a7EGqFOd+up6aYX99Gn5p2sMZuuB4u+B4fkwc61Aa3+I70cnconaNf4LJya3yxyWeym8c2TNDaBrIudCfrfP7zmGoAhjVV2iRfH1f5Jpv/UfFLojPPvb4AvjtdhzDnjSF9TQ6CJYul6rKzHD/dM0hcMRazWSsWlq5ZzeTFglR8PQZEy+Su9iKSUu7AX1qGwrAa1TYHriA2fcb5T3T4dZEW6FddZbKn/CtOQ1XO/UzQ8BNXvSok7tDQialRjZxTmKMRLOcVmbr/q+QW1VaOyxU9ByS2fJkTdNn2PZG7F3TV/vfL/WLvBEY9dgqfpZYne5YZAZZ8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6PG7rDVf4cEk4RqzZVKG6iYnAzchQ1zPvQVV5Q2L+4=;
 b=HwD0a/z7KGyd6k8usNyKZg+PWsjCFcXWXXqPjvds5Lh2x/gz/cgQJd9MX4UofgfyuyZWN1gkDXrB4/DFPbmGnn9Q4OOjae9IB2wjz+UOfS/aKcuu6EbAqQuCDpR00qXGfMOWKvqtxDe4fu1Z8AfkaK+Vuoe+WkJV6WBO1hvk4CU=
Received: from BN6PR17CA0054.namprd17.prod.outlook.com (2603:10b6:405:75::43)
 by PH7PR12MB7233.namprd12.prod.outlook.com (2603:10b6:510:204::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.16; Mon, 19 Feb
 2024 21:12:09 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:405:75:cafe::d0) by BN6PR17CA0054.outlook.office365.com
 (2603:10b6:405:75::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39 via Frontend
 Transport; Mon, 19 Feb 2024 21:12:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Mon, 19 Feb 2024 21:12:09 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 19 Feb
 2024 15:12:08 -0600
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
Subject: [PATCH] efi/x86: skip efi_arch_mem_reserve() in case of kexec.
Date: Mon, 19 Feb 2024 21:11:58 +0000
Message-ID: <20240219211158.768523-1-Ashish.Kalra@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|PH7PR12MB7233:EE_
X-MS-Office365-Filtering-Correlation-Id: 9593f61e-3912-4aea-ae6e-08dc318f6f02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zv5+Wj+QPkgmwV77lGpy67xlucjkDzmfuaeb/L6kP1ZRU8RFIhev9Eg0Z0mFZlBUrxbGW2daC1Mn3+3yge4VNwhklL6DDyqL3isZ9HbryqoHGeLSJKr73Pq/pYjK4icHc8lZAe06un0fm+5hFkGQRW32HES0w/F50HAfRQ8YGnRDaQRJU+qkG8OOIXQYx6fDz3N3Ob5uL3UCbM66bQiU/z+D4Hnso/NrxmRi2IsPSh2LbMUbnALhN6gfuNlIocZsVm1lxavWWOojuYDqfl9SUGyHL2SCNCqfuBUFgMDm7ZYSS4QcIO2BeK94TlmR735zbVZvdEEblA2Al31sTLa9xSSqV7N0JzSw1VRxkTAFICBppC+TGMruB02Sel/o/cTCZUP6I8LHaf2LNvSNEmaWBL32VlYhMHw05x0cfJgSL07BMXcvrmWzqbSTBqTSW6PU3ff6LBAjT5ZQ2+LknyR6wKlKyi1NHc5PcrngL1c8i7l8BN9zCuGHPvIOtrxT6PyMpIC5hr5Hy87+d4wjxN2ZOP7TLa+PtRtzMPj/oUE1BkjatZ+eVqpTFM3/cBgqpgVWhZG29Gd9ZClKf/0H0O5vuy4sKyL30C/P2djd3+tiGdzu6JjNJ4WnMMPKFFnlDD68+bm1iDHqTY1tpTfvRU/JI4uxmi5HVPlP9K/TaxGPjfY=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(46966006)(40470700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 21:12:09.1830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9593f61e-3912-4aea-ae6e-08dc318f6f02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7233

From: Ashish Kalra <ashish.kalra@amd.com>

For kexec use case, need to use and stick to the EFI memmap passed
from the first kernel via boot-params/setup data, hence,
skip efi_arch_mem_reserve() during kexec.

Additionally during SNP guest kexec testing discovered that EFI memmap
is corrupted during chained kexec. kexec_enter_virtual_mode() during
late init will remap the efi_memmap physical pages allocated in
efi_arch_mem_reserve() via memboot & then subsequently cause random
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
+	 * the efi_memmap physical pages allocated here via memboot & then
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


