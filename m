Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B17E93FD08F
	for <lists+linux-efi@lfdr.de>; Wed,  1 Sep 2021 03:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241552AbhIABEr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Aug 2021 21:04:47 -0400
Received: from mail-co1nam11on2063.outbound.protection.outlook.com ([40.107.220.63]:39520
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241544AbhIABEq (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 31 Aug 2021 21:04:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBHEhm5ufbv1cuwCtaG91ThHPnSIa4QtXmN127YqoPRsXmeSSODiC2jcdyoujy3Cq7Of4inhuBUYvdZzC+lD3RDFCAppx8CN6R3KjlkjB44eAUlkXNWwgpXsehUWJ2acurYXCDCkmZrN77sUUcPAOGjIdeZCv7UnHl0ZWBB11pioqla3iQ9dVKG8gESrNgP5fU/zxNo7kSDIHwKr5XcENS6sI0gEJqW+aWxksHX364sXn1gk3tvBaJ0NVfHcgOx3Wt4RV4VWcLNGTmP3abWJ6iERJB9o/tpiWq0nDGEanrbsS9X5uORLdkhEA4IGWkECt0t/7WNY7xtNua73EMMCfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wh2oHMArEH4Nx+/9A5fLqUvoRevYnAlOcPspQAx8h/Y=;
 b=kLgWYLNz7ao/QWvv7mT6sRfbp2r12I1hjShgNmn0oNQEsQ/dn1cKysckIJ/oFOyQYKQHpmX5WqTtTfA72jxRZhwdON8cl/903bXUTwoJ1qJT6ihyhgYJzgOEYD6lJ/835HWe2Fw98f1sCJIHdEhVQmrmJpTDh18+p5Olqs1/hb4+JoyWGdcTOc67tBdwjDjUNI7VV8krCOomVF7WiEN4xWuXHDE9weC3kH1HdEFeQYhIUhX1B0fLv5d6X7yCuQMqjTkJid9+watUaSUPBhhIXck9c1h3mk2zu8OUsUNs/Z9E91Fk6HK0/YvtqxoMHno42B2GRvSp1OS/nQ2FGyaHLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wh2oHMArEH4Nx+/9A5fLqUvoRevYnAlOcPspQAx8h/Y=;
 b=3lvAclBIYbodye5w6//PMYzxMpcpYrQWDEX47FoWr+BIuJ5EA54aNzYTDMGyLAI+NGfbdWe8SHZJnM+qlHyRSvt81N3V9Lxx8czenrZjjom6HqqLG8AhuhukUF/ZwXsgXD/2xN9wdKVJscKncjgydP45kxrBwgLBjBF7PaQVohI=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB4823.namprd12.prod.outlook.com (2603:10b6:610:11::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Wed, 1 Sep
 2021 01:03:42 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f5af:373a:5a75:c353]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f5af:373a:5a75:c353%6]) with mapi id 15.20.4457.024; Wed, 1 Sep 2021
 01:03:42 +0000
Date:   Tue, 31 Aug 2021 20:03:25 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH Part1 v5 28/38] x86/compressed/64: enable
 SEV-SNP-validated CPUID in #VC handler
Message-ID: <20210901010325.3nqw7d44vhsdzryb@amd.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-29-brijesh.singh@amd.com>
 <YSaXtpKT+iE7dxYq@zn.tnic>
 <20210827164601.fzr45veg7a6r4lbp@amd.com>
 <YS3+saDefHwkYwny@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YS3+saDefHwkYwny@zn.tnic>
