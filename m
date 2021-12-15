Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4508475FD7
	for <lists+linux-efi@lfdr.de>; Wed, 15 Dec 2021 18:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237846AbhLORwI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Dec 2021 12:52:08 -0500
Received: from mail-co1nam11on2069.outbound.protection.outlook.com ([40.107.220.69]:12859
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238060AbhLORwH (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 15 Dec 2021 12:52:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eE9iDdYEdjLsDjR09TLAoADRnbEFcxN1wZO7BEKpxBeSrxeBgyIJXO1lpJyJxxSxICesuBnXZp/QUWfX44/yvXrB6bBN6kx753pzIG1zN1BKU5rR39q4vBb2HLn5iQl6r3FnQDaMImBf9Aq2cOxcBZpUh6O8LEpxeygQ1Fu7AGr4MMyNGQjtAwf+8fV31DUFXSCypfSMMPjHP4WUjm3tNSnzgKZhDt2zMeWcA8pwBVK97guA4POu1awnm8ZU/7E0iVFcrDMd9viOQhzRCJGRkswD1m2AZvgQ5T4mVq8YPp+MGaZj5s7cDGf90NYL9IVfJZv0ZTctumXz0CzsA7FXkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMUr3D7bfdcZVZd8XKPQrRxEQwo2puvQF4dgS81c5Gw=;
 b=ocwwHs3KkgLWcteqt+GfCP0X6HDHQt28rZcN4lUDfPmk0tQG3U0j/UXikwNTsPYHgDw96SCNesVBoZNKyHVoS00IEfOCCLz5YGk6eiCd44SL3IkQWwvriCKmpksrM4OTkO/ZBVKXoLSKal0L4M6UggkYI7aLW9gRsksS8rzrQsojZ0lIUwVjwrOp+Is8TelX9g8cqDJcPBb6kQjFQzdOU5DOcPGs1QrOoKVQxgUZ6lwSud1Vc+f+2aSR4XPSnESubK+B6nAQmkh56JiafwAldIOaePYupaLQs/sBEFH2CRZiFodaPTStdcMD8cqA0uMU93ugo+H+XDyWZ2/BxaakTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMUr3D7bfdcZVZd8XKPQrRxEQwo2puvQF4dgS81c5Gw=;
 b=D9nUhUkEJZmyl7spswNIv2Ey6+46Y1Iu2WWx1FRl+qrW91tQyEjFZya82RDdja7K4pwu7pqqPC6LQv4uptKSuKZxk2C3eYOW/P8Fo3H3nL7IkhrgoerUiyAv5uNv+Q3z+ngchQkKYrRXFAcOHYE3CZX84goYdV6Z3A9yWufC96E=
Received: from DM5PR18CA0081.namprd18.prod.outlook.com (2603:10b6:3:3::19) by
 MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Wed, 15 Dec
 2021 17:52:05 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:3:cafe::49) by DM5PR18CA0081.outlook.office365.com
 (2603:10b6:3:3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Wed, 15 Dec 2021 17:52:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Wed, 15 Dec 2021 17:52:04 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 15 Dec
 2021 11:52:04 -0600
Date:   Wed, 15 Dec 2021 11:49:34 -0600
From:   Michael Roth <michael.roth@amd.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
CC:     Venu Busireddy <venu.busireddy@oracle.com>,
        Borislav Petkov <bp@alien8.de>,
        Brijesh Singh <brijesh.singh@amd.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
        <linux-efi@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
        <linux-coco@lists.linux.dev>, <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Srinivas Pandruvada" <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        "Tobin Feldman-Fitzthum" <tobin@ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        <tony.luck@intel.com>, <marcorr@google.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v8 01/40] x86/compressed/64: detect/setup SEV/SME
 features earlier in boot
Message-ID: <20211215174934.tgn3c7c4s3toelbq@amd.com>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-2-brijesh.singh@amd.com>
 <YbeaX+FViak2mgHO@dt>
 <YbecS4Py2hAPBrTD@zn.tnic>
 <YbjYZtXlbRdUznUO@dt>
 <YbjsGHSUUwomjbpc@zn.tnic>
 <YbkzaiC31/DzO5Da@dt>
 <b18655e3-3922-2b5d-0c35-1dcfef568e4d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b18655e3-3922-2b5d-0c35-1dcfef568e4d@amd.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48defd6f-6ab8-43d5-9e8b-08d9bff39b03
X-MS-TrafficTypeDiagnostic: MN2PR12MB3775:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB37754981DB92DF4B602C1B0795769@MN2PR12MB3775.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RXrFbtmDjTC+m6FiIVddH5kVmtmULp+XmXtxszqm8BtJqDfhXJMHq311AiTJKftLtQGNvntDycU2c3cF/PQJwtAnlOEGHdB1yjZsHycwIMpYDsvdwD7MvB3cERPxFHd3a/rDDO2ybmbpyiLegJiYHl1XFVJirU0583bJx/gFyV2JgyFFL7zo9dWq9rJco7H0Khr03ve70f2Y3r1e83rg/r5a+axUEqE62WcP0dqbuxFmgBrVdphIpeAOKRy7QmEwsw+LDfgA2a2KU5Kks3CETiRPmugEp4Kg5TWcuA0NC5c1Y8UQDmNUka8swvUF0yHcjD/XH3szTN4pDlktIll6kKnoKeRTHD10sM9XbeHrFN11qqOVAIsb/CqEwMfrR+TXt/6ETKHb63AzrW8qCukMeBHe2LGUsResqF6fPyx63O/vyR/xhUS5h2/fKZJsPC61Iz8xAlKgmXz+J/8GldhksUJidjbEBDt9/bFpEqTp1T81k4lhmCwXHbMCAZN4cF1UhYtfoY5EgVl30J00Scu6A/Q7HdIEVtCD2ZdGF21V2m5ffL8h8tvZonOtnIVGHfPmgKQJZpnTqK/4nACVqA2kgJUk3j/6caqizXdEWiTGYYH4lYIKW1qjFGLjHMGlSr60cRrsPBbbjNOxtZN4B6j+z4zLgH119puLkoZYAPcRTHEpAYNZpGDQgoeDll4g7Wr7EtYgbSU6hcp+hQBeSh8i/a2u1jRfyucHx5UMizFR388s1mTSsPly0mgsm83igW3Q4N/3RBSWfbNMJCoiKGwvKAUq3bplANsb/0yPXrzs4em41s8p1LVi+qDZTp/7dLHPQd6n7PM3RyZGPaMC6rDo8O2epn2z3vvCKHaQ/hhLW6gp0DwnJA+yW4Zu08q+pAFt
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(37006003)(47076005)(8676002)(966005)(5660300002)(7416002)(356005)(7406005)(2616005)(40460700001)(44832011)(6636002)(54906003)(336012)(4001150100001)(8936002)(36860700001)(86362001)(45080400002)(426003)(83380400001)(81166007)(36756003)(82310400004)(16526019)(6862004)(70586007)(508600001)(70206006)(1076003)(316002)(6666004)(26005)(2906002)(186003)(4326008)(53546011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 17:52:04.7206
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48defd6f-6ab8-43d5-9e8b-08d9bff39b03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3775
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Dec 15, 2021 at 08:43:23AM -0600, Tom Lendacky wrote:
> On 12/14/21 6:14 PM, Venu Busireddy wrote:
> > On 2021-12-14 20:10:16 +0100, Borislav Petkov wrote:
> > > On Tue, Dec 14, 2021 at 11:46:14AM -0600, Venu Busireddy wrote:
> > > > What I am suggesting should not have anything to do with the boot stage
> > > > of the kernel.
> > > 
> > > I know exactly what you're suggesting.
> > > 
> > > > For example, both these functions call native_cpuid(), which is declared
> > > > as an inline function. I am merely suggesting to do something similar
> > > > to avoid the code duplication.
> > > 
> > > Try it yourself. If you can come up with something halfway readable and
> > > it builds, I'm willing to take a look.
> > 
> > Patch (to be applied on top of sev-snp-v8 branch of
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2FAMDESE%2Flinux.git&amp;data=04%7C01%7Cthomas.lendacky%40amd.com%7Cbff83ee03b1147c39ea808d9bf5fe9d8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637751240978266883%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=D8t%2FwXY%2FYIl8aJXN%2BU7%2Flubln8AbhtdgB0f4DCNWp4w%3D&amp;reserved=0) is attached at the end.
> > 
> > Here are a few things I did.
> > 
> > 1. Moved all the common code that existed at the begining of
> >     sme_enable() and sev_enable() to an inline function named
> >     get_pagetable_bit_pos().
> > 2. sme_enable() was using AMD_SME_BIT and AMD_SEV_BIT, whereas
> >     sev_enable() was dealing with raw bits. Moved those definitions to
> >     sev.h, and changed sev_enable() to use those definitions.
> > 3. Make consistent use of BIT_ULL.
> > 
> > Venu
> > 
> > 
> > diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> > index c2bf99522e5e..b44d6b37796e 100644
> > --- a/arch/x86/boot/compressed/sev.c
> > +++ b/arch/x86/boot/compressed/sev.c
> > @@ -291,6 +291,7 @@ static void enforce_vmpl0(void)
> >   void sev_enable(struct boot_params *bp)
> >   {
> >   	unsigned int eax, ebx, ecx, edx;
> > +	unsigned long pt_bit_pos;	/* Pagetable bit position */
> >   	bool snp;
> >   	/*
> > @@ -299,26 +300,8 @@ void sev_enable(struct boot_params *bp)
> >   	 */
> >   	snp = snp_init(bp);
> > -	/* Check for the SME/SEV support leaf */
> > -	eax = 0x80000000;
> > -	ecx = 0;
> > -	native_cpuid(&eax, &ebx, &ecx, &edx);
> > -	if (eax < 0x8000001f)
> > -		return;
> > -
> > -	/*
> > -	 * Check for the SME/SEV feature:
> > -	 *   CPUID Fn8000_001F[EAX]
> > -	 *   - Bit 0 - Secure Memory Encryption support
> > -	 *   - Bit 1 - Secure Encrypted Virtualization support
> > -	 *   CPUID Fn8000_001F[EBX]
> > -	 *   - Bits 5:0 - Pagetable bit position used to indicate encryption
> > -	 */
> > -	eax = 0x8000001f;
> > -	ecx = 0;
> > -	native_cpuid(&eax, &ebx, &ecx, &edx);
> > -	/* Check whether SEV is supported */
> > -	if (!(eax & BIT(1))) {
> > +	/* Get the pagetable bit position if SEV is supported */
> > +	if ((get_pagetable_bit_pos(&pt_bit_pos, AMD_SEV_BIT)) < 0) {
> >   		if (snp)
> >   			error("SEV-SNP support indicated by CC blob, but not CPUID.");
> >   		return;
> > @@ -350,7 +333,7 @@ void sev_enable(struct boot_params *bp)
> >   	if (snp && !(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
> >   		error("SEV-SNP supported indicated by CC blob, but not SEV status MSR.");
> > -	sme_me_mask = BIT_ULL(ebx & 0x3f);
> > +	sme_me_mask = BIT_ULL(pt_bit_pos);
> >   }
> >   /* Search for Confidential Computing blob in the EFI config table. */
> > diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> > index 2c5f12ae7d04..41b096f28d02 100644
> > --- a/arch/x86/include/asm/processor.h
> > +++ b/arch/x86/include/asm/processor.h
> > @@ -224,6 +224,43 @@ static inline void native_cpuid(unsigned int *eax, unsigned int *ebx,
> >   	    : "memory");
> >   }
> > +/*
> > + * Returns the pagetable bit position in pt_bit_pos,
> > + * iff the specified features are supported.
> > + */
> > +static inline int get_pagetable_bit_pos(unsigned long *pt_bit_pos,
> > +					unsigned long features)
> 
> I'm not a fan of this name. You are specifically returning the encryption
> bit position but using a very generic name of get_pagetable_bit_pos() in a
> very common header file. Maybe something more like get_me_bit() and move the
> function to an existing SEV header file.
> 
> Also, this can probably just return an unsigned int that will be either 0 or
> the bit position, right?  Then the check above can be for a zero value,
> e.g.:
> 
> 	me_bit = get_me_bit();
> 	if (!me_bit) {
> 
> 	...
> 
> 	sme_me_mask = BIT_ULL(me_bit);
> 
> That should work below, too, but you'll need to verify that.

I think in the greater context of consolidating all the SME/SEV setup
and re-using code, this helper stands a high chance of eventually becoming
something more along the lines of sme_sev_parse_cpuid(), since otherwise
we'd end up re-introducing multiple helpers to parse the same 0x8000001F
fields if we ever need to process any of the other fields advertised in
there. Given that, it makes sense to reserve the return value as an
indication that either SEV or SME are enabled, and then have a
pass-by-pointer parameters list to collect the individual feature
bits/encryption mask for cases where SEV/SME are enabled, which are only
treated as valid if sme_sev_parse_cpuid() returns 0.

So Venu's original approach of passing the encryption mask by pointer
seems a little closer toward that end, but I also agree Tom's approach
is cleaner for the current code base, so I'm fine either way, just
figured I'd mention this.

I think needing to pass in the SME/SEV CPUID bits to tell the helper when
to parse encryption bit and when not to is a little bit awkward though.
If there's some agreement that this will ultimately serve the purpose of
handling all (or most) of SME/SEV-related CPUID parsing, then the caller
shouldn't really need to be aware of any individual bit positions.
Maybe a bool could handle that instead, e.g.:

  int get_me_bit(bool sev_only, ...)

  or

  int sme_sev_parse_cpuid(bool sev_only, ...)

where for boot/compressed sev_only=true, for kernel proper sev_only=false.
