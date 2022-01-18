Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFEC8492888
	for <lists+linux-efi@lfdr.de>; Tue, 18 Jan 2022 15:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241509AbiAROiD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Jan 2022 09:38:03 -0500
Received: from mail-bn8nam11on2066.outbound.protection.outlook.com ([40.107.236.66]:31232
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245635AbiAROhy (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 18 Jan 2022 09:37:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BA0iG+ULplQSrOTW0hxc2Cg7WSMiP2iXCl+besc147VzWjFxDTkjvzlQiHkNnhNhiMCWAutydsx3h+uxVGVzPDMxjQ6rp0SvYjqxLvPFR9p2UTzn4OPN3M0DnxzAUfB2Im+AEs/W0/LdkHHW2t7qiJA81MMmngCnMkk7ZaK7qCJWzuTi8kJ0YOe45NM/K5suhQPkwto/+Y3jly9VbW3oAZADgpYob2YkYd9y3jJysedDTjFs4C0xZ/aDJImuwXUwlBdFIHD0imQN6VU5d5sXX31VNkz5N/o+lBCPP8zX6ylu0AcCwWsFTmFw4BD2Uyg9Httv7jLjMT0R0iyx0WTUiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhnhaCxcmrW5xjD2TObMDQfVHXvaF+V3u+RbvouJJeY=;
 b=KlaqgZUn2cXjUGUuoMxZbMT5flNZbkexe7Tr4B1fwUldPlT/uqdyIR4JgdzL7OYIZg6VokvWTV/KiIS855o2bt5g/8pG5ihXWagTsXz6X40mm8UGN+GEUs+KcS/wkF7alJHviOCWiwgNJC3MoDlty2HrYQZx0A0c7kj6fAIfVsK2tPA0LMw8Y24U3/bBGQiEMi7q0ylQbhvwq/JEcd9pXlD+uT5QsZubnL7WQ+/h4HB53zEAJneigKD9qHUJ9Ncjh7iYKuZyStqkS72aB497J9+c3gcwdik7sl3uhZyxVLMd9NLiZ8AVVMy6oKrSvzphsfBRiOq3F9hkCtgBUgwVLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhnhaCxcmrW5xjD2TObMDQfVHXvaF+V3u+RbvouJJeY=;
 b=sww1FLJgS1QFNDxTnoXkPZGFV6M5RY17FiOBmhkVQRb4oFQWWJtYpbZU+nSP0tPUvez18kAu9WvtrneSIOTA+HVusaz+olySpVfT3Dlgtb7f9xv92wehXVCvpKZgMC11sjuuX4lrk2La5CILUTr5gfV8CEzIF2gf4LqfT0AY2V0=
Received: from DS7PR06CA0036.namprd06.prod.outlook.com (2603:10b6:8:54::14) by
 CO6PR12MB5459.namprd12.prod.outlook.com (2603:10b6:303:13b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Tue, 18 Jan
 2022 14:37:51 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::cb) by DS7PR06CA0036.outlook.office365.com
 (2603:10b6:8:54::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10 via Frontend
 Transport; Tue, 18 Jan 2022 14:37:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Tue, 18 Jan 2022 14:37:49 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 18 Jan
 2022 08:37:48 -0600
Date:   Tue, 18 Jan 2022 08:37:30 -0600
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
Message-ID: <20220118143730.wenhm2bbityq7wwy@amd.com>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-30-brijesh.singh@amd.com>
 <YeAmFePcPjvMoWCP@zn.tnic>
 <20220113163913.phpu4klrmrnedgic@amd.com>
 <YeGhKll2fTcTr2wS@zn.tnic>
 <20220118043521.exgma53qrzrbalpd@amd.com>
 <YebIiN6Ftq2aPtyF@zn.tnic>
 <20220118142345.65wuub2p3alavhpb@amd.com>
 <20220118143238.lu22npcktxuvadwk@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220118143238.lu22npcktxuvadwk@amd.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4dbac7d-ecca-43bb-0665-08d9da9019da
X-MS-TrafficTypeDiagnostic: CO6PR12MB5459:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB5459085B7FB182F32496101295589@CO6PR12MB5459.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kvcHbVw4BAH93+yfnO/WM7aa7tb5I0t9No8QRwWk3jC0Ye9dmDxcgKpIBuKgn14cU7cBncTuEZDKjfhM5FLp6O6zEHXvKhxQC9S7+7hF2y3qP3twytoS5IUsMl29yFliYHQeTdTBjrmsaeZIfnvojPNQaUob4q6OF/NDtPqDqWIqlMMaGvDySSIU8xo795VWTt3HW8lacQE5LuPTBDFbQjstRTKlwbXItwzBBa3coZ8I8by+8lGkF4bxlnnwsN4O4umH9dFVvb/0OWIwTrs+eCa9qjWieMh7IIG4o1zSYRou7d8zZ0tvPMc1Uj7osi6W9Sh2IutNfpG3ohCaFz4izpqeQbcKSgX2vZJFrxTDtlIGstnhO3slv9h0oMDUyDCNOXLXpnvBHprsP/P6iCzsSFLSCGz+g5x7M/bNaXFAPgAWE7uesbsuRC5AziSO97m+HLIYb2IqGHoQ/vs+TBIdzpzRryg1VYVi7uRopXaxn2WiVG4EerPiPU8haW+xFZ+OS2YGXztXhIxIIwzH6mucS4hbGitmIOU7iFzvXdMGNglTkySnOUTFeD7KqJrkpK4u4j8aL49OO6SeVr+l+XIggPUFoYJxptBRfptpWzSZEd+KhokBK0SCpqyyJELsNCppeOSHBkcfRuXZzKhpA6ki/DYekQL+kVMBuv1xRt4NxxYppLPOKd9Lye+OrLnoCyJGHK/PDOYj+y+N/s8EdG2omTafBzFAPHIxaOpqEzddWw/fLAP5lCutA9ZGUYMPbqVb/LThkJghYrbYr2KNxEkSJ6nzGv3O93y1SgKupdN2qBQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(40470700002)(36840700001)(1076003)(44832011)(2616005)(186003)(36860700001)(426003)(316002)(70206006)(70586007)(8676002)(54906003)(16526019)(336012)(47076005)(8936002)(40460700001)(508600001)(82310400004)(86362001)(6666004)(81166007)(4326008)(5660300002)(356005)(83380400001)(7406005)(36756003)(26005)(7416002)(2906002)(6916009)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 14:37:49.2719
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4dbac7d-ecca-43bb-0665-08d9da9019da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5459
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jan 18, 2022 at 08:32:38AM -0600, Michael Roth wrote:
> On Tue, Jan 18, 2022 at 08:23:45AM -0600, Michael Roth wrote:
> > On Tue, Jan 18, 2022 at 03:02:48PM +0100, Borislav Petkov wrote:
> > > On Mon, Jan 17, 2022 at 10:35:21PM -0600, Michael Roth wrote:
> > > > Unfortunately, in sev_enable(), between the point where snp_init() is
> > > > called, and sev_status is actually set, there are a number of cpuid
> > > > intructions which will make use of do_vc_no_ghcb() prior to sev_status
> > > > being set (and it needs to happen in that order to set sev_status
> > > > appropriately). After that point, snp_cpuid_active() would no longer be
> > > > necessary, but during that span some indicator is needed in case this
> > > > is just an SEV-ES guest trigger cpuid #VCs.
> > > 
> > > You mean testing what snp_cpuid_info_create() set up is not enough?
> > > 
> > > diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> > > index 7bc7e297f88c..17cfe804bad3 100644
> > > --- a/arch/x86/kernel/sev-shared.c
> > > +++ b/arch/x86/kernel/sev-shared.c
> > > @@ -523,7 +523,9 @@ static int snp_cpuid_postprocess(u32 func, u32 subfunc, u32 *eax, u32 *ebx,
> > >  static int snp_cpuid(u32 func, u32 subfunc, u32 *eax, u32 *ebx, u32 *ecx,
> > >  		     u32 *edx)
> > >  {
> > > -	if (!snp_cpuid_active())
> > > +	const struct snp_cpuid_info *c = snp_cpuid_info_get_ptr();
> > > +
> > > +	if (!c->count)
> > >  		return -EOPNOTSUPP;
> > >  
> > >  	if (!snp_cpuid_find_validated_func(func, subfunc, eax, ebx, ecx, edx)) {
> > 
> > snp_cpuid_info_get_ptr() will always return non-NULL, since it's a
> > pointer to the local copy of the cpuid page. But I can probably re-work
> 
> Doh, misread your patch. Yes I think checking the count would also work,
> since a valid table should be non-zero.

Actually, no, because doing that would provide hypervisor a means to
effectively disable CPUID page for an SNP guest by provided a table with
count == 0, which needs to be guarded against.

But can still implement something similar by having snp_cpuid_info_get_ptr()
return NULL if local copy of cpuid page hasn't been initialized.
