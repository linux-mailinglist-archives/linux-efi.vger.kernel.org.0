Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96343492878
	for <lists+linux-efi@lfdr.de>; Tue, 18 Jan 2022 15:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245448AbiAROdE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Jan 2022 09:33:04 -0500
Received: from mail-mw2nam08on2080.outbound.protection.outlook.com ([40.107.101.80]:35904
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245344AbiAROdA (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 18 Jan 2022 09:33:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GagQTjlTefZayW5oXHp8OeOBhJ+ED71fwBGTgtYzucw69rMQKZzu6got7HyY5Fm3JF6qQib1wGXIloXWs8IKuwaJt7NU28Dr9acVv+KOWLb2wAEdZbKRGDDR8w2KIkOG+AF/i2ICCNKZj38G52zW0pB1j1QKpehYc5EG5abnHjEm+ZDTS3Oy+gqv89fi7/C24CwOhbbOHjsORG6M92CZZfLV0wa1dkQLvlhFo2dpyHIv75e6zslFnmdmtRBcAMq69hgCTHgNTHxyr9aydP9x25rd7YDSeAESCVWrBKkiw784nimOiEyek1kUw2Xhrqrf6Cq8Jc1n4wE4DRxlmzAdqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXclLcIqW+bGjplCdNGS6o403c166KgsOt5LJ3CC+mY=;
 b=YHuq2UQHmCDmkFT7PVa817k38n3Hz89u6NgIDq5qpQUxA3naJRPOe+uoa9XKBJluTJoWJeUXN+X8vsy2CK2+HN7gqs7n6BYqAq7lrQoUl+kDUpAOwc99/T7fn18izG25xmMf60ueYNUz/n+abDGHBXZXwVjMhtnM4arVc8MMs8Mv4bU2PRYtKGgYG9FpjIfn0ZXt2dVR/ZTL8aR/tp72L2baMxWW0QIaVlVxN67OFPoxsW6fJERPa2vsAp2ZfuG7d3v7W23BrKqzNPy7gs107z3Ug5MWVcxIKCiDfZyqkyaYUX1N/YgsO9tUn3M2Z7k6KjcZWB/4KjJbzROGtdewZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXclLcIqW+bGjplCdNGS6o403c166KgsOt5LJ3CC+mY=;
 b=TXr6v0lff+Ir8TmhRN4N+HnymhJv5KRjmP9ia+zF1Jqdq87PGK/gQzH73cfhdJqhZ6bsHPQ1GlUP8Xj6kQrUpvBBWGdyvk0sOU21X9ObMXGRIv7qk0BU4EQygBaDZi5A+zPk+CqrMCa2b3+VYF+wGaaLA3EaMX7cZbFvvewTReU=
Received: from MW4PR03CA0356.namprd03.prod.outlook.com (2603:10b6:303:dc::31)
 by SN6PR12MB2735.namprd12.prod.outlook.com (2603:10b6:805:69::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Tue, 18 Jan
 2022 14:32:57 +0000
Received: from CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::e9) by MW4PR03CA0356.outlook.office365.com
 (2603:10b6:303:dc::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11 via Frontend
 Transport; Tue, 18 Jan 2022 14:32:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT053.mail.protection.outlook.com (10.13.175.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Tue, 18 Jan 2022 14:32:55 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 18 Jan
 2022 08:32:54 -0600
Date:   Tue, 18 Jan 2022 08:32:38 -0600
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
Message-ID: <20220118143238.lu22npcktxuvadwk@amd.com>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-30-brijesh.singh@amd.com>
 <YeAmFePcPjvMoWCP@zn.tnic>
 <20220113163913.phpu4klrmrnedgic@amd.com>
 <YeGhKll2fTcTr2wS@zn.tnic>
 <20220118043521.exgma53qrzrbalpd@amd.com>
 <YebIiN6Ftq2aPtyF@zn.tnic>
 <20220118142345.65wuub2p3alavhpb@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220118142345.65wuub2p3alavhpb@amd.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f77ca88e-ce5a-4ef3-ef06-08d9da8f6af4
X-MS-TrafficTypeDiagnostic: SN6PR12MB2735:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB2735F51BAFD54890D6B5769C95589@SN6PR12MB2735.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NNxvmp8c/TSGYoh19cEP3QC9OuyFsZ91Nt0ubT6+sQD4EsdIbgDDPTFvbd/52uaBo7axmC2PeXf5Ymbij2O59jpEeJw/XWtPXCP6aClGLV0T9EK/YfKK8lOHjkaqkUn2Gy7WtkuO83YrABe6almcqui9S8rhAXISHp58El7YUDWIW3U3QFXHZv9ow4RtqqsSstAZQ6+RtgZqnvpA4je6EUQ2WX9XwhPfgEfSfvAzv9NkIdpnLssP0j0npHeWo6idsQ9cWYE8748pdcUuIn1+MLTVihqlZMwmr7Qc51bmnc9WlbsDcdAM/OWmo1VLSvOtnK/50+UWTcMDSMYv4RDLn/MmIxwXp/mK95VB/T4qSuskyTPBqU+1l9sB4NnRtMtu6sT6nS69dmC4yCTc172uLXCvu1nQDHD4zlM134pdu6nfzVh5K4v20LMES4kLCrxryoXehjqMJafGWyd16ITl3kt6sDUTdbtS4mbIoQ92+oXMep1gJijioLQnXqer0VPBGr0JbpFkipgKSGiY7zQkEriE21pNJJAXtrHLmYAJwSsQI9qt+qt4sKWFgUFiwxRxuxuJ5MR35AFrE7eU2Eljt08z0toSIE67xP0NNeJckx2d+EtkBkQC/7vJHEOQHoKGEMhDrWnbumqMtcbOtkS4G29+CIFu5YaNXbPKx5Aa9DBpwhnzLIRSSRBHj2GJ9i7k5S/4hq2LT7JYimPqi1EI0HZO7V8ULTKe1AkQFO4FZkvH52jtxaQoIlBTTREC2qHJ2D90LsjJ4esT5PUTdVl0jU27el+ebvXuyastYM9SRuk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(40470700002)(46966006)(36840700001)(40460700001)(26005)(70206006)(316002)(36860700001)(426003)(6666004)(1076003)(4326008)(70586007)(82310400004)(5660300002)(2616005)(336012)(16526019)(44832011)(186003)(7406005)(7416002)(2906002)(8936002)(6916009)(508600001)(86362001)(36756003)(54906003)(81166007)(356005)(47076005)(83380400001)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 14:32:55.7376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f77ca88e-ce5a-4ef3-ef06-08d9da8f6af4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2735
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jan 18, 2022 at 08:23:45AM -0600, Michael Roth wrote:
> On Tue, Jan 18, 2022 at 03:02:48PM +0100, Borislav Petkov wrote:
> > On Mon, Jan 17, 2022 at 10:35:21PM -0600, Michael Roth wrote:
> > > Unfortunately, in sev_enable(), between the point where snp_init() is
> > > called, and sev_status is actually set, there are a number of cpuid
> > > intructions which will make use of do_vc_no_ghcb() prior to sev_status
> > > being set (and it needs to happen in that order to set sev_status
> > > appropriately). After that point, snp_cpuid_active() would no longer be
> > > necessary, but during that span some indicator is needed in case this
> > > is just an SEV-ES guest trigger cpuid #VCs.
> > 
> > You mean testing what snp_cpuid_info_create() set up is not enough?
> > 
> > diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> > index 7bc7e297f88c..17cfe804bad3 100644
> > --- a/arch/x86/kernel/sev-shared.c
> > +++ b/arch/x86/kernel/sev-shared.c
> > @@ -523,7 +523,9 @@ static int snp_cpuid_postprocess(u32 func, u32 subfunc, u32 *eax, u32 *ebx,
> >  static int snp_cpuid(u32 func, u32 subfunc, u32 *eax, u32 *ebx, u32 *ecx,
> >  		     u32 *edx)
> >  {
> > -	if (!snp_cpuid_active())
> > +	const struct snp_cpuid_info *c = snp_cpuid_info_get_ptr();
> > +
> > +	if (!c->count)
> >  		return -EOPNOTSUPP;
> >  
> >  	if (!snp_cpuid_find_validated_func(func, subfunc, eax, ebx, ecx, edx)) {
> 
> snp_cpuid_info_get_ptr() will always return non-NULL, since it's a
> pointer to the local copy of the cpuid page. But I can probably re-work

Doh, misread your patch. Yes I think checking the count would also work,
since a valid table should be non-zero.
