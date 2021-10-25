Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96032439BAB
	for <lists+linux-efi@lfdr.de>; Mon, 25 Oct 2021 18:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbhJYQiX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 25 Oct 2021 12:38:23 -0400
Received: from mail-mw2nam12on2069.outbound.protection.outlook.com ([40.107.244.69]:45472
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232526AbhJYQiX (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 25 Oct 2021 12:38:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNzQtoElNHIMh/D2c8OWmWpDsq2F4aHCVLQCCbPrKlhzWzaDNc4VrV0yzOc+fFgIZv779iKuxCmkvk6IeZtvX8qG3g/FZ60bWJUCVzWhH+FCQG5ngKDf5lg/eqA8uPhRw1m6ZtD6R3YMsJsgFImTNPSA6WRR333ircxqQHWEDch2xoeUOvU3QVQuy8iXH2dQIp58eLtG9rCwdh8utQNXkRGPZqA5i7j2AkFb2rjiljh7Zivxq1LQpzDT5jQvyGeJqvYNNgJKNKnopVff1kPQC3lyhFNRmjQYVGMI2x7N+gbfP/WqOu0bo8v5Vn5jZUevntAMHdZhigvja1JrkPhkGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8OzXdvqpdppUhbZQiqVrBcxRN8JmC66LS6cHqbBjmQg=;
 b=NStx7W5un4abmH+OXVWuES4glxGkyneCA7lGbFooitEtxe+S/AQ+ebqjHvsOZaP55sL6jBNNh65VTP5a0nTiL+QuhvKazSxCx89xsvNLhL2j8Vr3gqoA+KeTOs+4g8RhpU/WMLjN4LX7Xrtf3Y2Lqc3/g4vRNaZTCkAeWvNc5kGYCZnFP6TuzwQ8wg8YOgPzDvs6Dlnxathx53AsKuyDimLuGQTYo0e4ayMC/Rod62PBsHNoGnUUFGDRyzF1NWiKCdNSqwfOMUtygu0d6ToAZKkU1UixKFIbSkEqYmf4Vk8J0OwUFOlkml6lZ8bWcePgZnlb32zHlvJZ7sTsNfuwLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OzXdvqpdppUhbZQiqVrBcxRN8JmC66LS6cHqbBjmQg=;
 b=dr7nye3N4Pz+IJ/OjJiHE6uh8gZywEQDZ7uu10qJXno5sQ3v9/ePtJht7ZT6gokyY3Ae7MS6uy65WEtu3OjXRH2b3qLMTa4CyRjdgeQVRm0+i70OGquXseVl/K8MIblEfVj8tqZYC93l52YsdJAK6MgC47+QyATn6wepxha+FS0=
Received: from MWHPR07CA0020.namprd07.prod.outlook.com (2603:10b6:300:116::30)
 by DM6PR12MB3258.namprd12.prod.outlook.com (2603:10b6:5:187::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Mon, 25 Oct
 2021 16:35:57 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:116:cafe::5e) by MWHPR07CA0020.outlook.office365.com
 (2603:10b6:300:116::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Mon, 25 Oct 2021 16:35:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Mon, 25 Oct 2021 16:35:56 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 25 Oct
 2021 11:35:55 -0500
Date:   Mon, 25 Oct 2021 11:35:18 -0500
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
Message-ID: <20211025163518.rztqnngwggnbfxvs@amd.com>
References: <20211008180453.462291-1-brijesh.singh@amd.com>
 <20211008180453.462291-9-brijesh.singh@amd.com>
 <YW2EsxcqBucuyoal@zn.tnic>
 <20211018184003.3ob2uxcpd2rpee3s@amd.com>
 <YW3IdfMs61191qnU@zn.tnic>
 <20211020161023.hzbj53ehmzjrt4xd@amd.com>
 <YXF+WjMHW/dd0Wb6@zn.tnic>
 <20211021204149.pof2exhwkzy2zqrg@amd.com>
 <YXaPKsicNYFZe84I@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YXaPKsicNYFZe84I@zn.tnic>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ade8967-52a8-401e-ddf1-08d997d584d5
X-MS-TrafficTypeDiagnostic: DM6PR12MB3258:
X-Microsoft-Antispam-PRVS: <DM6PR12MB32581D403B3BAD5B2EA6583495839@DM6PR12MB3258.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KUdUEepCBXMNLP1PLPj24zdS+OjZQRVgkR/iKf66x+FgDZuF0HldDVvarc/U5arPXg7DgwIY/mldbDsSYZB+GZj3xFJYGJugrKRcMEXwrSeaMAJOI2XFHmRM+GBuRcbWNiDiP785mT9UNEP4ufXtH2TvH6hVsZ8pnCbol7Y1qDaRUaWsoIY8jETakWGvRkJ5akQv1Gnkd05JhF2Iw2NyMWuRJAXUgUoF/Pb0WZeKZYLv4lFT24IcnY5dpC2/pwCf0rARdZn8qF9mWTspyMXf4g5tc2iUt+/myMNksqKDyAOMZURXPY1H8MpW3U4Ip1keRSZ5DdY6tJsUWqJ9lgEJQ2ySgeqvXeO5R9QwtqnYCDGLgU4/BTF9i7I95YKgbPwfUaRk1xR1ctGDYefP6CZeeO6Hv5A8LySLz3VtsFNNLbCciro6ZUVHIjqk3Av+E9awdiJgsEu313YyrF9OnlyLV8T4Uaillh/DIZfzoDNMOsIfTNFtMIN1lx7p53eW3N6RVlwO8sh6G0zB/V/HRFRut0FGkp6Wc7vqGq/KtNrQeOOxQwTbzd56v/f8ano9/ki++qOpny6IdCqhF9DlRQ+weDrqyMsgPPUliBox3SyvyYlvmY82aTqxvzH3ORJdwIoWuj4pYSVFT42quuX3FbVF3ZD7Q5/m2UnVzdqd6CptJQZq+s4aCyoWPCAYTegeUvEaefsHvS/plY0c/d/aM/JHGB0gfvJHXYX2Eaw7kn+7Lguw4iV6wLeMBPrg/YWl5Rrk0mRbwV68T/PpTf7xK2awyZqTy+39jtFYqVuURBcdHUAWiU4iGq6oFokqfWL8G87b
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(36860700001)(8936002)(44832011)(2906002)(16526019)(4326008)(6666004)(47076005)(7416002)(54906003)(5660300002)(7406005)(8676002)(81166007)(36756003)(1076003)(356005)(186003)(70206006)(508600001)(6916009)(45080400002)(83380400001)(70586007)(316002)(426003)(966005)(18074004)(336012)(26005)(3716004)(2616005)(86362001)(82310400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 16:35:56.0433
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ade8967-52a8-401e-ddf1-08d997d584d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3258
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Oct 25, 2021 at 01:04:10PM +0200, Borislav Petkov wrote:
> On Thu, Oct 21, 2021 at 03:41:49PM -0500, Michael Roth wrote:
> > On Thu, Oct 21, 2021 at 04:51:06PM +0200, Borislav Petkov wrote:
> > > On Wed, Oct 20, 2021 at 11:10:23AM -0500, Michael Roth wrote:
> > > > The CPUID calls in snp_cpuid_init() weren't added specifically to induce
> > > > the #VC-based SEV MSR read, they were added only because I thought the
> > > > gist of your earlier suggestions were to do more validation against the
> > > > CPUID table advertised by EFI
> > > 
> > > Well, if EFI is providing us with the CPUID table, who verified it? The
> > > attestation process? Is it signed with the AMD platform key?
> > 
> > For CPUID table pages, the only thing that's assured/attested to by firmware
> > is that:
> > 
> >  1) it is present at the expected guest physical address (that address
> >     is generally baked into the EFI firmware, which *is* attested to)
> >  2) its contents have been validated by the PSP against the current host
> >     CPUID capabilities as defined by the AMD PPR (Publication #55898),
> >     Section 2.1.5.3, "CPUID Policy Enforcement"
> >  3) it is encrypted with the guest key
> >  4) it is in a validated state at launch
> > 
> > The actual contents of the CPUID table are *not* attested to,
> 
> Why?

As counter-intuitive as it sounds, it actually doesn't buy us if the CPUID
table is part of the PSP attestation report, since:

 - the boot stack is attested to, and if the boot stack isn't careful to
   use the CPUID table at all times, then attesting CPUID table after
   boot doesn't provide any assurance that the boot wasn't manipulated
   by CPUID
 - given the boot stack must take these precautions, guest-specific
   attestation code is just as capable of attesting the CPUID table
   contents/values, since it has the same view of the CPUID values that
   were used during boot.

So leaving it to the guest owner to attest it provides some flexibility
to guest owners to implement it as they see fit, whereas making it part
of the attestation report means that the guest needs the exact contents
of the CPUID page for a particular guest configuration so it can be
incorporated into the measurement they are expecting, which would likely
require some tooling provided by the cloud vendor, since every different
guest configuration, or even changes like the ordering in which entries
are placed in the table, would affect measurement, so it's not something
that could be easily surmised separately with minimal involvement from a
cloud vendor.

And even if the cloud vendor provided a simple way to export the table
contents for measurement, can you really trust it? If you have to audit
individual entries to be sure there's nothing fishy, why not just
incorporate those checks into the guest owner's attestation flow and
leave the vendor out of it completely?

So not including it in the measurement meshes well with the overall
SEV-SNP approach of reducing the cloud vendor's involvement in the
overall attestation process.

> 
> > so in theory it can still be manipulated by a malicious hypervisor as
> > part of the initial SNP_LAUNCH_UPDATE firmware commands that provides
> > the initial plain-text encoding of the CPUID table that is provided
> > to the PSP via SNP_LAUNCH_UPDATE. It's also not signed in any way
> > (apparently there were some security reasons for that decision, though
> > I don't know the full details).
> 
> So this sounds like an unnecessary complication. I'm sure there are
> reasons to do it this way but my simple thinking would simply want the
> CPUID page to be read-only and signed so that the guest can trust it
> unconditionally.

The thing here is that it's not just a specific CPUID page that's valid
for all guests for a particular host. Booting a guest with additional
vCPUs changes the contents, different CPU models/flags changes the
contents, etc. So it needs to be generated for each specific guest
configuration, and can't just be a read-only page.

Some sort of signature that indicates the PSP's stamp of approval on a
particular CPUID page would be nice, but we do sort of have this in the
sense that CPUID page 'address' is part of measurement, and can only
contain values that were blessed by the PSP. The problem then becomes
ensuring that only that address it used for CPUID lookups, and that it's
contents weren't manipulated in a way where it's 'valid' as far as the
PSP is concerned, but still not the 'expected' values for a particular
guest (which is where the attestation mentioned above would come into
play).

> 
> > [A guest owner can still validate their CPUID values against known good
> > ones as part of their attestation flow, but that is not part of the
> > attestation report as reported by SNP firmware. (So long as there is some
> > care taken to ensure the source of the CPUID values visible to
> > userspace/guest attestion process are the same as what was used by the boot
> > stack: i.e. EFI/bootloader/kernel all use the CPUID page at that same
> > initial address, or in cases where a copy is used, that copy is placed in
> > encrypted/private/validated guest memory so it can't be tampered with during
> > boot.]
> 
> This sounds like the good practices advice to guest owners would be,
> "Hey, I just booted your SNP guest but for full trust, you should go and
> verify the CPUID page's contents."
> 
> "And if I were you, I wouldn't want to run any verification of CPUID
> pages' contents on the same guest because it itself hasn't been verified
> yet."
> 
> It all sounds weird.

Yes, understandably so. But the only way to avoid that sort of weirdness
in general is for *all* guest state to be measured, all pages, all
registers, etc. Baking that directly into the SEV-SNP attestation report
would be a non-starter for most since computing the measurement for all
that state independently would require lots of additional inputs from
cloud vendor (who we don't necessarily trust in the first place), and
constant updates of measurement values since they would change with
every guest configuration change, every different starting TSC offset,
different, maybe the order in which vCPUs were onlined, stuff that the
kernel prints to log buffers, etc.

But, if a guest owner wants to attempt clever ways to account for some/all
of that in their attestation flow, they are welcome to try. That's sort of
the idea behind SNP attestation vs. SEV. Things like page
validation/encryption, cpuid enforcement, etc., reduce some of the
variables/possibilities guest owners need to account for during attestation
to make the process more secure/tenable, but they don't rule out all
possibilities, just as Trusted Boot doesn't necessarily mean you can fully
trust your OS state immediately afer boot; there are still outside
influences at play, and the boot stack should guard against them
wherever possible.

> 
> > So, while it's more difficult to do, and the scope of influence is reduced,
> > there are still some games that can be played to mess with boot via
> > manipulation of the initial CPUID table values, so long as they are within
> > the constraints set by the CPUID enforcement policy defined in the PPR.
> > 
> > Unfortunately, the presence of the SEV/SEV-ES/SEV-SNP bits in 0x8000001F,
> > EAX, are not enforced by PSP. The only thing enforced there is that the
> > hypervisor cannot advertise bits that aren't supported by hardware. So
> > no matter how much the boot stack is trusted, the CPUID table does not
> > inherit that trust, and even values that we *know* should be true should be
> > verified rather than assumed.
> > 
> > But I think there are a couple approaches for verifying this is an SNP
> > guest that are robust against this sort of scenario. You've touched on
> > some of them in your other replies, so I'll respond there.
> 
> Yah, I guess the kernel can do good enough verification and then the
> full thing needs to be done by the guest owner and in *some* userspace
> - not necessarily on the currently booted, unverified guest - but
> somewhere, where you have maximal flexibility.

Exactly, moving attestation into the guest allows for more of the these
unexpected states to be accounted for at whatever level of paranoia a guest
owner sees fit, while still allowing firmware to provide some basic
assurances via attestation report and various features to reduce common
attack vectors during/after boot.

> 
> IMHO.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7CMichael.Roth%40amd.com%7Cd9f9c20a37ce4a4b0e0608d997a72f6a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637707566641580997%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=OmfuUZfcf3bkC%2FmSsiInQ1vScK5Onu1lHWAUH3o%2FUmE%3D&amp;reserved=0
