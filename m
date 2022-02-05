Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC0C4AAA1D
	for <lists+linux-efi@lfdr.de>; Sat,  5 Feb 2022 17:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357864AbiBEQYL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 5 Feb 2022 11:24:11 -0500
Received: from mail-dm6nam10on2082.outbound.protection.outlook.com ([40.107.93.82]:38945
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243355AbiBEQYK (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 5 Feb 2022 11:24:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qc+kM9hZgjxPDPlcDa41s4MNkOtaMMn0HjkJH0oH9YfdcPGQXY68ZvV9UbfMbcaHlC//UlG8IEuWxANLnBmJQ4GsUfCv/f9PTwP9Xt1FZCJ8g5hBdMc6ucPth8duiwT0g7D0lx3R0rmcbIyD9S4BMK98QV022lSjwJGx/fMpK6odb1kzzfESTdK7wp2OosW2qqznK1B0jqJ2HDgFPAp652at32Hs7wOxo/rpaLmpfQNPnF5bK7BtHnnfFhkAHUWNvUhzrjNlg1vr+SmcVal+NF3gYd0OPIy0mCMSouCbztubRLTy936El4Awa2PaVB9pBI1tGL+zaZw//kNaGbWbxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Str507xKElpvWPFEd83PNNJxPBek4EWKEIAX2SuhclA=;
 b=I6FgY0x7NJqOQsSavH1gSW+lwiy++76oHfY7ZKWWuieXa7ujPVmOrAQsZgEUqtMVYYoEIa0PWvyP0si1SMY0OBEIfAi56xot7bo1pZGPA08z1T8b/J/iwjmbGmMhLoei68Yx44TnsDjHiP1Pt/MNI6eYOgY7FOmORzhe9TS87Qhfh42pJVzH75/KyRbLXD4rTEL8MZLM3rYn2au1ViBQcV5XTAsI6HjD89I8ZSuAt3Ldj1bcq1W5/JQ00yE7gptnXek0SJQtX4sOHWJ32EKgqWkt0pAIHZ7mIhpd95PCvXJg7Hg97w1yK72YjIXhJArfBZePxF5HPUKNQ6S6x2uF3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Str507xKElpvWPFEd83PNNJxPBek4EWKEIAX2SuhclA=;
 b=HvpQXs4qATbMYgxvkLc4WCUAWZJxHTwsrGLXldCjVqq6taKLTApskvIsfvsWxf4gFeOaMLN4lxk39yF4jjLKtktJyOEWu+N301g3ape87UqIYXnb7HJ/97b9Jd+e7y6Ws07Lb1+A2Iwi/ptXKu3GLPGapOAPTfEllLKbh1xYF/U=
Received: from DM5PR21CA0039.namprd21.prod.outlook.com (2603:10b6:3:ed::25) by
 BYAPR12MB3095.namprd12.prod.outlook.com (2603:10b6:a03:a9::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.11; Sat, 5 Feb 2022 16:24:07 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ed:cafe::f9) by DM5PR21CA0039.outlook.office365.com
 (2603:10b6:3:ed::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.2 via Frontend
 Transport; Sat, 5 Feb 2022 16:24:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Sat, 5 Feb 2022 16:24:05 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sat, 5 Feb
 2022 10:24:04 -0600
Date:   Sat, 5 Feb 2022 09:42:43 -0600
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
        <marcorr@google.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v9 31/43] x86/compressed/64: Add support for SEV-SNP
 CPUID table in #VC handlers
Message-ID: <20220205154243.s33gwghqwbb4efyl@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3b8e5d94-7f7a-4b9d-b816-08d9e8c3ede6
X-MS-TrafficTypeDiagnostic: BYAPR12MB3095:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3095548C0402C28981E00DE9952A9@BYAPR12MB3095.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TCYb0lQdYVZqdwvgokFRhFi+iJgMx+X90GpzAQrxoWJTDfmOHtJ6vivEnQQqIIpDQEp2JJ0/Kl6oCJfjJ0sJzpGP/86avNSvOC24g496nPQEfes0Pt0GjVeSymb8JyQE2H4zup9MJlLzyUc8B18kkSDVZEfbGkN8vsXYJD683AQawP/M8Mbjt2odMcIToP0R6TN7zE8dIiqLLy6f0GYOB4sbCwaWHQv/kPFOS9sg2YZw4fNJWF7O1OQEyS99GjHJpuqX+eZChHkdXb+n9xk8+BXksyT/8I/ECWJJz5L3eqoiZ7NQ6rs3jgflzwKAVEZE+PouFNLQEIdrF8a7K6PXnJqDCUWXhWayOFIUCncuxeZLHXfqu6j3dzbkOtQjXKQG4xPeo4PdCg/oyOn+NxtcDnMyKLYU6E1H9CM2dt31tcChJZjgoQQnMy4RKCjF5ObIMP5zHh+bybKTM2xy0gkbJn9px6pwCDy+VXufQkrR4kyfgaD+S5XXo/mVrdvMOGzeNoazukHkrTqGnWtv5YGzpvXAsd/PkWOuJjE5TLrSw5eGHViseEEEnX9VdzvVX8Q6Q5TTptCFbgXY2e+WCOkVv7XgbHch4eqeXbRBoB/GPngfmR16DsmoK3qxXpguQFM1ujbYvUFnLfyvytoqwJUq+n0Cxk85FUmLqBXK+yZ1iJLNWJYdnPUm3ePQYQw42qr/JeRc2wNZZ2HCRVSoMP4ppg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36860700001)(70586007)(70206006)(6666004)(1076003)(4326008)(8676002)(8936002)(44832011)(86362001)(26005)(186003)(316002)(81166007)(47076005)(82310400004)(16526019)(336012)(40460700003)(7416002)(5660300002)(7406005)(426003)(356005)(6916009)(2616005)(83380400001)(508600001)(2906002)(54906003)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2022 16:24:05.6129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b8e5d94-7f7a-4b9d-b816-08d9e8c3ede6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3095
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Feb 05, 2022 at 11:54:01AM +0100, Borislav Petkov wrote:
> On Fri, Jan 28, 2022 at 11:17:52AM -0600, Brijesh Singh wrote:
> > +/*
> > + * Individual entries of the SEV-SNP CPUID table, as defined by the SEV-SNP
> > + * Firmware ABI, Revision 0.9, Section 7.1, Table 14.
> > + */
> > +struct snp_cpuid_fn {
> > +	u32 eax_in;
> > +	u32 ecx_in;
> > +	u64 xcr0_in;
> > +	u64 xss_in;
> 
> So what's the end result here:
> 
> -+	u64 __unused;
> -+	u64 __unused2;
> ++	u64 xcr0_in;
> ++	u64 xss_in;
> 
> those are not unused fields anymore but xcr0 and xss input values?
> 
> Looking at the FW abi doc, they're only mentioned in "Table 14.
> CPUID_FUNCTION Structure" that they're XCR0 and XSS at the time of the
> CPUID execution.
> 
> But those values are input values to what exactly, guest or firmware?

These are inputs to firmware, either through a MSG_CPUID_REQ guest
message that gets passed along by the HV to firmware for validation,
or, in this case, through SNP_LAUNCH_UPDATE when the HV passes the
initial CPUID table contents to firmware for validation before it
gets mapped into guest memory.

> 
> There's a typo in the FW doc, btw:
> 
> "The guest constructs an MSG_CPUID_REQ message as defined in Table 13.
> This message contains an array of CPUID function structures as defined
> in Table 13."
> 
> That second "Table" is 14 not 13.
> 
> So, if an array CPUID_FUNCTION[] is passed as part of an MSG_CPUID_REQ
> command, then, the two _IN variables contain what the guest received
> from the HV for XCR0 and XSS values. Which means, this is the guest
> asking the FW whether those values the HV gave the guest are kosher.
> 
> Am I close?

Most of that documentation is written in the context of the
MSG_CPUID_REQ guest message interface. In that case, a guest has been
provided a certain sets of CPUID values by KVM CPUID instruction
emulation (or potentially the CPUID table), and wants firmware to
validate whether all/some of them are valid for that particular
system/configuration.

In the case of 0xD subfunction 0x0 and 0x1, the CPUID leaf on real
hardware will change depending on what the guest sets in its actual
XCR0 control register (APM Volume 2 11.5.2) or IA32_XSS_MSR register,
whose combined bits are OR'd to form the XFEATURE_ENABLED_MASK.

CPUID leaf 0xD subfunctions 0x0 and 0x1 advertise the size of the
XSAVE area required for the features currently enabled in
XFEATURE_ENABLED_MASK via the EBX return value from the corresponding
CPUID instruction, so for firmware to validate whether that EBX value
is valid for a particular system/configuration, it needs to know
what the guest's currently XFEATURE_ENABLED_MASK is, so it needs to
know what the guest has set in its XCR0 and IA32_XSS_MSR registers.

That's where the XCR0_IN and XSS_IN inputs come into play: they are
inputs to the firmware so it can do the proper validation based on
the guest's current state / XFEATURE_ENABLED_MASK.

But that guest message interface will likely be deprecated at some
point in favor of the static CPUID table (SNP FW ABI 8.14.2.6),
since all the firmware validation has already been done in advance,
and any additional validation is redundant, so this series relies
purely on the CPUID table.

In the case of the CPUID table, we don't know what the guest's
XFEATURE_ENABLED_MASK is going to be at the time a CPUID instruction
is issued for 0xD:0x0,0xD,0x1, and those values will change as the
guest boots and begins enabling additional XSAVE features. The only
thing that's certain is that there needs to be at least one CPUID
table entry for 0xD:0x0 and 0xD:0x1 corresponding to the initial
XFEATURE_ENABLED_MASK, which will correspond to XCR0_IN=1/XSS_IN=0,
or XCR0_IN=3/XSS_IN=0 depending on the hypervisor/guest
implementation.

What to do about other combinations of XCR0_IN/XSS_IN gets a bit
weird, since encoding all those permutations would not scale well,
and alternative methods of trying to encode them in the table would
almost certainly result in lots of different incompatibile guest
implementations floating around.

So our recommendation has been for hypervisors to encode only the
0xD:0x0/0xD:0x1 entries corresponding to these initial guest states
in the CPUID table, and for guests to ignore the XCR0_IN/XSS_IN
values completely, and instead have the guest calculate the XSAVE
save area size dynamically (EBX). This has multiple benefits:

1) Guests that implement this approach would be compatible even
   with hypervisors that try to encode additional permutations of
   XCR0_IN/XSS_IN in the table based on their read of the spec
2) It is just as secure, since it requires only that the guest
   trust itself and the APM specification, which is the ultimate
   authority on what firmware would be validationa against
3) The other leaf registers, EAX/ECX/EDX are not dependent on
   XCR0_IN/XSS_IN/XFEATURE_ENABLED_MASK, and so any
   0xD:0x0/0xD:0x1 entry will do as the starting point for the
   calculation.

That's why in v8 these fields were documented as unused1/unused2.
But when you suggested that we should enforce 0 in that case, it
became clear we should adjust our recommendation to go ahead and
check for the specific XCR0_IN={1,3}/XSS_IN=0 values when
searching for the base 0xD:0x0/0xD:0x1 entry to use, because a
hypervisor that chooses to use XCR0_IN/XSS_IN is not out-of-spec,
and should be supported, and there isn't really any read of the
spec from the hypervisor perspective where XCR0_IN=0/XSS_IN=0
would be valid.

So for v9 I went ahead and added the XCR0_IN/XSS_IN checks, and
updated our recommendations (will send an updated version to
SNP mailing list by Monday) to not ignore them in the guest.

I added some comments in snp_cpuid_get_validated_func() and
snp_cpuid_calc_xsave_size() to clarify how XCR0_IN/XSS_IN are
being used there, but let me know if those need to be beefed up
a bit.

-Mike
