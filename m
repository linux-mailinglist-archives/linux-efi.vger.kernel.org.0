Return-Path: <linux-efi+bounces-1576-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AEC95C265
	for <lists+linux-efi@lfdr.de>; Fri, 23 Aug 2024 02:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B62A1283881
	for <lists+linux-efi@lfdr.de>; Fri, 23 Aug 2024 00:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181AFB653;
	Fri, 23 Aug 2024 00:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SMkJDJA0"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B1A1643A;
	Fri, 23 Aug 2024 00:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724372686; cv=fail; b=BEvt6sogY9B4Hjm5UzIJNJrFJmXWD1ReKqMAKGhvJopr/SAas/IYOM1iwgpg7egDHpiU7wFKG/zSNlIaG4oqBXAEYMuTu7u/ySbbg0w0oGF6OOhuuTITQ4VidSOfV02KZ+ZfqK4AoEsvszT8jZoJy9iknwtvXPYDG3ezH92AAoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724372686; c=relaxed/simple;
	bh=Z9j6cJYdPVGxGzFxXTDq82r8yjeeZHf15nsJwULvnVg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W2vKkoB9MYCIgimgo3gHMDxt7W4rmrHreI5K+y/Ac8cVBI48u9xfdezC3GXDueEU2uDMf6DVFY85gfAL73jXN2e8DTIRbRGjg2vKOAdWnuTnSRZTo5Y9YKJ5UQLMCeY0Vg1Idh14sLFbJj1RvsYqniRtmL23DJ6ThqSY75Lbsgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SMkJDJA0; arc=fail smtp.client-ip=40.107.220.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f1juQ/DBcjTFZRhcTRKvjiwM+W+7+lvaAiAvnkWwEIC5NolxctrAOOl4rtQpMRWb09ZS/Zs6P+5gbhEDZj7OguAHqnhEEsCLaA46Q9hNJj5pD4p87gulBQi5Wm7QDqry2kjqxbgSOnnKBTy1Z46gQCv2i/NjUKfqDAg2orw3Mf7fYWXZJwcWJjhGR24hiCjFBtZR8ptaStOjPQbgWXlrxoLYVcnpysRXRI0wpXFx6R5plNC0e61IocF1Uma1F1LTf494DblhQkbTZwUAt/HwDc3mZZWKSoo5k8d2eha4eWFDczTW1NmpIAridWMQ67IEmhsYgrRnPi2m67flUVFihQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RK03vw/gx5D+32F9ADyDnRXGyHBMr5ScWahcR0aI9kE=;
 b=s6uON2hFgCp3+L//HOR1xKdxO0GO+ieHd7jmr1+EJHZQKNQ3toylGcyB7IACCZp7k2Z8XRBVSKGhkhDhOK66S1S3ezw23YAMVsQuZHFLpDM8xR0PdibzKnoXH+3QvlmJrrk/02FXd1n78DryOqeg65/TKx7kQNHE7u7o+gDb9Oa14HCLRo00M5Z6xPVIUQ/vAlTwgarUikkUCihV9yiOBNpkliJlwW8xVjn+FpJ1ppcg8Xgt13Jpz6iecwRwPspuHcTLkDe39ciww6IbV5wRfuLPJIAAhrN3vfw+Qg67yLj+mCMHFZ/xcGPz09r9trlBcenHRzpZ1vsmRkcpt8+8tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RK03vw/gx5D+32F9ADyDnRXGyHBMr5ScWahcR0aI9kE=;
 b=SMkJDJA05UZ95XrEr5tpoKL903k6AdGavB1uIKWuy8Bhi+h7LICWZU75aAmecz54+MlPCDfeqqJ7Z91GuXyPCl5LORhQijCtO7MXmTakZ2dI5GuHHmSUOLNGJJp7f9cd+cb4mwL47r6jFmoyoqxSENoPcPuj+vQd2rEF+MozITA=
