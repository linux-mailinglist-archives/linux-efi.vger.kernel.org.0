Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D886173423
	for <lists+linux-efi@lfdr.de>; Fri, 28 Feb 2020 10:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgB1Jfa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Feb 2020 04:35:30 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47348 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726661AbgB1Jfa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 28 Feb 2020 04:35:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582882528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=H9mzUDxRVetooVherOzlH07tNF8Ied45V4Iiu5Mh0KM=;
        b=AG9ZgueMIhTpzhRSECEmejEVnyzz7IOU7xylwY7KpYLfW+giu1t8+bS0yrV0LCip9iW59t
        NZ1CHvigbGzjxYofxUVzQtxSyJXkZVdQ+DC/lwlDBuppoU8wybYLTk2cIL6s4KbrunvRU2
        pY7qsrZckCuY84+t57F8fHFTpmrEcn0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-hzM-64btOf2KR2nFOXdfLA-1; Fri, 28 Feb 2020 04:35:26 -0500
X-MC-Unique: hzM-64btOf2KR2nFOXdfLA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 868D48017CC;
        Fri, 28 Feb 2020 09:35:24 +0000 (UTC)
Received: from [10.36.117.180] (ovpn-117-180.ams2.redhat.com [10.36.117.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 32F4187B08;
        Fri, 28 Feb 2020 09:35:19 +0000 (UTC)
Subject: Re: [RESEND PATCH v2] efi: Only print errors about failing to get
 certs if EFI vars are found
From:   David Hildenbrand <david@redhat.com>
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-efi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Eric Richter <erichte@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        YueHaibing <yuehaibing@huawei.com>,
        linux-security-module@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
References: <20200217113947.2070436-1-javierm@redhat.com>
 <0fd1b499-3a5e-c78e-0279-186a4c424217@redhat.com>
 <5c60e016-fb30-b33d-39c6-ea30a4f777cb@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <30819cad-1a00-1ea7-13cf-d1d15c0fa96c@redhat.com>
Date:   Fri, 28 Feb 2020 10:35:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <5c60e016-fb30-b33d-39c6-ea30a4f777cb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 28.02.20 10:31, David Hildenbrand wrote:
> On 28.02.20 10:19, David Hildenbrand wrote:
>> On 17.02.20 12:39, Javier Martinez Canillas wrote:
>>> If CONFIG_LOAD_UEFI_KEYS is enabled, the kernel attempts to load the certs
>>> from the db, dbx and MokListRT EFI variables into the appropriate keyrings.
>>>
>>> But it just assumes that the variables will be present and prints an error
>>> if the certs can't be loaded, even when is possible that the variables may
>>> not exist. For example the MokListRT variable will only be present if shim
>>> is used.
>>>
>>> So only print an error message about failing to get the certs list from an
>>> EFI variable if this is found. Otherwise these printed errors just pollute
>>> the kernel log ring buffer with confusing messages like the following:
>>>
>>> [    5.427251] Couldn't get size: 0x800000000000000e
>>> [    5.427261] MODSIGN: Couldn't get UEFI db list
>>> [    5.428012] Couldn't get size: 0x800000000000000e
>>> [    5.428023] Couldn't get UEFI MokListRT
>>>
>>> Reported-by: Hans de Goede <hdegoede@redhat.com>
>>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>>> Tested-by: Hans de Goede <hdegoede@redhat.com>
>>
>> This patch seems to break a very basic x86-64 QEMU setup (booting
>> upstream kernel with a F31 initrd - are you running basic boot tests?).
>> Luckily, it only took me 5 minutes to identify this patch. Reverting
>> this patch from linux-next fixes it for me.
>>
>>
>> [    1.042766] Loaded X.509 cert 'Build time autogenerated kernel key: 6625d6e34255935276d2c9851e2458909a4bcd69'
>> [    1.044314] zswap: loaded using pool lzo/zbud
>> [    1.045663] Key type ._fscrypt registered
>> [    1.046154] Key type .fscrypt registered
>> [    1.046524] Key type fscrypt-provisioning registered
>> [    1.051178] Key type big_key registered
>> [    1.055108] Key type encrypted registered
>> [    1.055513] BUG: kernel NULL pointer dereference, address: 0000000000000000
>> [    1.056172] #PF: supervisor instruction fetch in kernel mode
>> [    1.056706] #PF: error_code(0x0010) - not-present page
>> [    1.057367] PGD 0 P4D 0 
>> [    1.057729] Oops: 0010 [#1] SMP NOPTI
>> [    1.058249] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.6.0-rc3-next-20200228+ #79
>> [    1.059167] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.4
>> [    1.060230] RIP: 0010:0x0
>> [    1.060478] Code: Bad RIP value.
>> [    1.060786] RSP: 0018:ffffbc7880637d98 EFLAGS: 00010246
>> [    1.061281] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffbc7880637dc8
>> [    1.061954] RDX: 0000000000000000 RSI: ffffbc7880637df0 RDI: ffffffffa73c40be
>> [    1.062611] RBP: ffffbc7880637e20 R08: ffffbc7880637dac R09: ffffa0238f4ba6c0
>> [    1.063278] R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
>> [    1.063956] R13: ffffa024bdd6f660 R14: 0000000000000000 R15: 0000000000000000
>> [    1.064609] FS:  0000000000000000(0000) GS:ffffa023fdd00000(0000) knlGS:0000000000000000
>> [    1.065360] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [    1.065900] CR2: ffffffffffffffd6 CR3: 00000000b1610000 CR4: 00000000000006e0
>> [    1.066562] Call Trace:
>> [    1.066803]  load_uefi_certs+0xc8/0x2bb
>> [    1.067171]  ? get_cert_list+0xfb/0xfb
>> [    1.067523]  do_one_initcall+0x5d/0x2f0
>> [    1.067894]  ? rcu_read_lock_sched_held+0x52/0x80
>> [    1.068337]  kernel_init_freeable+0x243/0x2c2
>> [    1.068751]  ? rest_init+0x23a/0x23a
>> [    1.069095]  kernel_init+0xa/0x106
>> [    1.069416]  ret_from_fork+0x27/0x50
>> [    1.069759] Modules linked in:
>> [    1.070050] CR2: 0000000000000000
>> [    1.070361] ---[ end trace fcce9bb4feb21d99 ]---
>>
>>
> 
> Sorry, wrong mail identified, the patch is actually
> 
> commit 6b75d54d5258ccd655387a00bbe1b00f92f4d965
> Author: Ard Biesheuvel <ardb@kernel.org>
> Date:   Sun Feb 16 19:46:25 2020 +0100
> 
>     integrity: Check properly whether EFI GetVariable() is available
> 
>     Testing the value of the efi.get_variable function pointer is not
> 
> which made it work. (not even able to find that patch on lkml ...)

To clarify for Ard, your patch breaks a basic QEMU setup (see above,
NULL pointer dereference). Reverting your patch from linux-next makes it
work again.


-- 
Thanks,

David / dhildenb

