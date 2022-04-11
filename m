Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4074FB3FE
	for <lists+linux-efi@lfdr.de>; Mon, 11 Apr 2022 08:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235128AbiDKGwD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Apr 2022 02:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbiDKGwC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Apr 2022 02:52:02 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E4118B13;
        Sun, 10 Apr 2022 23:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649659789; x=1681195789;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=Im18RwYdvETKIFnmTzUmsr5SNvinw0XNRdaj7/G9hPU=;
  b=nahHGn8CB8nwBoomeylnzecH4kkM2bHE4szTEDm3ePuuo/gahsbgWve7
   xNDLJb9SlFijIGdBXMqIrupJu8JkhGwfYpF16hiQxeo/wVXzg6DTSk5bi
   uNwosBm1hYTDsTzHRddJz6CKjWgHiVdJpTFAPDsoKMPnosaNqiGhxncWP
   yXZCbxXTFAdz1WvyrkpHVCVM7UjDW2ZkgHJFSf9Idefb2qhlTAh/PWyqH
   R/1Wk8T7S/sch3mHV6O+/aj/26POc2LVBsw7E8xYzSAuyBUYKSZlbGBpU
   fBbjd13zDwJHDtTpf1BLGku8OYRt+KBo7bFPeUJc2Z03/8E6nUOub4Rwc
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="324959680"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="324959680"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2022 23:49:49 -0700
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="525318292"
Received: from srkondle-mobl.amr.corp.intel.com (HELO [10.212.113.6]) ([10.212.113.6])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2022 23:49:47 -0700
Message-ID: <a8e79d89-ec91-8f04-88b5-be932e9fb020@intel.com>
Date:   Sun, 10 Apr 2022 23:49:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220405234343.74045-1-kirill.shutemov@linux.intel.com>
 <20220405234343.74045-5-kirill.shutemov@linux.intel.com>
 <043469ae-427c-b2bb-89ff-db8975894266@intel.com>
 <20220409202035.plaiekzuihov4kvq@box.shutemov.name>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv4 4/8] x86/boot/compressed: Handle unaccepted memory
In-Reply-To: <20220409202035.plaiekzuihov4kvq@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 4/9/22 13:20, Kirill A. Shutemov wrote:
> On Fri, Apr 08, 2022 at 10:57:17AM -0700, Dave Hansen wrote:
...
>> It's a real shame that we have to duplicate this code.  Is there
>> anything crazy we could do here like
>>
>> #include "../../../lib/find_bit.c"
>>
>> ?
> 
> Well, it would require fracturing source files on the kernel side.
> 
> __bitmap_set() and __bitmap_clear() are now in lib/bitmap.c.
> 
> _find_next_bit() is in lib/find_bit.c.
> 
> Both lib/bitmap.c and lib/find_bit.c have a lot of stuff that are not used
> here. I guess we would need to split them into few pieces to make it in
> sane way. Do you want me to go this path?

I'd be curious if others have any sane ideas for how to do it.

One idea would be to stick most of the implementation in a header that
we can #include.  Then, lib/find_bit.c #includes that header and does
something simple like:

#include "header.h"
int _find_next_bit(...)
{
	return _find_next_bit_from_header();
}
EXPORT_SYMBOL(_find_next_bit);


>>> diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
>>> index fa8969fad011..c1d9d71a6615 100644
>>> --- a/arch/x86/boot/compressed/misc.c
>>> +++ b/arch/x86/boot/compressed/misc.c
>>> @@ -18,6 +18,7 @@
>>>  #include "../string.h"
>>>  #include "../voffset.h"
>>>  #include <asm/bootparam_utils.h>
>>> +#include <asm/unaccepted_memory.h>
>>>  
>>>  /*
>>>   * WARNING!!
>>> @@ -43,6 +44,9 @@
>>>  void *memmove(void *dest, const void *src, size_t n);
>>>  #endif
>>>  
>>> +#undef __pa
>>> +#define __pa(x)	((unsigned long)(x))
>>
>> Those #undef's always worry me.  Why is this one needed?
> 
> arch/x86/boot/compressed/misc.c:47:9: warning: '__pa' macro redefined [-Wmacro-redefined]
> #define __pa(x) ((unsigned long)(x))
>         ^
> arch/x86/include/asm/page.h:47:9: note: previous definition is here
> #define __pa(x)         __phys_addr((unsigned long)(x))
> 
> Note that sev.c does the same. At least we are consistent :)

Ugh.  Please do look into fixing this properly.  The SEV folks will
thank you. :)

>>> +void accept_memory(phys_addr_t start, phys_addr_t end)
>>> +{
>>> +	unsigned long *unaccepted_memory;
>>> +	unsigned int rs, re;
>>> +
>>> +	unaccepted_memory = (unsigned long *)boot_params->unaccepted_memory;
>>> +	rs = start / PMD_SIZE;
>>
>> OK, so start is a physical address, PMD_SIZE is 2^21, and 'rs' is an
>> unsigned int.  That means 'rs' can, at most, represent a physical
>> address at 2^(21+32), or 2^53.  That's cutting it a *bit* close, don't
>> you think?
>>
>> Could we please just give 'rs' and 're' real names and make them
>> 'unsigned long's, please?  It will surely save at least one other person
>> from doing math.  The find_next_bit() functions seem to take ulongs anyway.
> 
> Okay. 'range_start' and 'range_end' are good enough names?

Yep, works for me.

