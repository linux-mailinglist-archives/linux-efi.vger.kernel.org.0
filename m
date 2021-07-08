Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E15ED3C16F5
	for <lists+linux-efi@lfdr.de>; Thu,  8 Jul 2021 18:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbhGHQWM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 8 Jul 2021 12:22:12 -0400
Received: from mga09.intel.com ([134.134.136.24]:17447 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229468AbhGHQWM (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 8 Jul 2021 12:22:12 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10039"; a="209499244"
X-IronPort-AV: E=Sophos;i="5.84,224,1620716400"; 
   d="scan'208";a="209499244"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2021 09:16:29 -0700
X-IronPort-AV: E=Sophos;i="5.84,224,1620716400"; 
   d="scan'208";a="645962338"
Received: from kezheong-mobl.gar.corp.intel.com (HELO [10.212.152.178]) ([10.212.152.178])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2021 09:16:25 -0700
Subject: Re: [PATCH Part2 RFC v4 10/40] x86/fault: Add support to handle the
 RMP fault for user address
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
 <20210707183616.5620-11-brijesh.singh@amd.com>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <3c6b6fc4-05b2-8d18-2eb8-1bd1a965c632@intel.com>
Date:   Thu, 8 Jul 2021 09:16:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210707183616.5620-11-brijesh.singh@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Oh, here's the THP code.  The subject just changed.

On 7/7/21 11:35 AM, Brijesh Singh wrote:
> When SEV-SNP is enabled globally, a write from the host goes through the
> RMP check. When the host writes to pages, hardware checks the following
> conditions at the end of page walk:
> 
> 1. Assigned bit in the RMP table is zero (i.e page is shared).
> 2. If the page table entry that gives the sPA indicates that the target
>    page size is a large page, then all RMP entries for the 4KB
>    constituting pages of the target must have the assigned bit 0.
> 3. Immutable bit in the RMP table is not zero.
> 
> The hardware will raise page fault if one of the above conditions is not
> met. Try resolving the fault instead of taking fault again and again. If
> the host attempts to write to the guest private memory then send the
> SIGBUG signal to kill the process. If the page level between the host and

"SIGBUG"?

> RMP entry does not match, then split the address to keep the RMP and host
> page levels in sync.


> ---
>  arch/x86/mm/fault.c | 69 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mm.h  |  6 +++-
>  mm/memory.c         | 13 +++++++++
>  3 files changed, 87 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 195149eae9b6..cdf48019c1a7 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -1281,6 +1281,58 @@ do_kern_addr_fault(struct pt_regs *regs, unsigned long hw_error_code,
>  }
>  NOKPROBE_SYMBOL(do_kern_addr_fault);
>  
> +#define RMP_FAULT_RETRY		0
> +#define RMP_FAULT_KILL		1
> +#define RMP_FAULT_PAGE_SPLIT	2
> +
> +static inline size_t pages_per_hpage(int level)
> +{
> +	return page_level_size(level) / PAGE_SIZE;
> +}
> +
> +static int handle_user_rmp_page_fault(unsigned long hw_error_code, unsigned long address)
> +{
> +	unsigned long pfn, mask;
> +	int rmp_level, level;
> +	struct rmpentry *e;
> +	pte_t *pte;
> +
> +	if (unlikely(!cpu_feature_enabled(X86_FEATURE_SEV_SNP)))
> +		return RMP_FAULT_KILL;

Shouldn't this be a WARN_ON_ONCE()?  How can we get RMP faults without
SEV-SNP?

> +	/* Get the native page level */
> +	pte = lookup_address_in_mm(current->mm, address, &level);
> +	if (unlikely(!pte))
> +		return RMP_FAULT_KILL;

What would this mean?  There was an RMP fault on a non-present page?
How could that happen?  What if there was a race between an unmapping
event and the RMP fault delivery?

> +	pfn = pte_pfn(*pte);
> +	if (level > PG_LEVEL_4K) {
> +		mask = pages_per_hpage(level) - pages_per_hpage(level - 1);
> +		pfn |= (address >> PAGE_SHIFT) & mask;
> +	}

This looks inherently racy.  What happens if there are two parallel RMP
faults on the same 2M page.  One of them splits the page tables, the
other gets a fault for an already-split page table.

Is that handled here somehow?

> +	/* Get the page level from the RMP entry. */
> +	e = snp_lookup_page_in_rmptable(pfn_to_page(pfn), &rmp_level);
> +	if (!e)
> +		return RMP_FAULT_KILL;

The snp_lookup_page_in_rmptable() failure cases looks WARN-worthly.
Either you're doing a lookup for something not *IN* the RMP table, or
you don't support SEV-SNP, in which case you shouldn't be in this code
in the first place.

> +	/*
> +	 * Check if the RMP violation is due to the guest private page access.
> +	 * We can not resolve this RMP fault, ask to kill the guest.
> +	 */
> +	if (rmpentry_assigned(e))
> +		return RMP_FAULT_KILL;

No "We's", please.  Speak in imperative voice.

> +	/*
> +	 * The backing page level is higher than the RMP page level, request
> +	 * to split the page.
> +	 */
> +	if (level > rmp_level)
> +		return RMP_FAULT_PAGE_SPLIT;

This can theoretically trigger on a hugetlbfs page.  Right?

I thought I asked about this before... more below...

> +	return RMP_FAULT_RETRY;
> +}
> +
>  /*
>   * Handle faults in the user portion of the address space.  Nothing in here
>   * should check X86_PF_USER without a specific justification: for almost
> @@ -1298,6 +1350,7 @@ void do_user_addr_fault(struct pt_regs *regs,
>  	struct task_struct *tsk;
>  	struct mm_struct *mm;
>  	vm_fault_t fault;
> +	int ret;
>  	unsigned int flags = FAULT_FLAG_DEFAULT;
>  
>  	tsk = current;
> @@ -1378,6 +1431,22 @@ void 
(struct pt_regs *regs,
>  	if (error_code & X86_PF_INSTR)
>  		flags |= FAULT_FLAG_INSTRUCTION;
>  
> +	/*
> +	 * If its an RMP violation, try resolving it.
> +	 */
> +	if (error_code & X86_PF_RMP) {
> +		ret = handle_user_rmp_page_fault(error_code, address);
> +		if (ret == RMP_FAULT_PAGE_SPLIT) {
> +			flags |= FAULT_FLAG_PAGE_SPLIT;
> +		} else if (ret == RMP_FAULT_KILL) {
> +			fault |= VM_FAULT_SIGBUS;
> +			do_sigbus(regs, error_code, address, fault);
> +			return;
> +		} else {
> +			return;
> +		}
> +	}

Why not just have handle_user_rmp_page_fault() return a VM_FAULT_* code
directly?

I also suspect you can just set VM_FAULT_SIGBUS and let the do_sigbus()
call later on in the function do its work.

>  	 * Faults in the vsyscall page might need emulation.  The
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 322ec61d0da7..211dfe5d3b1d 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -450,6 +450,8 @@ extern pgprot_t protection_map[16];
>   * @FAULT_FLAG_REMOTE: The fault is not for current task/mm.
>   * @FAULT_FLAG_INSTRUCTION: The fault was during an instruction fetch.
>   * @FAULT_FLAG_INTERRUPTIBLE: The fault can be interrupted by non-fatal signals.
> + * @FAULT_FLAG_PAGE_SPLIT: The fault was due page size mismatch, split the
> + *  region to smaller page size and retry.
>   *
>   * About @FAULT_FLAG_ALLOW_RETRY and @FAULT_FLAG_TRIED: we can specify
>   * whether we would allow page faults to retry by specifying these two
> @@ -481,6 +483,7 @@ enum fault_flag {
>  	FAULT_FLAG_REMOTE =		1 << 7,
>  	FAULT_FLAG_INSTRUCTION =	1 << 8,
>  	FAULT_FLAG_INTERRUPTIBLE =	1 << 9,
> +	FAULT_FLAG_PAGE_SPLIT =		1 << 10,
>  };
>  
>  /*
> @@ -520,7 +523,8 @@ static inline bool fault_flag_allow_retry_first(enum fault_flag flags)
>  	{ FAULT_FLAG_USER,		"USER" }, \
>  	{ FAULT_FLAG_REMOTE,		"REMOTE" }, \
>  	{ FAULT_FLAG_INSTRUCTION,	"INSTRUCTION" }, \
> -	{ FAULT_FLAG_INTERRUPTIBLE,	"INTERRUPTIBLE" }
> +	{ FAULT_FLAG_INTERRUPTIBLE,	"INTERRUPTIBLE" }, \
> +	{ FAULT_FLAG_PAGE_SPLIT,	"PAGESPLIT" }
>  
>  /*
>   * vm_fault is filled by the pagefault handler and passed to the vma's
> diff --git a/mm/memory.c b/mm/memory.c
> index 730daa00952b..aef261d94e33 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4407,6 +4407,15 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
>  	return 0;
>  }
>  
> +static int handle_split_page_fault(struct vm_fault *vmf)
> +{
> +	if (!IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT))
> +		return VM_FAULT_SIGBUS;
> +
> +	__split_huge_pmd(vmf->vma, vmf->pmd, vmf->address, false, NULL);
> +	return 0;
> +}

What will this do when you hand it a hugetlbfs page?