Received: from CH0PR03CA0306.namprd03.prod.outlook.com (2603:10b6:610:118::35)
 by PH8PR12MB6986.namprd12.prod.outlook.com (2603:10b6:510:1bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.26; Fri, 23 Aug
 2024 00:24:40 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::21) by CH0PR03CA0306.outlook.office365.com
 (2603:10b6:610:118::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Fri, 23 Aug 2024 00:24:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Fri, 23 Aug 2024 00:24:39 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 19:24:36 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-efi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <ardb@kernel.org>, <bp@alien8.de>,
	<james.morse@arm.com>, <tony.luck@intel.com>,
	<ilpo.jarvinen@linux.intel.com>, <ira.weiny@intel.com>,
	<yazen.ghannam@amd.com>, <avadnaik@amd.com>
Subject: [PATCH] efi/cper: Print correctable AER information
Date: Thu, 22 Aug 2024 19:24:22 -0500
Message-ID: <20240823002422.3056599-1-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|PH8PR12MB6986:EE_
X-MS-Office365-Filtering-Correlation-Id: b968506c-b10a-4413-f050-08dcc309f9eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oMJuqOhn19SuPZA6ZVvUkPyfLghwwIi3TpdVYtWRULnlWzb7qXX5p9sd+2Z7?=
 =?us-ascii?Q?nCmclnyTWtiYky55TnpXOLiiJ2qQt7uO9VGgyEPCg5NWI9ispfhD2FeDq5f3?=
 =?us-ascii?Q?o0atSqJKA6cOUiNaOzcOV13gXOiA0nDhsbJPSWVgiODm69i0041gJJhO31M7?=
 =?us-ascii?Q?8ltcWpF9Akg56ZZRA/sqPMvaSFQ2vAxUZbMb7tUD3ApfCF7KurayvmSv+BVS?=
 =?us-ascii?Q?h8JRzlGxFPDLRvBUTg1nWRW9SXqcv9niu1GBSyO0mtK4YYFAGdvWtE/zKCHr?=
 =?us-ascii?Q?6fcQR8YbdeyUeYEMDyiqM53/Mtw2vJQsLnMahlf1xTPn85ZPuyxgMOJC4tn3?=
 =?us-ascii?Q?Qy6RlCvHF63D2XcG6rBp2VT7o17PdvO4+5URl5R6NM9G30yVmPNaPx39xOLf?=
 =?us-ascii?Q?EmrDKsLUgAXUs+kmgmNT+WHTsIHucHFXuhRDE0tXAqrVSnSU8OLOrQlKVdT6?=
 =?us-ascii?Q?JJweXgLsBK0MfxMx97Tm1MXdeXX366UEC6k2jrEosIlRFHyZAEfnGi9QUJCd?=
 =?us-ascii?Q?54FwwM63OzPKpDvQcJ3yvi3pgi18FDMDlh9LCo+69DVLN5y3GOG8wdjRKDFe?=
 =?us-ascii?Q?F9Ge1x2s4H8IBYN8nALd5O9PMneWtTbHNnmTgUR8qjShnvhSUvbcUAM5PT7p?=
 =?us-ascii?Q?ntSUMZU5Mo98oo3ekMqJAuEOhmYIgajmDhnCi85a7NAjoJlxq+KfJcovvAQq?=
 =?us-ascii?Q?uqJuF8jiIr2NnyI1/zza39Lx8Ig6MQCNWEKz2ZyZknNZRD1FX2XtSDGS127m?=
 =?us-ascii?Q?t5blX8YzEpxRkAvy/mFcnXHOX1fJER2VBh/2qVcMEwxlC8TJ5okvzvQEogvH?=
 =?us-ascii?Q?XCa4EZTJzvLUGRHzQ7kGeuFb+3LFjQ1FIvXxElaFK1cLW4h1hhfgiY383KiZ?=
 =?us-ascii?Q?chjOxKu0OjlwHPRu9Q7Slgop5qFuqpFFnvEcXtFtUfHRpDdRtThoDiewm6a/?=
 =?us-ascii?Q?kBvE1qqu0ZXxOWSxrhULrdLC8U0RkDr+Xfm8C5OO1ThtXrsQ/eiMRsDdObfU?=
 =?us-ascii?Q?sPp527Mr0jUHMeQBC5J9RumHy/yhOf3ITiTeAkxd6T//x+7hNxE3fJpCFcoO?=
 =?us-ascii?Q?MpEUrtknANQriHC8//SXBsDEnv7MfXaXhFlotSqfwDQxKoTTIWQFsEMi6WCu?=
 =?us-ascii?Q?d31f9xqg9jogGfBmfBWDn9w4gT4aIicwsnRPkx5xkJorzeclshHDSRV4Mf4w?=
 =?us-ascii?Q?Xd51bnePnE/O4hOPH9Zuv063MR45/Jb0/9zYooMMQgW7WWJ5u3icwPlqoHI3?=
 =?us-ascii?Q?kMva/xnNqfKTq4EzO4pgY3HuPPHM2bKUkDxFBuEslqQX0Daunw8IyFMNkLca?=
 =?us-ascii?Q?L79eF+ufIQADCvugh0gbFopTsYojJGOMUyDpvuUelBil9icAVNKR5YqJPDIv?=
 =?us-ascii?Q?/2Sa8EXtkOi2pOQoOmVHqAUFpWND1XB/vkro9VTBUsRArF+qAcFVQE2swoJ1?=
 =?us-ascii?Q?R+SDcENi7JKcqU56raElaQJvVRHwuIOp?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 00:24:39.4097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b968506c-b10a-4413-f050-08dcc309f9eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6986

From: Yazen Ghannam <yazen.ghannam@amd.com>

Currently, cper_print_pcie() only logs Uncorrectable Error Status, Mask
and Severity registers along with the TLP header.

If a correctable error is received immediately preceding or following an
Uncorrectable Fatal Error, its information is lost since Correctable
Error Status and Mask registers are not logged.

As such, to avoid skipping any possible error information, Correctable
Error Status and Mask registers should also be logged.

Additionally, ensure that AER information is also available through
cper_print_pcie() for Correctable and Uncorrectable Non-Fatal Errors.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Tested-by: Avadhut Naik <avadhut.naik@amd.com>
Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
---
 drivers/firmware/efi/cper.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 7d2cdd9e2227..b69e68ef3f02 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -434,12 +434,17 @@ static void cper_print_pcie(const char *pfx, const struct cper_sec_pcie *pcie,
 	"%s""bridge: secondary_status: 0x%04x, control: 0x%04x\n",
 	pfx, pcie->bridge.secondary_status, pcie->bridge.control);
 
-	/* Fatal errors call __ghes_panic() before AER handler prints this */
-	if ((pcie->validation_bits & CPER_PCIE_VALID_AER_INFO) &&
-	    (gdata->error_severity & CPER_SEV_FATAL)) {
+	/*
+	 * Print all valid AER info. Record may be from BERT (boot-time) or GHES (run-time).
+	 *
+	 * Fatal errors call __ghes_panic() before AER handler prints this.
+	 */
+	if (pcie->validation_bits & CPER_PCIE_VALID_AER_INFO) {
 		struct aer_capability_regs *aer;
 
 		aer = (struct aer_capability_regs *)pcie->aer_info;
+		printk("%saer_cor_status: 0x%08x, aer_cor_mask: 0x%08x\n",
+		       pfx, aer->cor_status, aer->cor_mask);
 		printk("%saer_uncor_status: 0x%08x, aer_uncor_mask: 0x%08x\n",
 		       pfx, aer->uncor_status, aer->uncor_mask);
 		printk("%saer_uncor_severity: 0x%08x\n",

base-commit: fdf969bbceb389f5a7c69e226daf2cb724ea66ba
-- 
2.34.1


