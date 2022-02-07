Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1C14AC713
	for <lists+linux-efi@lfdr.de>; Mon,  7 Feb 2022 18:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241406AbiBGRO5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Feb 2022 12:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383080AbiBGRAm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Feb 2022 12:00:42 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE95C0401D8;
        Mon,  7 Feb 2022 09:00:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKQrQ0z47rtNQsvCSu9chea6Gso4JBkZVkeQBYauhLGCbnFpF05NnMesT7mNxHjhaKs4z+3fIbKUnMzphpVlmo2ctA/gbymxGNEqKI07WlfZwQdqpIKNhXilU+psy3V8BaqIS1iGBRIlSiK9bBv+srX3dSTClRPMOFXMVg+Ls56CVhbJoNk7ej8EfgDaRGB4K+dEAm2l0jNbrhsIT6IKqW1Wyx5VzCUGA+vC61TQHnL84D0nwk4Chj3Srrv9EBlJYkz+C2PYW39GM/VUr522hB7EcwrALcV36fcUwy3eWpmIopot1EV5wkKH0SgEt20oQd5N0v2oVGzQqulI3OkS2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jK4FYXqQ+HmpinXCqHtdOCj+E53IZ6dmyQ9eOL25edI=;
 b=n12iR0B6ZxdVa8/BXfptQl7K4vfSnu3mv2HtOPFTG85dzttfuLXqmZzrD2DjgcZtba6NkQD7Lqc+M14jr/NfBg33aOXakL99tfP7xpOMfyuXUk/C8lqfSRf3x+1Sa+1tFGCbcV3VOsk+/plRbqPdNjW6gKX4E8hzhz+ez1F0GHMZyZmgHOHwzje4Tg+Cu/WziGqngBqd//2N6et3C5Pg50dOUYDCbTSY2eGeOlvEkfTasBjDVegEeKJ4jJ8Y9SNkozc47+x/uU7Zwejg7SmfSw7K8KMlBfGcdodsnbMgqMUzT2w1r9Xcz1VaqnbyoyhHzjEONhiFEQtLQHkQF9qDWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jK4FYXqQ+HmpinXCqHtdOCj+E53IZ6dmyQ9eOL25edI=;
 b=GgD6ffXYlE+HPdHdSy7Zmmjc+P7pUS0MswFoEK/ZSZfEiJEZbBICbCz36G13OaSCd1d2erpwlWAMH/hcduwjDO3cZY5PPmicaIOJpp5e+hpvm/S2jXZBkWC6gB/cBosmqoMLby+lkbOYXnGQ2ilQ8hd84vo+DNI9yqU/FabrxaM=
