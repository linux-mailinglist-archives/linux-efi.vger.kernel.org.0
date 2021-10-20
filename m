Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67AEE434FCE
	for <lists+linux-efi@lfdr.de>; Wed, 20 Oct 2021 18:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbhJTQNE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 Oct 2021 12:13:04 -0400
Received: from mail-bn7nam10on2078.outbound.protection.outlook.com ([40.107.92.78]:10848
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231207AbhJTQND (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 20 Oct 2021 12:13:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5jvOHoL7mJf7u2b89Uzp3z6nH+h8hh9QFnGCCMJTQCBaYxoDdaMyaugr6akiyDuHplF1d1tHG+Mwr/wa3xuLm8nosSH/UDny/ULvatps/A6M5bbf6GfGoc68kNtBdL24pNvG0TWmsZPvbRThdwhAz1NvQ6wz8FVvyOaY8HJ6+ewiAIeeXCebFubGsdcL3QSy3QiLJ4a6wY74yLRV4yXFn8fRnD8F5Hss0rGgAcQ5dJzfJSthTlrNQYQfQzwB4/NFgaG2Ux5PJGAr1GtwTmt/qd+x9JJznkblV3pzPLvkUsED8mYgkWlZeOY2KQTE9uDte7zxCXOuglnGyuGaih9nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3W/1I90HN2LHumujvyPlr/T27cwj+Jws/FEERs852nU=;
 b=SpgbZEltKTO6hCQj2EviVoLQDg+3MY1XPqWRMWx6K+Qs5ryUu2y1Jay/v5XUuy+0PpsoPdNTo69SEEVm7VB+JNNYSnUhJpHjQgCPHhNqGFannUnnX3V4IidMfruHJmNSGuyxhsPjLCOjOoPaqKy0hI8VSCYodaKSeJO2oMSg4Qzv+2qRxIWfzvbK6uu/yvSUPM2z0msYpkA4MqFJF6t4zb19L2wUQP+k3vl0xWVvFplg7CNlWTv73RRmI01dS3/CValGYKpUhXPYt0hyAaps0p3Wv5iKxJQbFvUMATWe26OH99bX2nOMwTpvd/KN39s1u9HZlu8VmsiJuY6mHNxaFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3W/1I90HN2LHumujvyPlr/T27cwj+Jws/FEERs852nU=;
 b=iw7+lTrYM51yHuZB7X9E1PWgtLDCznOVKnexQEOVJlscsECET3bBtIwvrqr+G2hXQ7WZ1Hi97EJa0V/6ONJ62GIdqajZgJPOYJ/ZGOHcDV0aZv7JFfjOux61IXtc52LK9CoCJtpGYtexngpbpOYE76gKxHL0KLQlWRQ+GBPoCms=
Received: from BN6PR11CA0063.namprd11.prod.outlook.com (2603:10b6:404:f7::25)
 by DM6PR12MB3258.namprd12.prod.outlook.com (2603:10b6:5:187::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Wed, 20 Oct
 2021 16:10:44 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:f7:cafe::da) by BN6PR11CA0063.outlook.office365.com
 (2603:10b6:404:f7::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend
 Transport; Wed, 20 Oct 2021 16:10:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Wed, 20 Oct 2021 16:10:42 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Wed, 20 Oct
 2021 11:10:42 -0500
Date:   Wed, 20 Oct 2021 11:10:23 -0500
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
Subject: Re: [PATCH v6 08/42] x86/sev-es: initialize sev_status/features
 within #VC handler
Message-ID: <20211020161023.hzbj53ehmzjrt4xd@amd.com>
References: <20211008180453.462291-1-brijesh.singh@amd.com>
 <20211008180453.462291-9-brijesh.singh@amd.com>
 <YW2EsxcqBucuyoal@zn.tnic>
 <20211018184003.3ob2uxcpd2rpee3s@amd.com>
 <YW3IdfMs61191qnU@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YW3IdfMs61191qnU@zn.tnic>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b4ffa7b-8e18-48a9-6267-08d993e42ad2
X-MS-TrafficTypeDiagnostic: DM6PR12MB3258:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3258289A948234D14A78DD7095BE9@DM6PR12MB3258.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oQ3aPkCKN4bj58oFtJ7tYArUIE1CstuuF9Iuj142LeInSWGxR0AW32b7JHGOf0IvdwEd55rr2MMMIXqG1hMHj0y8GBdB/Fand5mtnGBOn9KJ3GuBZ8g/wJs1ZFDtNZEtBuytiOO9pxoKMCKGRRaR0GRgBYTQbV5VK4cwJ7hDcgNBEPQmOymdk3HKPUF0MAuOOJGfJy25HwxmTdRhCmwqJllp98i4ATSc86C7oCQjP4t08idg4R3DQD/MC/VqIn0JHFmVGwnrAy0lgGQvxtMcFBr5d+jHbEHQYk9KQMySrPYHab9km5x8wQo9uyFpwuJT14N/taE8k3BGvafkIvKIrw2TNetIcyXcHf5vQH1kolnbF2JhgxiVzha1zk1AtaLPk3gQLZqv27o84ZBZtAx0MVVy0rt9qO2rE6woyTc9tXawALIpRV4voFwy0fNJZV2t6RCFl0Yax1JytY8YTp1ZjRxmvstCuHTegjVYNQuBQL0M3aH7UcZ3glWV6lpOmXUr2KfN4lwVRZ//y2Rg+qpcm3JVe+uy1cFZus1eSaCGTu5SJCKIw631t9Sb1lg4x0bgynWcfDgWPVnmkwjfjxSewgLHM2dBReQf6z78/x2g1TTQdhOMn7UWAvJ5mfX675pvDRgkVpsh0enDeK3tXsQ8OrUxr8IAiSNhv6ouMlNzAiIGMMj4CY9dXVQ0v1OvcNyuzFr3xG3Wn/2CxBA8NMAKHPEgsmbT//ffFcphKGs+/sX785CznmnIzm9X2W+M1/CQSSR3HVsFPO44pCePuZN4H5a/hfd5fsXLXB0RAF6+KGacZuqc4lgI55iCB11Hfa+F
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(54906003)(70586007)(70206006)(336012)(44832011)(2906002)(81166007)(1076003)(83380400001)(316002)(356005)(7406005)(8676002)(2616005)(4326008)(7416002)(426003)(86362001)(47076005)(508600001)(36756003)(186003)(966005)(6666004)(16526019)(5660300002)(8936002)(6916009)(36860700001)(26005)(45080400002)(82310400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 16:10:42.9453
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b4ffa7b-8e18-48a9-6267-08d993e42ad2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3258
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Oct 18, 2021 at 09:18:13PM +0200, Borislav Petkov wrote:
> On Mon, Oct 18, 2021 at 01:40:03PM -0500, Michael Roth wrote:
> > If CPUID has lied, that would result in a #GP, rather than a controlled
> > termination in the various checkers/callers. The latter is easier to
> > debug.
> > 
> > Additionally, #VC is arguably a better indicator of SEV MSR availability
> > for SEV-ES/SEV-SNP guests, since it is only generated by ES/SNP hardware
> > and doesn't rely directly on hypervisor/EFI-provided CPUID values. It
> > doesn't work for SEV guests, but I don't think it's a bad idea to allow
> > SEV-ES/SEV-SNP guests to initialize sev_status in #VC handler to make
> > use of the added assurance.
> 

[Sorry for the wall of text, just trying to work through everything.]

> Ok, let's take a step back and analyze what we're trying to solve first.
> So I'm looking at sme_enable():

I'm not sure if this is pertaining to using the CPUID table prior to
sme_enable(), or just the #VC-based SEV MSR read. The following comments
assume the former. If that assumption is wrong you can basically ignore
the rest of this email :)

[The #VC-based SEV MSR read is not necessary for anything in sme_enable(),
it's simply a way to determine whether the guest is an SNP guest, without
any reliance on CPUID, which seemed useful in the context of doing some
additional sanity checks against the SNP CPUID table and determining that
it's appropriate to use it early on (rather than just trust that this is an
SNP guest by virtue of the CC blob being present, and then failing later
once sme_enable() checks for the SNP feature bits through the normal
mechanism, as was done in v5).]

> 
> 1. Code checks SME/SEV support leaf. HV lies and says there's none. So
> guest doesn't boot encrypted. Oh well, not a big deal, the cloud vendor
> won't be able to give confidentiality to its users => users go away or
> do unencrypted like now.
> 
> Problem is solved by political and economical pressure.
> 
> 2. Check SEV and SME bit. HV lies here. Oh well, same as the above.

I'd be worried about the possibility that, through some additional exploits
or failures in the attestation flow, a guest owner was tricked into booting
unencrypted on a compromised host and exposing their secrets. Their
attestation process might even do some additional CPUID sanity checks, which
would at the point be via the SNP CPUID table and look legitimate, unaware
that the kernel didn't actually use the SNP CPUID table until after
0x8000001F was parsed (if we were to only initialize it after/as-part-of
sme_enable()).

Fortunately in this scenario I think the guest kernel actually would fail to
boot due to the SNP hardware unconditionally treating code/page tables as
encrypted pages. I tested some of these scenarios just to check, but not
all, and I still don't feel confident enough about it to say that there's
not some way to exploit this by someone who is more clever/persistant than
me.

> 
> 3. HV lies about 1. and 2. but says that SME/SEV is supported.
> 
> Guest attempts to read the MSR Guest explodes due to the #GP. The same
> political/economical pressure thing happens.

That's seems likely, but maybe some future hardware bug, or some other
exploit, makes it possible to intercept that MSR read? I don't know, but
if that particular branch of execution can be made less likely by utilizing
SNP CPUID validation I think it makes sense to make use of it.

> 
> If the MSR is really there, we've landed at the place where we read the
> SEV MSR. Moment of truth - SEV/SNP guests have a communication protocol
> which is independent from the HV and all good.

At which point we then switch to using the CPUID table? But at that
point all the previous CPUID checks, both SEV-related/non-SEV-related,
are now possibly not consistent with what's in the CPUID table. Do we
then revalidate? Even a non-malicious hypervisor might provide
inconsistent values between the two sources due to bugs, or SNP
validation suppressing certain feature bits that hypervisor otherwise
exposes, etc. Now all the code after sme_enable() can potentially take
unexpected execution paths, where post-sme_enable() code makes
assumptions about pre-sme_enable() checks that may no longer hold true.

Also, it would be useful from an attestation perspective that the CPUID
bits visible to userspace correspond to what the kernel used during boot,
which wouldn't necessarily be the case if hypervisor-provided values were
used during early boot and potentially put the kernel into some unexpected
state that could persist beyond the point of attestation.

Code-wise, thanks in large part to your suggestions, it really isn't all
that much more complicated to hook in the CPUID table lookup in the #VC
handlers (which are already needed anyway for SEV-ES) early on so all
these checks are against the same trusted (or more-trusted at least)
CPUID source.

> 
> Now, which case am I missing here which justifies the need to do those
> acrobatics of causing #VCs just to detect the SEV MSR?

There are a few more places where cpuid is utilized prior to
sme_enable():

# In boot/compressed
paging_prepare():
  ecx = cpuid(7, 0) # SNP-verified against host values
  # check ecx for LA57

# In boot/compressed and kernel proper
verify_cpu():
  eax, ebx, ecx, edx = cpuid(0, 0) # SNP-verified against host values
  # check eax for range > 0
  # check ebx, ecx, edx for "AuthenticAMD" or "GenuineIntel"

if_amd:
  edx = cpuid(1, 0) # SNP-verified against host values
  # check edx feature bits against REQUIRED_MASK0 (PAE|FPU|PSE|etc.)

  eax = cpuid(0x80000001, 0) # SNP-verified against host values
  # check eax against REQUIRED_MASK1 (LM|3DNOW)

  edx = cpuid(1, 0) # SNP-verified against host values
  # check eax against SSE_MASK
  # if not set, try to force it on via MSR_K7_HWCR if this is an AMD CPU
  # if forcing fails, report no_longmode available

if_intel:
  # completely different stuff

It's possible that various lies about the values checked for in
REQUIRED_MASK0/REQUIRED_MASK1, LA57 enablement, etc., can be audited in
similar fashion as you've done above to find nothing concerning, but
what about 5 years from now? And these are all checks/configuration that
can put the kernel in unexpected states that persist beyond the point of
attestation, where we really need to care about the possible effects. If
SNP CPUID validation isn't utilized until after-the-fact, we'd end up
not utilizing it for some of the more 'interesting' CPUID bits.

It's also worth noting that TDX guards against most of this through
CPUID virtualization, where hardware/microcode provides similar
validation for these sorts of CPUID bits in early boot. It's only because
the SEV-SNP CPUID 'virtualization' lives in the guest code that we have to
deal with the additional complexity of initializing the CPUID table early
on. But if both platforms are capable of providing similar assurances then
it seems worthwhile to pursue that.

> acrobatics of causing #VCs just to detect the SEV MSR?

The CPUID calls in snp_cpuid_init() weren't added specifically to induce
the #VC-based SEV MSR read, they were added only because I thought the
gist of your earlier suggestions were to do more validation against the
CPUID table advertised by EFI rather than the v5 approach of deferring
them till later after sev_status gets set by sme_enable(), and then
failing later if turned out that SNP CPUID feature bit wasn't set by
sme_enable(). I thought this was motivated by a desire to be more
paranoid about what EFI provides, so once I had the cpuid checks added
in snp_cpuid_init() it seemed like a logical step to further
sanity-check the SNP CPUID bit using a mechanism that was completely
independent of the CPUID table.

I'm not dead set on that at all however, it was only added based on me
[mis-]interpreting your comments as a desire to be less trusting of EFI
as to whether this is an SNP guest or not. But I also don't think it's
a good idea to not utilize the CPUID table until after sme_enable(),
based on the above reasons.

What if we simply add a check in sme_enable() that terminates the guest
if the cc_blob/cpuid table is provided, but the CPUID/MSR checks in
sme_enable() determine that this isn't an SNP guest? That would be similar
to the v5 approach, but in a less roundabout way, and then the cpuid/MSR
checks could be dropped from snp_cpuid_init().

If we did decide that it is useful to use #VC-based initialization of
sev_status there, it would all be self-contained there (but again, that's
a separate thing that I don't have a strong opinion on).

Thanks,

Mike

> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7Cmichael.roth%40amd.com%7Cddb8c27d71794244176308d9926c094d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637701815061371715%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=LUArcQqb%2F0WFlworDbZOClXhgYqEGje364fpBycixUg%3D&amp;reserved=0
