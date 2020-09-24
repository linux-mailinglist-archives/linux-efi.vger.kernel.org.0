Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBFF2778F4
	for <lists+linux-efi@lfdr.de>; Thu, 24 Sep 2020 21:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbgIXTJs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Sep 2020 15:09:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44793 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726681AbgIXTJs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Sep 2020 15:09:48 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600974586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1xBZCyYKlE5WRUUtzWjHwjgmCmL0z091Bn3uVsUx0eo=;
        b=NevDrEEF8pQjw21jntcX3nUp0XH0yHxojjlII3cEnBTYXDqsMDsmx/lnX3LG2ZXgWDp1oJ
        VQXUOnBOWTUP8pMeOKLtLem+agsUVcaKmpBlW3xueK+CBQj6JG57lbgZHwkLC93dD66TP3
        I3Hz97TUlTEGOKRizIkUE4hXOWVy32M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-V9gDJwwwM46Cw7RYWDdzCQ-1; Thu, 24 Sep 2020 15:09:42 -0400
X-MC-Unique: V9gDJwwwM46Cw7RYWDdzCQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C569D425E6;
        Thu, 24 Sep 2020 19:09:40 +0000 (UTC)
Received: from [10.10.110.8] (unknown [10.10.110.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E87610013C1;
        Thu, 24 Sep 2020 19:09:37 +0000 (UTC)
Subject: Re: [PATCH V2 1/3] efi: Support for MOK variable config table
To:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        linux-security-module@vger.kernel.org, andy.shevchenko@gmail.com,
        James Morris <jmorris@namei.org>, serge@hallyn.com,
        Kees Cook <keescook@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Jones <pjones@redhat.com>,
        David Howells <dhowells@redhat.com>, prarit@redhat.com
References: <20200905013107.10457-1-lszubowi@redhat.com>
 <20200905013107.10457-2-lszubowi@redhat.com>
 <20200921161859.GA544292@rani.riverdale.lan>
 <CAMj1kXFV7LqsyHM8iM5yQwJX4tKbY=w9vfjERvjyabVDKcbJpA@mail.gmail.com>
 <20200921165506.GA549786@rani.riverdale.lan>
From:   Lenny Szubowicz <lszubowi@redhat.com>
Message-ID: <e01b3f50-20ee-0168-b6ee-4d3d2d4dc13f@redhat.com>
Date:   Thu, 24 Sep 2020 15:09:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200921165506.GA549786@rani.riverdale.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 9/21/20 12:55 PM, Arvind Sankar wrote:
> On Mon, Sep 21, 2020 at 06:27:17PM +0200, Ard Biesheuvel wrote:
>> On Mon, 21 Sep 2020 at 18:19, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>>>
>>> On Fri, Sep 04, 2020 at 09:31:05PM -0400, Lenny Szubowicz wrote:
>>>> +     /*
>>>> +      * The EFI MOK config table must fit within a single EFI memory
>>>> +      * descriptor range.
>>>> +      */
>>>> +     err = efi_mem_desc_lookup(efi.mokvar_table, &md);
>>>> +     if (err) {
>>>> +             pr_warn("EFI MOKvar config table is not within the EFI memory map\n");
>>>> +             return;
>>>> +     }
>>>> +     end_pa = efi_mem_desc_end(&md);
>>>> +     if (efi.mokvar_table >= end_pa) {
>>>> +             pr_err("EFI memory descriptor containing MOKvar config table is invalid\n");
>>>> +             return;
>>>> +     }
>>>
>>> efi_mem_desc_lookup() can't return success if efi.mokvar_table >= end_pa,
>>> why check it again?

I agree it's unnecessary and I see that Ard has addressed this in a patch.

>>>
>>>> +     offset_limit = end_pa - efi.mokvar_table;
>>>> +     /*
>>>> +      * Validate the MOK config table. Since there is no table header
>>>> +      * from which we could get the total size of the MOK config table,
>>>> +      * we compute the total size as we validate each variably sized
>>>> +      * entry, remapping as necessary.
>>>> +      */
>>>> +     while (cur_offset + sizeof(*mokvar_entry) <= offset_limit) {
>>>> +             mokvar_entry = va + cur_offset;
>>>> +             map_size_needed = cur_offset + sizeof(*mokvar_entry);
>>>> +             if (map_size_needed > map_size) {
>>>> +                     if (va)
>>>> +                             early_memunmap(va, map_size);
>>>> +                     /*
>>>> +                      * Map a little more than the fixed size entry
>>>> +                      * header, anticipating some data. It's safe to
>>>> +                      * do so as long as we stay within current memory
>>>> +                      * descriptor.
>>>> +                      */
>>>> +                     map_size = min(map_size_needed + 2*EFI_PAGE_SIZE,
>>>> +                                    offset_limit);
>>>> +                     va = early_memremap(efi.mokvar_table, map_size);
>>>
>>> Can't we just map the entire region from efi.mokvar_table to end_pa in
>>> one early_memremap call before the loop and avoid all the remapping
>>> logic?
>>>
>>
>> I suppose that depends on whether there is a reasonable upper bound on
>> the size which is guaranteed to be mappable using early_memremap()
>> (e.g., 128 KB on 32-bit ARM, or 256 KB on other architectures)
> 
> Ah, sorry, I thought only the number of early mappings was limited, not
> the size as well. We could still just map the maximum possible
> (NR_FIX_BTMAPS * PAGE_SIZE), since it will fail anyway if the config
> table turns out to be bigger than that?

In practice, the loop will only do one or two mappings. That's because of
two factors.

First the code attempts to map a little more than it needs (2*EFI_PAGE_SIZE).
Secondly, right now only one entry in the MOKvar config table might be quite
large, i.e. the entry named MoKListRT. It's extremely likely that the header
of MokListRT entry will be encountered on the first mapping. If that entry
goes beyond what was originally mapped, then a second mapping will cover all
the data in that large entry as well as the remaining small entries that might
follow it.

> 
>>
>>
>>>> +     if (va)
>>>> +             early_memunmap(va, map_size);
>>>> +     if (err) {
>>>> +             pr_err("EFI MOKvar config table is not valid\n");
>>>> +             return;
>>>> +     }
>>>
>>> err will never be non-zero here: it was cleared when the
>>> efi_mem_desc_lookup() was done. I think the initialization of err to
>>> -EINVAL needs to be moved just prior to the loop.
>>>
>>>> +     efi_mem_reserve(efi.mokvar_table, map_size_needed);
>>>> +     efi_mokvar_table_size = map_size_needed;
>>>> +}
> 

