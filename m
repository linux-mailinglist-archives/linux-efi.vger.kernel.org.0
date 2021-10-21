Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AED743587D
	for <lists+linux-efi@lfdr.de>; Thu, 21 Oct 2021 04:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhJUCKe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 Oct 2021 22:10:34 -0400
Received: from mail-bn8nam08on2061.outbound.protection.outlook.com ([40.107.100.61]:8801
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230363AbhJUCKc (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 20 Oct 2021 22:10:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AqlP9gJx5CG+tNku7+cXJQlAi+DpiOaP0l4DHhMJ+5MkjZozGKiPt8kvXCtvhdwAap7BK80aQ7VsymLNgGo8DSvUcf3yPv9JY5zHzYClENQAxToUQQq/9L1WqZbx/XfkUL51ARmcITUqlKnmK5v7Digcs4GxBG9aXXKYZ8rl2QzWF+3oPEbvONsd3t6zl5ddw25mFwNqNLc3UImeNXLmdvGyd66oWcwBc4vx4stbju3bpL98d7uXbFkeIgA6tKUxEAfAW7w3TxBvIEHRp3hvbJ1le4nDxFa4Hz3K+w9HqwTnGBU7g7xeAsG5Vwc3xEqEZ31w69bB6hJPMdgYu0C5Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Ux9BOYNEyMVH0JGeaQSURCQ2XHuVTURqkZqfAJbqPY=;
 b=mbDwWpRfI295Ls9yIYbwkYmS9qZVPTbmfddtowV/ODjZbqkT0W86Yog0lQk+uNccc2fNXD/7O7CnkRcj3yhV42ay2OKYmMlPtxECNrFpErcAZ6CDWzEBvfxoMcg/tnzg+muMwdgWDJydb/6W7PfF9ldgkRcqez/zLKkjcpIClFvFK+sFJToQ9kMh8OOSxBINy6yTwdjqVMSIvXWY3tS+uUDKQOGMYm2zl7NC22gZXL0LvFMRpgl43b6/7EZ+sXjC8kh5b8Oijkkid2Q1DhVw6hhYNfel7BwoO8/419cBXZA4iHn2vg1zzX1TArqDLt7/xtUmsOudWXPvEnpepnXF8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Ux9BOYNEyMVH0JGeaQSURCQ2XHuVTURqkZqfAJbqPY=;
 b=V/ywVRJHTysu9LvTmR7OwhlyJcdNoczRZBw5Gu/TKzWW1MQ7j9m34/yuo+TlvtArUdbjOPBuLVtqPEB/0hbDtvejheAHVrl6aLZmpwqOaSdlF6phut05Y95AD5yfx+hFJSKiYSSFpM/Ond70UcTubhreB0xKzj8uzsIsBTIF30E=
Received: from BN9PR03CA0345.namprd03.prod.outlook.com (2603:10b6:408:f6::20)
 by BY5PR12MB3825.namprd12.prod.outlook.com (2603:10b6:a03:1a2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Thu, 21 Oct
 2021 02:08:11 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::52) by BN9PR03CA0345.outlook.office365.com
 (2603:10b6:408:f6::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Thu, 21 Oct 2021 02:08:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 02:08:11 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Wed, 20 Oct
 2021 21:08:10 -0500
Date:   Wed, 20 Oct 2021 19:35:35 -0500
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
Message-ID: <20211021003535.ic35p6nnxdmavw35@amd.com>
References: <20211008180453.462291-1-brijesh.singh@amd.com>
 <20211008180453.462291-9-brijesh.singh@amd.com>
 <YW2EsxcqBucuyoal@zn.tnic>
 <20211018184003.3ob2uxcpd2rpee3s@amd.com>
 <YW3IdfMs61191qnU@zn.tnic>
 <20211020161023.hzbj53ehmzjrt4xd@amd.com>
 <YXBZYws8NnxiQJD7@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YXBZYws8NnxiQJD7@zn.tnic>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e343eeaa-339e-4e51-a57e-08d99437a208
X-MS-TrafficTypeDiagnostic: BY5PR12MB3825:
X-Microsoft-Antispam-PRVS: <BY5PR12MB3825392BED027E5BF663FB9B95BF9@BY5PR12MB3825.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DN5uywu4hMsLx9JqZvOI1/D4Ep8BajYYcXxW3oRIdn1jJnZD+V/cNlaoV34gpF6pR5hRCznXXJokyduW36qPiF1p7cdKPXBRy4iThsrLZ041eUlcyKFejEqOsNgs0mjAKF7VnfMpxE3jEJNZvlAWDBtGp9zjWD6I5tj0t9jz02DQbjVQZfZIyW1ZLmedP5kF3EbCUgSzBG9bFIZPK5ShCCKOoKDHDvR2kfp/ez1AhTLHLwAx0HXB4WLvuNBf+c/c9L8YrGnUpuwS6bQ+39oyk12EhmOXXWaJt3cPSVYC1rEMj4tmqDDr6XTJ2xeFdYmJ2ZIUAiK1rnKBnDighOLDyp3P3PjRp3OD43nlayJhFQN8ak5JQgI+r3OVeUbMwatR+gINtnSr1qI4fjyW73X3IHysypIvRmvn/HjuYZ4+IdIjA+U1xIBiVo4Yn2lpe03JVIk+wijN0yiODAMEM1b4MmBNc0zn0lZRcS8F36k6FfKMEsgjqEU6/48JFtCdFTxFtU4YdjlifdwlLqnwJAJFNXO7MUFlCeQYD6ADvFM6yrC6hbjVmszSRMp5zqsa7HXl0M5QRf4AeCgBqZLSXO4GasbdN+NFcPL1a+uqHxDOZwHRu6Uxr3Y2loPhllh3fLn9l/3HmcsFO5AEPzrTfn8CPT9FJD8OZyPNyVXCrfwqKHqAF8Gumf8dRwucr1wR7WIhdIi+sCpaSHx7cR9CH7Xvh3UKiW51p1b3OLwQ9GNzIjJq9JTS+E5Yhto+mkoozn+TS7fB2WvZl2mOG53XOyC07oDAkIWThxJDT/ToRJFo+NwuSf7fPo2P9FGDX0Mwohwh
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(356005)(44832011)(186003)(7416002)(16526019)(2616005)(6916009)(70586007)(70206006)(426003)(2906002)(1076003)(6666004)(5660300002)(36860700001)(83380400001)(47076005)(4326008)(316002)(336012)(8936002)(45080400002)(7406005)(54906003)(81166007)(966005)(8676002)(86362001)(36756003)(508600001)(82310400003)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 02:08:11.1144
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e343eeaa-339e-4e51-a57e-08d99437a208
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3825
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Oct 20, 2021 at 08:01:07PM +0200, Borislav Petkov wrote:
> On Wed, Oct 20, 2021 at 11:10:23AM -0500, Michael Roth wrote:
> > [Sorry for the wall of text, just trying to work through everything.]
> 
> And I'm going to respond in a couple of mails just for my own sanity.
> 
> > I'm not sure if this is pertaining to using the CPUID table prior to
> > sme_enable(), or just the #VC-based SEV MSR read. The following comments
> > assume the former. If that assumption is wrong you can basically ignore
> > the rest of this email :)
> 
> This is pertaining to me wanting to show you that the design of this SNP
> support needs to be sane and maintainable and every function needs to
> make sense not only now but in the future.

Absolutely.

> 
> In this particular example, we should set sev_status *once*, *before*
> anything accesses it so that it is prepared when something needs it. Not
> do a #VC and go, "oh, btw, is sev_status set? No? Ok, lemme set it."
> which basically means our design is seriously lacking.

Yes, taking a step back there are some things that could probably be
improved upon there.

currently:

  - boot kernel initializes sev_status in set_sev_encryption_mask()
  - run-time kernel initializes sev_status in sme_enable()

with this series the following are introduced:

  - boot kernel initializes sev_status on-demand in sev_snp_enabled()
    - initially used by snp_cpuid_init_boot(), which happens before
      set_sev_encryption_mask()
  - run-time kernel initializes sev_status on-demand via #VC handler
    - initially used by snp_cpuid_init(), which happens before
      sme_enable()

Fortunately, all the code makes use of sev_status to get at the SEV MSR
bits, so breaking the appropriate bits out of sme_enable() into an earlier
sev_init() routine that's the exclusive writer of sev_status sounds like a
promising approach.

It makes sense to do it immediately after the first #VC handler is set
up, so CPUID is available, and since that's where SNP CPUID table
initialization would need to happen if it's to be made available in
#VC handler.

It may even be similar enough between boot/compressed and run-time kernel
that it could be a shared routine in sev-shared.c. But then again it also
sounds like the appropriate place to move the snp_cpuid_init*() calls,
and locating the cc_blob, and since there's differences there it might make
sense to keep the boot/compressed and kernel proper sev_init() routines
separate to avoid #ifdeffery).

Not to get ahead of myself though. Just seems like a good starting point
for how to consolidate the various users.

> 
> And I had suggested a similar thing for TDX and tglx was 100% right in
> shooting it down because we do properly designed things - not, get stuff
> in so that vendor is happy and then, once the vendor programmers have
> disappeared to do their next enablement task, the maintainers get to mop
> up and maintain it forever.
> 
> Because this mopping up doesn't scale - trust me.

Got it, and my apologies if I've given you that impression as it's
certainly not my intent. (though I'm sure you've heard that before.)

> 
> > [The #VC-based SEV MSR read is not necessary for anything in sme_enable(),
> > it's simply a way to determine whether the guest is an SNP guest, without
> > any reliance on CPUID, which seemed useful in the context of doing some
> > additional sanity checks against the SNP CPUID table and determining that
> > it's appropriate to use it early on (rather than just trust that this is an
> > SNP guest by virtue of the CC blob being present, and then failing later
> > once sme_enable() checks for the SNP feature bits through the normal
> > mechanism, as was done in v5).]
> 
> So you need to make up your mind here design-wise, what you wanna do.
> 
> The proper thing to do would be, to detect *everything*, detect whether
> this is an SNP guest, yadda yadda, everything your code is going to need
> later on, and then be done with it.
> 
> Then you continue with the boot and now your other code queries
> everything that has been detected up til now and uses it.

Agreed, if we need to check SEV MSR early for the purposes of SNP it makes
sense to move the overall SEV feature detection code earlier as well. I
should have looked into that aspect more closely before introducing the
changes.

> 
> End of mail 1.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7Cmichael.roth%40amd.com%7C1f46689b40da4a700a6308d993f3993a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637703496776826912%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Kdi9h%2FTzuzoLn64BRsRMLWHkew14BxZHR28QsORsSxs%3D&amp;reserved=0
