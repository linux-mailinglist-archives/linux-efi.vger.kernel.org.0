Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20839436DD4
	for <lists+linux-efi@lfdr.de>; Fri, 22 Oct 2021 01:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhJUXC6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 21 Oct 2021 19:02:58 -0400
Received: from mail-dm6nam12on2076.outbound.protection.outlook.com ([40.107.243.76]:58848
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229567AbhJUXC6 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 21 Oct 2021 19:02:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jh0m0kaUYqwWgDCXfg8Md7R85xSuj1gCkZLJfSs+vCXwtQMyTRtcXRWb3R0awrcQm1iDJJpP6JHlO+nTl48H821a2D2y8S61loG1KE/UQYgRvifOksq08TOEdlowuYnO2/SbSQX5qj5HoHm5QyOJTlUrSG2sD55BH5p9iJ5cnauZfYI9ihD2U/ojpkrnTmWrTEPnSwweRMHgRwpfPlWObg50nSn4ZS8uj/qc7qxMRfdRjUwU1FagNC7yfnLBq9vl57cacMw59yDvnhaL5Nnm6EPT+WcDXiMnjs1GUywg+kmwNnyXeT/Ov449SQmTHYPF513KywmLlxHNH4LZcHkOxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i3jmlXEbjFRZBEmwvMQ+xYn++JDk1nTC7Lob36GlWt8=;
 b=N4cUtNA1DdbTkcWPJuN7wOPZ62Wco+0bVMR3RB+TRQ6kZJlntfJHJWRYb7iTBwI15GPOv8dvHZwBfgyUvTvJWoOaH6mPjbMNiZ7G2NrEYGUx82k50oY9EjdXuhqs+s7fHF72q4ysR3EhfZwBA2kJpEbB9CZ7b1Jf9NYFGjaouniwxfdioDa75V91xUqmLiTFWwoNCSJMMQJ1xtHPH595UqCbpJmuMr90h61OTcoVrOjAi23BmvLkN2zazJWQVSDUzK5pS1+GTmRj7myL6hWLtk0buUqXAjC6Xb3VnhwLnTbKRovu26L9+Du66p+Wf6jOiWKN5heN/OAml5Qn93vUEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3jmlXEbjFRZBEmwvMQ+xYn++JDk1nTC7Lob36GlWt8=;
 b=E8UoEBNLv9jGF0QgAdEmUDlX0UQTuDMSnkqUk266grJU5w8mIVFtANov15SdOxS6me5GmiSdEyHQid3BsEiiqt+tY3n/KQxn/sWqSHNn4S7oflnu3s8aAHaAILMCXBeFOJd+0Or90xXQe2gyCe744gGcw0h7dfOBWtBf2obL9gE=
Received: from BN8PR15CA0011.namprd15.prod.outlook.com (2603:10b6:408:c0::24)
 by DM5PR1201MB0123.namprd12.prod.outlook.com (2603:10b6:4:50::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Thu, 21 Oct
 2021 23:00:37 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::8b) by BN8PR15CA0011.outlook.office365.com
 (2603:10b6:408:c0::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Thu, 21 Oct 2021 23:00:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 23:00:36 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 21 Oct
 2021 18:00:35 -0500
Date:   Thu, 21 Oct 2021 18:00:17 -0500
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
Subject: Re: [PATCH v6 08/42] x86/sev-es: initialize sev_status/features
 within #VC handler
Message-ID: <20211021230017.yzjploxlh4oepyx4@amd.com>
References: <20211008180453.462291-1-brijesh.singh@amd.com>
 <20211008180453.462291-9-brijesh.singh@amd.com>
 <YW2EsxcqBucuyoal@zn.tnic>
 <20211018184003.3ob2uxcpd2rpee3s@amd.com>
 <YW3IdfMs61191qnU@zn.tnic>
 <20211020161023.hzbj53ehmzjrt4xd@amd.com>
 <YXBbJwd2M03Ssq6I@zn.tnic>
 <20211021020542.v5s7xr4s2j3gsale@amd.com>
 <YXF7o8X9Elc8s8t7@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YXF7o8X9Elc8s8t7@zn.tnic>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59fed264-f07e-499b-4e92-08d994e69805
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0123:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0123FF011937603F74DEB0F695BF9@DM5PR1201MB0123.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IeRMUrRBp4bfHrCMk/xAtDyPnBQTH07gx7kCKeQGf5gaQzvm7Re+tK0YtTu8tRtsQIOZt3GofC7hJm6fmeeKlfrfM10/ZkJZN4OFwbFN2LscC926hLJeii/ReYYtuNmcJSUsOAvTSq1ygJK+FH3urD9Xro0nqc/PZyLjjseuBLWgnCdq6N2LwiPUHhzP8iQGLlR1Bye/bQ0cnDJiCiZu7rDEhh8POSnndQ8I+NjJvV/5VtVc7HiCaisnP9JMnoeOzUsyBQRTsAnV85SmaZtx4Gu5LCqb2tVUjz0w9bwKnO37zmHFukY0zvsnFQL6cxLQZ5ejLoK/wHk2AvPyJ8jx0URv1OrYzHkH1HvQFowftPh0yHOljWmY6edGYq7zjrqkXZQ2dguqbIecsi5NCvz3Rt3QYHAHKdNV1RJAuOu4wunai11IS4EgMDkBZBLChQEL+7cGiOyKWVR3gigAK2lLIeKEvrQHtV+l6Zim/ebez8/DMi7Pwr30uXDsMgdECN2YgbWvd/nnq2Q3OzfQly+19Phv3zBYHD7UonfiYzO6jM0a1CbSMSzFecV3E+hx9jJKJ4lcX2EK8GxhnM1BcZm7uEM5xwSIVDUIOuGsgDwsfbyyWeqKoAuBPtXAOmcna7/LZPDlX/zpIP6tQNDH8iVXnsLkY4OwiPZWa8oCAUCC7y6LU0Btp8QlLlB1FMhQbJcDVyno3kW7fuXJ+PDlq4C6LipSuMapuYIbfJkUcABO08k4ljPHAfOPbvaxI8YgefjBhdTZY/9Tj19IZPsIAb1q3Y7edsdMKqvSXvnJPo7tuj73xFj11Zt/31otk2K5jztus9CqlOCQ5LGbBR31JBSMgl1DagYA58PwO1WB1VjaV5E=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(45080400002)(6916009)(16526019)(70206006)(336012)(26005)(36860700001)(356005)(7416002)(36756003)(2906002)(83380400001)(7406005)(316002)(47076005)(54906003)(426003)(86362001)(8936002)(44832011)(186003)(8676002)(5660300002)(81166007)(6666004)(4326008)(70586007)(82310400003)(2616005)(1076003)(966005)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 23:00:36.3069
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59fed264-f07e-499b-4e92-08d994e69805
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0123
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Oct 21, 2021 at 04:39:31PM +0200, Borislav Petkov wrote:
> On Wed, Oct 20, 2021 at 09:05:42PM -0500, Michael Roth wrote:
> > According to the APM at least, (Rev 3.37, 15.34.10, "SEV_STATUS MSR"), the
> > SEV MSR is the appropriate source for guests to use. This is what is used
> > in the EFI code as well. So that seems to be the right way to make the
> > initial determination.
> 
> Yap.
> 
> > There's a dependency there on the SEV CPUID bit however, since setting the
> > bit to 0 would generally result in a guest skipping the SEV MSR read and
> > assuming 0. So for SNP it would be more reliable to make use of the CPUID
> > table at that point, since it's less-susceptible to manipulation, or do the
> > #VC-based SEV MSR read (or both).
> 
> So the CPUID page is supplied by the firmware, right?

Yes.

> 
> Then, you parse it and see that the CPUID bit is 1, then you start using
> the SEV_STATUS MSR and all good.
> 
> If there *is* a CPUID page but that bit is 0, then you can safely assume
> that something is playing tricks on ya so you simply refuse booting.

I think that's a good way to deal with this.

I was going to suggest we could assume the presence of SEV status MSR by
virtue of EFI/bootloader/etc having provided a cc_blob, and just read it
right away to confirm this is SNP. But with your approach we could basically
just set up the table early, based on the presence of the cc_blob, and do all
the checks in sme_enable() in the same order as with SEV/SEV-ES, then just
have additional sanity checks against the CPUID/MSR response values to
ensure the SNP bits are present for the cases where a cpuid table / cc_blob
are provided.

I'll work on implementing things in this way and see how it goes.

> 
> > Fully-unencrypted should result in a crash due to the reasons below.
> 
> Crash is a good thing in confidential computing. :)
> 
> > But there may exist some carefully crafted outside influences that could
> > goad the guest into, perhaps, not marking certain pages as private. The
> > best that can be done to prevent that is to audit/harden all the code in the
> > boot stack so that it is less susceptible to that kind of outside
> > manipulation (via mechanisms like SEV-ES, SNP page validation, SNP CPUID
> > table, SNP restricted injection, etc.)
> 
> So to me I wonder why would one use anything *else* but an SNP guest. We
> all know that those previous technologies were just the stepping stones
> towards SNP.

Yah, I think ultimately that's where things are headed.

> 
> > Then of course that boot stack needs to be part of the attestation process
> > to provide any meaningful assurances about the resulting guest state.
> >
> > Outside of the boot stack the guest owner might take some extra precautions.
> > Perhaps custom some kernel driver to verify encryption/validated status of
> > guest pages, some checks against the CPUID table to verify it contains sane
> > values, but not really worth speculating on that aspect as it will be
> > ultimately dependent on how the cloud vendor decides to handle things after
> > boot.
> 
> Well, I've always advocated having a best-practices writeup somewhere
> goes a long way to explain this technology to people and how to get
> their feet wet. And there you can give hints how such verification could
> look like in detail...

Our security team is working on some initial reference designs / tooling
for attestation. It'll eventually make it's way to here:

  https://github.com/AMDESE/sev-guest

but it's still mostly an internal effort so nothing there ATM. But hopefully
that will fill in some of these gaps. But I agree some an accompanying best
practices document to highlight some of these considerations is also
something that should be considered, I'll need to check to see if there's
anything like that in the works already.

> 
> > That would indeed be useful. Perhaps as a nice big comment in sme_enable()
> > and/or the proposed sev_init() so that those invariants can be maintained,
> > or updated in sync with future changes. I'll look into that for the next
> > spin and check with Brijesh on the details.
> 
> There is Documentation/x86/amd-memory-encryption.rst, for example.

Makes sense, will work with Brijesh on this.

Thanks!

-Mike

> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7Cmichael.roth%40amd.com%7C966f1e67d4704901d29a08d994a099e1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637704239855683221%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=730WoYycYnjabC4igLcViZsEokSrcMkJ9oXvZso4ULQ%3D&amp;reserved=0
