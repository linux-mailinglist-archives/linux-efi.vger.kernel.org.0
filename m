Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B973C15FC
	for <lists+linux-efi@lfdr.de>; Thu,  8 Jul 2021 17:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbhGHPcu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 8 Jul 2021 11:32:50 -0400
Received: from mga02.intel.com ([134.134.136.20]:36689 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231955AbhGHPcu (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 8 Jul 2021 11:32:50 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10039"; a="196701341"
X-IronPort-AV: E=Sophos;i="5.84,224,1620716400"; 
   d="scan'208";a="196701341"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2021 08:30:07 -0700
X-IronPort-AV: E=Sophos;i="5.84,224,1620716400"; 
   d="scan'208";a="645948336"
Received: from kezheong-mobl.gar.corp.intel.com (HELO [10.212.152.178]) ([10.212.152.178])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2021 08:30:05 -0700
Subject: Re: [PATCH Part2 RFC v4 09/40] x86/fault: Add support to dump RMP
 entry on fault
To:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-10-brijesh.singh@amd.com>
 <cb9e3890-9642-f254-2fe7-30621e686844@intel.com>
 <0d19eb84-f2b7-aa24-2fe9-19035b49fbd6@amd.com>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <15d5e954-0383-fe0e-e8c1-3e9f8b0ef8ff@intel.com>
Date:   Thu, 8 Jul 2021 08:30:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0d19eb84-f2b7-aa24-2fe9-19035b49fbd6@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 7/8/21 8:02 AM, Brijesh Singh wrote:
...
>>> +    pgd = __va(read_cr3_pa());
>>> +    pgd += pgd_index(address);
>>> +
>>> +    pte = lookup_address_in_pgd(pgd, address, &level);
>>> +    if (unlikely(!pte))
>>> +        return;
>>
>> It's a little annoying this is doing *another* separate page walk.
>> Don't we already do this for dumping the page tables themselves at oops
>> time?
> 
> Yes, we already do the walk in oops function, I'll extend the
> dump_rmpentry() to use the level from the oops to avoid the duplicate walk.

I was even thinking that you could use the pmd/pte entries that come
from the walk in dump_pagetable().

BTW, I think the snp_lookup_page_in_rmptable() interface is probably
wrong.  It takes a 'struct page':

+struct rmpentry *snp_lookup_page_in_rmptable(struct page *page, int *level)

but then immediately converts it to a paddr:

> +	unsigned long phys = page_to_pfn(page) << PAGE_SHIFT;

If you just had it take a paddr, you wouldn't have to mess with all of
this pfn_valid() and phys_to_page() error checking.

>>> +    case PG_LEVEL_2M: {
>>> +        pfn = pmd_pfn(*(pmd_t *)pte);
>>> +        break;
>>> +    }
>>> +    case PG_LEVEL_1G: {
>>> +        pfn = pud_pfn(*(pud_t *)pte);
>>> +        break;
>>> +    }
>>> +    case PG_LEVEL_512G: {
>>> +        pfn = p4d_pfn(*(p4d_t *)pte);
>>> +        break;
>>> +    }
>>> +    default:
>>> +        return;
>>> +    }
>>> +
>>> +    e = snp_lookup_page_in_rmptable(pfn_to_page(pfn), &level);
>>
>> So, lookup_address_in_pgd() looks to me like it will return pretty
>> random page table entries as long as the entry isn't
>> p{gd,4d,ud,md,te}_none().  It can certainly return !p*_present()
>> entries.  Those are *NOT* safe to call pfn_to_page() on.
>>
> 
> I will add some checks to make sure that we are accessing only safe pfn's.

Or fix the snp_lookup_page_in_rmptable() interface, please.

>>> +    if (rmpentry_assigned(e)) {
>>> +        pr_alert("RMPEntry paddr 0x%lx [assigned=%d immutable=%d
>>> pagesize=%d gpa=0x%lx"
>>> +            " asid=%d vmsa=%d validated=%d]\n", pfn << PAGE_SHIFT,
>>> +            rmpentry_assigned(e), rmpentry_immutable(e),
>>> rmpentry_pagesize(e),
>>> +            rmpentry_gpa(e), rmpentry_asid(e), rmpentry_vmsa(e),
>>> +            rmpentry_validated(e));
>>> +
>>> +        pr_alert("RMPEntry paddr 0x%lx %016llx %016llx\n", pfn <<
>>> PAGE_SHIFT,
>>> +            e->high, e->low);
>>
>> Could you please include an entire oops in the changelog that also
>> includes this information?  It would be really nice if this was at least
>> consistent in style to the stuff around it.
> 
> Here is one example: (in this case page was immutable and HV attempted
> to write to it).
> 
> BUG: unable to handle page fault for address: ffff98c78ee00000
> #PF: supervisor write access in kernel mode
> #PF: error_code(0x80000003) - rmp violation

Let's capitalize "RMP" here, please.

> PGD 304b201067 P4D 304b201067 PUD 20c7f06063 PMD 20c8976063 PTE
> 80000020cee00163
> RMPEntry paddr 0x20cee00000 [assigned=1 immutable=1 pagesize=0 gpa=0x0
> asid=0 vmsa=0 validated=0]
> RMPEntry paddr 0x20cee00000 000000000000000f 8000000000000ffd

That's a good example, thanks!

But, it does make me think that we shouldn't be spitting out
"immutable".  Should we call it "readonly" or something so that folks
have a better chance of figuring out what's wrong?  Even better, should
we be looking specifically for X86_PF_RMP *and* immutable=1 and spitting
out something in english about it?

This also *looks* to be spitting out the same "RMPEntry paddr
0x20cee00000" more than once.  Maybe we should just indent the extra
entries instead of repeating things.  The high/low are missing a "0x"
prefix, they also don't have any kind of text label.

>> Also, how much of this stuff like rmpentry_asid() is duplicated in the
>> "raw" dump of e->high and e->low?
> 
> Most of the rmpentry_xxx assessors read the e->low. The RMP entry is a
> 16-bytes. AMD APM defines only a few bits and keeps everything else
> reserved. We are in the process of updating APM to document few more
> bits. I am not adding assessors for the undocumented fields. Until then,
> we dump the entire 16-bytes.
> 
> I agree that we are duplicating the information. I can live with just a
> raw dump. That means anyone who is debugging the crash will look at the
> APM to decode the fields.

I actually really like processing the fields.  I think it's a good
investment to make the error messages as self-documenting as possible
and not require the poor souls who are decoding oopses to also keep each
vendor's architecture manuals at hand.

>> This also needs a comment about *WHY* this case is looking at a 2MB
>> region.
>>
> 
> Actually the comment above says why we are looking for the 2MB region.
> Let me rearrange the comment block so that its more clear.
> 
> The reason for iterating through 2MB region is; if the faulting address
> is not assigned in the RMP table, and page table walk level is 2MB then
> one of entry within the large page is the root cause of the fault. Since
> we don't know which entry hence I dump all the non-zero entries.

Logically you can figure this out though, right?  Why throw 511 entries
at the console when we *know* they're useless?

>>> +        pfn_end = pfn + PTRS_PER_PMD;
>>> +
>>> +        while (pfn < pfn_end) {
>>> +            e = snp_lookup_page_in_rmptable(pfn_to_page(pfn), &level);
>>> +
>>> +            if (unlikely(!e))
>>> +                return;
>>> +
>>> +            if (e->low || e->high)
>>> +                pr_alert("RMPEntry paddr 0x%lx: %016llx %016llx\n",
>>> +                    pfn << PAGE_SHIFT, e->high, e->low);
>>
>> Why does this dump "raw" RMP entries while the above stuff filters them
>> through a bunch of helper macros?
> 
> There are two cases which we need to consider:
> 
> 1) the faulting page is a guest private (aka assigned)
> 2) the faulting page is a hypervisor (aka shared)
> 
> We will be primarily seeing #1. In this case, we know its a assigned
> page, and we can decode the fields.
> 
> The #2 will happen in rare conditions,

What rare conditions?

> if it happens, one of the undocumented bit in the RMP entry can
> provide us some useful information hence we dump the raw values.
You're saying that there are things that can cause RMP faults that
aren't documented?  That's rather nasty for your users, don't you think?

I'd be fine if you want to define a mask of unknown bits and spit out to
the users that some unknown bits are set.
