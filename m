Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 245E3493238
	for <lists+linux-efi@lfdr.de>; Wed, 19 Jan 2022 02:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350601AbiASBSe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Jan 2022 20:18:34 -0500
Received: from mail-co1nam11on2070.outbound.protection.outlook.com ([40.107.220.70]:14471
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238605AbiASBSd (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 18 Jan 2022 20:18:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4PBFjB+3nBFgS9ZkAetpK3xHt17dSJ7QXKDPySrMs5T+F+Di4m9KZatSsnZQ/cLhZ0yukDZiMMfzejBnt8FDjSXnr7AtAMvOBBTMRVOYSD2GKZLXbKlsOj3OsGB3SFHkomSCmYDZbYSCmzbFoNpDjesT2UWv5Q/hbkcD1SJkw+dYgfObAkagUby2emWgRYYbc3hVpDMff2h8dU429TurRmx2JO5odf/7i1dQhQcFzVDvf8xH21cIaNFQKlV32RbnG5QCWdeUYYmyiYyCsftTttAnroWMTpzapTPzRjC8xm2nFlm6z53IhBoTMyEprADQGCwbcO2S5PpYOorcRaOYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqvCQLTZkIfD6QpHY8rNtMGQ6189mSy+Rf5pFonC+F4=;
 b=FsGe/8bEzXpJB1QeUb79DpDb4ASs75fxiqlf0d8ad9aFvS6QwQEugQbz0gmeFenWqdWerq6h84p+MR83JrqSHy8iBoGn1TqNMu0XTPK7I/mNlPlu8bc8Ur2DR2gdcGMfcLSjvo80TMHAIhx1KAsfXVJLPz5lWL66krDsabueoeGnGuaOdtOr6r6VvqndjXfbsTheqJdIZiwVbWUrmamwvgLxbZxnUXoPHB0ooS7EOZaH+P7qg4XHJP2JsX9RprZdKV7UHX6INrawviAz+ATf9ZxAEVpJ+WzPZD4GHYuoKU0kFGpJS06dzbIRGQ/TOBnwYPpPL6uOqvrxWz8Nat2y8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqvCQLTZkIfD6QpHY8rNtMGQ6189mSy+Rf5pFonC+F4=;
 b=JZcllDf4pnhpmdK/9ItP426msdoQgmbBMvxjvGdP+9p+QHgXrLVlPhpjoEs2pwu147Qyy0CPWffwWRqDlr30sCFmEgxLTtUEfUyLy9+/pj1cx7N3RjMLGf4Ohto+5JsH6/S3eAMmBlL4OprsTRa8LyhZVMno8cASXjOxFUcW8M0=
Received: from BN6PR11CA0070.namprd11.prod.outlook.com (2603:10b6:404:f7::32)
 by CH0PR12MB5089.namprd12.prod.outlook.com (2603:10b6:610:bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 19 Jan
 2022 01:18:31 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:f7:cafe::9f) by BN6PR11CA0070.outlook.office365.com
 (2603:10b6:404:f7::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7 via Frontend
 Transport; Wed, 19 Jan 2022 01:18:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Wed, 19 Jan 2022 01:18:30 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 18 Jan
 2022 19:18:29 -0600
Date:   Tue, 18 Jan 2022 19:18:06 -0600
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
Message-ID: <20220119011806.av5rtxfv4et2sfkl@amd.com>
References: <YeGhKll2fTcTr2wS@zn.tnic>
 <20220118043521.exgma53qrzrbalpd@amd.com>
 <YebIiN6Ftq2aPtyF@zn.tnic>
 <20220118142345.65wuub2p3alavhpb@amd.com>
 <20220118143238.lu22npcktxuvadwk@amd.com>
 <20220118143730.wenhm2bbityq7wwy@amd.com>
 <YebsKcpnYzvjaEjs@zn.tnic>
 <20220118172043.djhy3dwg4fhhfqfs@amd.com>
 <Yeb7vOaqDtH6Fpsb@zn.tnic>
 <20220118184930.nnwbgrfr723qabnq@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220118184930.nnwbgrfr723qabnq@amd.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c8197a3-5fdc-4d2c-b54a-08d9dae99ab8
X-MS-TrafficTypeDiagnostic: CH0PR12MB5089:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5089DA1DCB8E4F54095E00B595599@CH0PR12MB5089.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kQ2mFLt+XU1EwoxmefkJ7EWhb1MFzbg3w7/E+jfoOub3uRs3lRjOQElqDM/HG8AKhEfIXcvrVSnDFxnTMbjJ30tctSnQv5W8NqBhBP512RaVEgBdT4/sSAP2Np5gqAaLdikO+JzMdB05RYKTTZ+qz+DSd+PY/eLBrkkyrfKq+FRBq/2IrfTE3HahqtYgzt2SATWxZuveGfvaiMAWoZfDxSTCIeN/y0FIRmzkBfoPRMkeMiWulCZmc5zbCvVtHbN8gkNmoWXWBEK1gvR2diqf8X0K0Q6iPuWHvYymbtD2mlF3KkhiLj0Ve3XdntOomfeUbokK+6rwCDYMhcE/EXiHcF0a0ceFs9GynSV2BV50w1IATSL5HUKtiDi7F51GjANtRu/K9SHyboLunMmZwG1o7YGqxJg7kfKIvVEQwWzxkYBN2iK+hmTgDGwo/mGMOYQNgPRRfOXrlFblvyr4hE+frDoob5XMThgFk35UAyjXshZt7lVJGwzZ/D4ZrcXf7NO0VpofEzR8vWPR0lJlB1/wUKNAKJAIzH2iPtNqYyVgb/0/X63VKyGCk/AMQ0b7LvIOgce2DV7ZJk1w9M4oTYkUDs/Ya8iTeMfAdTCup2OcmRiUv4odW+2Kzcpl08TKOTEvRZSJkSBKG40qxer52rv2MHB/xIG46WTcMxnLdcwvfgDJS55yRW126kl6qHVXRxDJbKUO/v/L7jGTRiwha3dHe463/STxa8B5shwtC8AqcvErdi+T/EpnjRjduJSl3XDYtMFSQR8G+R+KR5jWSlUyzGibTP3+wi9+HZV/pSLA4h4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(40470700002)(46966006)(36840700001)(7416002)(81166007)(70206006)(356005)(2906002)(2616005)(82310400004)(26005)(44832011)(8936002)(336012)(4326008)(40460700001)(6666004)(7406005)(8676002)(316002)(426003)(54906003)(1076003)(47076005)(5660300002)(86362001)(70586007)(36756003)(36860700001)(16526019)(6916009)(508600001)(186003)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 01:18:30.6573
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c8197a3-5fdc-4d2c-b54a-08d9dae99ab8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5089
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jan 18, 2022 at 12:49:30PM -0600, Michael Roth wrote:
> On Tue, Jan 18, 2022 at 06:41:16PM +0100, Borislav Petkov wrote:
> > On Tue, Jan 18, 2022 at 11:20:43AM -0600, Michael Roth wrote:
> > > The HV fills out the initial contents of the CPUID page, which includes
> > > the count. SNP/PSP firmware will validate the contents the HV tries to put
> > > in the initial page, but does not currently enforce that the 'count' field
> > > is non-zero.
> > 
> > And regardless, what if the HV fakes the count - how do you figure out
> > what the proper count is? You go and read the whole CPUID page and try
> > to make sense of what's there, even beyond the "last" function leaf.
> 
> 

<snip>

> > 
> > But see above, how do you check whether the HV hasn't "hidden" some
> > entries by modifying the count field?
> > 
> > Either I'm missing something or this sounds really weird...
> 
> ...count must match the actual number of entries in the table in all
> cases.

Turns out in my testing earlier there was a separate check that was
causing the PSP to fail, so I re-tested the behavior, and things are
actually a bit more interesting, but nothing too concerning:

If 'fake_count'/'reported_count' is greater than the actual number of
entries in the table, 'actual_count', then all table entries up to
'fake_count' will also need to pass validation. Generally the table
will be zero'd out initially, so those additional/bogus entries will
be interpreted as a CPUID leaves where all fields are 0. Unfortunately,
that's still considered a valid leaf, even if it's a duplicate of the
*actual* 0x0 leaf present earlier in the table. The current code will
handle this fine, since it scans the table in order, and uses the
valid 0x0 leaf earlier in the table.

This is isn't really a special case though, it falls under the general
category of a hypervisor inserting garbage entries that happen to pass
validation, but don't reflect values that a guest would normally see.
This will be detectable as part of guest owner attestation, since the
guest code is careful to guarantee that the values seen after boot,
once the attestation stage is reached, will be identical to the values
seen during boot, so if this sort of manipulation of CPUID values
occurred, the guest owner will notice this during attestation, and can
abort the boot at that point. The Documentation patch addresses this
in more detail.

If 'fake_count' is less than 'actual_count', then the PSP skips
validation for anything >= 'fake_count', and leaves them in the table.
That should also be fine though, since guest code should never exceed
'fake_count'/'reported_count', as that's a blatant violation of the
spec, and it doesn't make any sense for a guest to do this. This will
effectively 'hide' entries, but those resulting missing CPUID leaves
will be noticeable to the guest owner once attestation phase is
reached.

This does all highlight the need for some very thorough guidelines
on how a guest owner should implement their attestation checks for
cpuid, however. I think a section in the reference implementation
notes/document that covers this would be a good starting point. I'll
also check with the PSP team on tightening up some of these CPUID
page checks to rule out some of these possibilities in the future.

> in the table. count==0 is only special in that code might erroneously
> decide to treat it as an indicator that cpuid table isn't enabled at
> all, but since that case causes termination it should actually be ok.
> 
> Though I wonder if we should do something like this to still keep
> callers from relying on checking count==0 directly:
> 
>   static const struct snp_cpuid_info *
>   snp_cpuid_info_get_ptr(void)
>   {
>           const struct snp_cpuid_info *cpuid_info;
>           void *ptr;
>   
>           /*
>            * This may be called early while still running on the initial identity
>            * mapping. Use RIP-relative addressing to obtain the correct address
>            * in both for identity mapping and after switch-over to kernel virtual
>            * addresses.
>            */
>           asm ("lea cpuid_info_copy(%%rip), %0"
>                : "=r" (ptr)
>                : "p" (&cpuid_info_copy));
>   
>           cpuid_info = ptr;
>           if (cpuid_info->count == 0)
>                   return NULL
>   
>           return cpuid_info;
>   }

Nevermind, that doesn't work since snp_cpuid_info_get_ptr() is also called
by snp_cpuid_info_get_ptr() *prior* to initializing the table, so it ends
seeing cpuid->count==0 and fails right away. So your initial suggestion
of checking cpuid->count==0 at the call-sites to determine if the table
is enabled is probably the best option.

Sorry for the noise/confusion.
