Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFE93F2EEE
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 17:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241207AbhHTPWQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Aug 2021 11:22:16 -0400
Received: from mail-co1nam11on2068.outbound.protection.outlook.com ([40.107.220.68]:8352
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241051AbhHTPWB (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 20 Aug 2021 11:22:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lw0QuETTi7muWGYExd+iPlM/F/QLyFvJ9tPEej7V6QANuORp/dLndF43dUTGjNxXsUnqIqmOx89w8WBQp3O4VbeyraPlZYHgHePKs4DsvHCy0iqMQob3G2kpS8XlFhJMfa1RlGLui3vtdefZaum2QcO+PAqx8pXnFJxVL0oL4qhkAX0E3ewXMBWrCCxf8F3EXsBCVXIsWy0EAkUwvF7t0ZQvdGYTFw6OJ7UZcPQ9EAsrXpxFWQEw8E2QPc+q3a3k9XBVmifJbjldscfvhDFrnUYe7NVbL/MaBmbW7SQ3nWKRtK5w+FquzOGQs65SxLrkd8WYG5r+zMM0am/taTEfew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FsRMvjxPaUVVcDiIEqM0oaos47OgL7woSC2GHnQLHvI=;
 b=FS24xzCffSwKuOJ05AIHSzVzmLji7B8ZHAmaXaJc6zZ1V56+xaAGhqIEzKIBsLWUaygzeihmAXryyvR/K14ahUu+sNA7mnhdA9oUyM6WBNexAIOW9bhqGLYfxY1CLunDapLOtyFS30TAdppNfJ3Co0C0xEE/hONBN8fIio5aphw01woM43Y/W7lDdwWKxBLC0Ax3rJVP2tZk3FrJFACdq2mlo3+R8vuu3pvfm8GYbbnuFRsEOZBDxuSnIOE/4L96iEyf+cCm/tsIvhfTS3dlced7Ku8qkXawmOXXzLoTkIHAXfnBiy15sy1PZX3XpG4H0xedSu7Nx+Di96vvRFbq3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FsRMvjxPaUVVcDiIEqM0oaos47OgL7woSC2GHnQLHvI=;
 b=oZjCAy5QgDAjV1lJ0xxEEj3ltB12lpmHMfZIFQR+2RcXkFoTFzkgjAy09y3awvpDbDAfqtRKLBRyRuvhqu0jEo1p/hUtJiGUxdQng11rRSWlf4C5rdvdXMnFZG4g/NDYMpJt+kTmQa2fqshsyqEioOGTFOdty9vmORHO9ZRoKHA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2719.namprd12.prod.outlook.com (2603:10b6:805:6c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 15:20:57 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 15:20:57 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org
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
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH Part1 v5 08/38] x86/sev: Check SEV-SNP features support
Date:   Fri, 20 Aug 2021 10:19:03 -0500
Message-Id: <20210820151933.22401-9-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210820151933.22401-1-brijesh.singh@amd.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::7) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 15:20:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a16af6bb-d37c-4187-bd52-08d963ee1c16
X-MS-TrafficTypeDiagnostic: SN6PR12MB2719:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB27198E10F4E20CEEB9B878A9E5C19@SN6PR12MB2719.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DSy29NKo3awkn7vipbPF26aMG9wiK+x114oMcXXOG59fXEcexiw2Ye1tGfsgCGR4Y5/RF+lzUK2khbKiGQ4GmtKvHGIOBWl4RSgNQz92zpxVItOhgDXtUC0U69Grp7EN4AxXck57zy6RbtKExlm8Pmg9DhwVUxqYGmQ2SpCW6HNQvMAc70TLA97aLuxJL291qJVBNumEF2ZhtgxMtq31Y3LaMoCRk/ZmZFcb/J5UYhiayGcqEDD4MJoCqhEHkcx+2CGoCa+WtUteELE+tHsMzqFZ5xlb93+/NRrqr7GffIGzPMew9rkUcMU/ZrZ6Ayx7cPrRh6Lc9VWUOsmVofFdIkez67cbX0LwH5Rq5p9NyczNrMBzXSPhkO8Lbc3pGd80QkwkmGJyZjVKwfmQsH8ohc5sxkhC/xadmmertCgn5wcRUvS2Xh8/6Ea0//giM7w67uzB/squuA0yYQh+ayuy7OUiROGOTumiTSA7ZcxeJZ99Vgz2SNXGu5k2PYhPo0yxJSvTNEOTasgXDEAhQugMsivBwo2/jhBM8Gn8jrDGlgAQcdpDLe3C423owjKjqx+Bxztdh+HiVNPlsqT8HaUUXDcFh4+1vvnGMtZ6SQ0yfia7Po6sDWxDdB4MgLnM772PRMaB78WmFvGNOTawAd33vVkDKctuWmzVaOEwsqkfa0F5218X1GWcc0qMGLrKlKIheJ4xyBiG/LDsgf6X1V5ZXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(956004)(38100700002)(38350700002)(8936002)(52116002)(6486002)(478600001)(8676002)(44832011)(2616005)(66476007)(7416002)(66556008)(7406005)(2906002)(83380400001)(66946007)(5660300002)(54906003)(316002)(86362001)(6666004)(26005)(4326008)(186003)(7696005)(36756003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3TvKcBF3G9xIpeLO4PqvxQFe6dnDFUoLpNpPxPrzcw+SBNQShp80YVylFnSc?=
 =?us-ascii?Q?TB1bOK3l0RGM66LNxWbCVeGzqbWUBzD74J3OD0WAlAOiDJ5XcHfkY9AS0Lb+?=
 =?us-ascii?Q?NwS/ma6CdjQj16rtXXd1Vw24uqHqVxAYMN5Q3Eb8aY2Kin8Yi87K4beJd1r2?=
 =?us-ascii?Q?hOxSaHMZh9Gh5f4NagzS7ZTNv3zTkYIHRdY6Qloe3s/LKYYxwA+UigXAUbae?=
 =?us-ascii?Q?cJAcezO4P/rIXJJDv1dD811x7VabxQdRDDeEdeqspVPk5ybkb3frnfPuyu1t?=
 =?us-ascii?Q?NgxbRD7I4hvR4rq6p4xK38QbCV+dL/aEZXjcizn7TMyVEyd8vyScEmNyrNzH?=
 =?us-ascii?Q?ztiJ7uKsVZ1xs4eTgUR67XrA19wU7GKgJ0XRWxo2I0Vc277Mwc+9Z8Gf2GU2?=
 =?us-ascii?Q?KoQXUmA0c2qHXKHA8J1irUv2r5ATuB4ksukc1yiRi1HRU4Tt/x2a/2i5wAE4?=
 =?us-ascii?Q?s8TmV78Us0yz7yRIJN4w/WyObb15fJ96epqLNTVCe7Pt+q1m1AQYgyScwqeD?=
 =?us-ascii?Q?nb4RLfzBpV1vmMwq3FhtM8dTKFlr9nEzYUPoCKj1QF+9Gm9K68I5AtVUYolG?=
 =?us-ascii?Q?edIrTfKtOH4cphZaWGwaQVXz235RMLPjMbiZ6OEsOYJpXxrkL7lGSlOaom9K?=
 =?us-ascii?Q?KPtP1Z8kN4Rjg82BPh7JWpqM3/drlODRn2dpekjPRGcEMR/hO9CyYr3GtzPH?=
 =?us-ascii?Q?ftHM18XEjhr3vz2Gkix+CSnXoDNBmaaAnm8tr2zCUblTovu1vRb/wXtQZ1ff?=
 =?us-ascii?Q?XjlBQpbCSh4LeC92Czrf+B93hYv2nMpaJSVh2JNUkWoVFqO8++N7lqXlfvGT?=
 =?us-ascii?Q?i3JHTo0OXF2ILBqSJzUTLF5DWs63IdtmWXsQMPher3SC/Jh5NmVuaTf39Ia2?=
 =?us-ascii?Q?XpvyZogXAtqXbzIw2jpMjj/cHTp+hSCOB1OP6SRayP4iRZomxUoAvqpbhITS?=
 =?us-ascii?Q?XDyqBddXdjZy+/rwVm0v21Hrqg5i/D6Rk6edNYrn2FxPRz+Fr+Ho7LKcvk6k?=
 =?us-ascii?Q?WmNw3hxSOh/GcaH1/nRoPws2906bxF9UvtWrzCEFnWiwBTlhz6jCUdhp5llN?=
 =?us-ascii?Q?wiy6Pe8KztT/8QMdyd0JXHCRVjltHWfODXEnNBblS+LOmPNaXryKflzQf676?=
 =?us-ascii?Q?aXDpDeqskjQRvAxjVr4eLsqjvJtVaui+sDeYWYQEMqwqOlv2ngsdt0WBEMuW?=
 =?us-ascii?Q?8R1f/5JUITn7fXeaUr9wdy1qW5rhbJxkGr5Yoy0Pkr+MGt/agBKLO6xnbyzY?=
 =?us-ascii?Q?tTsZO30DsNmXL4AVs6HdLw6x259FwuxgRI3i3mkv6XXnKa1qXrvs5MGuTr2/?=
 =?us-ascii?Q?kcthaXxf5L6SmBpJC3mQY2Mt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a16af6bb-d37c-4187-bd52-08d963ee1c16
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 15:20:57.6383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jZxbAXVAAlvPxc4QiDwkT0b0odKlef4AviSPzryQApjurrj9DeYUtviAB1lrSPax7AYAy7Z5XvcWV+1wK/15/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2719
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
 arch/x86/boot/compressed/sev.c    | 26 ++++++++++++++++++++++++--
 arch/x86/include/asm/sev-common.h |  3 +++
 arch/x86/kernel/sev.c             |  8 ++++++--
 3 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 7760959fe96d..7be325d9b09f 100644
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
 
-static bool early_setup_sev_es(void)
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
+static bool do_early_sev_setup(void)
 {
 	if (!sev_es_negotiate_protocol())
 		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_PROT_UNSUPPORTED);
 
+	/*
+	 * If SEV-SNP is enabled, then check if the hypervisor supports the SEV-SNP
+	 * features.
+	 */
+	if (sev_snp_enabled() && !(sev_hv_features & GHCB_HV_FT_SNP))
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
+
 	if (set_page_decrypted((unsigned long)&boot_ghcb_page))
 		return false;
 
@@ -174,7 +196,7 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
 	struct es_em_ctxt ctxt;
 	enum es_result result;
 
-	if (!boot_ghcb && !early_setup_sev_es())
+	if (!boot_ghcb && !do_early_sev_setup())
 		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
 
 	vc_ghcb_invalidate(boot_ghcb);
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 891569c07ed7..f80a3cde2086 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -64,6 +64,8 @@
 	/* GHCBData[63:12] */				\
 	(((u64)(v) & GENMASK_ULL(63, 12)) >> 12)
 
+#define GHCB_HV_FT_SNP			BIT_ULL(0)
+
 #define GHCB_MSR_TERM_REQ		0x100
 #define GHCB_MSR_TERM_REASON_SET_POS	12
 #define GHCB_MSR_TERM_REASON_SET_MASK	0xf
@@ -80,6 +82,7 @@
 #define SEV_TERM_SET_GEN		0
 #define GHCB_SEV_ES_GEN_REQ		0
 #define GHCB_SEV_ES_PROT_UNSUPPORTED	1
+#define GHCB_SNP_UNSUPPORTED		2
 
 /* Linux-specific reason codes (used with reason set 1) */
 #define SEV_TERM_SET_LINUX		1
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 646912709334..06e6914cdc26 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -662,12 +662,16 @@ static enum es_result vc_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
  * This function runs on the first #VC exception after the kernel
  * switched to virtual addresses.
  */
-static bool __init sev_es_setup_ghcb(void)
+static bool __init setup_ghcb(void)
 {
 	/* First make sure the hypervisor talks a supported protocol. */
 	if (!sev_es_negotiate_protocol())
 		return false;
 
+	/* If SNP is active, make sure that hypervisor supports the feature. */
+	if (sev_feature_enabled(SEV_SNP) && !(sev_hv_features & GHCB_HV_FT_SNP))
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
+
 	/*
 	 * Clear the boot_ghcb. The first exception comes in before the bss
 	 * section is cleared.
@@ -1476,7 +1480,7 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
 	enum es_result result;
 
 	/* Do initial setup or terminate the guest */
-	if (unlikely(boot_ghcb == NULL && !sev_es_setup_ghcb()))
+	if (unlikely(!boot_ghcb && !setup_ghcb()))
 		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
 
 	vc_ghcb_invalidate(boot_ghcb);
-- 
2.17.1