X-ClientProxiedBy: SA9PR13CA0178.namprd13.prod.outlook.com
 (2603:10b6:806:28::33) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (165.204.77.1) by SA9PR13CA0178.namprd13.prod.outlook.com (2603:10b6:806:28::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.9 via Frontend Transport; Wed, 1 Sep 2021 01:03:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f132e3ef-7381-47dc-cc38-08d96ce456cd
X-MS-TrafficTypeDiagnostic: CH2PR12MB4823:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB482347D07C712DEBFC050E3095CD9@CH2PR12MB4823.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j3bpRzP0spx0ZGtSGUnEhEGpQjzPEIvdky6kMBrzBpC2WiZrtvla0VVKyN2YxmI//wb6lNhVvXCehNFW8J+4XpnaI0S2bCi409WJ5nqJ4ofh0rbFiR5KrpG6sNsLIh+9RLggvMz6cbbHE/9L+V20ZWbB08aMwZOhvOVbZJPC6lHwXUzdIq1v96lzU3DDsyfn9VCRZS2fj2Wc2v9Npnq48hbQkQwa/Xw0jDDjsmyRwEIXq4cRRLR5YYwKX1A00XNbUOgTtuzp9rveXxyU5jzMRruTCw5R6/WW+fR2BHeOlZ5gnwegTiyK+jCrdJbzUqnsg7UMsDKZShWnfWzkUFb0W+9qjhmjquimqNEZPc04GPVkKt1gySKi3fNa9Z3G6zkCTWOiy4ivc0WpqBsgqirBYBJExQdUKeOT+0i+T+2v0vjqufh5X9PfYOYvBnUbP3k4QuwAOrQ6Kwsb+PDi6U7aL9t24Gz4hfoQyK747t1AyTUPajZPIb4Z6y4QErT/16m8ND+kIAV5ehgP/FMwEtEElH+hTn5BtCKwvqimb7ozg+PxQkKyD4OBEiDv0SkjwnsXfCMns2fREZPi3/FklFQ+u6QIgmXMxLcGfHyDxKQbTEHXyUCf7mh+sUfD4RhfBXHIBDOBE3c6+uwLA9kVXhjVz2I9o2UFYn9KbiIbwNKOq3uHSO9JL78NgD6hzUqI+/y3688ldYKNxqLKvtNpwyWvPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4133.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(8676002)(6666004)(86362001)(1076003)(8936002)(6486002)(186003)(36756003)(52116002)(26005)(66946007)(66556008)(83380400001)(38100700002)(38350700002)(6496006)(66476007)(6916009)(2616005)(956004)(5660300002)(2906002)(478600001)(44832011)(7416002)(7406005)(4326008)(54906003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dzjHCdGh+AdsDYWflQjAfH0iNfGbwIumJg4B5MipRsnKjaTu9XmBSgHpa8Up?=
 =?us-ascii?Q?IcQhh41pF1SFyCz9KXXw9eoeDVHt7QE/JEWmk4xWzYyIGItS8xxiTqxQtWO/?=
 =?us-ascii?Q?Vb0eWJwYbGuod9WIXzDc5mckgW4eV1ZI3NHThGuCR379cN4ibSy8Bev1UQQ3?=
 =?us-ascii?Q?NnTTMwjPML5OO2hSLTpG4DV5ZL9sqCfhVdheYFbEylxnYZG3rLbKLR7uTJI7?=
 =?us-ascii?Q?2xLgt9xPzhfV2h5+5jVk07dD0+/AUsjtSXHc6UCdakW+BtiC5p5Nv+bG3+65?=
 =?us-ascii?Q?MlKwyQFVsB7JcZazlce6VaFEMWG9V5HgaaFjHGOG7CgPIR/PaKAIcA/2kQWS?=
 =?us-ascii?Q?1ANLtKT63UMmW058grGxDfr/hWVsYNevkRVlViCGbFInYb09iw5hXw3jG6Am?=
 =?us-ascii?Q?kRlXAalwMDCHY6o449RwpKQL47M2Ke/7pKyKi0oXCSXTs0uYWX3CQEti4Ppg?=
 =?us-ascii?Q?Ts3d+W6nEtFG1AEGHChNbMlYEYDUlqN+jV0WQnQN4ANyV5Xc1YuUJURaMMql?=
 =?us-ascii?Q?OatYvU4zLU52cvoNdbu8JvqQFX6jgkIwX6PjSfVQXztFsr0vWaOdnLtVyqQq?=
 =?us-ascii?Q?LNiDrQyvp4HpDII1W8pfL4VmAey/Mu1UdCqbgeIiuCBCFytr8HeJpORgSGma?=
 =?us-ascii?Q?gFOVwTwyUwqlE1NLZLDU3eDgmzL2/2kVrE3kpGxqITH3ejte+H3HE9/HD8Ob?=
 =?us-ascii?Q?RnTKZnC53uvbar/z93ovaFa8EnBiPtAQuSjrVUHLEHOiANP9qV//Eb2gumx2?=
 =?us-ascii?Q?px5MblW1fc8FCE5crLJENSbTVXc3oquKoxYclAx9uEb9QPl1gGr1dDdvXMW2?=
 =?us-ascii?Q?KTXYV48Y3vjJg+qeRKJvPN3TktZAk0hYlbxC1WYijzIDhPe3pX1cm8TjOaRY?=
 =?us-ascii?Q?dE8OnhnnYwhMJxNLwpwjDaQDkJYFh3ZUrIV1/tguWm1aECWf6fELsINjQYkl?=
 =?us-ascii?Q?5qdD5dc5+B4GBa2Aw+TNwVImJnYp32qrft192xndLg+Lz1pa9F4tp+IAl5+U?=
 =?us-ascii?Q?QaXlImJ7+yX1WEV+6bEYclH1jvZHsrWSY94/NsDp+g9JZzfbj65hyoUsfIvD?=
 =?us-ascii?Q?QolFRDmiVvIKgc1zoxXJJXhP89H0crg+JHS1kIjUZgqLMUU/6uSuN0bYkYFU?=
 =?us-ascii?Q?UPT55zvbzZ8CgSft7+LfRrTH87XPIzkliy+lJ635DqZ9oK5cFCbXAB4HtlyU?=
 =?us-ascii?Q?IfIzdxgbPQxuM/qEyRRcCdJ/mNWjmpnNTldRaKpqZL3rcXmbZeW8NmuapwQJ?=
 =?us-ascii?Q?hzhVsx1oYPZHpUs53Sfl+XYqeV1BROuR8aHiBYbLG6s7WFAGcOAPZALFN1xP?=
 =?us-ascii?Q?SKdp7+rlLUqLuoveR6fHBYAY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f132e3ef-7381-47dc-cc38-08d96ce456cd
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 01:03:41.8080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dSFYioyk3kjt47ctFiUnzelIR86hqWFAXIc7nifuQSXs4qKwVLoHurigh2m0yxlEI/bdUm2yYNEADSAsTIMMlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4823
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Aug 31, 2021 at 12:04:33PM +0200, Borislav Petkov wrote:
> On Fri, Aug 27, 2021 at 11:46:01AM -0500, Michael Roth wrote:
> > Will make sure to great these together, but there seems to be a convention
> > of including misc.h first, since it does some fixups for subsequent
> > includes. So maybe that should be moved to the top? There's a comment in
> > boot/compressed/sev.c:
> > 
> > /*
> >  * misc.h needs to be first because it knows how to include the other kernel
> >  * headers in the pre-decompression code in a way that does not break
> >  * compilation.
> >  */
> > 
> > And while it's not an issue here, asm/sev.h now needs to have
> > __BOOT_COMPRESSED #define'd in advance. So maybe that #define should be
> > moved into misc.h so it doesn't have to happen before each include?
> 
> Actually, I'd like to avoid all such nasty games, if possible, with the
> compressed kernel includes because this is where it leads us: sprinkling
> defines left and right and all kinds of magic include order which is
> fragile and error prone.
> 
> So please try to be very conservative here with all the including games.
> 
> So I'd like to understand first *why* asm/sev.h needs to have
> __BOOT_COMPRESSED defined and can that be avoided? Maybe in a separate
> mail because this one already deals with a bunch of things.

I think I just convinced myself at some point that that's where all
these sev-shared.c declarations are supposed to go, but you're right, I
could just as easily move all the __BOOT_COMPRESSED-only definitions
into boot/compressed/misc.h and avoid the mess.

That'll make it nicer if I can get some of the __BOOT_COMPRESSED-guarded
definitions in sev-shared.c moved out boot/compressed/sev.c and
kernel/sev.c as well, with the help of some common setter/getter helpers
to still keep most of the core logic/data structures contained in
sev-shared.c.

> 
> > cpuid.h is for cpuid_function_is_indexed(), which was introduced in this
> > series with patch "KVM: x86: move lookup of indexed CPUID leafs to helper".
> 
> Ok, if we keep cpuid.h only strictly with cpuid-specific helpers, I
> guess that's fine.
> 
> > efi.h is for EFI_CC_BLOB_GUID, which gets referenced by sev-shared.c
> > when it gets included here. However, misc.h seems to already include it,
> > so it can be safely dropped from this patch.
> 
> Yeah, and this is what I mean: efi.h includes a bunch of linux/
> namespace headers and then we have to go deal with compressed
> pulling all kinds of definitions from kernel proper, with hacks like
> __BOOT_COMPRESSED, for example.
> 
> That EFI_CC_BLOB_GUID is only needed in the compressed kernel, right?
> That is, if you move all the CC blob parsing to the compressed kernel
> and supply the thusly parsed info to kernel proper. In that case, you
> can simply define in there, in efi.c or so.

It was used previously in kernel proper to get at the secrets page later,
but now it's obtained via the cached entry in boot_params.cc_blob_address.
Unfortunately it uses EFI_GUID() macro, so maybe efi.c or misc.h where
it makes more sense to add a copy of the macro?
