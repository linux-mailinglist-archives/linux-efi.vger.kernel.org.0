Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B593BEE5B
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbhGGSU0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:20:26 -0400
Received: from mail-bn8nam12on2057.outbound.protection.outlook.com ([40.107.237.57]:41568
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232050AbhGGSTq (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:19:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQFg7N+9ZwB0qTppJgBUiGxPOQ15QA4i7y592w/LD1e2aOKAUoW1+jFro9nYO9crW1wJsjfLHrNQ9hCMxaRDozzCFHT5F+FgrzKLzGUyUgJpbz5ruif+EI0f9OwJ7/Id6p3667BbWBCDihgZuBo9AHj8C2sQa0I2skzsk8CAeVCMUe6TYZv6nQChnwQv1VC46/cA/YietEUn1WZI4uV5ILQLZj2eb3rPpVQ4Z+HwlZxIy95ab1k8b7MEHPDGq6bWW4mQKDRvzi6lEgT3uFeHL7BBTDUEiASbOj8HG7H9/UDBZRa70AeFgMU/ZGgR5OgzYnqyvV10I/X15wbP1l1NBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KiWbdxaVYo6yGflzsIqUHjYzBRDbDTO0jVJIW4bZPI8=;
 b=ZWGR+zKgjQ20vc6TJ753gQnnpGmm1hLeFhxx3UYl85GL+3SPjlokSivbOQ8D/7uQYV1+VXtE+HMUVX5k5lwevOO2epKW2KhETl6IptcL7KXC1phtUI9FVCu8FKtukR7bNnDqi2MTNS9fwtHkJeUwS+lLrlJovT4eO3tY69RqM04dA35jT3B8NJEalNS2mhVBQGU8IuU9Hdjke+MxBW6WHa3Q0cnD26LW9KVQEWcKBIk/eNwea5ZAJebWv32FWDC8tGSxcmpT2h81EzxzBOACXN/EhEoGKQoac3juyDS46gDXYwbW5ciuhoxfSMtYfN5eer8W3KRwP1FSgezbvAMgIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KiWbdxaVYo6yGflzsIqUHjYzBRDbDTO0jVJIW4bZPI8=;
 b=W/kyHlDG+VmeMGDw1FvPpYG9eoo7VO9LdCMyyUsi/oNBBsLpNA2UeoA/XiwT0nD+3NGUHyysx9aF8pBHq0eNUWaxVLmOE9UMFNgdXhlS7pIPCnmGrtw6OC4tND4vkf0ZyPWoM0WvQm7gWQ8pvSwB2g8qNvkvhtiDjqInqHipV3k=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB5016.namprd12.prod.outlook.com (2603:10b6:a03:1c5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Wed, 7 Jul
 2021 18:16:25 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:16:25 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH Part1 RFC v4 22/36] x86/sev: move MSR-based VMGEXITs for CPUID to helper
Date:   Wed,  7 Jul 2021 13:14:52 -0500
Message-Id: <20210707181506.30489-23-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707181506.30489-1-brijesh.singh@amd.com>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0104.namprd11.prod.outlook.com
 (2603:10b6:806:d1::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA0PR11CA0104.namprd11.prod.outlook.com (2603:10b6:806:d1::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Wed, 7 Jul 2021 18:16:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc8400c7-ca67-40fe-f7ee-08d9417354b5
X-MS-TrafficTypeDiagnostic: BY5PR12MB5016:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB5016B1D28E97AE7FCEA093D9E51A9@BY5PR12MB5016.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V9Q+H6YTvJ+WpgOBZPtX79QGQK3/XVl0ZQqcuZgSpQEZ6LM7xii3rNadK/hFiQvPpH1srUUWBcKxKmKRSPw4a3IpItnnbeosA6ktgdtSaXPP7lujQybetZGVC69doNFRvmuTHYwvMUUWSO7VThs+Zta3ardi8j6Xz1YtCSaPZ2cIxN6j1atDpe9UFObOEaQGyrTJER702aegqGHw2q21Iazqt958EegM8+f9BBdmOJp6WPjxKX5p/iA424B3Q7Y4obL2kSxVxKgNMCxCT+rlU2h+ljX/Yf+pCshJPW/0JkCrW29HunPog00vyCtjTE4dW2bHRgWqc8pVZj9QOzCPJcH/8uwSHtfgACeXnpXTR/9xCQJ/ld5rDdNdDvYSwQsH3hA4lFhkz5dnRKHPevbgm9a3nGadLgRDuc0gEI3PPuopYGkeQHW5uqzbvJvLQVx/bMyJOQsC2B47R9jGBZQcAUxs6LefY3llvoQYdUs4i+3lkKdBR0QM6UlB8N81xGLnc9fbfFpB0vwG3Qzo5siGlyKZ2bEtd4ItS0a1WIzC1q9N4sOuKXjLn7CHXnMxTa9olfp3nlvXvx3toubeyEfXZW1yc/aZIzoSaF/PfIWsMf1UeEWALAGA+vQ+S31FwuMHSiKcHW7+OQ/Sr+GJ4Z8m4vAnjL5TB/dfPc3DFAfWGIgwCS1pHsMmx4ljn2OtcAOPIeJSv60n1YCpgU+KxzVh+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(66556008)(66476007)(186003)(7416002)(52116002)(86362001)(26005)(956004)(8936002)(478600001)(7406005)(7696005)(8676002)(83380400001)(5660300002)(2616005)(38350700002)(38100700002)(44832011)(2906002)(1076003)(54906003)(6666004)(66946007)(316002)(4326008)(36756003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kdVRYWQb2kgKLOp+05vvYeZjwySuZnoMe0jkRTMuFJEI1RfqJciWbTa18UAZ?=
 =?us-ascii?Q?Yx8xbWiLHtEcdO+QwZ/HKbooGAZ4qWE465kE4tvXNfmKgnq2APGw9A7DGyc1?=
 =?us-ascii?Q?PyBTeXfLiqN3JMu8BMKVBDYF/4kgKlNCOiG86yxkdMOM/eoB63mY8cNue6MK?=
 =?us-ascii?Q?eMs0D/imH7YthmzOyWSTenvezVfFbAma5lk4EmFIiJTojCx6kV5yPEvKZGrF?=
 =?us-ascii?Q?AaLDm1FdpUP8acITzuHXRnu8BuNuoeeiVnlFboAWKa+S957SvVjhrJ6iC1v8?=
 =?us-ascii?Q?WZQ8nMTab+BHSgMINeAW8ZUT5LI9BxaSP2mJG3i3YRT6hxX3+iM90SNvxe/2?=
 =?us-ascii?Q?+aiSzzxOl+cm7LM0yj8vCMZPW92iFk2+RjUAT+9rZE1XE+gA/lSOJLn5mRgX?=
 =?us-ascii?Q?bFVlkN+enKHQbT1KVe+3/JWYz+nibdNgxI46KzfFZx3YdFlxn+gUgCHDQBbF?=
 =?us-ascii?Q?vUl/9TYTGgwT0+7cFsnfHImuKoudn3IWc3g4QE2B5nYEa/kSh598sPuJw0KG?=
 =?us-ascii?Q?RHmy0aHJeLCVw2AQU27O0sbj4V1QrKVwAB3cRpEJ5MU8qN++1Os3Ed60i5b+?=
 =?us-ascii?Q?JeP5xCyChlYD7XN/Sj1Him1KRjZcg7rLlBLPoyBDXcWUFyjqR8Ub53tijGfp?=
 =?us-ascii?Q?00qCXZV915xVB3N1nmeXcJqpWL7DVB1NRudzxHSTqi96y0L4MOHSXT2+ssdW?=
 =?us-ascii?Q?OoVBlreK6jqcVbr4Brwu8aYuGLl2Klt7cU8h7N9M3ClT9HwkXxzxpVSGWOK1?=
 =?us-ascii?Q?v70sgYXR27/Z785gmtEMf5ScK5a8U838fWqJBxI0AYwU5bXjnZtY/Q49guZi?=
 =?us-ascii?Q?HGGuWMkSjTwFteRDld8sr5l0mmJmE4FqxP+W5QULt9k2GvGfOi7ECYPV/1So?=
 =?us-ascii?Q?lWZ/A25fZscdet8Ryx3E8nwJzO+vyT9cWHXbSs/Ve3HLnTOw40eW4jAnTDIX?=
 =?us-ascii?Q?amzOQPzusgYU6EzNXDn2tOqd1D6fzYIAMHm7gBwGfCi1Zhpnb+ZhVRTtYTor?=
 =?us-ascii?Q?tTeIfSFctI8Vfv3/+WbYNwUlxiWrjhElKZfyxPtsUFxRcN39YGorITJ+TRSo?=
 =?us-ascii?Q?QedMlfVUKcTCpD1wK0jS3aDYFmY+DXUkwgehxTDzDTfZLl/Fu80SYrYcV56U?=
 =?us-ascii?Q?WKin0un040BBSZ7niT+HKHvFhBLPv1QF+fMcnZCgIxf8xvYCIAdQO9ga0fZl?=
 =?us-ascii?Q?9R0JCFCpvZsZYaTBmDLHJycYaKDKQYauo5d4cDoAWsHgoK8smmvf9Z48dbDC?=
 =?us-ascii?Q?FYtSP+dj7BfIb96fSYEQa7uE649hyLGKrUThCXCXuHeADlpCpdkmKCOsnSaD?=
 =?us-ascii?Q?RqppGZjqq2xC0Bz0VZ/NPlc3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc8400c7-ca67-40fe-f7ee-08d9417354b5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:16:24.9910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VCJOLzf93tOWxj+RW70W3mYWlEN6uqe81sZERIHN5ewF8e+HyEmUPbU3sAzmSNveJWA9mcnUOQ3iul9e1lbBeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5016
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

This code will also be used later for SEV-SNP-validated CPUID code in
some cases, so move it to a common helper.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/kernel/sev-shared.c | 84 +++++++++++++++++++++++++-----------
 1 file changed, 58 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index be4025f14b4f..4884de256a49 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -184,6 +184,58 @@ static enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
 	return ret;
 }
 
+static int sev_es_cpuid_msr_proto(u32 func, u32 subfunc, u32 *eax, u32 *ebx,
+				  u32 *ecx, u32 *edx)
+{
+	u64 val;
+
+	if (eax) {
+		sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(func, GHCB_CPUID_REQ_EAX));
+		VMGEXIT();
+		val = sev_es_rd_ghcb_msr();
+
+		if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
+			return -EIO;
+
+		*eax = (val >> 32);
+	}
+
+	if (ebx) {
+		sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(func, GHCB_CPUID_REQ_EBX));
+		VMGEXIT();
+		val = sev_es_rd_ghcb_msr();
+
+		if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
+			return -EIO;
+
+		*ebx = (val >> 32);
+	}
+
+	if (ecx) {
+		sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(func, GHCB_CPUID_REQ_ECX));
+		VMGEXIT();
+		val = sev_es_rd_ghcb_msr();
+
+		if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
+			return -EIO;
+
+		*ecx = (val >> 32);
+	}
+
+	if (edx) {
+		sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(func, GHCB_CPUID_REQ_EDX));
+		VMGEXIT();
+		val = sev_es_rd_ghcb_msr();
+
+		if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
+			return -EIO;
+
+		*edx = (val >> 32);
+	}
+
+	return 0;
+}
+
 /*
  * Boot VC Handler - This is the first VC handler during boot, there is no GHCB
  * page yet, so it only supports the MSR based communication with the
@@ -192,39 +244,19 @@ static enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
 void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 {
 	unsigned int fn = lower_bits(regs->ax, 32);
-	unsigned long val;
+	u32 eax, ebx, ecx, edx;
 
 	/* Only CPUID is supported via MSR protocol */
 	if (exit_code != SVM_EXIT_CPUID)
 		goto fail;
 
-	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_EAX));
-	VMGEXIT();
-	val = sev_es_rd_ghcb_msr();
-	if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
+	if (sev_es_cpuid_msr_proto(fn, 0, &eax, &ebx, &ecx, &edx))
 		goto fail;
-	regs->ax = val >> 32;
 
-	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_EBX));
-	VMGEXIT();
-	val = sev_es_rd_ghcb_msr();
-	if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
-		goto fail;
-	regs->bx = val >> 32;
-
-	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_ECX));
-	VMGEXIT();
-	val = sev_es_rd_ghcb_msr();
-	if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
-		goto fail;
-	regs->cx = val >> 32;
-
-	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_EDX));
-	VMGEXIT();
-	val = sev_es_rd_ghcb_msr();
-	if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
-		goto fail;
-	regs->dx = val >> 32;
+	regs->ax = eax;
+	regs->bx = ebx;
+	regs->cx = ecx;
+	regs->dx = edx;
 
 	/*
 	 * This is a VC handler and the #VC is only raised when SEV-ES is
-- 
2.17.1

