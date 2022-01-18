Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF5B492C2F
	for <lists+linux-efi@lfdr.de>; Tue, 18 Jan 2022 18:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346602AbiARRVQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Jan 2022 12:21:16 -0500
Received: from mail-bn8nam12on2088.outbound.protection.outlook.com ([40.107.237.88]:4660
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243729AbiARRVQ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 18 Jan 2022 12:21:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nY64PdBPguHb/bkRqZSWR8WA/ET3OQdpVGMuLj6xWQWGSjFYum0igDUqCKMZ+JXDSImNnqeGD3D1/aAVaStDbUjQ227biP6X3JIS+w/Bv9KGr/1BU45Ft+KKM8RQXOnKs27JNiVSM9WeytbqM/A43oPDitwY7wah0/8pHnyPGYCxWSYUIYXluJzCfTCDPY4SBjKhQs5hZ1mJXxv9dXajdoJ7m/ye3GrLHM/jYdal21dV0+XOioBvtze1ackgt+R+oIhdl7qZprjCia9JrS2p7eLQg6q4ppc3o8fWMKYDoM/GlRnDroxDe0AAQU7UEXjVjhyoXOl52r6jakklpZRaqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vhi8ftj1FHIu8yC4Q5AfNvmXrw9xWOGazPHTSIBBZnA=;
 b=hlk7gZ8K3uGD+EDFZhW3WbfH1ypGqF0IfUFlf2KKDz7KWjXseojGOXcBKAfDkX2V+NtmZAqG0iBay4WHtGcpeBEsSpoxoExUT+PHxLntQHMSgs6gScl4V+QpkLp4IGpFjdziTHgc/hzPCHfzBPCPGVC55ayA+yZ3/diaP5isBDrWCl59+eve58XentafCApPd5yfhvFDWrwcgIHtT8OFvhIx7GsHn3/flRefG9tALaa4zZb+FOfp6AMUgQgZwrHmWHMaOMD9DlkttE+4uMH9JrzOLQEnYQfiDQ0TDo+Nv6JHmLm9bVGJfl4wHtz3UzuhSRMuFP2bEqTfwzSVLB5KFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vhi8ftj1FHIu8yC4Q5AfNvmXrw9xWOGazPHTSIBBZnA=;
 b=IdaIn58XYfIrChq62X5d1mXQV/jMHmNxQmhHuibFjU+RexK8kApD1Lx4iPRXy6VcZ2XkH9YlXXfYzvp7aMKkYj3afS0pvcYHT+nHnpbF8MM5sDMrYu7hojJSA6BQBrYTzmAHDj/9RJDztFCsxyzBPn4WxPj8irDa5/wV6hwg2Yk=
Received: from BN8PR07CA0031.namprd07.prod.outlook.com (2603:10b6:408:ac::44)
 by MW2PR12MB2362.namprd12.prod.outlook.com (2603:10b6:907:e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Tue, 18 Jan
 2022 17:21:02 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::1f) by BN8PR07CA0031.outlook.office365.com
 (2603:10b6:408:ac::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7 via Frontend
 Transport; Tue, 18 Jan 2022 17:21:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Tue, 18 Jan 2022 17:21:01 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 18 Jan
 2022 11:20:58 -0600
Date:   Tue, 18 Jan 2022 11:20:43 -0600
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
Message-ID: <20220118172043.djhy3dwg4fhhfqfs@amd.com>
References: <20211210154332.11526-30-brijesh.singh@amd.com>
 <YeAmFePcPjvMoWCP@zn.tnic>
 <20220113163913.phpu4klrmrnedgic@amd.com>
 <YeGhKll2fTcTr2wS@zn.tnic>
 <20220118043521.exgma53qrzrbalpd@amd.com>
 <YebIiN6Ftq2aPtyF@zn.tnic>
 <20220118142345.65wuub2p3alavhpb@amd.com>
 <20220118143238.lu22npcktxuvadwk@amd.com>
 <20220118143730.wenhm2bbityq7wwy@amd.com>
 <YebsKcpnYzvjaEjs@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YebsKcpnYzvjaEjs@zn.tnic>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98cb8334-fcbe-4933-f2f8-08d9daa6e6a1
X-MS-TrafficTypeDiagnostic: MW2PR12MB2362:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB236282D6B459203A68CE42E395589@MW2PR12MB2362.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OUxW4zz0z8ZChQOw+MW+4nrHjOQ/L07fdrwCMYJHeySz54XF0DaUqLqzq8eG90BwN8S+aQYMdKZmSKN5zYJSJbD66Lj8rNl4+0nSbqLF/pm5D5fqIkWIZXLwbir/uwco64HrQBOGYNvqDc7vKppQTl4LoKHjHWMRjFSEsHsLZbtjFoP8WFQBNIb2EZRT/Ddoq+vrM17KkWysnftDPqBTcbyV+KmR5gRvfRQyid8K1ufI+c72X7NtnSJGcs8MrVdieIz//M+74DYzUtf2aTWEbDo4gcGG/l08AAOk45GjFhziM88DJgvfCKC9G8yOTgxo/DI2WCMWQm8yoSrKJRoxPSrE9fby21oeuARHqef9djaB9uuxrPUo0zvT70G+jYyhg5qHDLyUIFRrsyX/nnMGVLp+fzFEUNe9iq5vpSSGJrzx/ozXf4ZDtWRetCWv/9xmO81/OC5YM/zBFWUY+cbuAWleFXLdHe4+mWYG9/PzE3DYCPXu+IXxFJBMePOYm0n5+hPnsucuvzY4zAjv4LN9e0HE9s9Dzvh+8jWwjgNqbyUH0hSdsp/awmcGmZwzxq+fYKo9t/pvZC7iQHZwH4Z1ldg5BD9N0vQ2Y6rBY140JidPA+NjcK/MZ9Nv+VHHY3KVjHKT4IPi4AE0hFFyy68cypsVHBsDFl6mhQu8bTPS/I634q1FaU7hFDEhOql23U8UQ5IlPCrkfc6Qsj9Sy4ohK69H5lwEDtTI4nz8d+nZY7UGnW/tABndSQkFnSGIyfBwFmqEEaeJqU4TaWnEzX2wdsMFOBSp5QsrD7figEh3SuwJGEpTy7lc6EBT2v87Og6VgXusmImU4M7VQU62R+KZg9BSzoOB7wBvnn5TQKh8vWDxlQYFyBO5/3kTbkaDMzWPrIuIvzipNXQKOQxgXHJNSSj+oC6gclR21S2xxdeqMy0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700002)(40460700001)(2616005)(81166007)(508600001)(82310400004)(7406005)(1076003)(8936002)(44832011)(36860700001)(5660300002)(6666004)(356005)(45080400002)(2906002)(7416002)(4326008)(316002)(426003)(26005)(8676002)(54906003)(36756003)(86362001)(70206006)(70586007)(966005)(16526019)(6916009)(47076005)(186003)(336012)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 17:21:01.7966
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98cb8334-fcbe-4933-f2f8-08d9daa6e6a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2362
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jan 18, 2022 at 05:34:49PM +0100, Borislav Petkov wrote:
> On Tue, Jan 18, 2022 at 08:37:30AM -0600, Michael Roth wrote:
> > Actually, no, because doing that would provide hypervisor a means to
> > effectively disable CPUID page for an SNP guest by provided a table with
> > count == 0, which needs to be guarded against.
> 
> Err, I'm confused.
> 
> Isn't that "SEV-SNP guests will be provided the location of special
> 'secrets' 'CPUID' pages via the Confidential Computing blob..." and the
> HV has no say in there?
> 
> Why does the HV provide the CPUID page?

The HV fills out the initial contents of the CPUID page, which includes
the count. SNP/PSP firmware will validate the contents the HV tries to put
in the initial page, but does not currently enforce that the 'count' field
is non-zero. So we can't rely on the 'count' field as an indicator of
whether or not the CPUID page is active, we need to rely on the presence
of the ccblob as the true indicator, then treat a non-zero 'count' field
as an invalid state.

I think we discussed this to some extent in the past. The following
document was added to clarify the security model for CPUID page:

https://lore.kernel.org/lkml/20211210154332.11526-29-brijesh.singh@amd.com/

> 
> And when I read "secrets page" I think, encrypted/signed and given
> directly to the guest, past the HV which cannot even touch it.

The CPUID page is also encrypted, but its initial contents come from the
HV, which are then passed through the PSP for initial validation before
being placed in the CPUID page. But the count==0 case is not disallowed
by the PSP firmware, so can't be relied upon as a means to indicate that
the CPUID page is not active.

> 
> Hmmm.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7Cmichael.roth%40amd.com%7C9e8f64f998744605658608d9daa073ee%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637781205020570217%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=26Fkw4FJ9jOLVRW7SMs6IWYyaY5gO8iUfdm3x4HDaJk%3D&amp;reserved=0
