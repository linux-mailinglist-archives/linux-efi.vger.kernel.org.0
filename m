Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50542398B82
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jun 2021 16:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhFBOHJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Jun 2021 10:07:09 -0400
Received: from mail-dm6nam11on2061.outbound.protection.outlook.com ([40.107.223.61]:8225
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230246AbhFBOGo (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 2 Jun 2021 10:06:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZen08JSsWWRlqfIVZGKDq7+a2PzOy9TL2QGWkzdXkKNrwrYISiD23+1mWMMx5ptqD9DYyPHiVSXK3KlaZUxutEXql0M351Oq2lBUylKIh5ptKrkJ310B3pVXIGh8L3CUAfVLq8wkMVrMH/g2d43kPbGccgG9aMEwcDEdyJt6PHm/Z2w/SeTcqcjqNpHxd3XOVFTAvjpYiFUPy3SYZPbIQfCXpW/Itx6kKW5GLhWlYIHZV/fcq4JwcrlTU7rKG7RphTSo9PT4O4Xnwcvg5n7RwlEwFG81S0EcL6FAt4RvrkJ7pQGwmAJu3rJJtCoMEHrQ3ygPZgKCzD+vYljBWputA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Dv/UE/9EnoCsyQmOni1aMFaAFwOyUclfjA5UCmeWJY=;
 b=ioP/AmEpvXt4nfMc0M+huEaexjxxQaA9gU0Grg2zsRUDo2+WNJb42EzxgCPGGExoNJTyqiFqTwllOOLia9dqft3fth137t3Id7m3DastwExsnlhjfo/Q/+duT/u6SSWgduIK/beReFuKmhzOaVCwGxEU1068P+orS8AEkPo6+V7sKIbq+fNRJsWnmgp9yD+BBlFchf0KFpzDNYAnrrtB1O2mFQ5tKP66VcaaLpbqmxujSsiMWLO+sIbPqqtdz7zIS03vhYnNl3IEkzmTfA3OzgvmnU+SkJIt4SwYTRy1id7KS9ZvT27CSUid/lJrJOa5Z5XFk/NmduRAsh/u3mGOog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Dv/UE/9EnoCsyQmOni1aMFaAFwOyUclfjA5UCmeWJY=;
 b=Q1VsMS3ELu7XJyKXvcJ/Nm/qge3Fsv22ebX1aQ83oglzs6rXE/CJhCqRgLIgo6/kug5QmsLA7Z2kwr/A8Ovk5WkOysaSeWGXIvxsop79QHuimReCOowgA90COm8l0108aDPli6TE/i4nNoyWHhNgJYYG3ygXyUMChHxz0lNUQeQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4512.namprd12.prod.outlook.com (2603:10b6:806:71::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Wed, 2 Jun
 2021 14:04:47 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::9898:5b48:a062:db94]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::9898:5b48:a062:db94%6]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 14:04:47 +0000
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
        David Rientjes <rientjes@google.com>, tony.luck@intel.com,
        npmccallum@redhat.com, Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH Part1 RFC v3 06/22] x86/sev: check SEV-SNP features support
