Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55714416052
	for <lists+linux-efi@lfdr.de>; Thu, 23 Sep 2021 15:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241372AbhIWN4Y (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 23 Sep 2021 09:56:24 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:32845 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231974AbhIWN4Y (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 23 Sep 2021 09:56:24 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HFc9P5sHPz9sV7;
        Thu, 23 Sep 2021 15:54:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xdm1Ouzf8XXu; Thu, 23 Sep 2021 15:54:49 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HFc9P4lm1z9sV4;
        Thu, 23 Sep 2021 15:54:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8BA938B776;
        Thu, 23 Sep 2021 15:54:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id i24VgXHaAF2s; Thu, 23 Sep 2021 15:54:49 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.200])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id ACF658B763;
        Thu, 23 Sep 2021 15:54:47 +0200 (CEST)
Subject: Re: [PATCH 3/3] memblock: cleanup memblock_free interface
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        devicetree@vger.kernel.org, linux-efi@vger.kernel.org,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org, linux-usb@vger.kernel.org,
        linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-snps-arc@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20210923074335.12583-1-rppt@kernel.org>
 <20210923074335.12583-4-rppt@kernel.org>
 <1101e3c7-fcb7-a632-8e22-47f4a01ea02e@csgroup.eu>
 <YUxsgN/uolhn1Ok+@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <96e3da9f-70ff-e5c0-ef2e-cf0b636e5695@csgroup.eu>
Date:   Thu, 23 Sep 2021 15:54:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YUxsgN/uolhn1Ok+@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



Le 23/09/2021 à 14:01, Mike Rapoport a écrit :
> On Thu, Sep 23, 2021 at 11:47:48AM +0200, Christophe Leroy wrote:
>>
>>
>> Le 23/09/2021 à 09:43, Mike Rapoport a écrit :
>>> From: Mike Rapoport <rppt@linux.ibm.com>
>>>
>>> For ages memblock_free() interface dealt with physical addresses even
>>> despite the existence of memblock_alloc_xx() functions that return a
>>> virtual pointer.
>>>
>>> Introduce memblock_phys_free() for freeing physical ranges and repurpose
>>> memblock_free() to free virtual pointers to make the following pairing
>>> abundantly clear:
>>>
>>> 	int memblock_phys_free(phys_addr_t base, phys_addr_t size);
>>> 	phys_addr_t memblock_phys_alloc(phys_addr_t base, phys_addr_t size);
>>>
>>> 	void *memblock_alloc(phys_addr_t size, phys_addr_t align);
>>> 	void memblock_free(void *ptr, size_t size);
>>>
>>> Replace intermediate memblock_free_ptr() with memblock_free() and drop
>>> unnecessary aliases memblock_free_early() and memblock_free_early_nid().
>>>
>>> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
>>> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
>>> ---
>>
>>> diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
>>> index 1a04e5bdf655..37826d8c4f74 100644
>>> --- a/arch/s390/kernel/smp.c
>>> +++ b/arch/s390/kernel/smp.c
>>> @@ -723,7 +723,7 @@ void __init smp_save_dump_cpus(void)
>>>    			/* Get the CPU registers */
>>>    			smp_save_cpu_regs(sa, addr, is_boot_cpu, page);
>>>    	}
>>> -	memblock_free(page, PAGE_SIZE);
>>> +	memblock_phys_free(page, PAGE_SIZE);
>>>    	diag_amode31_ops.diag308_reset();
>>>    	pcpu_set_smt(0);
>>>    }
>>> @@ -880,7 +880,7 @@ void __init smp_detect_cpus(void)
>>>    	/* Add CPUs present at boot */
>>>    	__smp_rescan_cpus(info, true);
>>> -	memblock_free_early((unsigned long)info, sizeof(*info));
>>> +	memblock_free(info, sizeof(*info));
>>>    }
>>>    /*
>>
>> I'm a bit lost. IIUC memblock_free_early() and memblock_free() where
>> identical.
> 
> Yes, they were, but all calls to memblock_free_early() were using
> __pa(vaddr) because they had a virtual address at hand.

I'm still not following. In the above memblock_free_early() was taking 
(unsigned long)info . Was it a bug ? It looks odd to hide bug fixes in 
such a big patch, should that bug fix go in patch 2 ?

> 
>> In the first hunk memblock_free() gets replaced by memblock_phys_free()
>> In the second hunk memblock_free_early() gets replaced by memblock_free()
> 
> In the first hunk the memory is allocated with memblock_phys_alloc() and we
> have a physical range to free. In the second hunk the memory is allocated
> with memblock_alloc() and we are freeing a virtual pointer.
>   
>> I think it would be easier to follow if you could split it in several
>> patches:
> 
> It was an explicit request from Linus to make it a single commit:
> 
>    but the actual commit can and should be just a single commit that just
>    fixes 'memblock_free()' to have sane interfaces.
> 
> I don't feel strongly about splitting it (except my laziness really
> objects), but I don't think doing the conversion in several steps worth the
> churn.

The commit is quite big (55 files changed, approx 100 lines modified).

If done in the right order the change should be minimal.

It is rather not-easy to follow and review when a function that was 
existing (namely memblock_free() ) disappears and re-appears in the same 
commit but to do something different.

You do:
- memblock_free() ==> memblock_phys_free()
- memblock_free_ptr() ==> memblock_free()

At least you could split in two patches, the advantage would be that 
between first and second patch memblock() doesn't exist anymore so you 
can check you really don't have anymore user.

> 
>> - First patch: Create memblock_phys_free() and change all relevant
>> memblock_free() to memblock_phys_free() - Or change memblock_free() to
>> memblock_phys_free() and make memblock_free() an alias of it.
>> - Second patch: Make memblock_free_ptr() become memblock_free() and change
>> all remaining callers to the new semantics (IIUC memblock_free(__pa(ptr))
>> becomes memblock_free(ptr) and make memblock_free_ptr() an alias of
>> memblock_free()
>> - Fourth patch: Replace and drop memblock_free_ptr()
>> - Fifth patch: Drop memblock_free_early() and memblock_free_early_nid() (All
>> users should have been upgraded to memblock_free_phys() in patch 1 or
>> memblock_free() in patch 2)
>>
>> Christophe
> 
