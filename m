Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE55049E83C
	for <lists+linux-efi@lfdr.de>; Thu, 27 Jan 2022 18:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244169AbiA0RAf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 27 Jan 2022 12:00:35 -0500
Received: from mail-bn8nam12on2053.outbound.protection.outlook.com ([40.107.237.53]:3040
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229861AbiA0RAe (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 27 Jan 2022 12:00:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLdgbV+Ml0ySQLd4Lj//hXTEnvh1uhGOsriZpYbUCHc98Y81Pv98D5pNflrzyeMvdgwgkqCgdG2HTqvZp8bCBIq+0Z1aoETlLCY5Sta9T4hqUd7+fbrrezPShuKZSSsUFlaF8Y+JZyPXC+FZ8n2RHniLGQaaQeAnzHN8y5Pj8iQFF0oBwlBqVMR/BPZIwZelWo5i8ALeyC7+IN7ZfZ3C6tWRldIUEcTBiNGrqbqacnZsp5nX0tbwopgHF4P/GVK6V4ptO3svbRI1FLo5iRLq4AZuuS7d63YzxqLejEyBaiOdk6RFqjOcW0ob2feps0OcIe61o5T7Ea+koyoCIyWUnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cunN01VHRVxIyA3QvZpAEHjVfiFejgrRcAVfPkofpY0=;
 b=VKE8y1gSNaf6fIazqZOMAFD6LRWljsb8XzTo3XpYNmvHysQpTNlH8fE0pT5T//1Bza0CXTS0R36nYUG8YYEV7TbwFwjcwiUeYFhwgaTtI/oNf3FDYabStGT7ebciS6Y+DhKv73DlpnLWqZnftalflzIOC1QNKOxvvN7pGUh/fGQFvstO3M8m625SwDTxS91YHblAYg90il0WecOmA4MYfUWex6O1tmqyi1jUMjv3ooyoFYX0yfcBlb2AHvmX58JqZNTusWXjP4VGPDac44flbwxZQJV8yGn0JAsT8Tjn0i7sibU5H5eatAf/zyGNcsT2nvNVhgDE7pAjlciYAjj3rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cunN01VHRVxIyA3QvZpAEHjVfiFejgrRcAVfPkofpY0=;
 b=gPNID77eXTeJKK0M2jZAVTLKV78rWx0QFFF/9Za9Py86nHqrVc/XLMiUCB+EcCpK2Ad4taP2n3TYBVwXitoCepK3EvHtKppYDrnIMvjhWi9wEwH6kIilcyvF4ee6qS+PtlZXpyYSOOhfGqUUKsWa9c6S29WNx2NaIqam9Hwo8jc=
Received: from BN9PR03CA0431.namprd03.prod.outlook.com (2603:10b6:408:113::16)
 by SA1PR12MB5671.namprd12.prod.outlook.com (2603:10b6:806:23b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.13; Thu, 27 Jan
 2022 17:00:32 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::3) by BN9PR03CA0431.outlook.office365.com
 (2603:10b6:408:113::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17 via Frontend
 Transport; Thu, 27 Jan 2022 17:00:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 17:00:31 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 27 Jan
 2022 11:00:25 -0600
Date:   Wed, 19 Jan 2022 10:27:47 -0600
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
Message-ID: <20220119162747.ewgxirwcnrcajazm@amd.com>
References: <YebIiN6Ftq2aPtyF@zn.tnic>
 <20220118142345.65wuub2p3alavhpb@amd.com>
 <20220118143238.lu22npcktxuvadwk@amd.com>
 <20220118143730.wenhm2bbityq7wwy@amd.com>
 <YebsKcpnYzvjaEjs@zn.tnic>
 <20220118172043.djhy3dwg4fhhfqfs@amd.com>
 <Yeb7vOaqDtH6Fpsb@zn.tnic>
 <20220118184930.nnwbgrfr723qabnq@amd.com>
 <20220119011806.av5rtxfv4et2sfkl@amd.com>
 <YefzQuqrV8kdLr9z@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YefzQuqrV8kdLr9z@zn.tnic>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69d74272-89ac-49b7-fe42-08d9e1b686fc
X-MS-TrafficTypeDiagnostic: SA1PR12MB5671:EE_
X-Microsoft-Antispam-PRVS: <SA1PR12MB5671FD0B2E72B9D4F7630B5A95219@SA1PR12MB5671.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r8EycPUhCXElC6By25NxG8uxtrnScWXDZOS3p6LTos0iMt/zXYJqZ8J5kbyaDJ14FZSjnjUh+qLGyYLGgAnpen/qjTK6wOH1wW11x+V8VHgGp5VZZsEo020PDops54p/dK32sWGst2SGoZKkaWTWfKeYXm/y3ieHwTebYYJCyV2MtGo0F5HFFfySyPY2/VMo0+wnNzhl6uEmyxy8Qyl92ekogThID6Jqg7WO1yGohdxq+8AcPWDBju267AXtKvEwbQ059534WPFOyey9YrLpJ8WARJMu+8EJQJsHzRpQgYjTOSBktA0H4lKR0OMkqpxo/CPjdXEhMrd+/ZgXKoyEi0sl9pzhBty0vpO3/VNP/BuDjWcU1UkPKs5UN4iQk7tJ0mGJ/4gBIWDC27qhZcZPu/bB9n04D06yjuccem6RD0HV5B58rgQEVgeNJbQ3gcQgfkig2lOMYQbl9ypgR5McvJJdv/pxqZgJTZXQwP4egjlwwXyfpwWpdvjfB3R1sbVszdNJ3ccswNP07CFoLcHz8nhUhYR0GN3ogTvuSe5eoAgV7aF7zeJwAVzEtGuglPDie/WRZEg+UTNMV+TkPHUR80ymJb8mVFj36vsAxYdpcjFr4WC5sx5sMrZ3IfUDmbq8piEAMiBTOPb5xI2V7xrdC2mSU1ekM/WumZeTxcXq6DH4d814GzjIEcFjC27SPbWCDSNpnW1vOF40OlZu/P4tAAQW+MzXYyRNNY9fvzGMe2R9TVONpHOoZQttua/Dro75zmr0hAyOw+bsCvCSy9Ehju/6uv0BAnEPl0LU5n6Z8rk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(40470700004)(36840700001)(46966006)(8676002)(2616005)(6666004)(1076003)(82310400004)(36860700001)(508600001)(16526019)(3716004)(186003)(70586007)(26005)(40460700003)(86362001)(426003)(4326008)(2906002)(54906003)(6916009)(7416002)(81166007)(7406005)(36756003)(83380400001)(70206006)(5660300002)(356005)(44832011)(47076005)(8936002)(316002)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 17:00:31.4035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d74272-89ac-49b7-fe42-08d9e1b686fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5671
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jan 19, 2022 at 12:17:22PM +0100, Borislav Petkov wrote:
> On Tue, Jan 18, 2022 at 07:18:06PM -0600, Michael Roth wrote:
> > If 'fake_count'/'reported_count' is greater than the actual number of
> > entries in the table, 'actual_count', then all table entries up to
> > 'fake_count' will also need to pass validation. Generally the table
> > will be zero'd out initially, so those additional/bogus entries will
> > be interpreted as a CPUID leaves where all fields are 0. Unfortunately,
> > that's still considered a valid leaf, even if it's a duplicate of the
> > *actual* 0x0 leaf present earlier in the table. The current code will
> > handle this fine, since it scans the table in order, and uses the
> > valid 0x0 leaf earlier in the table.
> 
> I guess it would be prudent to have some warnings when enumerating those
> leafs and when the count index "goes off into the weeds", so to speak,
> and starts reading 0-CPUID entries. I.e., "dear guest owner, your HV is
> giving you a big lie: a weird/bogus CPUID leaf count..."
> 
> :-)

Ok, there's some sanity checks that happen a little later in boot via
snp_cpuid_check_status(), after printk is enabled, that reports some
basic details to dmesg like the number of entries in the table. I can
add some additional sanity checks to flag the above case (really,
all-zero entries never make sense, since CPUID 0x0 is supposed to report
the max standard-range CPUID leaf, and leaf 0x1 at least should always
be present). I'll print a warning for such cases, add maybe dump the
cpuid the table in that case so it can be examined more easily by
owner.

> 
> And lemme make sure I understand it: the ->count itself is not
> measured/encrypted because you want to be flexible here and supply
> different blobs with different CPUID leafs?

Yes, but to be clear it's the entire CPUID page, including the count,
that's not measured (though it is encrypted after passing PSP
validation). Probably the biggest reason is the logistics of having
untrusted cloud vendors provide a copy of the CPUID values they plan
to pass to the guest, since a new measurement would need to be
calculated for every new configuration (using different guest
cpuflags, SMP count, etc.), since those table values will need to be
made easily-accessible to guest owner for all these measurement
calculations, and they can't be trusted so each table would need to
be checked either manually or by some tooling that could be difficult
to implement unless it was something simple like "give me the expected
CPUID values and I'll check if the provided CPUID table agrees with
that".

At that point it's much easier for the guest owner to just check the
CPUID values directly against known good values for a particular
configuration as part of their attestation process and leave the
untrusted cloud vendor out of it completely. So not measuring the
CPUID page as part of SNP attestation allows for that flexibility.

> 
> > This is isn't really a special case though, it falls under the general
> > category of a hypervisor inserting garbage entries that happen to pass
> > validation, but don't reflect values that a guest would normally see.
> > This will be detectable as part of guest owner attestation, since the
> > guest code is careful to guarantee that the values seen after boot,
> > once the attestation stage is reached, will be identical to the values
> > seen during boot, so if this sort of manipulation of CPUID values
> > occurred, the guest owner will notice this during attestation, and can
> > abort the boot at that point. The Documentation patch addresses this
> > in more detail.
> 
> Yap, it is important this is properly explained there so that people can
> pay attention to during attestation.
> 
> > If 'fake_count' is less than 'actual_count', then the PSP skips
> > validation for anything >= 'fake_count', and leaves them in the table.
> > That should also be fine though, since guest code should never exceed
> > 'fake_count'/'reported_count', as that's a blatant violation of the
> > spec, and it doesn't make any sense for a guest to do this. This will
> > effectively 'hide' entries, but those resulting missing CPUID leaves
> > will be noticeable to the guest owner once attestation phase is
> > reached.
> 
> Noticeable because the guest owner did supply a CPUID table with X
> entries but the HV is reporting Y?

Or even more simply by the guest owner simply running 'cpuid -r -1' on
the guest after boot, and making sure all the expected entries are
present. If the HV manipulated the count to be lower, there would be
missing entries, if they manipulated it to be higher, then there would
either be extra duplicate entries at the end of the table (which the
#VC handler would ignore due to it using the first matching entry in
the table when doing lookups), or additional non-duplicate garbage
entries, which will show up in 'cpuid -r -1' as unexpected entries.

Really 'cpuid -r -1' is the guest owner/userspace view of things, so
some of these nuances about the table contents might be noteworthy,
but wouldn't actually affect guest behavior, which would be the main
thing attestation process should be concerned with.

> 
> If so, you can make this part of the attestation process: guest owners
> should always check the CPUID entries count to be of a certain value.
> 
> > This does all highlight the need for some very thorough guidelines
> > on how a guest owner should implement their attestation checks for
> > cpuid, however. I think a section in the reference implementation
> > notes/document that covers this would be a good starting point. I'll
> > also check with the PSP team on tightening up some of these CPUID
> > page checks to rule out some of these possibilities in the future.
> 
> Now you're starting to grow the right amount of paranoia - I'm glad I
> was able to sensitize you properly!
> 
> :-)))

Hehe =*D

Thanks!

-Mike
