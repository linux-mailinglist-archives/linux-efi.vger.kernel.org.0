Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9294ADBBF
	for <lists+linux-efi@lfdr.de>; Tue,  8 Feb 2022 15:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240348AbiBHO4h (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Feb 2022 09:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234194AbiBHO4g (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 8 Feb 2022 09:56:36 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A76C061576;
        Tue,  8 Feb 2022 06:56:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXGQ7KH4gBlpNFWAlrAZU7JY1prlLJfojNAEWs9/Jajf9astyvWs9d1MtObyCuuHvu/dwwJNWtzi/bhbAK315fdPCVzWFQi4eZioQSK6NT19W031UL50V3nAvYgR0pSF4UWwrIjHE+ZpPjIIAZO1mJwT/gm7Pxh/78XVNGlbcSdNzbvgtTAPDfoCSyntXnS16dAC9Ro0SRTfL0D8323rsrH2O1Ucy+mBAfNntZN+CA89UAUxGRkYQoqUZjToqMsgbM0xbMFxPfnLIrO74IJXvkHAgeStHiJ9FAESXMEZezwlvHSR5b2lRh5EpRqTjWU3ECk7bhSEX8GLE5Ih3mQbmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXRe9jIcp7dAgK3TSGQPQmq7ps2tmtQEkFwWgWt2vR4=;
 b=ZDkYQ9XRlRYVWJvDPeVHF2BabeO35wjp3/+BM+H5+Cf8dtL6QIVuLtTdneukOY5IfRy/m0LKH799m9+KgwnKsLszc4a2vmdwHYULLBNotlarC5IubfT4MgaByBwDhHBkcmDSOiWmz4/esUivZB092qeaPlhsdb9EMO5PdaFY7YAa7EkxCSGNmrl5JMkMy5QLP98ygTZqVQU3MNmq7HX31wC1H8c/BQ8TvNO7+RdOIgNO+0pTuQXBOII0goD+OiCP7cb113FCuySkHd2O7L5MtJI34nfW8GZbz9qRVb8yNIol1/QZTApaa2sqiIQrVUzy/jI7oxiAnzO7DmAV5UhETg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXRe9jIcp7dAgK3TSGQPQmq7ps2tmtQEkFwWgWt2vR4=;
 b=EgIOyq2hXt2rQPomh5gHfa83z/wwHcpge/mP+YG4Wx+4lD9YdDhMwtohAobOZqinHXYr9odTq6njIFJPuWaUwulKPmcuT2b/HNRIslSpEVsVfF+pUP/10ynO/DFiM+ks9GNkE7Xv9i3+f5GwUCmbklDQR7TSTaV6DAd7chq0id8=
Received: from BN7PR02CA0032.namprd02.prod.outlook.com (2603:10b6:408:20::45)
 by DM5PR12MB2440.namprd12.prod.outlook.com (2603:10b6:4:b6::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Tue, 8 Feb
 2022 14:56:31 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::c4) by BN7PR02CA0032.outlook.office365.com
 (2603:10b6:408:20::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Tue, 8 Feb 2022 14:56:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Tue, 8 Feb 2022 14:56:31 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 8 Feb
 2022 08:56:30 -0600
Date:   Tue, 8 Feb 2022 08:54:39 -0600
From:   Michael Roth <michael.roth@amd.com>
To:     Sean Christopherson <seanjc@google.com>
CC:     Brijesh Singh <brijesh.singh@amd.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
        <linux-efi@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
        <linux-coco@lists.linux.dev>, <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
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
        Borislav Petkov <bp@alien8.de>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Andi Kleen" <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        <brijesh.ksingh@gmail.com>, <tony.luck@intel.com>,
        <marcorr@google.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v9 30/43] KVM: SEV: Add documentation for SEV-SNP CPUID
 Enforcement
Message-ID: <20220208145439.ozw4cjhqfvozewl4@amd.com>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-31-brijesh.singh@amd.com>
 <YgGvu1BsYP9cihwh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YgGvu1BsYP9cihwh@google.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 205c953d-9c7d-4b8b-cba8-08d9eb133175
X-MS-TrafficTypeDiagnostic: DM5PR12MB2440:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB24401F74968EAB8C7F9C6A31952D9@DM5PR12MB2440.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zm5m1i8vGRKkfviARu86uzc2jhCDq2LZebGaw0+dx58hOfI6rKHnusDIdnDyLMivdMrJ14FCb7uK9U6ZONlxRUQ2Ww8OkkPHu31nZjJVlsMm1XBAzMwMuYuCrDy+RY6jyYX37zVUTFeu4BFWwKitPg/ILqmd4j26CdhjwFrC6bjaWhim4AuALZSeHf8tOTqPZ9/73eYvSYrmdvbkVJfRfavJyC3310BB+g6+rbjqTimzVEaHNNEJPAPy2YaGnXpdJ4hy5j+z0KS13BYQ5ULzYWY9PvTklCuhoZL/16FEgtPLIiCEPN3EuKH7VBP/wEcnFg8ZxH3851ZWCvqzm9PgT8s8puQyyGMi/lbD87h7zNYH4SmImQqNY1/Jxq0zV4b3j0yyUGatSYJ3cypbAI5I1U3YjUcjLBM41qxqLms86UYeMbEdSeDAlFuFpYIq1IVmcKKiFDcVtZJoqgBq9cZMbCwJVuyxVA3IH+/lVz9tluyptAmjlfydJJQ5vR1Ohwx5q+oZDc9/50Jw7MIq+PMgGNp4Ti1irEHeCW/nzD86Z+10Whjzcww1xC72QEIkudfNyoyaVjokvl/Sk5oXAYcHX33ea2o5vOgzV72/8FASCeN/Mvd3VRbWN0u+nEZu2SrB6SicxFaJJxZUUMH9jtGaEr6bouIO5ttZJrPdX0dwZeD8QX8ts2cXJlVqMbu+61BKb3UKsPldrfU4ZEkm4LgceA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(426003)(186003)(1076003)(508600001)(26005)(16526019)(336012)(36756003)(86362001)(6916009)(36860700001)(47076005)(40460700003)(54906003)(83380400001)(2616005)(7406005)(70586007)(70206006)(8936002)(81166007)(7416002)(5660300002)(4326008)(356005)(8676002)(2906002)(44832011)(316002)(82310400004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 14:56:31.5564
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 205c953d-9c7d-4b8b-cba8-08d9eb133175
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2440
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Feb 07, 2022 at 11:48:11PM +0000, Sean Christopherson wrote:
> On Fri, Jan 28, 2022, Brijesh Singh wrote:
> > From: Michael Roth <michael.roth@amd.com>
> > 
> > Update the documentation with SEV-SNP CPUID enforcement.
> > 
> > Signed-off-by: Michael Roth <michael.roth@amd.com>
> > Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> > ---
> >  .../virt/kvm/amd-memory-encryption.rst        | 28 +++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> > 
> > diff --git a/Documentation/virt/kvm/amd-memory-encryption.rst b/Documentation/virt/kvm/amd-memory-encryption.rst
> > index 1c6847fff304..0c72f44cc11a 100644
> > --- a/Documentation/virt/kvm/amd-memory-encryption.rst
> > +++ b/Documentation/virt/kvm/amd-memory-encryption.rst
> 
> This doc is specifically for KVM's host-side implemenation, whereas the below is
> (a) mostly targeted at the guest and (b) has nothing to do with KVM.
> 
> Documentation/x86/amd-memory-encryption.rst isn't a great fit either.
> 
> Since TDX will need a fair bit of documentation, and SEV-ES could retroactively
> use docs as well, what about adding a sub-directory:
> 
> 	Documentation/virt/confidential_compute

There's actually a Documentation/virt/coco/sevguest.rst that was added
in this series as part of:

  "virt: Add SEV-SNP guest driver"

Maybe that's good choice?

I've been wondering about potentially adding the:

  "Guest/Hypervisor Implementation Notes for SEV-SNP CPUID Enforcement"

document that was sent to SNP mailing list under Documentation/
somewhere. If we were to do that, it would be a good place to move the
documentation from this patch into as well. Any thoughts on that?

> 
> to match the "cc_platform_has" stuffr, and then we can add sev.rst and tdx.rst
> there?  Or sev-es.rst, sev-snp.rst, etc... if we want to split things up more.
> 
> It might be worth extracting the SEV details from x86/amd-memory-encryption.rst
> into virt/ as well.  A big chunk of that file appears to be SEV specific, and it
> appears to have gotten a little out-of-whack.  E.g. this section no longer makes
> sense as the last paragraph below appears to be talking about SME (bit 23 in MSR
> 0xc0010010), but walking back "this bit" would reference SEV.  I suspect a
> mostly-standalone sev.rst would be easier to follow than an intertwined SME+SEV.
> 
>   If support for SME is present, MSR 0xc00100010 (MSR_AMD64_SYSCFG) can be used to
>   determine if SME is enabled and/or to enable memory encryption::
> 
>           0xc0010010:
>                   Bit[23]   0 = memory encryption features are disabled
>                             1 = memory encryption features are enabled
> 
>   If SEV is supported, MSR 0xc0010131 (MSR_AMD64_SEV) can be used to determine if
>   SEV is active::
> 
>           0xc0010131:
>                   Bit[0]    0 = memory encryption is not active
>                             1 = memory encryption is active
> 
>   Linux relies on BIOS to set this bit if BIOS has determined that the reduction
>   in the physical address space as a result of enabling memory encryption (see
>   CPUID information above) will not conflict with the address space resource
>   requirements for the system.  If this bit is not set upon Linux startup then
>   Linux itself will not set it and memory encryption will not be possible.

I'll check with Brijesh on these.

Thanks!

-Mike



