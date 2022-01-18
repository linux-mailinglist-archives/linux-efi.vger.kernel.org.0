Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60E1D491E8A
	for <lists+linux-efi@lfdr.de>; Tue, 18 Jan 2022 05:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbiAREfs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Jan 2022 23:35:48 -0500
Received: from mail-bn8nam12on2053.outbound.protection.outlook.com ([40.107.237.53]:13050
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229777AbiAREfs (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 17 Jan 2022 23:35:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q51YvjcmNjWK8pmbDNlPTrwGJksf7/bVip9Pl0i3UD+LmTUVqb/wY2YMDrgTt7w/cY5RFhOomXZiJG2utxNyNCULj27MlpOUn9Cuv9yiKclIei6l+G2jXQ1nNf6JGzfdvmFHvvzBIVcErMAiogPgfl7D3aD3BzTktjkkIm/qtzEp0snkJEovYe8Df3VAuuGQArItU/4wjGw64TAMII91WNWxJTgDrnb4cHFkJeDcknQclPewuUcu1ml0yFEeFi9g9ugRdYUy2If+hPzyz9TfTKzfYEUtbN3L90753Pg+YnkUIJb9QTjEFcnVe1VjZ/Wc6xoX0CTjOGgSKNO1fqcVGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKqbJWt+JhAJeBYshth5wraYtnC7Hym9H0HZlmltm3Q=;
 b=SGizebQBWUzUEYELwWkdRRuNvYYUXk+ALv3PWr7oVY5dX3wqANwR6bI8nVmt6duQthfQCkmgToEIlwMXzpOeZd5jWahx1m85V8tbVMY2EkB+BMTrNA67R+fEBQXjqaC/jZuaaKIPb34vX1YG2BVEelBZFtAoKZ2lWTIjex1lvR16ZA2N/P0is5DaM5ce8K6tigTEfwZlF35REehn33gLvHYKF/3VUK/1MfmNCNBhs+vMXFuDsbuJYH1mC02kOVyncHCVewWd1uWokvUdZGRA5YZjsWweII6+3v4L/lCjZQplQWNFREznAvr0QPKNNkRGS3eHnOTvof2nFbJgQZi0DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKqbJWt+JhAJeBYshth5wraYtnC7Hym9H0HZlmltm3Q=;
 b=xfTltyXvuFxTWpjPKxmrq3qq+ifc6t2TbeIdCD5c/IyhrmLh4AMy+cWAhjV3JG4SbpK3S9+47KPBc+j8PrtlVMIZyyMcga0qKv9CsRR64oqjG1rK/LydCDxnbNLJtrO9eO091Al/Cjo/RYd5VqkBqyd12MHmNcNawmwoWa3fGmY=
Received: from CO2PR04CA0141.namprd04.prod.outlook.com (2603:10b6:104::19) by
 BN9PR12MB5289.namprd12.prod.outlook.com (2603:10b6:408:102::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Tue, 18 Jan
 2022 04:35:43 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:0:cafe::79) by CO2PR04CA0141.outlook.office365.com
 (2603:10b6:104::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Tue, 18 Jan 2022 04:35:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Tue, 18 Jan 2022 04:35:42 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 17 Jan
 2022 22:35:41 -0600
Date:   Mon, 17 Jan 2022 22:35:21 -0600
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
Message-ID: <20220118043521.exgma53qrzrbalpd@amd.com>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-30-brijesh.singh@amd.com>
 <YeAmFePcPjvMoWCP@zn.tnic>
 <20220113163913.phpu4klrmrnedgic@amd.com>
 <YeGhKll2fTcTr2wS@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YeGhKll2fTcTr2wS@zn.tnic>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cce05914-83f9-4d8b-4b07-08d9da3bfc96
X-MS-TrafficTypeDiagnostic: BN9PR12MB5289:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5289D0375BB903294C84FFC295589@BN9PR12MB5289.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D1+nuXYMbti3mZhP+F7D673gRRSQTPlysSr+p0Q8+hpHhuH6rBFgHhnVTaJ6UAsEssuuAuUcsx1IJEvVWLzGB8fW6/ZNA9FGJx8Bsy6Dn8kbuHVA5SqCH6ZmRB2r3C/RxbvxVhW8eRMalLABYITSsDX5cwCU5g4zc/1JzEbOgoh9BzTUXPcIGVpo77c651in+bTej03zSB3Le9PbSH945rViyWSpkhzGsnLWkUnolckdO9nZvCK236hJK6LvJZcNX/Rr2jifzyJWQ+etnmBTpBeODSd27jZpX78v8Rt5qTE1PwaJziNrb6WefIUaQaPJL5hsgmRr8egkw9uR2XiWUIBkQH45hwPZExTYDMPkJrdfcanPqc3e29R25DJ76Pwu8gmwfgYiaMdLr7tR6uG6qnZM2+ncTNGneSpOrV8mJepwm6S+AXIg/V7lQ7j3gZYQcZgRoUYDTYn1U4lU6q3yzrBD2x4TpLsX+oOXcqIautSRHyStK2xdjnR6upzyuAj9PcTTkHN5aMvkOMK/TNn6+Fapqa+2hV49XMH+oJoHKW/5ohVQrcRUcWNCRN25lDwilDYJga31GrnvfP6QH2Hwa5J0d8xrojGxTpmCcQX6AJP8UebxdWvZcIZEf6gV3kCgIoN8gxkmJ0d7Wph+tysHB1oBhShpvv9q6x7X+B0AFrUHN4q997L1IH7DdS4EH1BAZvU62dCFY8LV6Gh4A9YyiYGXq5KYU2H/D8q2/rkdLUGuEwSbuYIFfTmRq+Zn5HyoPuHVAcqU9Qe9GXX9q1b0tg2KVHyTs8WzU3rDoWwHzYJKy12shuvbJgXGNpMxnHxCV2A9zHQIeNHbo86Ecr/6fPIxIom/M1ikfi9A1kQhHRxH+MqIqg6n/59fjpvKfpNO
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(40470700002)(36840700001)(46966006)(356005)(83380400001)(40460700001)(36860700001)(316002)(45080400002)(47076005)(336012)(426003)(44832011)(86362001)(82310400004)(81166007)(508600001)(966005)(36756003)(6916009)(8936002)(70586007)(70206006)(8676002)(4326008)(6666004)(7406005)(26005)(186003)(54906003)(16526019)(2616005)(7416002)(1076003)(2906002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 04:35:42.3707
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cce05914-83f9-4d8b-4b07-08d9da3bfc96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5289
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jan 14, 2022 at 05:13:30PM +0100, Borislav Petkov wrote:
> On Thu, Jan 13, 2022 at 10:39:13AM -0600, Michael Roth wrote:
> > I was thinking a future hypervisor/spec might make use of this field for
> > new functionality, while still wanting to be backward-compatible with
> > existing guests, so it would be better to not enforce 0. The firmware
> > ABI does indeed document it as must-be-zero,
> 
> Maybe there's a good reason for that.
> 
> > by that seems to be more of a constraint on what a hypervisor is
> > currently allowed to place in the CPUID table, rather than something
> > the guest is meant to enforce/rely on.
> 
> So imagine whoever creates those, starts putting stuff in those fields.
> Then, in the future, the spec decides to rename those reserved/unused
> fields into something else and starts putting concrete values in them.
> I.e., it starts using them for something.
> 
> But, now the spec breaks existing usage because those fields are already
> in use. And by then it doesn't matter what the spec says - existing
> usage makes it an ABI.
> 
> So we start doing expensive and ugly workarounds just so that we don't
> break the old, undocumented use which the spec simply silently allowed,
> and accomodate that new feature the spec adds.
> 
> So no, what you're thinking is a bad bad idea.

I can certainly see that argument. I'll add checks to enforce these
cases. If it breaks an existing hypervisor implementation, it's probably
better to have that happen early based on this initial reference
implementation rather than down the road when we actually need these
fields for something.

> 
> > snp_cpuid_info_create() (which sets snp_cpuid_initialized) only gets
> > called if firmware indicates this is an SNP guests (via the cc_blob), but
> > the #VC handler still needs to know whether or not it should use the SNP
> > CPUID table still SEV-ES will still make use of it, so it uses
> > snp_cpuid_active() to make that determination.
> 
> So I went and applied the rest of the series. And I think you mean
> do_vc_no_ghcb() and it doing snp_cpuid().

Yes that's correct.

> 
> Then, looking at sev_enable() and it calling snp_init(), you fail
> further init if there's any discrepancy in the supplied data - CPUID,
> SEV status MSR, etc.
> 
> So, practically, what you wanna test in all those places is whether
> you're a SNP guest or not. Which we already have:
> 
> 	sev_status & MSR_AMD64_SEV_SNP_ENABLED
> 
> so, unless I'm missing something, you don't need yet another
> <bla>_active() helper.

Unfortunately, in sev_enable(), between the point where snp_init() is
called, and sev_status is actually set, there are a number of cpuid
intructions which will make use of do_vc_no_ghcb() prior to sev_status
being set (and it needs to happen in that order to set sev_status
appropriately). After that point, snp_cpuid_active() would no longer be
necessary, but during that span some indicator is needed in case this
is just an SEV-ES guest trigger cpuid #VCs.

> 
> > This code is calculating the total XSAVE buffer size for whatever
> > features are enabled by the guest's XCR0/XSS registers. Those feature
> > bits correspond to the 0xD subleaves 2-63, which advertise the buffer
> > size for each particular feature. So that check needs to ignore anything
> > outside that range (including 0xD subleafs 0 and 1, which would normally
> > provide this total size dynamically based on current values of XCR0/XSS,
> > but here are instead calculated "manually" since we are not relying on
> > the XCR0_IN/XSS_IN fields in the table (due to the reasons mentioned
> > earlier in this thread).
> 
> Yah, the gist of that needs to be as a comment of that line as it is not
> obvious (at least to me).
> 
> > Not duplicate entries (though there's technically nothing in the spec
> > that says you can't), but I was more concerned here with multiple
> > entries corresponding to different combination of XCR0_IN/XSS_IN.
> > There's no good reason for a hypervisor to use those fields for anything
> > other than 0xD subleaves 0 and 1, but a hypervisor could in theory encode
> > 1 "duplicate" sub-leaf for each possible combination of XCR0_IN/XSS_IN,
> > similar to what it might do for subleaves 0 and 1, and not violate the
> > spec.
> 
> 
> Ditto. Also a comment ontop please.

Will do.

> 
> > The current spec is a bit open-ended in some of these areas so the guest
> > code is trying to be as agnostic as possible to the underlying implementation
> > so there's less chance of breakage running on one hypervisor verses
> > another. We're working on updating the spec to encourage better
> > interoperability, but that would likely only be enforceable for future
> > firmware versions/guests.
> 
> This has the same theoretical problem as the reserved/unused fields. If
> you don't enforce it, people will do whatever and once it is implemented
> in hypervisors and it has become an ABI, you can't change it anymore.
> 
> So I'd very strongly suggest you tighten in up upfront and only allow
> stuff later, when it makes sense. Not the other way around.

Yah, I was trying to avoid causing issues for other early
implementations trying to make do with the current open-ended spec, but
that's probably a losing battle and it's probably better to try to get
everyone using the proposed reference implementation early on. I'll tighten
the code up in this regard and also send a new version of reference
implementation document to SNP mailing list for awareness.

> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7Cmichael.roth%40amd.com%7Cb2fefc5c0458441d2c9508d9d778cf46%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637777736172270637%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=lCq1wBm8iyW1AOorhL35om6gU9GEypzCksiFZUI3H%2Fk%3D&amp;reserved=0
