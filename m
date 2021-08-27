Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D9B3FB967
	for <lists+linux-efi@lfdr.de>; Mon, 30 Aug 2021 17:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237705AbhH3P4z (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 30 Aug 2021 11:56:55 -0400
Received: from mail-dm6nam11on2081.outbound.protection.outlook.com ([40.107.223.81]:34017
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237311AbhH3P4y (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 30 Aug 2021 11:56:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZ9zvRwOlXH658cO19wdHLZmBVr9gLyYi+kd0MlTfmzAyypq090OUb4p8Hw1BAgQ/oq2z8q3AR8oT9KZCHnZ0ODdK0d6y6KGGwrCPtOuq+v5AVkrFErbhme6z3m1fFGhEOiroI/taGNBJFVJayWsAFUhjjtE6VDAA4NDyIzjRqJSYZ0G92Yy1eZcsNt+KYsqyAXOURt9HIe4hO5DOdCvw3BvFFUEylhthwEXJkOZTVTfV/oXeD4xLFRYzjcJTsRzEzlCzuAKBNija0rBbf5BndBqg3dUbLosuzRU8Qg0PiDxS4rjqDi+HjVruwT4/cyfGmMKJqbNyMFdjTTxHIk7qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0z5IkWQ2Si1KpnLG7qkHNCPtVIvBTkmGhCd0RtmIzU=;
 b=iyx0gisyg8i+KD7DVrLP/WOKUOULv/fLDo1IDYG5QAMNJFL1QMyeKkkNtzStrfPcyA3lEo6f+7ElG5P3NE999bLIEHhq7GbBln8ivCFOcvJqFZp1kk3mN+meMUA5q8HTDhmpwq4riouEEwwy8h+EVckhHD+wvQQ4+URyILX+GP13ASnsfRMgPzTqw1KLVUeak3DyBFY0O9qPug6C+K1pS/rECXxYvU+KvSsrIb4rBF55oD6qnm+I3jSoys0N6mJPP5UEklTZni2rUy9zG8y3JM/TKmQ8SmYWr+YiAL8+ddLhPCpghG+U+XlPHXzxRyK0kJ1GEnp3uANv+RqiKz9Tww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0z5IkWQ2Si1KpnLG7qkHNCPtVIvBTkmGhCd0RtmIzU=;
 b=EBDLtCJTyTvMiqmr2a7yFC8iRhz9WxjyQ6SR0UdhaFVXVj/cF8OUeZZb6nSTkHDT/ctN/M2E4O7YZ2Ox/NBxM+0mMS/d/sjjabfu1digcqCk3wRITHAhfL3fH7qEdh+0t4UJw0C0vJ01Pr6Uy53UctATwN6BRLgU236tvZixuT0=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB4039.namprd12.prod.outlook.com (2603:10b6:610:a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Mon, 30 Aug
 2021 15:55:57 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::d19e:b657:5259:24d0]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::d19e:b657:5259:24d0%8]) with mapi id 15.20.4436.019; Mon, 30 Aug 2021
 15:55:57 +0000
Date:   Fri, 27 Aug 2021 11:46:01 -0500
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
Message-ID: <20210827164601.fzr45veg7a6r4lbp@amd.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-29-brijesh.singh@amd.com>
 <YSaXtpKT+iE7dxYq@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSaXtpKT+iE7dxYq@zn.tnic>
X-ClientProxiedBy: SA0PR11CA0112.namprd11.prod.outlook.com
 (2603:10b6:806:d1::27) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (165.204.77.11) by SA0PR11CA0112.namprd11.prod.outlook.com (2603:10b6:806:d1::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend Transport; Mon, 30 Aug 2021 15:55:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21d57555-15ca-4428-a9ae-08d96bcea789
X-MS-TrafficTypeDiagnostic: CH2PR12MB4039:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4039ACDB69D79597927471B195CB9@CH2PR12MB4039.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:381;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zC/UgaJ3kFH3GoyWhDJ7HhIOAiSMs2r4YjgN8W0clsg7+c7bgCzhQj9afxZTVxdQZF8QMqtAQ4Vr2O6jZB2SjrDsKZJUj3bRPkV5DV+COEWIDcf4WQkcV3Wj3WYj7/kSSSGKGy112z2SIntv/Aa0LEOb35i+Pi7qNOJ5pr+lIqlgdMmiR8zBrF4OilEUS/uTT5U1nn56amO8xpawmuLVDrN9s1JR/Zu/XxlagrMbmHAzIgn8R5y9kLK0kp+X1a4XPARNv26yJxg+dhZtOacc8A/pMJpACgSCRbYNyCZZ99HcFD6DkwRkA4BD+Jqbvu7292xVAinHfh3YnG5T66iPIRjNr4MnIYD3dGl46Czf7IAJ9w7rolwgqAaJdXEt9saAb6XZ4qc/VqlaHZkNkj2ftqw18IHVqAjiFR/gfe0D9t7DMPfHXbPYPKCfue39NxqtVb4HRSeCnVXfavSULLQKjSrSonmElVEVEVSjUbMi/y4eae96u8P8aRswT4HOPxS7Vr/zsZArI7J8aKmV9wYvV3pGma23gT0dHn0ybxpVkgCFRcf+RXoA/BCOGFYzxY5N9aOK+OAxL7cVlB/wJtc/L2lNeOX1GWeOiTjuUlNiXcQCJT6aCeociqVl/QwTdbJEgDDxRsiMTI3tg31u+7HY4DaNhZi0/MVzMbo0BjY/FzesZi0P5AtZCdtNs/q/xphsE6yUV96XY5X1iQ9pf7koUEpo+B8aEOMmEione3Z11zjLW+4t/1JadOShOg3us36QgSG2i92/5QPzA1kWrbjHfc0MVPqbjSR3efXtAK6tjgX3GCBv5AQyfmYoRMvJkLJiFHWx+2/RmGk7i3uA/4aY2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4133.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(38350700002)(2906002)(508600001)(86362001)(38100700002)(1076003)(66556008)(36756003)(186003)(956004)(6916009)(83380400001)(7406005)(7416002)(45080400002)(6666004)(52116002)(4326008)(30864003)(15650500001)(6486002)(26005)(966005)(6496006)(54906003)(66946007)(316002)(2616005)(8936002)(44832011)(5660300002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fjVE+hkYOBJ/1PPyfLvl3MGRQq8xtIVGjN9D2/SbWZ7DwtjaXuy53NP+sKmp?=
 =?us-ascii?Q?fVYYWpKMnRq239856fsmksfbjtZlf7WJ0Mbt4BBRPpbzptup0pq2FXuI6rEc?=
 =?us-ascii?Q?F3QnrFRLQ0uorSgujWZyaNwutbsi0cwYDmYjqX9h0y4Le8uj5qCmCh8YT7bu?=
 =?us-ascii?Q?7KpfF6kqPuYBhKeg9LqfZYCKzCJtNTvNf8ZksjXIQTfjTigT2wyA8zfM9LsF?=
 =?us-ascii?Q?56crtoYX2iWiCS6SqO2Cwh0IlrWL8SpvaLybhAoeaMGjCOEjtZj5HKYPV63I?=
 =?us-ascii?Q?ixhyjXTbutsADkN73+yxAVoSC02P/UQNShhgK/JWrMZsBqgg7NAgz1HKa0u5?=
 =?us-ascii?Q?XsO2G1mMqR89eOyjsI3VYmFSl19zZocFM/IgnvFKAYwNcZzdFSRkqlVOCtxO?=
 =?us-ascii?Q?U+Fi0AClCPYTVGw3e7SJBHZnLw3P67qBHATidSJkxuBcYnPBaTRqEHqShXog?=
 =?us-ascii?Q?+Wck+qWbdSDKirKbgY4XKus6HHV5m9vRFDQutaOIynJmcidBvVDc3Zi9UzkS?=
 =?us-ascii?Q?H/Z9f1fe2AlDoOqu/tyr1Z1jQ5gzfco/nqjFIiFopfKMrcl9WkusaxC5G9y7?=
 =?us-ascii?Q?pWxIa+lfOzw0X2oFYOJxvNSe/D3eNywuGCGLDSlwSyGpTdnc+YfLfaKArbZq?=
 =?us-ascii?Q?NZHURDUZK44GbmtwPFHogKcJXZKstUEEDmmIjzst/auULCGcWusIXv7OJRGw?=
 =?us-ascii?Q?jJ0RcVzWi0tuBrUALkd83Q2/qNvJGvSsN55UnWIfqo/fxTHrY5lE+nJZ2laS?=
 =?us-ascii?Q?cIeiArNfBxXmnfZUiwPZnytAf6it0b/XZOR3XUlHUMRblOSy64FtqvPPdCBg?=
 =?us-ascii?Q?qPdirw4oeUdD8EKk5x8Hy8Ypg+P2jtNQ/rn+s+DpL+8JChZNFMsdm6trOlT6?=
 =?us-ascii?Q?rLzcoSx1LvUbTEAvIr9L81CBxaqg4blgmS8IRnhw7/RZF2Hr35IhZBE1BVXj?=
 =?us-ascii?Q?kQAO25HgfHYII1VSsEiyU5e7VHKQFzHGkbuY7q68+7BqIWdNBruIDkXc5ghp?=
 =?us-ascii?Q?jmQLSyCvBT+h/k+erTdD7Z5iBp/hDPLT6g3/eup9QTSfuNuPUcmhaaNRuTVG?=
 =?us-ascii?Q?5kjSaYLkVi/QsY3ThtqlIi8JUpOPhAhFHQPAEE58bHEHptOBIJPb1LVCX0sS?=
 =?us-ascii?Q?G6QGZIBjuqwVq0dTk6ZpUwpOUvU+9Y539VkmqErb93l5upxYA7zZsj20wYKR?=
 =?us-ascii?Q?wgP1N6GFSyExPbnZFhFNzaUKA6mCTK6CvpfpUU1YG1EwXf+K2mg90w/qScoL?=
 =?us-ascii?Q?JntIwzJ7rFmhVD8Veg4SngEoEzKAhIeUQRNcqKfstMDxP6g9xdPbx87MKUbk?=
 =?us-ascii?Q?G2CR7pDyqAMq2Teub9gTWNBv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d57555-15ca-4428-a9ae-08d96bcea789
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 15:55:57.6987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4nNYRIvrxtNOzECe/AWwNcUHyFtnL9bBGsIc7KTHrOstuWyvVo8BE2wJcCYXGvJ6VhsatKstun9CR+Hc7bJUXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4039
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Aug 25, 2021 at 09:19:18PM +0200, Borislav Petkov wrote:
> On Fri, Aug 20, 2021 at 10:19:23AM -0500, Brijesh Singh wrote:
> > From: Michael Roth <michael.roth@amd.com>
> > 
> > CPUID instructions generate a #VC exception for SEV-ES/SEV-SNP guests,
> > for which early handlers are currently set up to handle. In the case
> > of SEV-SNP, guests can use a special location in guest memory address
> > space that has been pre-populated with firmware-validated CPUID
> > information to look up the relevant CPUID values rather than
> > requesting them from hypervisor via a VMGEXIT.
> > 
> > Determine the location of the CPUID memory address in advance of any
> > CPUID instructions/exceptions and, when available, use it to handle
> > the CPUID lookup.
> > 
> > Signed-off-by: Michael Roth <michael.roth@amd.com>
> > Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> > ---
> >  arch/x86/boot/compressed/efi.c     |   1 +
> >  arch/x86/boot/compressed/head_64.S |   1 +
> >  arch/x86/boot/compressed/idt_64.c  |   7 +-
> >  arch/x86/boot/compressed/misc.h    |   1 +
> >  arch/x86/boot/compressed/sev.c     |   3 +
> >  arch/x86/include/asm/sev-common.h  |   2 +
> >  arch/x86/include/asm/sev.h         |   3 +
> >  arch/x86/kernel/sev-shared.c       | 374 +++++++++++++++++++++++++++++
> >  arch/x86/kernel/sev.c              |   4 +
> >  9 files changed, 394 insertions(+), 2 deletions(-)
> 
> Another huuge patch. I wonder if it can be split...

I think I can split out at least sev_snp_cpuid_init() and
sev_snp_probe_cc_blob(). Adding the actual cpuid lookup and related code to
#VC handler though I'm not sure there's much that can be done there.

> 
> > diff --git a/arch/x86/boot/compressed/efi.c b/arch/x86/boot/compressed/efi.c
> > index 16ff5cb9a1fb..a1529a230ea7 100644
> > --- a/arch/x86/boot/compressed/efi.c
> > +++ b/arch/x86/boot/compressed/efi.c
> > @@ -176,3 +176,4 @@ efi_get_conf_table(struct boot_params *boot_params,
> >  
> >  	return 0;
> >  }
> > +
> 
> Applying: x86/compressed/64: Enable SEV-SNP-validated CPUID in #VC handler
> .git/rebase-apply/patch:21: new blank line at EOF.
> +
> warning: 1 line adds whitespace errors.
> 
> That looks like a stray hunk which doesn't belong.

Will get this fixed up. I should've noticed these checkpatch warnings so
I modified my git hook to flag these a bit more prevalently.

> 
> > diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> > index a2347ded77ea..1c1658693fc9 100644
> > --- a/arch/x86/boot/compressed/head_64.S
> > +++ b/arch/x86/boot/compressed/head_64.S
> > @@ -441,6 +441,7 @@ SYM_CODE_START(startup_64)
> >  .Lon_kernel_cs:
> >  
> >  	pushq	%rsi
> > +	movq	%rsi, %rdi		/* real mode address */
> >  	call	load_stage1_idt
> >  	popq	%rsi
> >  
> > diff --git a/arch/x86/boot/compressed/idt_64.c b/arch/x86/boot/compressed/idt_64.c
> > index 9b93567d663a..1f6511a6625d 100644
> > --- a/arch/x86/boot/compressed/idt_64.c
> > +++ b/arch/x86/boot/compressed/idt_64.c
> > @@ -3,6 +3,7 @@
> >  #include <asm/segment.h>
> >  #include <asm/trapnr.h>
> >  #include "misc.h"
> > +#include <asm/sev.h>
> 
> asm/ namespaced headers should go together, before the private ones,
> i.e., above the misc.h line.

Will make sure to great these together, but there seems to be a convention
of including misc.h first, since it does some fixups for subsequent
includes. So maybe that should be moved to the top? There's a comment in
boot/compressed/sev.c:

/*
 * misc.h needs to be first because it knows how to include the other kernel
 * headers in the pre-decompression code in a way that does not break
 * compilation.
 */

And while it's not an issue here, asm/sev.h now needs to have
__BOOT_COMPRESSED #define'd in advance. So maybe that #define should be
moved into misc.h so it doesn't have to happen before each include?

> 
> >  static void set_idt_entry(int vector, void (*handler)(void))
> >  {
> > @@ -28,13 +29,15 @@ static void load_boot_idt(const struct desc_ptr *dtr)
> >  }
> >  
> >  /* Setup IDT before kernel jumping to  .Lrelocated */
> > -void load_stage1_idt(void)
> > +void load_stage1_idt(void *rmode)
> >  {
> >  	boot_idt_desc.address = (unsigned long)boot_idt;
> >  
> >  
> > -	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT))
> > +	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
> > +		sev_snp_cpuid_init(rmode);
> >  		set_idt_entry(X86_TRAP_VC, boot_stage1_vc);
> > +	}
> >  
> >  	load_boot_idt(&boot_idt_desc);
> >  }
> > diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
> > index 16b092fd7aa1..cdd328aa42c2 100644
> > --- a/arch/x86/boot/compressed/misc.h
> > +++ b/arch/x86/boot/compressed/misc.h
> > @@ -190,6 +190,7 @@ int efi_get_conf_table(struct boot_params *boot_params,
> >  		       unsigned long *conf_table_pa,
> >  		       unsigned int *conf_table_len,
> >  		       bool *is_efi_64);
> > +
> 
> Another stray hunk.
> 
> >  #else
> >  static inline int
> >  efi_find_vendor_table(unsigned long conf_table_pa, unsigned int conf_table_len,
> > diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> > index 6e8d97c280aa..910bf5cf010e 100644
> > --- a/arch/x86/boot/compressed/sev.c
> > +++ b/arch/x86/boot/compressed/sev.c
> > @@ -20,6 +20,9 @@
> >  #include <asm/fpu/xcr.h>
> >  #include <asm/ptrace.h>
> >  #include <asm/svm.h>
> > +#include <asm/cpuid.h>
> > +#include <linux/efi.h>
> > +#include <linux/log2.h>
> 
> What are those includes for?
> 
> Polluting the decompressor namespace with kernel proper defines is a
> real pain to untangle as it is. What do you need those for and can you
> do it without them?

cpuid.h is for cpuid_function_is_indexed(), which was introduced in this
series with patch "KVM: x86: move lookup of indexed CPUID leafs to helper".

efi.h is for EFI_CC_BLOB_GUID, which gets referenced by sev-shared.c
when it gets included here. However, misc.h seems to already include it,
so it can be safely dropped from this patch.

log2.h seems to be an artifact, I'll get that cleaned up.

> 
> >  #include "error.h"
> >  
> > diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
> > index 072540dfb129..5f134c172dbf 100644
> > --- a/arch/x86/include/asm/sev-common.h
> > +++ b/arch/x86/include/asm/sev-common.h
> > @@ -148,6 +148,8 @@ struct snp_psc_desc {
> >  #define GHCB_TERM_PSC			1	/* Page State Change failure */
> >  #define GHCB_TERM_PVALIDATE		2	/* Pvalidate failure */
> >  #define GHCB_TERM_NOT_VMPL0		3	/* SNP guest is not running at VMPL-0 */
> > +#define GHCB_TERM_CPUID			4	/* CPUID-validation failure */
> > +#define GHCB_TERM_CPUID_HV		5	/* CPUID failure during hypervisor fallback */
> >  
> >  #define GHCB_RESP_CODE(v)		((v) & GHCB_MSR_INFO_MASK)
> >  
> > diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> > index 534fa1c4c881..c73931548346 100644
> > --- a/arch/x86/include/asm/sev.h
> > +++ b/arch/x86/include/asm/sev.h
> > @@ -11,6 +11,7 @@
> >  #include <linux/types.h>
> >  #include <asm/insn.h>
> >  #include <asm/sev-common.h>
> > +#include <asm/bootparam.h>
> >  
> >  #define GHCB_PROTOCOL_MIN	1ULL
> >  #define GHCB_PROTOCOL_MAX	2ULL
> > @@ -126,6 +127,7 @@ void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op
> >  void snp_set_memory_shared(unsigned long vaddr, unsigned int npages);
> >  void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
> >  void snp_set_wakeup_secondary_cpu(void);
> > +void sev_snp_cpuid_init(struct boot_params *bp);
> >  #else
> >  static inline void sev_es_ist_enter(struct pt_regs *regs) { }
> >  static inline void sev_es_ist_exit(void) { }
> > @@ -141,6 +143,7 @@ static inline void __init snp_prep_memory(unsigned long paddr, unsigned int sz,
> >  static inline void snp_set_memory_shared(unsigned long vaddr, unsigned int npages) { }
> >  static inline void snp_set_memory_private(unsigned long vaddr, unsigned int npages) { }
> >  static inline void snp_set_wakeup_secondary_cpu(void) { }
> > +static inline void sev_snp_cpuid_init(struct boot_params *bp) { }
> >  #endif
> >  
> >  #endif
> > diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> > index ae4556925485..651980ddbd65 100644
> > --- a/arch/x86/kernel/sev-shared.c
> > +++ b/arch/x86/kernel/sev-shared.c
> > @@ -14,6 +14,25 @@
> >  #define has_cpuflag(f)	boot_cpu_has(f)
> >  #endif
> >  
> > +struct sev_snp_cpuid_fn {
> > +	u32 eax_in;
> > +	u32 ecx_in;
> > +	u64 unused;
> > +	u64 unused2;
> 
> What are those for? Padding? Or are they spec-ed somewhere and left for
> future use?
> 
> Seeing how the struct is __packed, they probably are part of a spec
> definition somewhere.
> 
> Link pls.
> 
> > +	u32 eax;
> > +	u32 ebx;
> > +	u32 ecx;
> > +	u32 edx;
> > +	u64 reserved;
> 
> Ditto.
> 
> Please prefix all those unused/reserved members with "__".

Will do.

> 
> > +} __packed;
> > +
> > +struct sev_snp_cpuid_info {
> > +	u32 count;
> > +	u32 reserved1;
> > +	u64 reserved2;
> 
> Ditto.

The 'reserved' fields here are documented in SEV-SNP Firmware ABI
revision 0.9, section 8.14.2.6 (CPUID page), and the above 'reserved'
fields of sev_snp_cpuid_fn are documented in section 7.1 (CPUID Reporting)
Table 14:

  https://www.amd.com/system/files/TechDocs/56860.pdf

The 'unused' / 'unused2' fields correspond to 'XCR0_IN' and 'XSS_IN' in 
section 7.1 Table 14. They are meant to allow a hypervisor to encode
CPUID leaf 0xD subleaf 0x0:0x1 entries that are specific to a certain
set of XSAVE features enabled via XCR0/XSS registers, so a guest can
look up the specific entry based on its current XCR0/XSS register
values.

This doesn't scale very well as more XSAVE features are added however,
and was more useful for the CPUID guest message documented in 7.1, as
opposed to the static CPUID page implemented here.

Instead, it is simpler and just as safe to have the guest calculate the
appropriate values based on CPUID leaf 0xD, subleaves 0x2-0x3F, like
what sev_snp_cpuid_xsave_size() does below. So they are marked unused
here to try to make that clearer.

Some of these hypervisor-specific implementation notes have been summarized
into a document posted to the sev-snp mailing list in June:

  "Guest/Hypervisor Implementation Notes for SEV-SNP CPUID Enforcement"

It's currently in RFC v2, but there has been a change relating to the
CPUID range checks that needs to be added for v3, I'll get that sent
out soon. We are hoping to get these included in an official spec to
help with interoperability between hypervisors, but for now it is only
a reference to aid implementations.

> 
> > +	struct sev_snp_cpuid_fn fn[0];
> > +} __packed;
> > +
> >  /*
> >   * Since feature negotiation related variables are set early in the boot
> >   * process they must reside in the .data section so as not to be zeroed
> > @@ -26,6 +45,15 @@ static u16 __ro_after_init ghcb_version;
> >  /* Bitmap of SEV features supported by the hypervisor */
> >  u64 __ro_after_init sev_hv_features = 0;
> >  
> > +/*
> > + * These are also stored in .data section to avoid the need to re-parse
> > + * boot_params and re-determine CPUID memory range when .bss is cleared.
> > + */
> > +static int sev_snp_cpuid_enabled __section(".data");
> 
> That will become part of prot_guest_has() or cc_platform_has() or
> whatever its name is going to be.

Ok, will look at working this into there.

> 
> > +static unsigned long sev_snp_cpuid_pa __section(".data");
> > +static unsigned long sev_snp_cpuid_sz __section(".data");
> > +static const struct sev_snp_cpuid_info *cpuid_info __section(".data");
> 
> All those: __ro_after_init?

Makes sense.

> 
> Also, just like the ones above have a short comment explaining what they
> are, add such comments for those too pls and perhaps what they're used
> for.

Will do.

> 
> > +
> >  static bool __init sev_es_check_cpu_features(void)
> >  {
> >  	if (!has_cpuflag(X86_FEATURE_RDRAND)) {
> > @@ -236,6 +264,219 @@ static int sev_cpuid_hv(u32 func, u32 subfunc, u32 *eax, u32 *ebx,
> >  	return 0;
> >  }
> >  
> > +static bool sev_snp_cpuid_active(void)
> > +{
> > +	return sev_snp_cpuid_enabled;
> > +}
> 
> That too will become part of prot_guest_has() or cc_platform_has() or
> whatever its name is going to be.
> 
> > +
> > +static int sev_snp_cpuid_xsave_size(u64 xfeatures_en, u32 base_size,
> > +				    u32 *xsave_size, bool compacted)
> 
> Function name needs a verb. Please audit all your patches.
> 
> > +{
> > +	u64 xfeatures_found = 0;
> > +	int i;
> > +
> > +	*xsave_size = base_size;
> 
> Set that xsave_size only...
> > +
> > +	for (i = 0; i < cpuid_info->count; i++) {
> > +		const struct sev_snp_cpuid_fn *fn = &cpuid_info->fn[i];
> > +
> > +		if (!(fn->eax_in == 0xd && fn->ecx_in > 1 && fn->ecx_in < 64))
> > +			continue;
> > +		if (!(xfeatures_en & (1UL << fn->ecx_in)))
> > +			continue;
> > +		if (xfeatures_found & (1UL << fn->ecx_in))
> > +			continue;
> > +
> > +		xfeatures_found |= (1UL << fn->ecx_in);
> 
> For all use BIT_ULL().
> 
> > +		if (compacted)
> > +			*xsave_size += fn->eax;
> > +		else
> > +			*xsave_size = max(*xsave_size, fn->eax + fn->ebx);
> 
> ... not here ...
> 
> > +	}
> > +
> > +	/*
> > +	 * Either the guest set unsupported XCR0/XSS bits, or the corresponding
> > +	 * entries in the CPUID table were not present. This is not a valid
> > +	 * state to be in.
> > +	 */
> > +	if (xfeatures_found != (xfeatures_en & ~3ULL))
> > +		return -EINVAL;
> 
> ... but here when you're not going to return an error because callers
> will see that value change temporarily which is not clean.
> 
> Also, you need to set it once - not during each loop iteration.

Much nicer, will do.

> 
> > +
> > +	return 0;
> > +}
> > +
> > +static void sev_snp_cpuid_hv(u32 func, u32 subfunc, u32 *eax, u32 *ebx,
> > +			     u32 *ecx, u32 *edx)
> > +{
> > +	/*
> > +	 * Currently MSR protocol is sufficient to handle fallback cases, but
> > +	 * should that change make sure we terminate rather than grabbing random
> 
> Fix the "we"s please. Please audit all your patches.
> 
> > +	 * values. Handling can be added in future to use GHCB-page protocol for
> > +	 * cases that occur late enough in boot that GHCB page is available
> 
> End comment sentences with a fullstop. Please audit all your patches.
> 
> > +	 */
> 
> Also, put that comment over the function.
> 
> > +	if (cpuid_function_is_indexed(func) && subfunc != 0)
> 
> In all your patches:
> 
> s/ != 0//g
> 
> > +		sev_es_terminate(1, GHCB_TERM_CPUID_HV);
> > +
> > +	if (sev_cpuid_hv(func, 0, eax, ebx, ecx, edx))
> > +		sev_es_terminate(1, GHCB_TERM_CPUID_HV);
> > +}
> > +
> > +static bool sev_snp_cpuid_find(u32 func, u32 subfunc, u32 *eax, u32 *ebx,
> 
> I guess
> 
> 	find_validated_cpuid_func()
> 
> or so to denote where it picks it out from.
> 
> > +			       u32 *ecx, u32 *edx)
> > +{
> > +	int i;
> > +	bool found = false;
> 
> The tip-tree preferred ordering of variable declarations at the
> beginning of a function is reverse fir tree order::
> 
> 	struct long_struct_name *descriptive_name;
> 	unsigned long foo, bar;
> 	unsigned int tmp;
> 	int ret;
> 
> The above is faster to parse than the reverse ordering::
> 
> 	int ret;
> 	unsigned int tmp;
> 	unsigned long foo, bar;
> 	struct long_struct_name *descriptive_name;
> 
> And even more so than random ordering::
> 
> 	unsigned long foo, bar;
> 	int ret;
> 	struct long_struct_name *descriptive_name;
> 	unsigned int tmp;
> 
> Audit all your patches pls.
> 
> > +
> > +	for (i = 0; i < cpuid_info->count; i++) {
> > +		const struct sev_snp_cpuid_fn *fn = &cpuid_info->fn[i];
> > +
> > +		if (fn->eax_in != func)
> > +			continue;
> > +
> > +		if (cpuid_function_is_indexed(func) && fn->ecx_in != subfunc)
> > +			continue;
> > +
> > +		*eax = fn->eax;
> > +		*ebx = fn->ebx;
> > +		*ecx = fn->ecx;
> > +		*edx = fn->edx;
> > +		found = true;
> > +
> > +		break;
> 
> That's just silly. Simply:
> 
> 		return true;
> 
> 
> > +	}
> > +
> > +	return found;
> 
> 	return false;
> 
> here and the "found" variable can go.

Will do. Missed this cleanup when I originally moved this out to a
seperate helper.

> 
> > +}
> > +
> > +static bool sev_snp_cpuid_in_range(u32 func)
> > +{
> > +	int i;
> > +	u32 std_range_min = 0;
> > +	u32 std_range_max = 0;
> > +	u32 hyp_range_min = 0x40000000;
> > +	u32 hyp_range_max = 0;
> > +	u32 ext_range_min = 0x80000000;
> > +	u32 ext_range_max = 0;
> > +
> > +	for (i = 0; i < cpuid_info->count; i++) {
> > +		const struct sev_snp_cpuid_fn *fn = &cpuid_info->fn[i];
> > +
> > +		if (fn->eax_in == std_range_min)
> > +			std_range_max = fn->eax;
> > +		else if (fn->eax_in == hyp_range_min)
> > +			hyp_range_max = fn->eax;
> > +		else if (fn->eax_in == ext_range_min)
> > +			ext_range_max = fn->eax;
> > +	}
> 
> So this loop which determines those ranges will run each time
> sev_snp_cpuid_find() doesn't find @func among the validated CPUID leafs.
> 
> Why don't you do that determination once at init...
> 
> > +
> > +	if ((func >= std_range_min && func <= std_range_max) ||
> > +	    (func >= hyp_range_min && func <= hyp_range_max) ||
> > +	    (func >= ext_range_min && func <= ext_range_max))
> 
> ... so that this function becomes only this check?
> 
> This is unnecessary work as it is.

That makes sense. I was treating this as an edge case but it could actually
happen fairly often in some case. I'll plan to add __ro_after_init
variables to store these values.

> 
> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> > +/*
> > + * Returns -EOPNOTSUPP if feature not enabled. Any other return value should be
> > + * treated as fatal by caller since we cannot fall back to hypervisor to fetch
> > + * the values for security reasons (outside of the specific cases handled here)
> > + */
> > +static int sev_snp_cpuid(u32 func, u32 subfunc, u32 *eax, u32 *ebx, u32 *ecx,
> > +			 u32 *edx)
> > +{
> > +	if (!sev_snp_cpuid_active())
> > +		return -EOPNOTSUPP;
> > +
> > +	if (!cpuid_info)
> > +		return -EIO;
> > +
> > +	if (!sev_snp_cpuid_find(func, subfunc, eax, ebx, ecx, edx)) {
> > +		/*
> > +		 * Some hypervisors will avoid keeping track of CPUID entries
> > +		 * where all values are zero, since they can be handled the
> > +		 * same as out-of-range values (all-zero). In our case, we want
> > +		 * to be able to distinguish between out-of-range entries and
> > +		 * in-range zero entries, since the CPUID table entries are
> > +		 * only a template that may need to be augmented with
> > +		 * additional values for things like CPU-specific information.
> > +		 * So if it's not in the table, but is still in the valid
> > +		 * range, proceed with the fix-ups below. Otherwise, just return
> > +		 * zeros.
> > +		 */
> > +		*eax = *ebx = *ecx = *edx = 0;
> > +		if (!sev_snp_cpuid_in_range(func))
> > +			goto out;
> 
> That label is not needed.
> 
> > +	}
> 
> All that from here on looks like it should go into a separate function
> called
> 
> snp_cpuid_postprocess()
> 
> where you can do a switch-case on func and have it nice, readable and
> extensible there, in case more functions get added.

Sounds good.

> >  /*
> >   * Boot VC Handler - This is the first VC handler during boot, there is no GHCB
> >   * page yet, so it only supports the MSR based communication with the
> 
> Is that comment...

Technically it supports MSR communication *and* CPUID page lookups now.
Assuming that's what you're referring to I'll get that added.

> 
> > @@ -244,15 +485,25 @@ static int sev_cpuid_hv(u32 func, u32 subfunc, u32 *eax, u32 *ebx,
> >  void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
> >  {
> >  	unsigned int fn = lower_bits(regs->ax, 32);
> > +	unsigned int subfn = lower_bits(regs->cx, 32);
> >  	u32 eax, ebx, ecx, edx;
> > +	int ret;
> >  
> >  	/* Only CPUID is supported via MSR protocol */
> 
> ... and that still valid?

"Only CPUID #VCs can be handled without using a GHCB page" might be a
bit more to the point now. I'll update it.

> > +
> > +out_verify:
> > +	/* CC blob should be either valid or not present. Fail otherwise. */
> > +	if (cc_info && cc_info->magic != CC_BLOB_SEV_HDR_MAGIC)
> > +		sev_es_terminate(1, GHCB_SNP_UNSUPPORTED);
> > +
> > +	return cc_info;
> > +}
> > +#else
> > +/*
> > + * Probing for CC blob for run-time kernel will be enabled in a subsequent
> > + * patch. For now we need to stub this out.
> > + */
> > +static struct cc_blob_sev_info *sev_snp_probe_cc_blob(struct boot_params *bp)
> > +{
> > +	return NULL;
> > +}
> > +#endif
> > +
> > +/*
> > + * Initial set up of CPUID table when running identity-mapped.
> > + *
> > + * NOTE: Since SEV_SNP feature partly relies on CPUID checks that can't
> > + * happen until we access CPUID page, we skip the check and hope the
> > + * bootloader is providing sane values.
> 
> So I don't like the sound of that even one bit. We shouldn't hope
> anything here...

More specifically, the general protocol to determine SNP is enabled seems
to be:

 1) check cpuid 0x8000001f to determine if SEV bit is enabled and SEV
    MSR is available
 2) check the SEV MSR to see if SEV-SNP bit is set

but the conundrum here is the CPUID page is only valid if SNP is
enabled, otherwise it can be garbage. So the code to set up the page
skips those checks initially, and relies on the expectation that UEFI,
or whatever the initial guest blob was, will only provide a CC_BLOB if
it already determined SNP is enabled.

It's still possible something goes awry and the kernel gets handed a
bogus CC_BLOB even though SNP isn't actually enabled. In this case the
cpuid values could be bogus as well, but the guest will fail
attestation then and no secrets should be exposed.

There is one thing that could tighten up the check a bit though. Some
bits of SEV-ES code will use the generation of a #VC as an indicator
of SEV-ES support, which implies SEV MSR is available without relying
on hypervisor-provided CPUID bits. I could add a one-time check in
the cpuid #VC to check SEV MSR for SNP bit, but it would likely
involve another static __ro_after_init variable store state. If that
seems worthwhile I can look into that more as well.

> 
> > Current code relies on all CPUID
> > + * page lookups originating from #VC handler, which at least provides
> > + * indication that SEV-ES is enabled. Subsequent init levels will check for
> > + * SEV_SNP feature once available to also take SEV MSR value into account.
> > + */
> > +void sev_snp_cpuid_init(struct boot_params *bp)
> 
> snp_cpuid_init()
> 
> In general, prefix all SNP-specific variables, structs, functions, etc
> with "snp_" simply.
> 
> > +{
> > +	struct cc_blob_sev_info *cc_info;
> > +
> > +	if (!bp)
> > +		sev_es_terminate(1, GHCB_TERM_CPUID);
> > +
> > +	cc_info = sev_snp_probe_cc_blob(bp);
> > +
> 
> ^ Superfluous newline.
> 
> > +	if (!cc_info)
> > +		return;
> > +
> > +	sev_snp_cpuid_pa = cc_info->cpuid_phys;
> > +	sev_snp_cpuid_sz = cc_info->cpuid_len;
> 
> You can do those assignments ...
> 
> > +
> > +	/*
> > +	 * These should always be valid values for SNP, even if guest isn't
> > +	 * actually configured to use the CPUID table.
> > +	 */
> > +	if (!sev_snp_cpuid_pa || sev_snp_cpuid_sz < PAGE_SIZE)
> > +		sev_es_terminate(1, GHCB_TERM_CPUID);
> 
> 
> ... here, after you've verified them.
> 
> > +
> > +	cpuid_info = (const struct sev_snp_cpuid_info *)sev_snp_cpuid_pa;
> > +
> > +	/*
> > +	 * We should be able to trust the 'count' value in the CPUID table
> > +	 * area, but ensure it agrees with CC blob value to be safe.
> > +	 */
> > +	if (sev_snp_cpuid_sz < (sizeof(struct sev_snp_cpuid_info) +
> > +				sizeof(struct sev_snp_cpuid_fn) *
> > +				cpuid_info->count))
> 
> Yah, this is the type of paranoia I'm talking about!
> 
> > +		sev_es_terminate(1, GHCB_TERM_CPUID);
> > +
> > +	sev_snp_cpuid_enabled = 1;
> > +}
> > diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> > index ddf8ced4a879..d7b6f7420551 100644
> > --- a/arch/x86/kernel/sev.c
> > +++ b/arch/x86/kernel/sev.c
> > @@ -19,6 +19,8 @@
> >  #include <linux/kernel.h>
> >  #include <linux/mm.h>
> >  #include <linux/cpumask.h>
> > +#include <linux/log2.h>
> > +#include <linux/efi.h>
> >  
> >  #include <asm/cpu_entry_area.h>
> >  #include <asm/stacktrace.h>
> > @@ -32,6 +34,8 @@
> >  #include <asm/smp.h>
> >  #include <asm/cpu.h>
> >  #include <asm/apic.h>
> > +#include <asm/efi.h>
> > +#include <asm/cpuid.h>
> >  
> >  #include "sev-internal.h"
> 
> What are those includes for?

These are also for EFI_CC_BLOB_GUID and cpuid_function_is_indexed,
respectively. Will add comments to clarify.

Thanks for the thorough review, will address all comments.

> 
> Looks like a leftover...
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7Cmichael.roth%40amd.com%7C4640a85832a9482de34f08d967fd2972%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637655159332919463%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=jpLwHsCIsXMV1jvwBp7DjPX4RAnw5tWRqB%2F9Ddccp%2FY%3D&amp;reserved=0
