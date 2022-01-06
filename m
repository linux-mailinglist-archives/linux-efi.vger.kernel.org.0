Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9EE486B01
	for <lists+linux-efi@lfdr.de>; Thu,  6 Jan 2022 21:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243672AbiAFUVx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 6 Jan 2022 15:21:53 -0500
Received: from mail-mw2nam08on2042.outbound.protection.outlook.com ([40.107.101.42]:15841
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243663AbiAFUVw (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 6 Jan 2022 15:21:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+aGlSJmViAEq4XSOQsKr+GMDgOUtARNe+YTuW7KeugWF3tiaxIxA6kMpc+TeOR+tRrpuVLppSqZBu0WWPIlBjhzUcQYpToQRxeFbo1Ujk9YK1DYXhELi5K7AQN03bIgmlwmLN74+jWSI+OWnD2Np6/FAImFOm/rAGlEaqU3VCrfS6NB69J/Op5B7t9t2MhQJqWmWQ8YZTtBwfiQ0rO/VRzytw1xbH1I1vnfQAVLs+AQk07k5VfkI3QiB6WbLasEbs8r10Wpb/hlg4VJp/0xRFqKlQY37yoq6Kqo6gYR4HmDrfSe8wHnd1hycxgyeRpTyEdiojRennbhI9b3Zn3mWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RTqyjelPXfJqTpXMbXhE3kSd3zQ3G7qGrMHkFADQ9ew=;
 b=dkVuqG72N6TPO4UjN35TC0rkCz5NJwF6dIM08PGIAao86r6blSmau/lPMptOeqotLFIpaCeDiNuMEPxMyhIDjkPxWQo1tCknmAda3LJ78JkLXsMVPgriRO1NZQPx2vY4Keuwi7AVrm0M4cyI0a/nHfgojT1mLbLSfJiPjKBCrjpwmPH+cLaIRtItkIenrT7yA2OpNhkcbshI+XkgPc+3X+eaYglPsszd2vhpSy9aS1ZmFsUq4wKjlCYhRLtSKegUstg8ThcR7iMEpNX1NNAMY0BJzvUDHrBkvLJMmrrY8HO3+fU2sB9sxlhTB6TWOOzTYy+x0NyrJN4L2FqK7cb5GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RTqyjelPXfJqTpXMbXhE3kSd3zQ3G7qGrMHkFADQ9ew=;
 b=sZ96fq198Gl60KtpYb50t0Uy/SzjC3l2FmtwpnsfoCfmmtZFLX4j1U6KcBc0iJlFGlWogJZsnxiRHVis8DS0FmF5m8iVncuvi+I1ztg7BT+dTUvpXsMzqx9f2cRVPwxlFx6GsUoJzGrn8xWzjRs2dGIxOBxEloxYvih74oLxfkI=
Received: from MW4PR04CA0267.namprd04.prod.outlook.com (2603:10b6:303:88::32)
 by DM4PR12MB5133.namprd12.prod.outlook.com (2603:10b6:5:390::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Thu, 6 Jan
 2022 20:21:50 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::6f) by MW4PR04CA0267.outlook.office365.com
 (2603:10b6:303:88::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Thu, 6 Jan 2022 20:21:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Thu, 6 Jan 2022 20:21:50 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 6 Jan
 2022 14:21:49 -0600
Date:   Thu, 6 Jan 2022 14:21:35 -0600
From:   Michael Roth <michael.roth@amd.com>
To:     Venu Busireddy <venu.busireddy@oracle.com>
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
        Borislav Petkov <bp@alien8.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        <tony.luck@intel.com>, <marcorr@google.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v8 22/40] x86/sev: move MSR-based VMGEXITs for CPUID to
 helper
Message-ID: <20220106202135.in72kejithub33s6@amd.com>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-23-brijesh.singh@amd.com>
 <Ydc3Lbx2O00an/xj@dt>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Ydc3Lbx2O00an/xj@dt>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ee2fa30-ea49-4d36-10b4-08d9d1522c0e
X-MS-TrafficTypeDiagnostic: DM4PR12MB5133:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB51331070BE1D35FF598862C2954C9@DM4PR12MB5133.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EC2v8UoYPSc+2L7uKO5D83mmXhl2eUjGILPnZmVR1ScABxOvswlXFaSmBh8bY+qe6HXFTXImEnWy3DyLlE5xoCYDymbbQ+jhZW7roO+a+YrhuNytuRqmSRv0ocKKxaT/+6ZMteVhtSHZKvgkrxTNyFKbOPhrspeQ+ZxWoKrmpDjyeJ2RSJngP9VgRx3isxumpxLOsGVdu+6QTENYHwyxpMcwLZfpz073B5YvPUb7xgbmz91+SujbeEHUrYNYtGrIp4rkeubp2puiC9Qpp2FNpJPHNyh7XyFzhQD8NRbjrjMSBBvTEpWmeMTp8fNzGv5B/gLDu+k4LlzteJw8VFQoc5r3qKdocfXQih0+rt81K/zk37nFkijYbJFepABL05OHXPk3YYqA2pOKJC7zw86NpWTvragh2npN23Am8fBHBPn52MdPFFdmZMEH9sO+A/wsNr+oulBP8PldCf+fWnCVf2qyzvFd7O2Et7q0hWnP4JIa46z+vUnvLsI4CwRAywKYOuxPcqyChd0DEsSIRm1qLZszz15Sgfpu167dItwp68NajNKtKhR2zHIiT5XHvmZX3jmQFmOPLSnbdr4VCPvg3llnRJSfCi7zv2ZVX2/GKsFX6++ZH1SpoVagk1EWKsq79OhIcMIVmT//fI6WCSQR9UwWtn8Pg9WCstnDqkXOyofOcRXZu0KYxjenpZ0t38y63RhZ2FilF62insyCEcK0n0iAXJyyyqA9QEoQHece6DdzBvb2UWLe9o/mO9YulRaGLzH+ijXCPwv+HiapRD00v+JwFkMTNzZU+Wvp8ODCAqI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(40470700002)(46966006)(36840700001)(2616005)(5660300002)(426003)(336012)(47076005)(356005)(16526019)(36860700001)(26005)(53546011)(4001150100001)(86362001)(70206006)(6666004)(6916009)(70586007)(186003)(82310400004)(54906003)(8936002)(8676002)(2906002)(81166007)(44832011)(316002)(83380400001)(40460700001)(7416002)(4326008)(7406005)(1076003)(508600001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 20:21:50.4559
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee2fa30-ea49-4d36-10b4-08d9d1522c0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5133
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jan 06, 2022 at 12:38:37PM -0600, Venu Busireddy wrote:
> On 2021-12-10 09:43:14 -0600, Brijesh Singh wrote:
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
> > +
> > +	return 0;
> > +}
> > +
> >  /*
> >   * Boot VC Handler - This is the first VC handler during boot, there is no GHCB
> >   * page yet, so it only supports the MSR based communication with the
> > @@ -202,39 +254,19 @@ enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb, bool set_ghcb_msr,
> >  void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
> >  {
> >  	unsigned int fn = lower_bits(regs->ax, 32);
> > -	unsigned long val;
> > +	u32 eax, ebx, ecx, edx;
> >  
> >  	/* Only CPUID is supported via MSR protocol */
> >  	if (exit_code != SVM_EXIT_CPUID)
> >  		goto fail;
> >  
> > -	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_EAX));
> > -	VMGEXIT();
> > -	val = sev_es_rd_ghcb_msr();
> > -	if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
> > +	if (sev_cpuid_hv(fn, 0, &eax, &ebx, &ecx, &edx))
> >  		goto fail;
> > -	regs->ax = val >> 32;
> >  
> > -	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_EBX));
> > -	VMGEXIT();
> > -	val = sev_es_rd_ghcb_msr();
> > -	if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
> > -		goto fail;
> > -	regs->bx = val >> 32;
> > -
> > -	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_ECX));
> > -	VMGEXIT();
> > -	val = sev_es_rd_ghcb_msr();
> > -	if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
> > -		goto fail;
> > -	regs->cx = val >> 32;
> > -
> > -	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_EDX));
> > -	VMGEXIT();
> > -	val = sev_es_rd_ghcb_msr();
> > -	if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
> > -		goto fail;
> > -	regs->dx = val >> 32;
> > +	regs->ax = eax;
> > +	regs->bx = ebx;
> > +	regs->cx = ecx;
> > +	regs->dx = edx;
> 
> What is the intent behind declaring e?x as local variables, instead
> of passing the addresses of regs->?x to sev_cpuid_hv()? Is it to
> prevent touching any of the regs->?x unless there is no error from
> sev_cpuid_hv()? If so, wouldn't it be better to hide this logic from
> the callers by declaring the local variables in sev_cpuid_hv() itself,
> and moving the four "*e?x = (val >> 32);" statements there to the end
> of the function (just before last the return)? With that change, the
> callers can safely pass the addresses of regs->?x to do_vc_no_ghcb(),
> knowing that the values will only be touched if there is no error?

For me it was more about readability. E?X are well-defined as 32-bit
values, whereas regs->?x are longs. It seemed more readable to me to
have sev_cpuid_hv()/snp_cpuid() expect/return the actual native types,
and leave it up to the caller to cast/shift if necessary.

It also seems more robust for future re-use, since, for instance, if we
ever introduced another callsite that happened to already use u32 locally,
it seems like it would be a mess trying to setup up temp long* args or do
casts to pass them into these functions and then shift/cast them back just
so we could save a few lines at this particular callsite.

> 
> Venu
