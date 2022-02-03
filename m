Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C552C4A88E9
	for <lists+linux-efi@lfdr.de>; Thu,  3 Feb 2022 17:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbiBCQpu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 3 Feb 2022 11:45:50 -0500
Received: from mail-dm6nam12on2059.outbound.protection.outlook.com ([40.107.243.59]:48385
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229579AbiBCQpt (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 3 Feb 2022 11:45:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fcf5L1O482YC3KSKA/SfKptdTPGBmUfrboKW6UtJmxxvv8Smo668yZw9M/RUP6snev+tLsuUrbTI0cjX4S1l5vTvk62t0jSK0XGLoBjL7TZEhgoIRtfkU45FaF+Km3lKoWQoJU2UrpaYaF0HvsvLX7Py6F6y/4oRo/yy8zl80YTjLmOwW3L8ycuZGiQ+dpg9A95R6yY2v14sAJXy8i+A0ZNzwm4iSnZI0v1rRkjwqK7eLe7wj0p64RJgIKk9hKnU5FNALqLKigeUXCklK7G7zLuhhaSKyDX57IZWdUIBHgv+m4LdEzwEj9WsGnED1mPZFUewriYIQuk36T7n0I69Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPXd+aIf5W7FbaQ4J9y/rSH7rfR0DoPweK6GLzu7um8=;
 b=Bz/+ALyBCbK3Z+y0G5+xv76Zmyv30mCoLWLPu4aZUz4P/Lbd3mnLNsgbdI3lRq3H0n3RdAj8RXUvx4jqErwSCd8KPi5XA1wPtkSq6ZYrvP27v0+1RhqbIA/9iN8fkmqSYWUkPOdB7j5sJS4nGRLy2IycRDYqz4i2snZBKVw4rxDm0Aw4kc+y+69m5GxpqaJH2bqADKehTId87G/7bXo/eAPfPu3wcfewH6IqZpWsNFcI1+XZBnvMi6/MeXWy30rgSpQCn/H6QpFLEEA23G6/3Z7Dp5po9Xy5GNetyzarRnWgPQ9GB31zG+AXKqkk/g49PVHXZ5vsJa4/4yqo+OnbNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPXd+aIf5W7FbaQ4J9y/rSH7rfR0DoPweK6GLzu7um8=;
 b=rzR7QM5VK0950mR1JsEySZMYMYsy5n/cWzCAUAf6sMPUAfYkF/PNNX42ZvQFUl2MUiK7jW7hB329WLVcSEJHdYTI28eTXQTRaHxsukFQjDN2UX+KwrpCZ8Jl+/KL+Ny0LM0NFOZ3gX6HYGZNptWvLpUOXaa3QAic0VNhtCu0MJU=
Received: from DM5PR17CA0070.namprd17.prod.outlook.com (2603:10b6:3:13f::32)
 by CH0PR12MB5329.namprd12.prod.outlook.com (2603:10b6:610:d4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 16:45:47 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13f:cafe::16) by DM5PR17CA0070.outlook.office365.com
 (2603:10b6:3:13f::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14 via Frontend
 Transport; Thu, 3 Feb 2022 16:45:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Thu, 3 Feb 2022 16:45:45 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Feb
 2022 10:45:45 -0600
Date:   Thu, 3 Feb 2022 10:44:43 -0600
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
        <marcorr@google.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Venu Busireddy <venu.busireddy@oracle.com>
Subject: Re: [PATCH v9 23/43] KVM: x86: Move lookup of indexed CPUID leafs to
 helper
Message-ID: <20220203164443.byaxr4fu2vlvh4d2@amd.com>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-24-brijesh.singh@amd.com>
 <Yfvx0Rq8Tydyr/RO@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yfvx0Rq8Tydyr/RO@zn.tnic>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59963bf5-d951-4c45-ae39-08d9e734a007
X-MS-TrafficTypeDiagnostic: CH0PR12MB5329:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB53290F5DF085F8B35EFEAE6195289@CH0PR12MB5329.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mwdPCPrfJvBHrozr0Sgb8ZBehs1F9mj9KPTTrxlIBoWwL9YkyTWedSNff+iPpVNgaQe0meGpBcjEEQSDZ/rG5ALntGbmIy6UJysP5g8opBsfLszbNueIB3NhxxImAEipnR2V7FvF3vlwn9kxhZ1NgZ9o+QUgHv8UWL4qYeNCrJ4y14oczbMxwxgH4ldqNDmf0n/QhdBFcn8o/gflchrT2bNU1lHe/djtbPwT+cD3j5QworbLn9NXPdeZDfIU1pEnKT+kWvcoMn8fc6EKOhUm8SFwlgRGu4uYltwM3xBTuzVUQuCnaGPFNn6SKllpmhReu1L9Y72xT9a2Yxj61PJL7xaoDP8oY70cfDqN6ZQ1zb9CplB7y+T4ceQgU0t9Hs7M4jAMRIbbjAbtFPd/KSS2UBn1XWa29PuHIz+7kn2m2M6l73hl+ArB5a1VwaaIpqE4BdulAI9GCKYq9eYy1c4QYB/YwP9GfwTFxSTJpDxR5yI7azFXvfvCJnxeCzDK6/5yVB0njtE0uBhx22LASpkjrYbQdKpVCFa+kzg0HsUWiHeaiMc3L/B+urlQmYduFDTyvbVWwnWAF1iANUV9kkuwhsWEppvQIl2VZ0ptzqWLOmRYYzMH4H5VtVVmAPZgbFwz3F2Kwl4Li/GyS6vBbuqUgKSHYpMXk6wi1sQ4KVjvYl3j+VDNu1cp0yYby4xGSd72w9BFx1dnedb4wY/FCNJaWLAhMRF5pPHh6vf/GKJk9W/MCESyPvQAH4b/zeeJYBNdH5MaHsLLbxff5fmfRg+V8bjnZVRVMfsOh8VMO+X5uxfnM7RxZVMZK2HtNPy/SvXP4BC3iXeMHwE91NIPXSH7Ew==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(508600001)(2906002)(36860700001)(6916009)(40460700003)(82310400004)(45080400002)(44832011)(86362001)(54906003)(7416002)(7406005)(5660300002)(36756003)(83380400001)(186003)(47076005)(316002)(8676002)(1076003)(70586007)(2616005)(8936002)(70206006)(16526019)(81166007)(426003)(336012)(4326008)(26005)(966005)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 16:45:45.7559
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59963bf5-d951-4c45-ae39-08d9e734a007
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5329
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Feb 03, 2022 at 04:16:33PM +0100, Borislav Petkov wrote:
> On Fri, Jan 28, 2022 at 11:17:44AM -0600, Brijesh Singh wrote:
> > From: Michael Roth <michael.roth@amd.com>
> > 
> > Determining which CPUID leafs have significant ECX/index values is
> > also needed by guest kernel code when doing SEV-SNP-validated CPUID
> > lookups. Move this to common code to keep future updates in sync.
> > 
> > Reviewed-by: Venu Busireddy <venu.busireddy@oracle.com>
> > Signed-off-by: Michael Roth <michael.roth@amd.com>
> > Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> > ---
> >  arch/x86/include/asm/cpuid.h | 38 ++++++++++++++++++++++++++++++++++++
> >  arch/x86/kvm/cpuid.c         | 19 ++----------------
> >  2 files changed, 40 insertions(+), 17 deletions(-)
> >  create mode 100644 arch/x86/include/asm/cpuid.h
> > 
> > diff --git a/arch/x86/include/asm/cpuid.h b/arch/x86/include/asm/cpuid.h
> > new file mode 100644
> > index 000000000000..00408aded67c
> > --- /dev/null
> > +++ b/arch/x86/include/asm/cpuid.h
> > @@ -0,0 +1,38 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Kernel-based Virtual Machine driver for Linux cpuid support routines
> > + *
> > + * derived from arch/x86/kvm/x86.c
> > + * derived from arch/x86/kvm/cpuid.c
> > + *
> > + * Copyright 2011 Red Hat, Inc. and/or its affiliates.
> > + * Copyright IBM Corporation, 2008
> > + */
> 
> I have no clue what you're trying to achieve by copying the copyright of
> the file this comes from. As dhansen properly points out, those lines
> in that function come from other folks/companies too so why even bother
> with this?

I think Dave's main concern was that I'd added an AMD copyright banner
to a new file that was mostly derived from acpi.c. I thought we had some
agreement on simply adopting the file-wide copyright banner of whatever
source file the new one was derived from, since dropping an existing
copyright seemed similarly in bad taste, but if it's sufficient to lean
on git for getting a more accurate picture of copyright sources then
that sounds good to me and I'll adopt that for the next spin if there
are no objections.

  https://lore.kernel.org/linux-efi/16afaa00-06a9-dc58-6c59-3d1dfb819009@amd.com/T/#m88a765b6090ec794872f73bf0ee6642fd39db947

(In the case of acpi.c it happened to not have a file-wide copyright banner
so things were a little more straightforward for the acpi.c->efi.c movement)

> 
> git history holds the correct and full copyright anyway...
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7CMichael.Roth%40amd.com%7C189a90d4aa3e459f7d7908d9e7282f9c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637794982059320697%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=T95Les9sx71RFXYAImDag9%2FclmImsnjMbzPkOvIsbbY%3D&amp;reserved=0
