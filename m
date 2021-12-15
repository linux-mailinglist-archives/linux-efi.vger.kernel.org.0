Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B79B476309
	for <lists+linux-efi@lfdr.de>; Wed, 15 Dec 2021 21:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235515AbhLOUT3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Dec 2021 15:19:29 -0500
Received: from mail-dm6nam08on2051.outbound.protection.outlook.com ([40.107.102.51]:39221
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235425AbhLOUT3 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 15 Dec 2021 15:19:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKvcneuB1MHSlzqzHCqFJbZVC9f3zYuJvDcgwEN9hGvy2dg+9Ko1xkqXmv9otOGPw9SvIUn9gC3ryuX0LxS08lTo1Pp+dFZ51eqKj3yZdV47YJsxg3W7zV+NO8p1ySwf2mOO28UKip4Onxm1Bt30xZTSp5Yd/Ya7klq20NztSpVxqek8BKigqDbfJ0CVogoqRrqQ9d3JmLfi1Tsy7krGsvX0r7R0IjSO+ukzNy7rvil4AnYyPSpW2ZHOknxObzoi9V2gXmIrXQxuiXpWYJUwOY7a4tLRc3HRT7C4g9JTHBrxRfDTyoiSrX6IrFCDPvqjnSsaZilN0V7Xx0zO/Z+syg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jluifcnSuGncFW4f+lZK43WK4tu4gdrY95lopL4LdQ0=;
 b=ee8IE+NTwovEAMmUEKvewAfBGN/2L31+d3Pj5nbre4GspgvnkSOIg+Q5fbi/Cl3dJegBon0ylshxzbVvaaiLZQp+mY8WPO8Wd3UrXPZf34MStX6sqabg5eP+4V/M4J8UKP/1MNtWBA4kPo/9YLeoiIstMNf3HOymfN2hWvkIhDu565E6QJ5/cVc6LNCvTf8iROVP8Q8Cda3UlAP3kOxjSeUABV2uRhV5GSzwY886D5M+zeohNnrRRxxmFNAatUjiIfrgY08foH7u+8Rdo831TDEAZzfvtOx9D2jX0q+fRLpA06xpDnkmU+VLhapw0il7X+oRjjkCdfkwgcyJaUWXdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jluifcnSuGncFW4f+lZK43WK4tu4gdrY95lopL4LdQ0=;
 b=tmEAncar0EAUXkBtCQU8mtNPjTJ/JzjveriQdSAZczYuXfxlg7CeG6WCYqLlz7638x2/lkzbsCvJ3XQK8OCUA93QcBQZ431cZ7TWupuAFtJWFMKbXskY+cV1+RMY9sXx5wvrlsudFEgWeQumFcvzOO+MZD3xRi9FapWSuZ+1zfQ=
Received: from MWHPR14CA0064.namprd14.prod.outlook.com (2603:10b6:300:81::26)
 by CY4PR1201MB0070.namprd12.prod.outlook.com (2603:10b6:910:18::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Wed, 15 Dec
 2021 20:19:25 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:81:cafe::77) by MWHPR14CA0064.outlook.office365.com
 (2603:10b6:300:81::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13 via Frontend
 Transport; Wed, 15 Dec 2021 20:19:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Wed, 15 Dec 2021 20:19:24 +0000
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 15 Dec
 2021 14:19:23 -0600
Date:   Wed, 15 Dec 2021 14:17:34 -0600
From:   Michael Roth <michael.roth@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Venu Busireddy <venu.busireddy@oracle.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
        <linux-efi@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
        <linux-coco@lists.linux.dev>, <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
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
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        <tony.luck@intel.com>, <marcorr@google.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v8 01/40] x86/compressed/64: detect/setup SEV/SME
 features earlier in boot
Message-ID: <20211215201734.glq5gsle6crj25sf@amd.com>
References: <20211210154332.11526-2-brijesh.singh@amd.com>
 <YbeaX+FViak2mgHO@dt>
 <YbecS4Py2hAPBrTD@zn.tnic>
 <YbjYZtXlbRdUznUO@dt>
 <YbjsGHSUUwomjbpc@zn.tnic>
 <YbkzaiC31/DzO5Da@dt>
 <b18655e3-3922-2b5d-0c35-1dcfef568e4d@amd.com>
 <20211215174934.tgn3c7c4s3toelbq@amd.com>
 <YboxSPFGF0Cqo5Fh@dt>
 <Ybo1C6kpcPJBzMGq@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Ybo1C6kpcPJBzMGq@zn.tnic>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75f638b2-b570-4e75-6441-08d9c0082fee
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0070:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB007060973F83A14EF3EEA2FC95769@CY4PR1201MB0070.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IOeh7EaE+fs9Xwoobxs3qCYvHIwtg0XUUU9AWbNcrCjKCB3vcplAIhNvCgYxIgFyInqbBRwfnPGR3CAy/9JXOWBguzMsLS9ffBTlwoMBS4jVe5CUWk6L96r8mIX4VI9JhBlIIWp0dNuU1xhWPfzMO9knb4/8fh2Dux8SmW1eAmP9BQavdNbHXRCh3VOgg0uAYeIh/OtOvA9WXIZzxyey95ZDv2psK1lVIfPOOaPYLPd9w+ehoqvpPTcTr4ixaoHwJ0+sJngFCvRMl+JhGiUOduPxPo1xj0iPtKQgokvLCYNRb+i4rLBQ78w5GBUMWlFLztQcQDje8PLb0puDgv8HrHAkeImvoCslzmkaPHR5QBRhCFNp7eiTL713kNOle/UwrofuWjF+2xgoIe0sG3j6ge16cyYX29NRlHnxIaA3xoZh0iXSVXpoO4hT7k+ae7/Uo8xJCI3s+InJXGMsKFbnJX/JJa0VFrQHx9oYqxbrGPDkioG4+2Cuh32xVoaFivNyNV+wLkXq7paMJ1B8hQp9eIZWQ3kWvTjjqC+XiD6hBY1E1Yi56TuXglh/+mYtXdgdT/UHasDWJl9f5OSGAZURRvRBtpmD1WPlxGPCs6+gxHrbaMrqaZsc/UupqNzia2cPF78JHfZQu21bEfVWwExqfhuP5XhiegneXJE0XcJMa4TLGKhLuVku8N954A0LNU7yKOn2Se6JtnPrxVqPMqskFSVj3keIcPLvXg0wfy438jtKfDmhSxrpXR0hg5/UKf/NBkKUiqLSdiE0Q73Q8UIRli0Np33Bag72uMzZCi02t9lG7bmbCZhSdgF+sQXaDcCNt99+0CZ92zm0sutYRFmNReQvTYBqmVBbZIzCz9IHhpTgMWtcapkWC3n3j4SCHG7Z
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(426003)(186003)(40460700001)(86362001)(47076005)(26005)(8936002)(1076003)(7406005)(81166007)(336012)(82310400004)(16526019)(83380400001)(36756003)(2616005)(44832011)(8676002)(356005)(36860700001)(70586007)(2906002)(7416002)(5660300002)(316002)(70206006)(54906003)(45080400002)(6916009)(4326008)(6666004)(508600001)(966005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 20:19:24.4497
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f638b2-b570-4e75-6441-08d9c0082fee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0070
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Dec 15, 2021 at 07:33:47PM +0100, Borislav Petkov wrote:
> On Wed, Dec 15, 2021 at 12:17:44PM -0600, Venu Busireddy wrote:
> > Boris & Tom, which implementation would you prefer?
> 
> I'd like to see how that sme_sev_parse_cpuid() would look like. And that
> function should be called sev_parse_cpuid(), btw.
> 
> Because if that function turns out to be a subset of your suggestion,
> functionality-wise, then we should save us the churn and simply do one
> generic helper.

I was actually thinking this proposed sev_parse_cpuid() helper would be
a superset of what Venu currently has implemented. E.g. Venu's most recent
patch does:

sev_enable():
  unsigned int me_bit_pos;

  me_bit_pos = get_me_bit(AMD_SEV_BIT)
  if (!me_bit_pos)
    return;

  ...

Let's say in the future there's need to also grab say, the VTE bit. We
could introduce a new helper, get_vte_bit() that re-does all the
0x80000000-0x8000001F range checks, some sanity checks that SEV is set if
VTE bit is set, and then now have a nice single-purpose helper that
duplicates similar checks in get_me_bit(), or we could avoid the
duplication by expanding get_me_bit() so it could be used something like:

  me_bit_pos = get_me_bit(AMD_SEV_BIT, &vte_enabled)

at which point it makes more sense to just have it be a more generic
helper, called via:

  ret = sev_parse_cpuid(AMD_SEV_BIT, &me_bit_pos, &vte_enabled)

i.e. Venu's original patch basically, but with the helper function
renamed.

and if fields are added in the future:

  sev_parse_cpuid(AMD_SEV_BIT, &me_bit_pos, &vte_enabled, &new_feature_enabled, etc..)

or if that eventually becomes unwieldly it could later be changed to return
a feature mask.

> 
> Btw 2, that helper should be in arch/x86/kernel/sev-shared.c so that it
> gets shared by both kernel stages instead having an inline function in
> some random header.
> 
> Btw 3, I'm not crazy about the feature testing with the @features param
> either. Maybe that function should return the eYx register directly,
> like the cpuid_eYx() variants in the kernel do, where Y in { a, b, c, d
> }.
> 
> The caller can than do its own testing:
> 
> 	eax = sev_parse_cpuid(RET_EAX, ...)
> 	if (eax > 0) {
> 		if (eax & BIT(1))
> 			...
> 
> Something along those lines, for example.

I think having sev_parse_cpuid() using a more "human-readable" format
for reporting features/fields will make it easier to abstract away the
nitty-gritty details and reduce that chances for more duplication
between boot/compressed and kernel proper in the future. That
"human-readable" format could be in the form of a boolean/int
parameter list that gets expanded over time as needed (like the above
examples), or a higher-level construct like a struct/bitmask/etc. But
either way it would be nice to only have to think about specific CPUID
bits when looking at sev_parse_cpuid(), and have callers instead rely
purely on the sev_parse_cpuid() function prototype/documentation to
know what's going on.

> 
> But I'd have to see a concrete diff from Michael to get a better idea
> how that CPUID parsing from the CPUID page is going to look like.

It should look the same with/without CPUID page, since the CPUID page
will have already been set up early in sev_enable()/sme_enable() based
on the presence of the CC blob via snp_init(), introduced in:

 [PATCH v8 31/40] x86/compressed: add SEV-SNP feature detection/setup

Thanks,

Mike

> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7Cmichael.roth%40amd.com%7C6a28b961ef1441ed08f908d9bff970ea%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637751900351173552%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=nnCrpsw9%2FYlmhK1Xbx5y5vUScVsEOQeU%2F%2FTCmBMQ3v4%3D&amp;reserved=0
