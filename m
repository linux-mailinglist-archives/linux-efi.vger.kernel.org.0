Return-Path: <linux-efi+bounces-4266-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA29AFF7ED
	for <lists+linux-efi@lfdr.de>; Thu, 10 Jul 2025 06:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF86C3AEE1B
	for <lists+linux-efi@lfdr.de>; Thu, 10 Jul 2025 04:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9011F8747;
	Thu, 10 Jul 2025 04:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g+Pp/Y93"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D40D2F3E;
	Thu, 10 Jul 2025 04:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752121318; cv=fail; b=kJhIuZ9Dd9c0PtMsENeMs+tBiJ7NRXXZ2KKTArMTYg17qG+b6KcZVRtIU1/oxFVToUS6U6Y5R7H1PCBnWPOxix4u9v4RCbZNHQne6cpYrxEAcx0YRbMksA4W1hfpmLkZ80EoGf7TVj+wY6klZK2y+OnVBLbsz3Wcwp01q0Xdqak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752121318; c=relaxed/simple;
	bh=u+4l2sTHHEGBEhxu0d6LFTqi5BF1oMpiVhNAR4J8eJk=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A4CawgJA8fXjEZM3vLymgE3cRy+TvmFXEVnfNEGX/00JbtqAQ/ewZkH7pt/3NoSzSMcIXbKtipsln8XD35fxP9iMsHTs7p/dnnEDFcpWYsNHgH0y1o1a1kkB8jjXEcd8SHX8bmveQw6+UcUku1LEFaswZ5N32ybuNT0CTs2wT2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g+Pp/Y93; arc=fail smtp.client-ip=40.107.92.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kc6T+PQ6ViqX6Ia5cFGdThGGhT7UYeWuciJchkfmMFnQhkMRpuBpstcZyeCjd6xnh57dNGDDLpJwyd9rLHovYl3nJLbDLChh1buR72BXcaMhPDlIdztQmtm+Y4/BI7ybJjaSZisbdAT8yDZcEZD0ClMs7D/wkq+GJTek0mZy4pc2nKPqHlGF1FoEvnSmGpu3KOQKynq+lOFWY5ODXl9wDH8b8pLe8BlEybFlmIc/aEEnEg7FqntQeJi/s+W6dfYLKjoIqceizQJtf4vpM8Ni6LDSJUqfXwOz0PExBHfKGirFu7TWdH2dx+Z3CQ3dmEp90YgvJyv2yC4HPex5TtHBQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qNLKxGuHzE98a+y2KtwxM1Du+CSeOsOIZ+CqYPaYVJw=;
 b=QFXFejwGh81XdEGwUXFd5LsCZpXxwrvPnesTovzgNUMvKUsFfnkX6NlD2UxXdMxgEJ7VoU9Vx4sQpZRq+fN25MUFwQv4FQ7362yTmOa36QEwdXgRuziqsdeKxmz1AvslPxFb2XSnjtA19X9fpBW1kmKtZzQ7KXzdt3XSFhcUpJoKYTYNrbOSixcAWXSo24e+/Zv726vDX+XdU+ZrKkrqXKd+rtoX6SBkpFNdpRlSlQbl1THRaXeeQ/l25QNF6riU+45Yk4LTxcmVhVZ9p3zSNNzrAAItPAnINgb5YYERqDKgenGebHSQg7pczXIK6DtscO5F4meJOQggSddpUu6k3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qNLKxGuHzE98a+y2KtwxM1Du+CSeOsOIZ+CqYPaYVJw=;
 b=g+Pp/Y93IFbd7+cV5lSFfQNB7Rd8W61jFEJSDssZMkzd+9AGvLgf0J5yas7AlK7nD9JM2i2Flp+kZrhwOzV3BerCmM1+SGZUQ0jOQwlv8pO09E0FhVgJMuC8tUIqtPZ2tBps3pIEGr8Fy2Q33GsH29kE8yeei0msRx+3q5NGVKA=
