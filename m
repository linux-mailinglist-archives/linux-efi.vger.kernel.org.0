Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B12B6484B43
	for <lists+linux-efi@lfdr.de>; Wed,  5 Jan 2022 00:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236547AbiADXmP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 4 Jan 2022 18:42:15 -0500
Received: from mail-bn8nam11on2061.outbound.protection.outlook.com ([40.107.236.61]:14241
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235383AbiADXmN (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 4 Jan 2022 18:42:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZfjeNLWl2V/6n93x28O0YVVVZIBbSHcDqBL20E67jH8J00lwoFWyA53YHSyNomDLXs6mS1m1/jZF8FCVJ+Ryv1zFgnM0k5hCd7a//8ZT8JjKMKrI3A0v6Wty6+RNoR2EHDZGQVD7zpSYMATn0gLRbbbLXoPrg8MXNCSkMk5EchceffxzKFVixZIQYH7ls0Y/prxKP2xIsMR+sIa3JyerwOIwSx9j6XEYWdIQuqjwzQr30aRYVOkkc6qOz//kMT6sw1pGG8R4qBzRWdLRkO0dseHMpEKqAZv2rZcJ1mybQycq14gsBXxv502VyJfHrmGxCsCHQKXsol+/85e+Vcceg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJ7eLLHkwF8HSnZlZT//WVsvNEtnbi6vQLbjALGYrfI=;
 b=UFmKRTN9+hBowF+2EDL49qBCbxfIUsG1e8kr+zovbnpy+mOOfo38UpOlO6hBf9OlIfDSQ1DbgY3fov7JyrsC8UicNlVsesbMNHlBS4rq/+Zbr0QyMBnkOjodNWLgrj+xK41BHibunJruYEPb8t93vDaIwDCuFNNajnOIWBB4tHWjsNEzOrWwqfu+F2I+6T9cLoUf15gb+iIrYxOOFvNFe4XAwoXp1ucrb12J1AXUJiC2l2RKzdw2R00/HmB1ZzuZr/drs9ipIfJmVcn6OgxAyF5OXbJor6yp8UQwJPrvBFCAZcERyiQEtx+b6KibOmwjTy/+4PpnFD3IrQBJhxTKyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJ7eLLHkwF8HSnZlZT//WVsvNEtnbi6vQLbjALGYrfI=;
 b=aNPVVMSsyhhuFKWdCYxBeq/8kR1DKKd/tHs9KsLcTIQbqSvCnfBBPBOctkTUHJ4gNiqS0PX14UlwZDN0wBKUu6PhEfrA0Y6GQBm23ok87ncSVPl+xRIkdErDFhFQe4QGFd+JBFqB9rJOupDgxEpniTPwkncZsSTqyCTtBrUB/Ig=
Received: from DM5PR05CA0011.namprd05.prod.outlook.com (2603:10b6:3:d4::21) by
 CY4PR1201MB0245.namprd12.prod.outlook.com (2603:10b6:910:1e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 23:42:07 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:d4:cafe::1) by DM5PR05CA0011.outlook.office365.com
 (2603:10b6:3:d4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Tue, 4 Jan 2022 23:42:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Tue, 4 Jan 2022 23:42:06 +0000
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 4 Jan
 2022 17:42:06 -0600
Date:   Tue, 4 Jan 2022 17:36:14 -0600
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
        <tony.luck@intel.com>, <marcorr@google.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v8 22/40] x86/sev: move MSR-based VMGEXITs for CPUID to
 helper
Message-ID: <20220104233614.vnybv5sf54yiik7z@amd.com>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-23-brijesh.singh@amd.com>
 <Yc4ABL2EbBlwjma5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yc4ABL2EbBlwjma5@google.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b75443b-cbe2-4994-b063-08d9cfdbd185
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0245:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB024554141626C1D06F7ECA06954A9@CY4PR1201MB0245.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mID9v79s1/1xe4SxDGGhUz4VF7X4Bk3po8kubCJkEx/Cjqdq0b/E9xj+zMkGbAYzVd8EB0cPVJkSJk/f36cdVIcX8Ij15ndL+ApSz/bufw8PU3y5mSkFtqDq/vLqzLWwG1lrHLkgwX1CI8Zii5P2ulIUw9CH84p4QT8cDAoo6DbGYJHGsZC/xgnbhtKZb1xgkZZHTqyga8rphZXwo7Fi+rRvfdP0rt0AT8C8zxRWU4IAr7CCs2xoLyLX/Zuw6omnW7dgv9hqhxpwuLocEGIc3iwS9Ci8Sb41s11WpzYI6WQPbtLCUWLfxXM6I4rfC+ILC6MTkXpvGswtYcQ9a+CEPHjgHy9G3fm1M6/AmluCEP3adOKmFEtjgbZlgbHpaE0CnFtrLx/j5UQmJLTdwAGLK/vMFGp2iFmobJaIgw/VSl/SJeClH2h2J4/o1SCEBTxmgxWJkSms4wYnkNCIvg06yxov5N2xHSZ9cUKvxY2exrNSkb3xKZ7G6jgKLF4EL5ggzpOvOvz4wlyPntKk0ZtGWolqEGTTsLzX+lNFaP2K4Vwi+JlTCorEg0ZSnE/GbwVSl0JjrvvttRGsxY0K/kowjX5aCkF4D0unxfvJwk41EqWnkcWfZ4ihAWu1O73VZzX81POUxI8VykfQjkCZnAlFfuZ7u8f66CVtv0VahCo8Yrx3Bi2b9RAWFdI7zl1zm95ZjpIuNnLcY2Bpic7ULEZBYWd06V5yKP5uup61fF/E49PSNtUw7sOARldUKfGjBtsH8IRm3DOnvoM3uO1A5j+CBjgHhQhugHAQgDl9Ab/MZL0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700002)(508600001)(47076005)(16526019)(7416002)(186003)(1076003)(83380400001)(36860700001)(54906003)(8936002)(336012)(81166007)(26005)(86362001)(8676002)(4326008)(6666004)(426003)(316002)(5660300002)(6916009)(36756003)(82310400004)(356005)(40460700001)(70586007)(70206006)(2906002)(2616005)(7406005)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 23:42:06.8841
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b75443b-cbe2-4994-b063-08d9cfdbd185
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0245
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Dec 30, 2021 at 06:52:52PM +0000, Sean Christopherson wrote:
> On Fri, Dec 10, 2021, Brijesh Singh wrote:
> > From: Michael Roth <michael.roth@amd.com>
> > 
> > This code will also be used later for SEV-SNP-validated CPUID code in
> > some cases, so move it to a common helper.
> > 
> > Signed-off-by: Michael Roth <michael.roth@amd.com>
> > Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> > ---
> >  arch/x86/kernel/sev-shared.c | 84 +++++++++++++++++++++++++-----------
> >  1 file changed, 58 insertions(+), 26 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> > index 3aaef1a18ffe..d89481b31022 100644
> > --- a/arch/x86/kernel/sev-shared.c
> > +++ b/arch/x86/kernel/sev-shared.c
> > @@ -194,6 +194,58 @@ enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb, bool set_ghcb_msr,
> >  	return verify_exception_info(ghcb, ctxt);
> >  }
> >  
> > +static int sev_cpuid_hv(u32 func, u32 subfunc, u32 *eax, u32 *ebx,
> 
> Having @subfunc, a.k.a. index, in is weird/confusing/fragile because it's not consumed,
> nor is it checked.  Peeking ahead, it looks like all future users pass '0'.  Taking the
> index but dropping it on the floor is asking for future breakage.  Either drop it or
> assert that it's zero.
> 
> > +			u32 *ecx, u32 *edx)
> > +{
> > +	u64 val;
> > +
> > +	if (eax) {
> > +		sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(func, GHCB_CPUID_REQ_EAX));
> > +		VMGEXIT();
> > +		val = sev_es_rd_ghcb_msr();
> > +
> > +		if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
> > +			return -EIO;
> > +
> > +		*eax = (val >> 32);
> > +	}
> > +
> > +	if (ebx) {
> > +		sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(func, GHCB_CPUID_REQ_EBX));
> > +		VMGEXIT();
> > +		val = sev_es_rd_ghcb_msr();
> > +
> > +		if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
> > +			return -EIO;
> > +
> > +		*ebx = (val >> 32);
> > +	}
> > +
> > +	if (ecx) {
> > +		sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(func, GHCB_CPUID_REQ_ECX));
> > +		VMGEXIT();
> > +		val = sev_es_rd_ghcb_msr();
> > +
> > +		if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
> > +			return -EIO;
> > +
> > +		*ecx = (val >> 32);
> > +	}
> > +
> > +	if (edx) {
> > +		sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(func, GHCB_CPUID_REQ_EDX));
> > +		VMGEXIT();
> > +		val = sev_es_rd_ghcb_msr();
> > +
> > +		if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
> > +			return -EIO;
> > +
> > +		*edx = (val >> 32);
> > +	}
> 
> That's a lot of pasta!  If you add
> 
>   static int __sev_cpuid_hv(u32 func, int reg_idx, u32 *reg)
>   {
> 	u64 val;
> 
> 	if (!reg)
> 		return 0;
> 
> 	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(func, reg_idx));
> 	VMGEXIT();
> 	val = sev_es_rd_ghcb_msr();
> 	if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
> 		return -EIO;
> 
> 	*reg = (val >> 32);
> 	return 0;
>   }
> 
> then this helper can become something like:
> 
>   static int sev_cpuid_hv(u32 func, u32 *eax, u32 *ebx, u32 *ecx, u32 *edx)
>   {
> 	int ret;
> 
> 	ret = __sev_cpuid_hv(func, GHCB_CPUID_REQ_EAX, eax);
> 	ret = ret ? : __sev_cpuid_hv(func, GHCB_CPUID_REQ_EBX, ebx);
> 	ret = ret ? : __sev_cpuid_hv(func, GHCB_CPUID_REQ_ECX, ecx);
> 	ret = ret ? : __sev_cpuid_hv(func, GHCB_CPUID_REQ_EDX, edx);
> 
> 	return ret;

Looks good, will make these changes.

-Mike
