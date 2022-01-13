Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3EFE48DC01
	for <lists+linux-efi@lfdr.de>; Thu, 13 Jan 2022 17:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbiAMQjl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Jan 2022 11:39:41 -0500
Received: from mail-sn1anam02on2079.outbound.protection.outlook.com ([40.107.96.79]:28565
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230234AbiAMQjk (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 13 Jan 2022 11:39:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aK4xJp6rHOgVTNvNAX3a94Oyza9kJjkz1qYTmqgvktk7ni0gzcgG+XnfI3yVg+7MbBFcA/DW23L5Ot6BYWNzMouyqNZJYu6W4vRxxQjhwrBGFlLv8+B3fYKQp2d29sCSXDsGTB7hTq/pAqVtd/zoCzFZIJhiVV6Ldu5naQm9LbvFaYlRE/nGnW7xGqvt2nJjpR3pTjrWDXo44Q6TZB+Wn81Ka+lboeU1gosAzoKhEVuQCY+wyjvUsDvWvd34XA5q22YGPE9afkgGACXx7nOHv8oAr04LA7SsvhI8nZnZDI2HZFZ3/OGPx7EGlqSsmtuKHsmUYNhVqs386j3YQThOzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YELPSpt0a5/tJbNj+pms3SwSAWTqiBHyq9zLQvA9Tsk=;
 b=GcX2XaKXQgE6bveTzm9H0lvUeLUuS0DMLP51iqjTa5Vj8LPscCaArgIm9X/xZrpkIxrqdwSa/M2lQr9XasIX4zlFaLQg2PW8LkuIGt196dbVDeQwLmEcsEWDveWBRxoXcf1qJDU6RYf5aBuMDFwRsyuowvlc8+Z06lPhsFupcSpWU126o0ridcSnbHZl5Yf0udGh7M8g544BtYquYvp1q2RxZ0EusRoXrIQU/YUHf7DvSMIdcqVc8JtKEQAtYHswGCEi/JudUOG6WSEYPjzDFLGZHAqGU3u5wiQb0s5W++m7gcgokN9NcKBOgqDtKykrLm8T8E5FKITzECcDjzzFUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YELPSpt0a5/tJbNj+pms3SwSAWTqiBHyq9zLQvA9Tsk=;
 b=a99lhKjMiGh8TURjiBcep/eMWloJ0AG2gUAIj6SitoBuS4OAVI/UPDur920icgI1T7rvWw8RxQlWpz9TGSvUcBWhsF6vzT/RxRV7ObybpErXRfbe8zBxDQoB17xwn/de/8u2iC1RE1PqQC2ZQp6u4HcLlkc+Y17eATDMGIuYofI=
Received: from DM5PR05CA0006.namprd05.prod.outlook.com (2603:10b6:3:d4::16) by
 BYAPR12MB3431.namprd12.prod.outlook.com (2603:10b6:a03:da::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.9; Thu, 13 Jan 2022 16:39:34 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:d4:cafe::f7) by DM5PR05CA0006.outlook.office365.com
 (2603:10b6:3:d4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.2 via Frontend
 Transport; Thu, 13 Jan 2022 16:39:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Thu, 13 Jan 2022 16:39:32 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 10:39:31 -0600
Date:   Thu, 13 Jan 2022 10:39:13 -0600
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
        <tony.luck@intel.com>, <marcorr@google.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v8 29/40] x86/compressed/64: add support for SEV-SNP
 CPUID table in #VC handlers
Message-ID: <20220113163913.phpu4klrmrnedgic@amd.com>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-30-brijesh.singh@amd.com>
 <YeAmFePcPjvMoWCP@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YeAmFePcPjvMoWCP@zn.tnic>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d53266bb-a875-4084-923f-08d9d6b34701
X-MS-TrafficTypeDiagnostic: BYAPR12MB3431:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3431BB00795F78C817C2F3E695539@BYAPR12MB3431.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kBi4ZP/GhbJDtaA+I2JHe0sinWPIB3xWwyf22mZ8CvE+HDImUV55GC6SLfKDesTe5QMzq+/ZovwZmLNg0gWa7/oWa/s6/XXAOWq5u7b8t0Et71Cg7StYq667p4q5i35GBFePGaddXR99F3pelTCR6gAuwtaN4Zros8HKO12FSkZLgId8JcozmP8wF4T2rSoypraXVOBsVaha1hi0gaPFJEYEA6dlITeOfHs7G6cahPzKowroyVoyPQJhQ5xKLZu4MG586nQEVclUsKCKWU4MtLjHDe5jv0R++2YfdobmyVerI0tf3hW1XANLZz5NhvAJxruCnSLFUTPjEmw2FTbu2AyqKqghZ7T2oPajW6TWZVgsVv9mcUZtzvdTm5m+sSOBLgZNrAJiKRq5NIERs5sokR0SAv+0w7zWwRrUzm4lQCpKStt2atWQRXqZC4KvRfOdLysvTCHKYfB0aKx7rNKC74IegRTNe0ChcLbyoIzJ8kxdvqcLT2ZJZlxk7jYPlXUPE2E8PedEqscvy2n8FjKZ1H6lOwTYGuTNwnvtHL0s2Bm6BCoYWb2ajaZJTvzdPFOmx5Zf972nntpxp+srT4lhiFnscG34KVZt/XfBJ5AvR9j50apcb5aRS/evdl90hWkwJsguDX0V29kWxepo68oJoqsa7uDMuIc9xowgWa0DsG46BA+SHe7QpeGqTcUI3LSrZzTWoNQHr/JIF4JmRQY956ZrfuYhtcDhCyvzQvsnhIwWpkXpWLG2mq0N22SEQ5hUxQWFuRg5lGZiQZGM8DCFF02YTufJiNPNPcg/4LuJsIKby0OaDPSkMzXgGAR6fKimWZb7SKMUxkUkGk/UjS6MZoMmCW2IJbwmlVaLHldkS4LtqE14Xtiz/ZnQxnaYS5Wq
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(40470700002)(46966006)(36840700001)(36756003)(316002)(2616005)(7406005)(44832011)(47076005)(70206006)(40460700001)(70586007)(30864003)(966005)(7416002)(356005)(82310400004)(81166007)(4326008)(45080400002)(5660300002)(508600001)(83380400001)(2906002)(54906003)(86362001)(1076003)(6916009)(6666004)(8936002)(26005)(336012)(36860700001)(16526019)(426003)(186003)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 16:39:32.7473
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d53266bb-a875-4084-923f-08d9d6b34701
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3431
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jan 13, 2022 at 02:16:05PM +0100, Borislav Petkov wrote:
> On Fri, Dec 10, 2021 at 09:43:21AM -0600, Brijesh Singh wrote:
> > +/*
> > + * Individual entries of the SEV-SNP CPUID table, as defined by the SEV-SNP
> > + * Firmware ABI, Revision 0.9, Section 7.1, Table 14. Note that the XCR0_IN
> > + * and XSS_IN are denoted here as __unused/__unused2, since they are not
> > + * needed for the current guest implementation,
> 
> That's fine and great but you need to check in the function where you
> iterate over those leafs below whether those unused variables are 0
> and fail if not. Not that BIOS or whoever creates that table, starts
> becoming creative...

It's not actually necessary for the values to be 0 in this case. If a
hypervisor chooses to use them (which is allowed by current firmware
ABI, but should perhaps be updated to suggest against it), then guest
code written for that specific hypervisor implementation can choose to
make use of the fields.

But if a guest chooses to ignore the XCR0_IN/XSS_IN values, and instead
compute the XSAVE buffer size from scratch using it's own knowledge of
what features are enabled in the actual XCR0/XSS registers, then it can
compute the same information those fields encode into the cpuid table
by simply walking 0xD sub-leaves 2-63 and calculating the XSAVE buffer
size manually based on the individual sizes encoded in those sub-leaves
(as per CPUID spec).

All entries for 0xD subleaves 0 through 1, with different XCR0_IN/XSS_IN
values, can then be treated as being identical, since the only thing
that changes from a sub-leaf entry with one XCR0_IN/XSS_IN combination to
verses another is total XSAVE buffer size, which the guest doesn't need,
since it is computing them instead by summing up the 0xD subleaves 2-63.

Requiring these to be 0 places constraints on the hypervisor that are at
odds with the current firmware ABI, so that's not enforced here, but the
guest code should work regardless of how the hypervisor chooses to use
XCR0_IN/XSS_IN.

> 
> > where the size of the buffers
> > + * needed to store enabled XSAVE-saved features are calculated rather than
> > + * encoded in the CPUID table for each possible combination of XCR0_IN/XSS_IN
> > + * to save space.
> > + */
> > +struct snp_cpuid_fn {
> > +	u32 eax_in;
> > +	u32 ecx_in;
> > +	u64 __unused;
> > +	u64 __unused2;
> > +	u32 eax;
> > +	u32 ebx;
> > +	u32 ecx;
> > +	u32 edx;
> > +	u64 __reserved;
> 
> Ditto.

I was thinking a future hypervisor/spec might make use of this field for
new functionality, while still wanting to be backward-compatible with
existing guests, so it would be better to not enforce 0. The firmware
ABI does indeed document it as must-be-zero, by that seems to be more of
a constraint on what a hypervisor is currently allowed to place in the
CPUID table, rather than something the guest is meant to enforce/rely
on.

> 
> > +} __packed;
> > +
> > +/*
> > + * SEV-SNP CPUID table header, as defined by the SEV-SNP Firmware ABI,
> > + * Revision 0.9, Section 8.14.2.6. Also noted there is the SEV-SNP
> > + * firmware-enforced limit of 64 entries per CPUID table.
> > + */
> > +#define SNP_CPUID_COUNT_MAX 64
> > +
> > +struct snp_cpuid_info {
> > +	u32 count;
> > +	u32 __reserved1;
> > +	u64 __reserved2;
> > +	struct snp_cpuid_fn fn[SNP_CPUID_COUNT_MAX];
> > +} __packed;
> > +
> >  /*
> >   * Since feature negotiation related variables are set early in the boot
> >   * process they must reside in the .data section so as not to be zeroed
> > @@ -23,6 +58,20 @@
> >   */
> >  static u16 ghcb_version __ro_after_init;
> >  
> > +/* Copy of the SNP firmware's CPUID page. */
> > +static struct snp_cpuid_info cpuid_info_copy __ro_after_init;
> > +static bool snp_cpuid_initialized __ro_after_init;
> > +
> > +/*
> > + * These will be initialized based on CPUID table so that non-present
> > + * all-zero leaves (for sparse tables) can be differentiated from
> > + * invalid/out-of-range leaves. This is needed since all-zero leaves
> > + * still need to be post-processed.
> > + */
> > +u32 cpuid_std_range_max __ro_after_init;
> > +u32 cpuid_hyp_range_max __ro_after_init;
> > +u32 cpuid_ext_range_max __ro_after_init;
> 
> All of them: static.
> 
> >  static bool __init sev_es_check_cpu_features(void)
> >  {
> >  	if (!has_cpuflag(X86_FEATURE_RDRAND)) {
> > @@ -246,6 +295,244 @@ static int sev_cpuid_hv(u32 func, u32 subfunc, u32 *eax, u32 *ebx,
> >  	return 0;
> >  }
> >  
> > +static const struct snp_cpuid_info *
> 
> No need for that linebreak here.
> 
> > +snp_cpuid_info_get_ptr(void)
> > +{
> > +	void *ptr;
> > +
> > +	/*
> > +	 * This may be called early while still running on the initial identity
> > +	 * mapping. Use RIP-relative addressing to obtain the correct address
> > +	 * in both for identity mapping and after switch-over to kernel virtual
> > +	 * addresses.
> > +	 */
> 
> Put that comment over the function name.
> 
> And yah, that probably works but eww.

Yah... originally there was a cpuid table ptr that was initialized for
identity-mapping early on, then updated later after switch-over, but it
required an additional init routine or callback later in boot, which
seemed at odds with the goal of initializing everything in one spot, so
I switched to using this approach to avoid needed to re-introduce having
multiple stages of initialization throughout boot.

> 
> > +	asm ("lea cpuid_info_copy(%%rip), %0"
> > +	     : "=r" (ptr)
> 
> Why not "=g" and let the compiler decide?

I mainly re-used existing code from sme_enable() here, but I'll check
on this.

> 
> > +	     : "p" (&cpuid_info_copy));
> > +
> > +	return ptr;
> > +}
> > +
> > +static inline bool snp_cpuid_active(void)
> > +{
> > +	return snp_cpuid_initialized;
> > +}
> 
> That looks useless. That variable snp_cpuid_initialized either gets set
> or the guest terminates, so practically, if the guest is still running,
> you can assume SNP CPUID is properly initialized.

snp_cpuid_info_create() (which sets snp_cpuid_initialized) only gets
called if firmware indicates this is an SNP guests (via the cc_blob), but
the #VC handler still needs to know whether or not it should use the SNP
CPUID table still SEV-ES will still make use of it, so it uses
snp_cpuid_active() to make that determination.

Previous versions of the series basically did:

  snp_cpuid_active():
    return snp_cpuid_table_ptr != NULL;

but now that the above snp_cpuid_info_get_ptr() accessor is used instead
of storing an actual pointer somewhere, a new variable is needed to
track that, which why snp_cpuid_initialized was introduced here.

> 
> > +static int snp_cpuid_calc_xsave_size(u64 xfeatures_en, u32 base_size,
> > +				     u32 *xsave_size, bool compacted)
> > +{
> > +	const struct snp_cpuid_info *cpuid_info = snp_cpuid_info_get_ptr();
> > +	u32 xsave_size_total = base_size;
> > +	u64 xfeatures_found = 0;
> > +	int i;
> > +
> > +	for (i = 0; i < cpuid_info->count; i++) {
> > +		const struct snp_cpuid_fn *fn = &cpuid_info->fn[i];
> > +
> > +		if (!(fn->eax_in == 0xD && fn->ecx_in > 1 && fn->ecx_in < 64))
> > +			continue;
> 
> I guess that test can be as simple as
> 
> 		if (fn->eax_in != 0xd)
> 			continue;
> 
> or why do you wanna check ECX too? Funky values coming from the CPUID
> page?

This code is calculating the total XSAVE buffer size for whatever
features are enabled by the guest's XCR0/XSS registers. Those feature
bits correspond to the 0xD subleaves 2-63, which advertise the buffer
size for each particular feature. So that check needs to ignore anything
outside that range (including 0xD subleafs 0 and 1, which would normally
provide this total size dynamically based on current values of XCR0/XSS,
but here are instead calculated "manually" since we are not relying on
the XCR0_IN/XSS_IN fields in the table (due to the reasons mentioned
earlier in this thread).

> 
> > +		if (!(xfeatures_en & (BIT_ULL(fn->ecx_in))))
> > +			continue;
> > +		if (xfeatures_found & (BIT_ULL(fn->ecx_in)))
> > +			continue;
> 
> What is that test for? Don't tell me the CPUID page allows duplicate
> entries...

Not duplicate entries (though there's technically nothing in the spec
that says you can't), but I was more concerned here with multiple
entries corresponding to different combination of XCR0_IN/XSS_IN.
There's no good reason for a hypervisor to use those fields for anything
other than 0xD subleaves 0 and 1, but a hypervisor could in theory encode
1 "duplicate" sub-leaf for each possible combination of XCR0_IN/XSS_IN,
similar to what it might do for subleaves 0 and 1, and not violate the
spec.

The current spec is a bit open-ended in some of these areas so the guest
code is trying to be as agnostic as possible to the underlying implementation
so there's less chance of breakage running on one hypervisor verses
another. We're working on updating the spec to encourage better
interoperability, but that would likely only be enforceable for future
firmware versions/guests.

> 
> > +		xfeatures_found |= (BIT_ULL(fn->ecx_in));
> > +
> > +		if (compacted)
> > +			xsave_size_total += fn->eax;
> > +		else
> > +			xsave_size_total = max(xsave_size_total,
> > +					       fn->eax + fn->ebx);
> > +	}
> > +
> > +	/*
> > +	 * Either the guest set unsupported XCR0/XSS bits, or the corresponding
> > +	 * entries in the CPUID table were not present. This is not a valid
> > +	 * state to be in.
> > +	 */
> > +	if (xfeatures_found != (xfeatures_en & GENMASK_ULL(63, 2)))
> > +		return -EINVAL;
> > +
> > +	*xsave_size = xsave_size_total;
> > +
> > +	return 0;
> 
> This function can return xsave_size in the success case and negative in
> the error case so you don't need the IO param *xsave_size.

Makes sense.

> 
> > +}
> > +
> > +static void snp_cpuid_hv(u32 func, u32 subfunc, u32 *eax, u32 *ebx, u32 *ecx,
> > +			 u32 *edx)
> > +{
> > +	/*
> > +	 * MSR protocol does not support fetching indexed subfunction, but is
> > +	 * sufficient to handle current fallback cases. Should that change,
> > +	 * make sure to terminate rather than ignoring the index and grabbing
> > +	 * random values. If this issue arises in the future, handling can be
> > +	 * added here to use GHCB-page protocol for cases that occur late
> > +	 * enough in boot that GHCB page is available.
> > +	 */
> > +	if (cpuid_function_is_indexed(func) && subfunc)
> > +		sev_es_terminate(1, GHCB_TERM_CPUID_HV);
> > +
> > +	if (sev_cpuid_hv(func, 0, eax, ebx, ecx, edx))
> > +		sev_es_terminate(1, GHCB_TERM_CPUID_HV);
> > +}
> > +
> > +static bool
> > +snp_cpuid_find_validated_func(u32 func, u32 subfunc, u32 *eax, u32 *ebx,
> 
> snp_cpuid_get_validated_func()
> 
> > +			      u32 *ecx, u32 *edx)
> > +{
> > +	const struct snp_cpuid_info *cpuid_info = snp_cpuid_info_get_ptr();
> > +	int i;
> > +
> > +	for (i = 0; i < cpuid_info->count; i++) {
> > +		const struct snp_cpuid_fn *fn = &cpuid_info->fn[i];
> > +
> > +		if (fn->eax_in != func)
> > +			continue;
> > +
> > +		if (cpuid_function_is_indexed(func) && fn->ecx_in != subfunc)
> > +			continue;
> > +
> > +		*eax = fn->eax;
> > +		*ebx = fn->ebx;
> > +		*ecx = fn->ecx;
> > +		*edx = fn->edx;
> > +
> > +		return true;
> > +	}
> > +
> > +	return false;
> > +}
> > +
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
> ...

True, I could have snp_cpuid_find_validated_func() return a pointer to the
actual entry and pass that through to postprocess(). I'll see what that
looks like.

> 
> > +/*
> > + * Returns -EOPNOTSUPP if feature not enabled. Any other return value should be
> > + * treated as fatal by caller.
> > + */
> > +static int snp_cpuid(u32 func, u32 subfunc, u32 *eax, u32 *ebx, u32 *ecx,
> > +		     u32 *edx)
> > +{
> > +	if (!snp_cpuid_active())
> > +		return -EOPNOTSUPP;
> 
> And this becomes superfluous.
> 
> > +
> > +	if (!snp_cpuid_find_validated_func(func, subfunc, eax, ebx, ecx, edx)) {
> > +		/*
> > +		 * Some hypervisors will avoid keeping track of CPUID entries
> > +		 * where all values are zero, since they can be handled the
> > +		 * same as out-of-range values (all-zero). This is useful here
> > +		 * as well as it allows virtually all guest configurations to
> > +		 * work using a single SEV-SNP CPUID table.
> > +		 *
> > +		 * To allow for this, there is a need to distinguish between
> > +		 * out-of-range entries and in-range zero entries, since the
> > +		 * CPUID table entries are only a template that may need to be
> > +		 * augmented with additional values for things like
> > +		 * CPU-specific information during post-processing. So if it's
> > +		 * not in the table, but is still in the valid range, proceed
> > +		 * with the post-processing. Otherwise, just return zeros.
> > +		 */
> > +		*eax = *ebx = *ecx = *edx = 0;
> > +		if (!snp_cpuid_check_range(func))
> > +			return 0;
> 
> Do the check first and then assign.
> 
> > +	}
> > +
> > +	return snp_cpuid_postprocess(func, subfunc, eax, ebx, ecx, edx);
> > +}
> > +
> >  /*
> >   * Boot VC Handler - This is the first VC handler during boot, there is no GHCB
> >   * page yet, so it only supports the MSR based communication with the
> > @@ -253,16 +540,26 @@ static int sev_cpuid_hv(u32 func, u32 subfunc, u32 *eax, u32 *ebx,
> >   */
> >  void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
> >  {
> > +	unsigned int subfn = lower_bits(regs->cx, 32);
> >  	unsigned int fn = lower_bits(regs->ax, 32);
> >  	u32 eax, ebx, ecx, edx;
> > +	int ret;
> >  
> >  	/* Only CPUID is supported via MSR protocol */
> >  	if (exit_code != SVM_EXIT_CPUID)
> >  		goto fail;
> >  
> > +	ret = snp_cpuid(fn, subfn, &eax, &ebx, &ecx, &edx);
> > +	if (ret == 0)
> 
> 	if (!ret)
> 
> > +		goto cpuid_done;
> > +
> > +	if (ret != -EOPNOTSUPP)
> > +		goto fail;
> > +
> >  	if (sev_cpuid_hv(fn, 0, &eax, &ebx, &ecx, &edx))
> >  		goto fail;
> >  
> > +cpuid_done:
> >  	regs->ax = eax;
> >  	regs->bx = ebx;
> >  	regs->cx = ecx;
> > @@ -557,12 +854,35 @@ static enum es_result vc_handle_ioio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
> >  	return ret;
> >  }
> >  
> > +static int vc_handle_cpuid_snp(struct pt_regs *regs)
> > +{
> > +	u32 eax, ebx, ecx, edx;
> > +	int ret;
> > +
> > +	ret = snp_cpuid(regs->ax, regs->cx, &eax, &ebx, &ecx, &edx);
> > +	if (ret == 0) {
> 
> 	if (!ret)
> 
> > +		regs->ax = eax;
> > +		regs->bx = ebx;
> > +		regs->cx = ecx;
> > +		regs->dx = edx;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> >  static enum es_result vc_handle_cpuid(struct ghcb *ghcb,
> >  				      struct es_em_ctxt *ctxt)
> >  {
> >  	struct pt_regs *regs = ctxt->regs;
> >  	u32 cr4 = native_read_cr4();
> >  	enum es_result ret;
> > +	int snp_cpuid_ret;
> > +
> > +	snp_cpuid_ret = vc_handle_cpuid_snp(regs);
> > +	if (snp_cpuid_ret == 0)
> 
> 	if (! ... - you get the idea.

Thanks for the suggestions, will get these all implemented unless
otherwise noted above.

-Mike

> 
> 
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7CMichael.Roth%40amd.com%7Cbdeae41f29e841b9c98108d9d696dd53%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637776765726982239%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=u2W1ZARL%2Fn%2FgQZb7KXvnpR3o8%2FMUw7GoXwrIY19xFcY%3D&amp;reserved=0