Received: from BN7PR06CA0072.namprd06.prod.outlook.com (2603:10b6:408:34::49)
 by PH7PR12MB6977.namprd12.prod.outlook.com (2603:10b6:510:1b7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Thu, 10 Jul
 2025 04:21:50 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:408:34:cafe::2d) by BN7PR06CA0072.outlook.office365.com
 (2603:10b6:408:34::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Thu,
 10 Jul 2025 04:21:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 04:21:49 +0000
Received: from BLR-L1-NDADHANI (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Jul
 2025 23:21:45 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: Ard Biesheuvel <ardb+git@google.com>, <linux-kernel@vger.kernel.org>
CC: <linux-efi@vger.kernel.org>, <x86@kernel.org>, Ard Biesheuvel
	<ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar
	<mingo@kernel.org>, Dionna Amalie Glaze <dionnaglaze@google.com>, "Kevin
 Loughlin" <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 12/24] x86/sev: Unify SEV-SNP hypervisor feature check
In-Reply-To: <20250709080840.2233208-38-ardb+git@google.com>
References: <20250709080840.2233208-26-ardb+git@google.com>
 <20250709080840.2233208-38-ardb+git@google.com>
Date: Thu, 10 Jul 2025 04:21:36 +0000
Message-ID: <85qzyovfov.fsf@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|PH7PR12MB6977:EE_
X-MS-Office365-Filtering-Correlation-Id: 10b26f11-fac9-4b01-4b79-08ddbf694a31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ILfupFLmxmA2mwanwDbps+wYAjNEtDvq/ce8lZgGJdR7QcKQjfQF6dL9UDpw?=
 =?us-ascii?Q?6c3Rdjy6/eBlWWWanjaxf15mMjfMjiAZLttzOISqLARyI3NDW4kOiCNnlNCW?=
 =?us-ascii?Q?ZtgWU9wJTNRv+WDqTMdgVYcU7FloiEs0mEhD9ngvlu6uzKtw4moo9dK8PBNN?=
 =?us-ascii?Q?qmKyET6mGzcqHVm4DfpgXCXAHZ2GFnTwH1wqoNMPWX7FixR8fPKTD1gk922x?=
 =?us-ascii?Q?Gv+maalttvuqSCkkOhgoSO1+XSbWouzlh7L9naQQnrSb0gu+YMcycHBAusfe?=
 =?us-ascii?Q?qeHw8MbIn+Toh8LzQcrTCBDr2h3mhCpFsuE0vHwhYkpBgo53Bwl34iJ9fPEe?=
 =?us-ascii?Q?HlFbp6hdgnzPLQQ/VUxjLbhJyKIn5KivjHPRbALJa39JRDBJI+DEPZVtXhYq?=
 =?us-ascii?Q?0F5WKVXwRoZxIypy2c7vIJARpl5k7RylG7E+KC++9ClYYNtd7oua0/Ps5Z4e?=
 =?us-ascii?Q?tT3g0jKmF2kprdK/hAHpE6GEbUrvXmUhMAIKcYxWA4a7VyBbnc4oXFtbFES8?=
 =?us-ascii?Q?y4UymMPV6YJEScarMYzFqpx/M3/ykBu4YtblsMlbHt7c0zaURhIN3J+Qo31T?=
 =?us-ascii?Q?/DHbAkS6RG9qBHf0zemQKAnVEZ6hp6lrPAvOCPAhdwFUKvdE57Rpk9e5XdRM?=
 =?us-ascii?Q?J+kXZLKEn+PtMk6Qvg2UqUBMkW60wqFLDSikYUWdQIkfwoo2xan1cZOQQpQG?=
 =?us-ascii?Q?mpnVppsbddeoZc6n43KMus3pTJy6efttTHrzAPDuBf3I4EAgNVfHgqWPzdwo?=
 =?us-ascii?Q?QbmYuAU3F7d3s4MySMFaxB5XFgUV/4BZcicGel7Y3vXGyBUcDv+EIuMCrcsb?=
 =?us-ascii?Q?EBCrKAksuAeE6LXOjtWEOXftSLW2vxhdfyskiBZdOMew3ymgydN6zmsPkpVF?=
 =?us-ascii?Q?lIQM4bC7qfs5PcFgvtEfJPNeAKlZHdrJLufjoeeMd29ZfwGYn6adVqmx7Yfn?=
 =?us-ascii?Q?pvdaPUfGCJpiJb5iLJYy9hWcZANuLrmPpGpvvvrED8bvSIkpjChwLU/ZInKd?=
 =?us-ascii?Q?wHcx/yh8a2HNL26cLcJ5gUebbdbuPMJmwdPVgHy5vLcUrNVd80ijD9666jgf?=
 =?us-ascii?Q?VHV08ZLa2dV1ePoUonshWCOCfRX7cTGDyB9AjMKVZsnJFakWTKiz2QF/uVIQ?=
 =?us-ascii?Q?fn/BYJGBNo7FnRRfbIfWdrydHy/xNw0eh0V0eF33UH0MYfJsmINpFbMSCxPc?=
 =?us-ascii?Q?I1bIZUvCz1/bcB6c2EUOhk2bC2zR0hSM1nwWNBQPW0m1yY81Wq0pBawdk3CO?=
 =?us-ascii?Q?uBcW/qEHdJ/bKAOFLSk9Rsyasc7EfKaFBNj399+Jp665hslV7HRnfN2+KIE9?=
 =?us-ascii?Q?FOHM4nsOPKtBoRVCDQHilXy6Fjpc3R754iSb+4klUj6k/fvR31vSd/ghPLVG?=
 =?us-ascii?Q?IASR/aY7MiD31v/qYD2DgFuOth1VBOUPBVMQuAn2gETFCTlcmizsbGiczoL5?=
 =?us-ascii?Q?5YzHYBdBmUY3cqdfLwYJO7a2XO5dJK7L+yDRZXPWS7l8niRZ6U88zl5biWEK?=
 =?us-ascii?Q?C/drYqAkUDSIIvcazdMBXER8VREQLd032Zn2?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 04:21:49.3246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b26f11-fac9-4b01-4b79-08ddbf694a31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6977

Ard Biesheuvel <ardb+git@google.com> writes:

> From: Ard Biesheuvel <ardb@kernel.org>

...

> So move the HV feature check into a helper function and call that
> instead. For the core kernel, move the check to an earlier boot stage,
> right after the point where it is established that the guest is
> executing in SEV-SNP mode.

This change is causing the SNP guest to fail ...

>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---

>  arch/x86/boot/startup/sme.c         |  2 ++
>  arch/x86/coco/sev/core.c            | 11 -------

> diff --git a/arch/x86/boot/startup/sme.c b/arch/x86/boot/startup/sme.c
> index 70ea1748c0a7..529090e20d2a 100644
> --- a/arch/x86/boot/startup/sme.c
> +++ b/arch/x86/boot/startup/sme.c
> @@ -533,6 +533,8 @@ void __head sme_enable(struct boot_params *bp)
>  	if (snp_en ^ !!(msr & MSR_AMD64_SEV_SNP_ENABLED))
>  		snp_abort();
>  
> +	sev_hv_features = snp_check _hv_features();
> +

...
snp_check_hv_features()
 -> get_hv_features() fails as ghcb_version is not yet initalized

ghcb_version is initialized as part of sev_es_negotiate_protocol(),
atleast this function needs to be called before get_hv_features() is
called.

>  	/* Check if memory encryption is enabled */
>  	if (feature_mask == AMD_SME_BIT) {
>  		if (!(bp->hdr.xloadflags & XLF_MEM_ENCRYPTION))
> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index 4fe0928bc0ad..f73dea313f55 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -1344,17 +1344,6 @@ void __init sev_es_init_vc_handling(void)
>  	if (!sev_es_check_cpu_features())
>  		panic("SEV-ES CPU Features missing");
>  
> -	/*
> -	 * SNP is supported in v2 of the GHCB spec which mandates support for HV
> -	 * features.
> -	 */
> -	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
> -		sev_hv_features = get_hv_features();
> -
> -		if (!(sev_hv_features & GHCB_HV_FT_SNP))
> -			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
> -	}
> -

With the below change, SNP-guest boots fine. I will wait for Tom's
confirmation if this is enough.

diff --git a/arch/x86/boot/startup/exports.h b/arch/x86/boot/startup/exports.h
index 01d2363dc445..dc7ca6f14cfe 100644
--- a/arch/x86/boot/startup/exports.h
+++ b/arch/x86/boot/startup/exports.h
@@ -12,3 +12,4 @@ PROVIDE(snp_cpuid			= __pi_snp_cpuid);
 PROVIDE(snp_cpuid_get_table		= __pi_snp_cpuid_get_table);
 PROVIDE(svsm_issue_call			= __pi_svsm_issue_call);
 PROVIDE(svsm_process_result_codes	= __pi_svsm_process_result_codes);
+PROVIDE(sev_es_negotiate_protocol      = __pi_sev_es_negotiate_protocol);
diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
index ce11bab57d4f..ff6f3372cbb4 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -740,3 +740,24 @@ static bool __init svsm_setup_ca(const struct cc_blob_sev_info *cc_info,
 
 	return true;
 }
+
+bool sev_es_negotiate_protocol(void)
+{
+        u64 val;
+
+        /* Do the GHCB protocol version negotiation */
+        sev_es_wr_ghcb_msr(GHCB_MSR_SEV_INFO_REQ);
+        VMGEXIT();
+        val = sev_es_rd_ghcb_msr();
+
+        if (GHCB_MSR_INFO(val) != GHCB_MSR_SEV_INFO_RESP)
+                return false;
+
+        if (GHCB_MSR_PROTO_MAX(val) < GHCB_PROTOCOL_MIN ||
+            GHCB_MSR_PROTO_MIN(val) > GHCB_PROTOCOL_MAX)
+                return false;
+
+        ghcb_version = min_t(size_t, GHCB_MSR_PROTO_MAX(val), GHCB_PROTOCOL_MAX);
+
+        return true;
+}
diff --git a/arch/x86/boot/startup/sme.c b/arch/x86/boot/startup/sme.c
index c3eff6d5102c..a7f8ee64e211 100644
--- a/arch/x86/boot/startup/sme.c
+++ b/arch/x86/boot/startup/sme.c
@@ -533,6 +533,9 @@ void __init sme_enable(struct boot_params *bp)
 	if (snp_en ^ !!(msr & MSR_AMD64_SEV_SNP_ENABLED))
 		snp_abort();
 
+	if (!sev_es_negotiate_protocol())
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
+
 	sev_hv_features = snp_check_hv_features();
 
 	/* Check if memory encryption is enabled */
diff --git a/arch/x86/coco/sev/vc-shared.c b/arch/x86/coco/sev/vc-shared.c
index 3d44474f46e7..af2d0fae2e18 100644
--- a/arch/x86/coco/sev/vc-shared.c
+++ b/arch/x86/coco/sev/vc-shared.c
@@ -622,24 +622,3 @@ bool __init sev_es_check_cpu_features(void)
 
 	return true;
 }
-
-bool sev_es_negotiate_protocol(void)
-{
-	u64 val;
-
-	/* Do the GHCB protocol version negotiation */
-	sev_es_wr_ghcb_msr(GHCB_MSR_SEV_INFO_REQ);
-	VMGEXIT();
-	val = sev_es_rd_ghcb_msr();
-
-	if (GHCB_MSR_INFO(val) != GHCB_MSR_SEV_INFO_RESP)
-		return false;
-
-	if (GHCB_MSR_PROTO_MAX(val) < GHCB_PROTOCOL_MIN ||
-	    GHCB_MSR_PROTO_MIN(val) > GHCB_PROTOCOL_MAX)
-		return false;
-
-	ghcb_version = min_t(size_t, GHCB_MSR_PROTO_MAX(val), GHCB_PROTOCOL_MAX);
-
-	return true;
-}

Regards
Nikunj

