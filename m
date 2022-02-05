Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D124AAA1A
	for <lists+linux-efi@lfdr.de>; Sat,  5 Feb 2022 17:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380458AbiBEQYc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 5 Feb 2022 11:24:32 -0500
Received: from mail-dm6nam11on2055.outbound.protection.outlook.com ([40.107.223.55]:26593
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230210AbiBEQYb (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 5 Feb 2022 11:24:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jscwn3BHl7Kuz7gu+W+0DAUOJspbeAqorEfl98/70vJTpvRsW1JYVk0pVuCn1qasYl0hraAO6Jm6RqP4CNREOi2TmwUrwL1AXYddkKx0jdg0Q3wb/UugDp4Ym4uOWyfmWrM7N49tXjF5vMaWTDGV8QJs9mKcZTIF3pZ1LejIAcpxqDnhopx1Nt7qNGsXvKuCBu9KUFiTnWGgfJdpICoU0KhW+ni7zDgmugnGRmRdh25dF9YnGnxuG3J2TFHeRr9CO/jilcquL54rfOZVfs3mi4YYTYuASbNj3OKfXd9fXfRwoMbVMeh4ODCiGJJHrPIsCa7bu66sYwdGqzDwPQkoUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjY7yjzPLZrgqmMusLjZR9rq9igSxDiVfpGr1Zhvkos=;
 b=QLILIc5tNMoUA6kvqgaTmxWT0HNfTpsWvYpiNOWqrHsyn/jRoziBkC/sA3WRNAc+fJkK/AQWF99mV7pr4BThFENCK1z1PqFLxkiMtwhdH3+CuUn5hSQy5nTsj3cAQorkOmCNe5JgCM61hQ2V0lBtY8wKz0DwH6vDQSTnEawHfqfGJEDAfA0n1rJUwELag1nO8FM8ZRChqmNbougXdYbjX/f0Sy19vkLiSR+oUc0ldCNnj6vUiiYk86pHFj6Zu6/jqgbU/0v0SsTZ8jruVysi7U+AcHUsISHTj++WtThbKa0e/1f7StP8R3SGRT1jXnvRRkOKv7t8x0MJVcNJUtjR8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjY7yjzPLZrgqmMusLjZR9rq9igSxDiVfpGr1Zhvkos=;
 b=2xCgArRCl543fWH6i/FSFj2Zm0M1/Zw1Dx/8VlopzOY13XW2zgee/OYMwuhISztqQsP7zFuozbCW7s9WJoW6TwiUJT5JELLLKwOfbz7ikNQci8PiuAI/qavwpltdL/RzhFjBedH1NHzSN+PBEDEU28ZZftgSD6GRKNkaqdnUzLk=
Received: from DM3PR03CA0022.namprd03.prod.outlook.com (2603:10b6:0:50::32) by
 SN6PR12MB2797.namprd12.prod.outlook.com (2603:10b6:805:6e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.20; Sat, 5 Feb 2022 16:24:28 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:50:cafe::bd) by DM3PR03CA0022.outlook.office365.com
 (2603:10b6:0:50::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Sat, 5 Feb 2022 16:24:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Sat, 5 Feb 2022 16:24:26 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sat, 5 Feb
 2022 10:24:26 -0600
Date:   Sat, 5 Feb 2022 10:22:49 -0600
From:   Michael Roth <michael.roth@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Brijesh Singh <brijesh.singh@amd.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
        <linux-efi@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
        <linux-coco@lists.linux.dev>, <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        "Vitaly Kuznetsov" <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        <brijesh.ksingh@gmail.com>, <tony.luck@intel.com>,
        <marcorr@google.com>
Subject: Re: [PATCH v9 31/43] x86/compressed/64: Add support for SEV-SNP
 CPUID table in #VC handlers
Message-ID: <20220205162249.4dkttihw6my7iha3@amd.com>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-32-brijesh.singh@amd.com>
 <Yf5XScto3mDXnl9u@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yf5XScto3mDXnl9u@zn.tnic>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a1acc1a-2c2a-4360-099f-08d9e8c3fa87
X-MS-TrafficTypeDiagnostic: SN6PR12MB2797:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB27971D698F0AF94B099D1C8C952A9@SN6PR12MB2797.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TnNpFrxJuc5elS5PpoFk7kJ8uqzQzTrSX9/xwo9EOOtCvnA5D2qbBl5APg/qXOSMtbj6lEfk3wuPMj3XS8woawrS5CCmRpYq1HHXQTCBzK4BELK9AgU9kIaOIgmPpVu0Z6edMjMIzbuXkiIeynr99jyL6j+0SPQCfhqxkIhm2eVKHNixvXg1g2S3DIvqHYcmFh/7URWFT6PUDTS3VgHkPlNERfV5sYnmqMrSBkAcaRU3y864FDpymi3u7ZRnN0fTqLjEWr40csG3uhhPrbXoF/+fMmlIxO8vpxjHdF+xvf1b4txElUg6ljOzqexCA12OFU5RUduYzsOlH7y80DwCnXpGqGmlfdt1pS3XcY/o5HSwSs+GWyTROFVf5PX0xlxvC7iFpLDSJPLnmT4ue1Cmr4ZaCk3r50A/+JY6LxD28wrxLx7jjdy2ea1lXk2XgUgOy95yF3GzKDVxwBhad7Igl7ohb4wNf3XZR0Ww+B9EkkHKr1rHMFGpRYAJYq0Ti5r2cfDBCbmQ/i6I/y+F1pUd5N9LAB6EtpMNaytFyb0ENj/L9WSS58B3CldGDNUcX/VlKoN6ODNB6gvcSKbN4660PZlK1tPqxkp9vRvogiLXeVUoDzwfY7vwZgmYhiZxnwZk6AoFWjoGdGEnccUT14KFLJI4ULKnU9zNVpuZMR8AivTyTRGNrQ3quukSpVSGTfNZHBjGwc44PuT+te3s30lhe/TO8bO9LW9xIJ/k8Nf34HckuZvbnDBtAQLll5oJ0YzW80fQpjiBL/HB/2Q4/cGXyX/gT+8KS0kzPkFY7GltfOI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(2906002)(7416002)(82310400004)(36860700001)(81166007)(36756003)(26005)(47076005)(186003)(44832011)(5660300002)(356005)(16526019)(40460700003)(4326008)(508600001)(70206006)(8936002)(30864003)(2616005)(336012)(54906003)(1076003)(6916009)(316002)(45080400002)(86362001)(6666004)(426003)(966005)(70586007)(8676002)(7406005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2022 16:24:26.7962
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a1acc1a-2c2a-4360-099f-08d9e8c3fa87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2797
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Feb 05, 2022 at 11:54:01AM +0100, Borislav Petkov wrote:
> On Fri, Jan 28, 2022 at 11:17:52AM -0600, Brijesh Singh wrote:
> 
> > +static const struct snp_cpuid_info *snp_cpuid_info_get_ptr(void)
> > +{
> > +	void *ptr;
> > +
> > +	asm ("lea cpuid_info_copy(%%rip), %0"
> > +	     : "=r" (ptr)
> 
> Same question as the last time:
> 
> Why not "=g" and let the compiler decide?

The documentation for lea (APM Volume 3 Chapter 3) seemed to require
that the destination register be a general purpose register, so it
seemed like there was potential for breakage in allowing GCC to use
anything otherwise. Maybe GCC is smart enough to figure that out, but
since we know the constraint in advance it seemed safer to stick
with the current approach of enforcing that constraint.

> 
> > +	     : "p" (&cpuid_info_copy));
> > +
> > +	return ptr;
> > +}
> 
> ...
> 
> > +static bool snp_cpuid_check_range(u32 func)
> > +{
> > +	if (func <= cpuid_std_range_max ||
> > +	    (func >= 0x40000000 && func <= cpuid_hyp_range_max) ||
> > +	    (func >= 0x80000000 && func <= cpuid_ext_range_max))
> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> > +static int snp_cpuid_postprocess(u32 func, u32 subfunc, u32 *eax, u32 *ebx,
> > +				 u32 *ecx, u32 *edx)
> 
> And again, same question as the last time:
> 
> I'm wondering if you could make everything a lot easier by doing
> 
> static int snp_cpuid_postprocess(struct cpuid_leaf *leaf)
> 
> and marshall around that struct cpuid_leaf which contains func, subfunc,
> e[abcd]x instead of dealing with 6 parameters.
> 
> Callers of snp_cpuid() can simply allocate it on their stack and hand it
> in and it is all in sev-shared.c so nicely self-contained...
> 
> Ok I'm ignoring this patch for now and I'll review it only after you've
> worked in all comments from the previous review.

I did look into it and honestly it just seemed to add more abstractions that
made it harder to parse the specific operations taken place here. For
instance, post-processing of 0x8000001E entry, we have e{a,b,c,d}x from
the CPUID table, then to post process:

  switch (func):
  case 0x8000001E:
    /* extended APIC ID */
    snp_cpuid_hv(func, subfunc, eax, &ebx2, &ecx2, NULL);
                                |    |      |      |
                                |    |      |      edx from cpuid table is used as-is
                                |    |      |  
                                |    |      |
                                |    |      load HV value into tmp ecx2
                                |    |
                                |    load HV value into tmp ebx2
                                |
                                |
                                replace eax completely with the HV value

    # then do the remaining fixups for final ebx/ecx

    /* compute ID */
    *ebx = (*ebx & GENMASK(31, 8)) | (ebx2 & GENMASK(7, 0));
    /* node ID */
    *ecx = (*ecx & GENMASK(31, 8)) | (ecx2 & GENMASK(7, 0));

and it all reads in a clear/familiar way to all the other
cpuid()/native_cpuid() users throughout the kernel, and from the
persective of someone auditing this from a security perspective that
needs to quickly check what registers come from the CPUID table, what
registers come from HV, what the final result is, it all just seems very
clear and familiar to me.

But if we start passing around this higher-level structure that does
not do anything other than abstract away e{a,b,c,x} to save on function
arguments, things become muddier, and there's more pointer dereference
operations and abstractions to sift through. I saved the diff from when
I looked into it previously (was just a rough-sketch, not build-tested),
and included it below for reference, but it just didn't seem to help with
readability to me, which I think is important here since this is probably
one of the most security-sensitive piece of the CPUID table handling,
since we're dealing with untrusted CPUID sources here and it needs to be
clear what exactly is ending up in the E{A,B,C,D} registers we're
returning for a particular CPUID instruction:

(There are some possible optimizations below, like added a mask parameter
so control specifically what EAX/EBX/ECX/EDX field should be modified,
possibly reworking snp_cpuid_info structure definitions to re-use the
cpuid_leaf struct internally, also modifying __sev_cpuid_hv() to take
the cpuid_leaf struct, etc., but none of that really seemed like
it would help much with the key issue of readability, so I ended up
setting it aside for v9)

diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index b2defbf7e66b..53534a6b1dcc 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -49,6 +49,13 @@ struct snp_cpuid_info {
 	struct snp_cpuid_fn fn[SNP_CPUID_COUNT_MAX];
 } __packed;
 
+struct cpuid_leaf {
+	u32 eax;
+	u32 ebx;
+	u32 ecx;
+	u32 edx;
+};
+
 /*
  * Since feature negotiation related variables are set early in the boot
  * process they must reside in the .data section so as not to be zeroed
@@ -260,14 +267,14 @@ static int __sev_cpuid_hv(u32 func, int reg_idx, u32 *reg)
 	return 0;
 }
 
-static int sev_cpuid_hv(u32 func, u32 *eax, u32 *ebx, u32 *ecx, u32 *edx)
+static int sev_cpuid_hv(u32 func, struct cpuid_leaf *leaf)
 {
 	int ret;
 
-	ret = __sev_cpuid_hv(func, GHCB_CPUID_REQ_EAX, eax);
-	ret = ret ? : __sev_cpuid_hv(func, GHCB_CPUID_REQ_EBX, ebx);
-	ret = ret ? : __sev_cpuid_hv(func, GHCB_CPUID_REQ_ECX, ecx);
-	ret = ret ? : __sev_cpuid_hv(func, GHCB_CPUID_REQ_EDX, edx);
+	ret = __sev_cpuid_hv(func, GHCB_CPUID_REQ_EAX, &leaf->eax);
+	ret = ret ? : __sev_cpuid_hv(func, GHCB_CPUID_REQ_EBX, &leaf->ebx);
+	ret = ret ? : __sev_cpuid_hv(func, GHCB_CPUID_REQ_ECX, &leaf->ecx);
+	ret = ret ? : __sev_cpuid_hv(func, GHCB_CPUID_REQ_EDX, &leaf->edx);
 
 	return ret;
 }
@@ -328,8 +335,7 @@ static int snp_cpuid_calc_xsave_size(u64 xfeatures_en, bool compacted)
 	return xsave_size;
 }
 
-static void snp_cpuid_hv(u32 func, u32 subfunc, u32 *eax, u32 *ebx, u32 *ecx,
-			 u32 *edx)
+static void snp_cpuid_hv(u32 func, u32 subfunc, struct cpuid_leaf *leaf)
 {
 	/*
 	 * MSR protocol does not support fetching indexed subfunction, but is
@@ -342,13 +348,12 @@ static void snp_cpuid_hv(u32 func, u32 subfunc, u32 *eax, u32 *ebx, u32 *ecx,
 	if (cpuid_function_is_indexed(func) && subfunc)
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID_HV);
 
-	if (sev_cpuid_hv(func, eax, ebx, ecx, edx))
+	if (sev_cpuid_hv(func, leaf))
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID_HV);
 }
 
 static bool
-snp_cpuid_get_validated_func(u32 func, u32 subfunc, u32 *eax, u32 *ebx,
-			     u32 *ecx, u32 *edx)
+snp_cpuid_get_validated_func(u32 func, u32 subfunc, struct cpuid_leaf *leaf)
 {
 	const struct snp_cpuid_info *cpuid_info = snp_cpuid_info_get_ptr();
 	int i;
@@ -362,10 +367,10 @@ snp_cpuid_get_validated_func(u32 func, u32 subfunc, u32 *eax, u32 *ebx,
 		if (cpuid_function_is_indexed(func) && fn->ecx_in != subfunc)
 			continue;
 
-		*eax = fn->eax;
-		*ebx = fn->ebx;
-		*ecx = fn->ecx;
-		*edx = fn->edx;
+		leaf->eax = fn->eax;
+		leaf->ebx = fn->ebx;
+		leaf->ecx = fn->ecx;
+		leaf->edx = fn->edx;
 
 		return true;
 	}
@@ -383,33 +388,34 @@ static bool snp_cpuid_check_range(u32 func)
 	return false;
 }
 
-static int snp_cpuid_postprocess(u32 func, u32 subfunc, u32 *eax, u32 *ebx,
-				 u32 *ecx, u32 *edx)
+static int snp_cpuid_postprocess(u32 func, u32 subfunc, struct cpuid_leaf *leaf)
 {
-	u32 ebx2, ecx2, edx2;
+	struct cpuid_leaf leaf_tmp;
 
 	switch (func) {
 	case 0x1:
-		snp_cpuid_hv(func, subfunc, NULL, &ebx2, NULL, &edx2);
+		snp_cpuid_hv(func, subfunc, &leaf_tmp);
 
 		/* initial APIC ID */
-		*ebx = (ebx2 & GENMASK(31, 24)) | (*ebx & GENMASK(23, 0));
+		leaf->ebx = (leaf_tmp.ebx & GENMASK(31, 24)) | (leaf->ebx & GENMASK(23, 0));
 		/* APIC enabled bit */
-		*edx = (edx2 & BIT(9)) | (*edx & ~BIT(9));
+		leaf->edx = (leaf_tmp.edx & BIT(9)) | (leaf->edx & ~BIT(9));
 
 		/* OSXSAVE enabled bit */
 		if (native_read_cr4() & X86_CR4_OSXSAVE)
-			*ecx |= BIT(27);
+			leaf->ecx |= BIT(27);
 		break;
 	case 0x7:
 		/* OSPKE enabled bit */
-		*ecx &= ~BIT(4);
+		leaf->ecx &= ~BIT(4);
 		if (native_read_cr4() & X86_CR4_PKE)
-			*ecx |= BIT(4);
+			leaf->ecx |= BIT(4);
 		break;
 	case 0xB:
 		/* extended APIC ID */
-		snp_cpuid_hv(func, 0, NULL, NULL, NULL, edx);
+		snp_cpuid_hv(func, 0, &leaf_tmp);
+		leaf->edx = leaf_tmp.edx;
+
 		break;
 	case 0xD: {
 		bool compacted = false;
@@ -440,7 +446,7 @@ static int snp_cpuid_postprocess(u32 func, u32 subfunc, u32 *eax, u32 *ebx,
 			 * to avoid this becoming an issue it's safer to simply
 			 * treat this as unsupported for SEV-SNP guests.
 			 */
-			if (!(*eax & (BIT(1) | BIT(3))))
+			if (!(leaf->eax & (BIT(1) | BIT(3))))
 				return -EINVAL;
 
 			compacted = true;
@@ -450,16 +456,17 @@ static int snp_cpuid_postprocess(u32 func, u32 subfunc, u32 *eax, u32 *ebx,
 		if (xsave_size < 0)
 			return -EINVAL;
 
-		*ebx = xsave_size;
+		leaf->ebx = xsave_size;
 		}
 		break;
 	case 0x8000001E:
 		/* extended APIC ID */
-		snp_cpuid_hv(func, subfunc, eax, &ebx2, &ecx2, NULL);
+		snp_cpuid_hv(func, subfunc, &leaf_tmp);
+		leaf->eax = leaf_tmp.eax;
 		/* compute ID */
-		*ebx = (*ebx & GENMASK(31, 8)) | (ebx2 & GENMASK(7, 0));
+		leaf->ebx = (leaf->ebx & GENMASK(31, 8)) | (leaf_tmp.ebx & GENMASK(7, 0));
 		/* node ID */
-		*ecx = (*ecx & GENMASK(31, 8)) | (ecx2 & GENMASK(7, 0));
+		leaf->ecx = (leaf->ecx & GENMASK(31, 8)) | (leaf_tmp.ecx & GENMASK(7, 0));
 		break;
 	default:
 		/* No fix-ups needed, use values as-is. */
@@ -473,15 +480,14 @@ static int snp_cpuid_postprocess(u32 func, u32 subfunc, u32 *eax, u32 *ebx,
  * Returns -EOPNOTSUPP if feature not enabled. Any other return value should be
  * treated as fatal by caller.
  */
-static int snp_cpuid(u32 func, u32 subfunc, u32 *eax, u32 *ebx, u32 *ecx,
-		     u32 *edx)
+static int snp_cpuid(u32 func, u32 subfunc, struct cpuid_leaf *leaf)
 {
 	const struct snp_cpuid_info *cpuid_info = snp_cpuid_info_get_ptr();
 
 	if (!cpuid_info->count)
 		return -EOPNOTSUPP;
 
-	if (!snp_cpuid_get_validated_func(func, subfunc, eax, ebx, ecx, edx)) {
+	if (!snp_cpuid_get_validated_func(func, subfunc, leaf)) {
 		/*
 		 * Some hypervisors will avoid keeping track of CPUID entries
 		 * where all values are zero, since they can be handled the
@@ -497,12 +503,12 @@ static int snp_cpuid(u32 func, u32 subfunc, u32 *eax, u32 *ebx, u32 *ecx,
 		 * not in the table, but is still in the valid range, proceed
 		 * with the post-processing. Otherwise, just return zeros.
 		 */
-		*eax = *ebx = *ecx = *edx = 0;
+		leaf->eax = leaf->ebx = leaf->ecx = leaf->edx = 0;
 		if (!snp_cpuid_check_range(func))
 			return 0;
 	}
 
-	return snp_cpuid_postprocess(func, subfunc, eax, ebx, ecx, edx);
+	return snp_cpuid_postprocess(func, subfunc, leaf);
 }
 
 /*
@@ -514,28 +520,28 @@ void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 {
 	unsigned int subfn = lower_bits(regs->cx, 32);
 	unsigned int fn = lower_bits(regs->ax, 32);
-	u32 eax, ebx, ecx, edx;
+	struct cpuid_leaf *leaf;
 	int ret;
 
 	/* Only CPUID is supported via MSR protocol */
 	if (exit_code != SVM_EXIT_CPUID)
 		goto fail;
 
-	ret = snp_cpuid(fn, subfn, &eax, &ebx, &ecx, &edx);
+	ret = snp_cpuid(fn, subfn, leaf);
 	if (!ret)
 		goto cpuid_done;
 
 	if (ret != -EOPNOTSUPP)
 		goto fail;
 
-	if (sev_cpuid_hv(fn, &eax, &ebx, &ecx, &edx))
+	if (sev_cpuid_hv(fn, leaf))
 		goto fail;
 
 cpuid_done:
-	regs->ax = eax;
-	regs->bx = ebx;
-	regs->cx = ecx;
-	regs->dx = edx;
+	regs->ax = leaf->eax;
+	regs->bx = leaf->ebx;
+	regs->cx = leaf->ecx;
+	regs->dx = leaf->edx;
 
 	/*
 	 * This is a VC handler and the #VC is only raised when SEV-ES is


> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7CMichael.Roth%40amd.com%7C6bc14b8b5b854a38d7c008d9e895da5b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637796552649205409%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=Lc5o1tYKrtqUy2h%2B8onmgdaydqUWTlnj7V9rfuBEU0s%3D&amp;reserved=0