Received: from MW4PR03CA0106.namprd03.prod.outlook.com (2603:10b6:303:b7::21)
 by BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Mon, 7 Feb
 2022 17:00:38 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::2d) by MW4PR03CA0106.outlook.office365.com
 (2603:10b6:303:b7::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Mon, 7 Feb 2022 17:00:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Mon, 7 Feb 2022 17:00:36 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Feb
 2022 11:00:34 -0600
Date:   Mon, 7 Feb 2022 09:37:39 -0600
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
        <marcorr@google.com>
Subject: Re: [PATCH v9 31/43] x86/compressed/64: Add support for SEV-SNP
 CPUID table in #VC handlers
Message-ID: <20220207153739.p63sa5tcaxtdx2wn@amd.com>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-32-brijesh.singh@amd.com>
 <Yf5XScto3mDXnl9u@zn.tnic>
 <20220205162249.4dkttihw6my7iha3@amd.com>
 <Yf/PN8rBy3m5seU9@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yf/PN8rBy3m5seU9@zn.tnic>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b702571-85f9-4a46-36c7-08d9ea5b5ca0
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB51154F4A82340DBED03BB178952C9@BN9PR12MB5115.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0REhxsKHEMYnL3wlDjepmJ5I8vBgzNTGVpM/jPg/i+SmditHx1pvomd8hmddLpwQqd4QMjrPQPycPwQCXjs9nKz+/KJihpBgExyE1MwJxePGRkCH8rmU9yA26xLaLfBx1LMRqgefEiUMquIHAmgJPIrUEO1AO3q61ZAzaAKLE56vf2AWMOUErffqWr+PavabVKr5NPXQOu/IglcJAw2cngByUxHRLZL9qZbi4meb6xWIuvEPoTBzuGAvt+8i7S8xQZFq3DEaSoV9dsG3w2NSw5RfZw6bKGnwQa0APJSPrgCEc7RJkmIGkNnOF4QIZzDYDZxsJYPMqmv366lt0Q7spDn78tXDYrPRRGOYlA5Rp8uzJxCHH8HTLWfV70pYA/eWgZZE9hZDHRK+qUcq3lkyvorhFrPk3H2IXj2srFLoj9anrovLMIhxTkTa+S+ZLk5YR6EquSUlrW28PYGANg1wuIYbo67rR4AflqEM1B6vmjr3gSDTwJyGG+NvtqPxG8JuAxQbrRRgHiEQTV/0hzXaebJOd8ZHlELpwPQawDAs7H8fnpUSCvspqOmkiWJgkmDkPcCS5Z/DDYYLwullYZcSdl8nAEAiUyi6VtAxnszw8Mvwnjs+snSAR9Wo+3LqXuvesLxJxUM3+pB7IotE3VLHET/Lzv0+tAQrhypiG4nOQwNfmikFmpJA3y1qwuxaTd6BlBZF4zReHXfG69TwvoUgyq+SFCZx2q6esu7vcDGINVJV/PhEbnqNO4ncixsNdFFJ4ByNLY+mVsFQnIObuAHQOSzgAmH+TkZ1IKZrIfknnhc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(16526019)(81166007)(26005)(1076003)(186003)(2616005)(47076005)(36860700001)(356005)(82310400004)(83380400001)(336012)(426003)(7406005)(7416002)(44832011)(5660300002)(2906002)(40460700003)(36756003)(45080400002)(966005)(508600001)(8936002)(86362001)(4326008)(70206006)(70586007)(8676002)(54906003)(6916009)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 17:00:36.4844
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b702571-85f9-4a46-36c7-08d9ea5b5ca0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5115
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Feb 06, 2022 at 02:37:59PM +0100, Borislav Petkov wrote:
> First of all,
> 
> let me give you a very important piece of advice for the future:
> ignoring review feedback is a very unfriendly thing to do:
> 
> - if you agree with the feedback, you work it in in the next revision
> 
> - if you don't agree, you *say* *why* you don't
> 
> What you should avoid is what you've done - ignore it silently. Because
> reviewing submitters code is the most ungrateful work around the kernel,
> and, at the same time, it is the most important one.
> 
> So please make sure you don't do that in the future when submitting
> patches for upstream inclusion. I'm sure you can imagine, the ignoring
> can go both ways.

Absolutely, I know a thorough review is grueling work, and would never
want to give the impression that I don't appreciate it. Was just hoping
to revisit these in the context of v9 since there were some concerning
things in flight WRT the spec handling and I was sort of focused on
getting ahead of those in case they involved firmware/spec changes. But
I realize that's resulted in a waste of your time and I should have at
least provided some indication of where I was with these before your
review. Won't happen again.

> 
> On Sat, Feb 05, 2022 at 10:22:49AM -0600, Michael Roth wrote:
> > The documentation for lea (APM Volume 3 Chapter 3) seemed to require
> > that the destination register be a general purpose register, so it
> > seemed like there was potential for breakage in allowing GCC to use
> > anything otherwise.
> 
> There's no such potential: binutils encodes the unstruction operands
> and what types are allowed. IOW, the assembler knows that there goes a
> register.
> 
> > Maybe GCC is smart enough to figure that out, but since we know the
> > constraint in advance it seemed safer to stick with the current
> > approach of enforcing that constraint.
> 
> I guess in this particular case it won't matter whether it is "=r" or
> "=g" but still...
> 
> > I did look into it and honestly it just seemed to add more abstractions that
> > made it harder to parse the specific operations taken place here. For
> > instance, post-processing of 0x8000001E entry, we have e{a,b,c,d}x from
> > the CPUID table, then to post process:
> > 
> >   switch (func):
> >   case 0x8000001E:
> >     /* extended APIC ID */
> >     snp_cpuid_hv(func, subfunc, eax, &ebx2, &ecx2, NULL);
> 
> Well, my suggestion was to put it *all* in the subleaf struct - not just
> the regs:
> 
> struct cpuid_leaf {
> 	u32 func;
> 	u32 subfunc;
> 	u32 eax;
> 	u32 ebx;
> 	u32 ecx;
> 	u32 edx;
> };
> 
> so that the call signature is:
> 
> 	snp_cpuid_postprocess(struct cpuid_leaf *leaf)
> 
> 
> > and it all reads in a clear/familiar way to all the other
> > cpuid()/native_cpuid() users throughout the kernel,
> 
> maybe it should read differently *on* *purpose*. Exactly because this is
> *not* the usual CPUID handling code but CPUID verification code for SNP
> guests.

Well, there's also sev_cpuid_hv(), which really is sort of a variant of
cpuid()/native_cpuid() helpers that happens to use the GHCB protocol, and
snp_cpuid() gets called at roughly the same callsite in the #VC handler,
so it made sense to me to just stick to a similar signature across all of
them. But no problem implementing it as you suggested, that was just my
reasoning there.

> 
> And please explain to me what's so unclear about leaf->eax vs *eax?!

It's not that one is unclear, it's just that, in the context of reading
through a function which has a lot of similar/repetitive cases for
various leaves:

  snp_cpuid_hv(fn, subfn, &eax, &ebx2, NULL, NULL) 

  ebx = fixup(ebx2)

seems slightly easier to process to me than:

  snp_cpuid_hv(&leaf_hv)

  leaf->eax = leaf_hv->eax
  leaf->ebx = fixup(leaf_hv->ebx)

because I already have advance indication from the function call that eax
will be overwritten by hv, ebx2 will getting fixed up in subsequent lines,
and ecx/edx will be used as is, and don't need to parse multiple lines to
discern that.

But I know I may very well be biased from staring at the existing
implementation so much, and that maybe your approach would be clearer to
someone looking at the code who isn't as familiar with that pattern.

> 
> > I saved the diff from when I looked into it previously (was just a
> > rough-sketch, not build-tested), and included it below for reference,
> > but it just didn't seem to help with readability to me,
> 
> Well, looking at it, the only difference is that the IO is done
> over a struct instead of separate pointers. And the diff is pretty
> straight-forward.
> 
> So no, having a struct cpuid_leaf containing it all is actually better
> in this case because you know which is which if you name it properly and
> you have a single pointer argument which you pass around - something
> which is done all around the kernel.

Ok, will work this in for v10. My plan is to introduce this struct:

  struct cpuid_leaf {
      u32 fn;
      u32 subfn;
      u32 eax;
      u32 ebx;
      u32 ecx;
      u32 edx;
  }

as part of the patch which introduces sev_cpuid_hv():

  x86/sev: Move MSR-based VMGEXITs for CPUID to helper

and then utilize that for the function parameters there, here, and any
other patches in the SNP code involved with fetching/manipulating cpuid
values before returning them to the #VC handler.

Thanks!

-Mike

> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7Cmichael.roth%40amd.com%7Cd409d10fc3cc41c4cbfb08d9e975ebfc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637797515011518153%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=%2FDjnNrQ7a8%2F6eI%2FRVJJ2vmLEpeDaAeDVOJcW9CBnggU%3D&amp;reserved=0
