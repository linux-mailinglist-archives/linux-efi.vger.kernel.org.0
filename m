Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C3A475FDB
	for <lists+linux-efi@lfdr.de>; Wed, 15 Dec 2021 18:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238469AbhLORwf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Dec 2021 12:52:35 -0500
Received: from mail-dm6nam11on2061.outbound.protection.outlook.com ([40.107.223.61]:26848
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238305AbhLORwb (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 15 Dec 2021 12:52:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibKRcUOBj/V4qE9wiUX2nVEqn/80DqKeBOU2t1zywZoTefmfzQkHhXnFnNll741iPEMOPEY1p+CDmxpH2+41pyMLVXvPeBVVm0+/gMTkazvShZVY+CTA0FKxuBt0aA4suV1B8Hfd4hyvHia0fVLIKgMy73s63dZSBgGzwgoP8MeTnqc3tYhFiLmE8dHhEIt6bsBTKzr79LVElAVD8BKFUoYPjKxGKGAfO6JhU8PkBaanq+JRLcfHMdO3+nhybtUmJP72dDtsTVMYH3NS7hXNcRrT3qFRD+/jEgM72EwtekfvNLZd25xk8Ns2TosWHoYpGD2BX67zC56lJ3tg+YsPlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DzJdflHFmHa4TuGszXR9N7gtkHVUjMNdtQ/NS0c4BjA=;
 b=iY/qgUQ/YLDVHFFC6PCJg2YOMdcyXG7akRlBJGqqvgSFVh4Dy+dt84OIRAV1XCuEBU1QBK8VRUQ4TNlVYSipfttSFyYJTUi1VxE2Cf3zwWURvbeXjDE4D8h7UJjojGmqCRsGSKHoQ9K1Imcl+oanY2jnl+bWKy2atZwnyZFr6q53sZlwfoTCYoV5bvyP/UlK/FE01boLOgBhEuAqGjn2FvOICNTWUWS9VWiFD2RxXH0ozOjsa4Kz5FU4Mzf9OEyZYqj4/SRG5T0Him1mkVBTDPiKP49kLfwX9L515uWRibYMxAXj0I0XE93KvCjfIwE9Ju312XpWL0hxsdCCI59/Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DzJdflHFmHa4TuGszXR9N7gtkHVUjMNdtQ/NS0c4BjA=;
 b=UACLFa4vQO7aQVigPKYmf5+cVvSjZT4aJEny/q62pcOF4myYazwD1zRBG7+xos/jdx32QQlpUCmpcEwe0JyZszgLURZVs5kweRu+9WCLhdaPQ7C9xKisI59CBjICYqq/qoF42IE8QDm5NQNU5JSwcKnMoHgMCxdRBQ/G1cFRIR4=
Received: from DM6PR07CA0118.namprd07.prod.outlook.com (2603:10b6:5:330::31)
 by BL1PR12MB5096.namprd12.prod.outlook.com (2603:10b6:208:316::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Wed, 15 Dec
 2021 17:52:28 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::41) by DM6PR07CA0118.outlook.office365.com
 (2603:10b6:5:330::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.15 via Frontend
 Transport; Wed, 15 Dec 2021 17:52:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Wed, 15 Dec 2021 17:52:27 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 15 Dec
 2021 11:52:25 -0600
Date:   Wed, 15 Dec 2021 11:51:48 -0600
From:   Michael Roth <michael.roth@amd.com>
To:     Venu Busireddy <venu.busireddy@oracle.com>
CC:     Borislav Petkov <bp@alien8.de>,
        Brijesh Singh <brijesh.singh@amd.com>, <x86@kernel.org>,
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
Subject: Re: [PATCH v8 01/40] x86/compressed/64: detect/setup SEV/SME
 features earlier in boot
Message-ID: <20211215175148.rtgyyqgymouvs7ft@amd.com>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-2-brijesh.singh@amd.com>
 <YbeaX+FViak2mgHO@dt>
 <YbecS4Py2hAPBrTD@zn.tnic>
 <YbjYZtXlbRdUznUO@dt>
 <YbjsGHSUUwomjbpc@zn.tnic>
 <YbkzaiC31/DzO5Da@dt>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YbkzaiC31/DzO5Da@dt>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5af497e-5be6-485b-dfeb-08d9bff3a8dc
X-MS-TrafficTypeDiagnostic: BL1PR12MB5096:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5096A95C2DBBF31A5B91149F95769@BL1PR12MB5096.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6vj+CmqGPoS+IdnKq808awTf2W+Hrxu1M2OkzJ89l8nvHbekLGX2gwjb8lS09T0EpPwDT0MrENCuXBhr1bAuaZx8KVje0OU5uG5qhcw4Dzuw3PuywuyQmp5T/p8xwLoQg5MRWblWv9E4ZR2Wp33xUa6DFE0PWG1pcYrNdfiJItf/+OShuYbneAVDneNmeGi3VUemhLxp2puaNPJYTDXRgAhn7hAzvowzz1+CKWWn3aHiVLaXz8OhO9fht2er3mF1ANIMHLSlucMLI8GI3S2eb41JLBk+6W9wQx/wHeA5n+jbRCxHuTZj6o4i/lkjPE+EPSdqiYni2zlxDpGUd75zUJkRQb/gUfSsyRBgmLVJYLFK5wR+QTm4NbDjyQsJvTDKv6xCiU53zer4qsgnfUYn5i07AyKU+zwfsO3Yfz6ZVGM5vKzvCB5IuqJ2ujULBX7jli7bIlgMessuDtweXFihmFv4IBOODrSulfZppMHDMkMsXjniHDC6Bj5Sn7rs1Huaz2qJ7oETQ4k1rh+MPZX/TATlVAhN5eI/mfW9iOczeHcYZOSqNXVIaR3Vxw3SGJmFSJeIKxUJ+eVFoP39NUl/rtXvBprfZ/b/lmPZqXrtMAa8WRhadQv2NeX1FpnzuGAeqhsBeVM2G66A/Bs0BVISbXpsr5WFCZH1e3eNbz5u5Rkxi6jIXvDVCZSZ4BkqauW1I+RwazX296MvHNgVRzvQeo20HOoHV6ErVtxlE4vWWkTVuwsmtinL7kZUOn0yTUgLhnZzylgT60HfgshZ22yJyb3Ap/szCsdyvw2rKNY49fIgiFbVMOZyANq+utZZJjlK8W+bYHSjo2vxMfZq6JOtBBfpllDNu425/JYoYqKGvofQYjxQv3D3hZQgJhwXMV5d
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(47076005)(82310400004)(8676002)(4326008)(7416002)(5660300002)(7406005)(356005)(8936002)(40460700001)(36860700001)(81166007)(70206006)(2616005)(26005)(6666004)(1076003)(6916009)(36756003)(16526019)(70586007)(45080400002)(508600001)(336012)(186003)(44832011)(53546011)(316002)(2906002)(4001150100001)(86362001)(54906003)(426003)(966005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 17:52:27.9704
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5af497e-5be6-485b-dfeb-08d9bff3a8dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5096
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Dec 14, 2021 at 06:14:34PM -0600, Venu Busireddy wrote:
> On 2021-12-14 20:10:16 +0100, Borislav Petkov wrote:
> > On Tue, Dec 14, 2021 at 11:46:14AM -0600, Venu Busireddy wrote:
> > > What I am suggesting should not have anything to do with the boot stage
> > > of the kernel.
> > 
> > I know exactly what you're suggesting.
> > 
> > > For example, both these functions call native_cpuid(), which is declared
> > > as an inline function. I am merely suggesting to do something similar
> > > to avoid the code duplication.
> > 
> > Try it yourself. If you can come up with something halfway readable and
> > it builds, I'm willing to take a look.
> 
> Patch (to be applied on top of sev-snp-v8 branch of
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2FAMDESE%2Flinux.git&amp;data=04%7C01%7Cmichael.roth%40amd.com%7Cbff83ee03b1147c39ea808d9bf5fe9d8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637751240979543818%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=DZpgEtthswLhhfWqZlLkHHd5nJW2jb%2FVFuTssAFJ6Uo%3D&amp;reserved=0) is attached at the end.
> 
> Here are a few things I did.
> 
> 1. Moved all the common code that existed at the begining of
>    sme_enable() and sev_enable() to an inline function named
>    get_pagetable_bit_pos().
> 2. sme_enable() was using AMD_SME_BIT and AMD_SEV_BIT, whereas
>    sev_enable() was dealing with raw bits. Moved those definitions to
>    sev.h, and changed sev_enable() to use those definitions.
> 3. Make consistent use of BIT_ULL.

Hi Venu,

I know there's still comments floating around, but once there's consensus feel
free to respond with a separate precursor patch against tip which moves
sme_enable() cpuid code into your helper function, along with your S-o-B, and I
can include it directly in the next version. Otherwise, I can incorporate your
suggestions into the next spin, just let me know if it's okay to add:

  Co-authored-by: Venu Busireddy <venu.busireddy@oracle.com>
  Signed-off-by:  Venu Busireddy <venu.busireddy@oracle.com>

to the relevant commits.

Thank you (and Boris/Tom) for the suggestions!

-Mike

> 
> Venu
> 