Date:   Wed,  2 Jun 2021 09:04:00 -0500
Message-Id: <20210602140416.23573-7-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210602140416.23573-1-brijesh.singh@amd.com>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN6PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:805:de::23) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR05CA0010.namprd05.prod.outlook.com (2603:10b6:805:de::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend Transport; Wed, 2 Jun 2021 14:04:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5fad1f3-8b88-40a0-4649-08d925cf6107
X-MS-TrafficTypeDiagnostic: SA0PR12MB4512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB45122ED0632F0FE2F996350CE53D9@SA0PR12MB4512.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x9RC81E2FWJYPiqI5EJ8mlqDj9TVj2+2pFs/NrOrMu8RM/vSCN6tPkvcQmoIS5eKEd3YyvDboqxtBmI6+RkzS4ht33KzoakFcY6bzMR2sBNXLwxoLtwIpisAH2qLtCx9uZlvcd8fqWe5GkuJb6VcNELWLK/WfpKnCv2lfNatpdaLHkwUp7NgYKv+KKPLZlPhsDQTnNrmYQ3azMSh+8N7BSa0MH/iRctoYEnVn0mG2u8+Ch8SBvUTvq+Kp6aUZIFo4zhtZcxeksT7zOYuUgy1tJOje6eb5EA+g5IM4xVvSL+Yy/yxC3gnT31NwLOTS4tdhz2byrD9XDpMJ2sVlJX+FvyA2z1xhXrGodmoaijq1d2gzzaQLf5UDwgreNECeXIBpZIhsBtAsccfVUP8y3qPs9R2KSrqeHxLqJsscLHiRcRXIRP9V4YX6QWflzCvB1IQgESRHWpXFLgZLcloroYRn89PHV8D4lEf3WwcpG6V61w23csy98+AxMMRn8glRXgTjOOD0jpTPznXA69FgPtIG1MrIyBZ7YbV0eEBj+e3rJIr53YF61+wLjUDPpErVc+R64+5iB5foxXkmMo1IGYQzzOjsLHVS7E/3VUz7vOnCRPQqOzoUEqV0+/2CtSTrXtRR5zSW/cgTPTldxAw+duRZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(6666004)(44832011)(7416002)(26005)(2906002)(8676002)(6486002)(7696005)(52116002)(38100700002)(478600001)(956004)(66556008)(186003)(1076003)(36756003)(8936002)(16526019)(66946007)(38350700002)(5660300002)(2616005)(54906003)(4326008)(86362001)(66476007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?gttkHpYwv3LamnvSJkRn++kNSiEmlWykz4ynA7LMqiAmshB/XRylIHdX/SXn?=
 =?us-ascii?Q?FB8FP386wDB8WobGBlx9N4unalQF0yQBKx227hkxpf3qrF06luBQ8Ug7YgKt?=
 =?us-ascii?Q?NB/BecBHzPW1bnI2U1v5ARmQth8Qxe7aZEluTH2WeMfqL+KYYIDjgJe24ZRQ?=
 =?us-ascii?Q?7Tg6kKYXjcrQNmX0JoKdz9gLUOQrVNqNZyX0FzSczkGbEHuTRwaCa6NpkULq?=
 =?us-ascii?Q?rUbdN+2cJ3spMSXQo94CLPoFCLafEFCLzzqve+MAg1lbqyOv44YbJveb3+Kq?=
 =?us-ascii?Q?AJ4wAOt5ltaTfz0lWY9H/7LiLYneHl5eUNqbpEpjWt7OxoU1qJ/9TsK2oA4z?=
 =?us-ascii?Q?1Eg1Xe4Txo1Za3piIRIDZaovsk65D3slFeqdigK267OdaXuuFI9eRyp8DMCx?=
 =?us-ascii?Q?IJDpAvVd4EAQ0kcPhYRC83lUyIFo+JGEZY+kJ9PVR5+Iic1nW9ZdO+vIlTQU?=
 =?us-ascii?Q?F7Bs2tSGjZ64L54bVEo5suSDJIr/A+RgQK+RgJlOIr0LxbeFlaE8Vk+IiXyw?=
 =?us-ascii?Q?SPEfoYFSgTAhHGivufu1zSwpw1Wpk9WnfJiMz911QUfYJb+4Va4p85lB5/c1?=
 =?us-ascii?Q?KgOlXuZmJuLubsJrnQlCzWs/k2LO/DW1tVrVw9B8wYEqGfLn0YmUVuDU5JpN?=
 =?us-ascii?Q?gL3uj1zMGgC60dENOK/jLkEzq5ahjZtcD/3UGD+/NKzXvBgRRaow4ccZAeLk?=
 =?us-ascii?Q?ZudImGgX/dRG64iXWCcqnnJ8KHfPOU2BXdf8iSL4wj6n2fppXHZmThx6kmeU?=
 =?us-ascii?Q?DGiMTGvetU+yGA/sONehxnrlEJRBBeLnP3jsP0CR+Zg1q5RFxO5Mz3JiD8QD?=
 =?us-ascii?Q?cRO1cmDyQLWSoPE2JjzJHaJav3zbKCutAwb9H47aNs5VqXPRg3GdoLkixloA?=
 =?us-ascii?Q?qEk3gBxeo7PiQQgIsCCvOvFybprZIzjHlXti8Cs3/r05CvH4A6bQpVDXs6mI?=
 =?us-ascii?Q?IAAN1FbDczcIX/MBF3qShyjj5VidpgrM44BhpreWdb1O1CMVtgb0Nz0J55vO?=
 =?us-ascii?Q?3triTz1W0mkx8zTFgVypslyKvByz2ONxxbcyuk606aJGbDjwNnr8SkF/9Rw5?=
 =?us-ascii?Q?0DZfDJstePWDChVXTj/5WvFuzYz28YPQq3B3WQR6qHhuqS3wMae1mPRsrB2p?=
 =?us-ascii?Q?PCvsqnF665JA40kfmncM5g7btYiJK10gzOqTqhfLj2DFRFdorOtTvqj4KP4h?=
 =?us-ascii?Q?Dzp7d/PqquZcfb7nNoYv/RwgXFMTd5r44c4Wr1bDxJwDbfuXKl1OpkCHR//Z?=
 =?us-ascii?Q?TMZmCJ0l3zJXXdVpC4IgWaqHTtNx144UufVg1uti+JyaIsTBR/xLccYvoqzp?=
 =?us-ascii?Q?8oVbCcMmuQrWOlTAKPeJtbab?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5fad1f3-8b88-40a0-4649-08d925cf6107
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 14:04:46.8079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EHMhDxZ817OxIEmkXsXUiImszUWxQ9943xzvZMEAeQebAk0BGyMA+4wgpIwKfaX/gDC0VPC9c+YaYREWoKZyeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4512
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Version 2 of the GHCB specification added the advertisement of features
that are supported by the hypervisor. If hypervisor supports the SEV-SNP
then it must set the SEV-SNP features bit to indicate that the base
SEV-SNP is supported.

Check the SEV-SNP feature while establishing the GHCB, if failed,
terminate the guest.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/sev.c    | 22 ++++++++++++++++++++++
 arch/x86/include/asm/sev-common.h |  3 +++
 arch/x86/kernel/sev-shared.c      | 11 +++++++++++
 arch/x86/kernel/sev.c             |  4 ++++
 4 files changed, 40 insertions(+)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 87621f4e4703..0745ea61d32e 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -25,6 +25,7 @@
 
 struct ghcb boot_ghcb_page __aligned(PAGE_SIZE);
 struct ghcb *boot_ghcb;
+static u64 msr_sev_status;
 
 /*
  * Copy a version of this function here - insn-eval.c can't be used in
@@ -119,11 +120,32 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
 /* Include code for early handlers */
 #include "../../kernel/sev-shared.c"
 
+static inline bool sev_snp_enabled(void)
+{
+	unsigned long low, high;
+
+	if (!msr_sev_status) {
+		asm volatile("rdmsr\n"
+			     : "=a" (low), "=d" (high)
+			     : "c" (MSR_AMD64_SEV));
+		msr_sev_status = (high << 32) | low;
+	}
+
+	return msr_sev_status & MSR_AMD64_SEV_SNP_ENABLED;
+}
+
 static bool early_setup_sev_es(void)
 {
 	if (!sev_es_negotiate_protocol())
 		sev_es_terminate(0, GHCB_SEV_ES_PROT_UNSUPPORTED);
 
+	/*
+	 * If SEV-SNP is enabled, then check if the hypervisor supports the SEV-SNP
+	 * features.
+	 */
+	if (sev_snp_enabled() && !sev_snp_check_hypervisor_features())
+		sev_es_terminate(0, GHCB_SEV_ES_SNP_UNSUPPORTED);
+
 	if (set_page_decrypted((unsigned long)&boot_ghcb_page))
 		return false;
 
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 981fff2257b9..3ebf00772f26 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -51,6 +51,8 @@
 #define GHCB_MSR_HV_FT_POS	12
 #define GHCB_MSR_HV_FT_MASK	GENMASK_ULL(51, 0)
 
+#define GHCB_HV_FT_SNP		BIT_ULL(0)
+
 #define GHCB_MSR_HV_FT_RESP_VAL(v)	\
 	(((unsigned long)((v) & GHCB_MSR_HV_FT_MASK) >> GHCB_MSR_HV_FT_POS))
 
@@ -65,6 +67,7 @@
 
 #define GHCB_SEV_ES_GEN_REQ		0
 #define GHCB_SEV_ES_PROT_UNSUPPORTED	1
+#define GHCB_SEV_ES_SNP_UNSUPPORTED	2
 
 #define GHCB_RESP_CODE(v)		((v) & GHCB_MSR_INFO_MASK)
 
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 94957c5bdb51..b8312ad66120 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -32,6 +32,17 @@ static bool __init sev_es_check_cpu_features(void)
 	return true;
 }
 
+static bool __init sev_snp_check_hypervisor_features(void)
+{
+	if (ghcb_version < 2)
+		return false;
+
+	if (!(hv_features & GHCB_HV_FT_SNP))
+		return false;
+
+	return true;
+}
+
 static void __noreturn sev_es_terminate(unsigned int set, unsigned int reason)
 {
 	u64 val = GHCB_MSR_TERM_REQ;
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 77a754365ba9..9b70b7332614 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -609,6 +609,10 @@ static bool __init sev_es_setup_ghcb(void)
 	if (!sev_es_negotiate_protocol())
 		return false;
 
+	/* If SNP is active, make sure that hypervisor supports the feature. */
+	if (sev_feature_enabled(SEV_SNP) && !sev_snp_check_hypervisor_features())
+		sev_es_terminate(0, GHCB_SEV_ES_SNP_UNSUPPORTED);
+
 	/*
 	 * Clear the boot_ghcb. The first exception comes in before the bss
 	 * section is cleared.
-- 
2.17.1

