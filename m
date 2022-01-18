Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818EC49284C
	for <lists+linux-efi@lfdr.de>; Tue, 18 Jan 2022 15:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245227AbiAROYI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Jan 2022 09:24:08 -0500
Received: from mail-dm6nam12on2046.outbound.protection.outlook.com ([40.107.243.46]:25249
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242710AbiAROYH (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 18 Jan 2022 09:24:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNID0mm5QiW0V0OxZBS+hwcUizbInkGm8EIe1OJ/x2Xh2RiKg5uHiL/dm6lTGHO24kvKiZqmTa88a/hkhCkRx9wHykUOGKhTZyNxstUOFhgunKruWsuVh9EvmYT26+YaxgcXgBrpC6bsuXeBoCCBfEs0fO4PumEjicFvdSVj8qyQb317zsg7RhSSIcccnWy/oyRY/WzHSq+VLul1yS8crZCDAADxujcyziBIvxCp97q2Qu/QngsfLqkx6xCamhz2BEsbWuzapo3IEuMnGqFxpmjEQr820y4YrfvxEL4OPy9rqwyNeIIHzSfnhdiQvRH4LI1qzIOOwAkM83in28m3IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JdfGxe0vbJjV1YGRy6ut1yyYm4IRJcNnykyDDysT5fY=;
 b=huKg7aN+fKIn2pItRckLxDBR4c1uhPfof7HaZkwUTJjulnDE8ePBS8oHsHUJsw7LCMn30L03XG6XvRiGmpmZuhRg5iVaM3ET11Ej3hfC/r1PFuvdMp7rLsrMulYdZ8V96h9OU9kWlDoiIsn+kd0RVnD7X1vg+yLa/00EmIZvtbVGg7LtaTg5f0e9yhLInxo1P2O6b3M8oKu7gAWikcqZVTP/UitIvDIjHDDltKHh6+i0ndbu59et8uE5S9SWKPXkbqWd7IUc2O3HeKABxVxCTrpZ9SzhXjKu/RASGOI9uad39iWYfFnPx2eFSIo1E7/BvtDEa/koqEG/mCMOj1hdaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdfGxe0vbJjV1YGRy6ut1yyYm4IRJcNnykyDDysT5fY=;
 b=nePa/I6GtsjiI051b08rih/V7UbnYMxABn/GwZPCTeh0qsKdJV5PV/mQ6+v+XBKlFcQ1KHcqj5MpXI0hZgzkWGoYfIZ+r/8Lv63Gn1B73pjRA6+d/H2c2xV8485z3L8JqtzdBwgsKwB2+zC0jsZbym8oqwiZNodo765nlrLBeAE=
Received: from BN0PR04CA0011.namprd04.prod.outlook.com (2603:10b6:408:ee::16)
 by MN2PR12MB4093.namprd12.prod.outlook.com (2603:10b6:208:198::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Tue, 18 Jan
 2022 14:24:05 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::11) by BN0PR04CA0011.outlook.office365.com
 (2603:10b6:408:ee::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11 via Frontend
 Transport; Tue, 18 Jan 2022 14:24:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Tue, 18 Jan 2022 14:24:05 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 18 Jan
 2022 08:24:04 -0600
Date:   Tue, 18 Jan 2022 08:23:45 -0600
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
Message-ID: <20220118142345.65wuub2p3alavhpb@amd.com>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-30-brijesh.singh@amd.com>
 <YeAmFePcPjvMoWCP@zn.tnic>
 <20220113163913.phpu4klrmrnedgic@amd.com>
 <YeGhKll2fTcTr2wS@zn.tnic>
 <20220118043521.exgma53qrzrbalpd@amd.com>
 <YebIiN6Ftq2aPtyF@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YebIiN6Ftq2aPtyF@zn.tnic>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15d5387d-b403-4f58-928d-08d9da8e2e95
X-MS-TrafficTypeDiagnostic: MN2PR12MB4093:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4093FEA4375B0A9D7E60196895589@MN2PR12MB4093.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GSdSSeRSgrdLkwru3GbvunGgdc7KvGlp2iDV2wJXOlhUDxtsGFVS5SaGcQm54NamPM/1NkWvq24C0kbBN7cX9R5c59IZ2VnVm4jnzB9wS5q+briZPsF2YFWKt1a+zbpG4mvaoEZPFHhNn/3lOAcJ24pWXvC46NJOtPMSc4VtKTPwg3s9CDTnGxtZdMMhRPMtZ1Yysm0BKDF3a5HboLDtnVyR6wCpeU+lzr5KfkfWO6DyLNvwujIZ+J9+j7wM7GMqlVbUekJvtBLR/72VWX9m4Wlpi/Q1lfb5/Q0bJsFC4tf4iru20rfGAdRCpe38voXM6DpistakGAweF2Oz1niG5YfJszlC9EwEkcTfTOmjt8qAlvR8b4nYFbqY/oIsYyuVVVmtELzM6cqE3MyyOFzdJjaq6J0324HAfoCGa690UCjqywzzxueYsOTQR/VpSPewwKEi3clYX1IjQ3Zpuu7LxwFQHOd2MrLSRKCO/bTqVooHuxf5k9Z7MLAuCp4YRsVYcO021mJBVjxYfzNV027n2fC4XQj6Zb0Aew9oe3YvXklAltEL/ypNp7WHDsIySes+q1w2wvtRjQBDseGDCz1E1R5SKh1ZrbFibNm2VKky7/6hGb9oTyDUC4A6DFWKjbLUDUdPrFxQhBETkmOOTYKXdiwWwuMTmq1Q7uKyrJVWNSNxGsuBC+aUIEPS2worWCkwKJ3RQEUcmDh4vLd8XmBM51SfevUSWC3EujHsEUVK+Aw6qtXtsT8Qb8w18XlquXWDtvIj9MG34HzgNAxktS3skwIHe6JfZipKHynTycckOQphcM/fU42/ZySH1nOpzSWkXl1A8sCSpmxBB04/JrmzWiwKh7Yb/wkiz8pOpgLfB77d4h+t8sdn1dVYElXlMF/M
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700002)(26005)(186003)(70206006)(44832011)(7406005)(7416002)(966005)(81166007)(6916009)(70586007)(2616005)(336012)(508600001)(86362001)(45080400002)(83380400001)(4326008)(8676002)(16526019)(426003)(5660300002)(8936002)(40460700001)(6666004)(1076003)(36756003)(36860700001)(356005)(47076005)(82310400004)(2906002)(316002)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 14:24:05.0932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15d5387d-b403-4f58-928d-08d9da8e2e95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4093
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jan 18, 2022 at 03:02:48PM +0100, Borislav Petkov wrote:
> On Mon, Jan 17, 2022 at 10:35:21PM -0600, Michael Roth wrote:
> > Unfortunately, in sev_enable(), between the point where snp_init() is
> > called, and sev_status is actually set, there are a number of cpuid
> > intructions which will make use of do_vc_no_ghcb() prior to sev_status
> > being set (and it needs to happen in that order to set sev_status
> > appropriately). After that point, snp_cpuid_active() would no longer be
> > necessary, but during that span some indicator is needed in case this
> > is just an SEV-ES guest trigger cpuid #VCs.
> 
> You mean testing what snp_cpuid_info_create() set up is not enough?
> 
> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> index 7bc7e297f88c..17cfe804bad3 100644
> --- a/arch/x86/kernel/sev-shared.c
> +++ b/arch/x86/kernel/sev-shared.c
> @@ -523,7 +523,9 @@ static int snp_cpuid_postprocess(u32 func, u32 subfunc, u32 *eax, u32 *ebx,
>  static int snp_cpuid(u32 func, u32 subfunc, u32 *eax, u32 *ebx, u32 *ecx,
>  		     u32 *edx)
>  {
> -	if (!snp_cpuid_active())
> +	const struct snp_cpuid_info *c = snp_cpuid_info_get_ptr();
> +
> +	if (!c->count)
>  		return -EOPNOTSUPP;
>  
>  	if (!snp_cpuid_find_validated_func(func, subfunc, eax, ebx, ecx, edx)) {

snp_cpuid_info_get_ptr() will always return non-NULL, since it's a
pointer to the local copy of the cpuid page. But I can probably re-work
it slightly that so snp_cpuid_info_get_ptr() does the same check that
snp_cpuid_active() does, and have it return NULL if the copy hasn't been
initialized, if that seems preferable to the separate snp_cpuid_active()
function.

> 
> ---
> 
> Btw, all those
> 
>         /* SEV-SNP CPUID table should be set up now. */
>         if (!snp_cpuid_active())
>                 sev_es_terminate(1, GHCB_TERM_CPUID);
> 
> after snp_cpuid_info_create() has returned are useless either. If that
> function returns, you know you're good to go wrt SNP.

It seemed like a good thing to assert in case something slipped in later
that tried to use snp_cpuid() without the table being initialized, but
if I implement things the way you suggested above,
snp_cpuid_info_get_ptr() will return NULL in that case, so we get that
assurance for free. That does sound cleaner.

> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7Cmichael.roth%40amd.com%7Cb8be348c4db84954006708d9da8b3820%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637781113782595576%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=HszNjYntQNNI827LNK4H8Tpx0vhpICo7y3FCzIvhNtc%3D&amp;reserved=0
