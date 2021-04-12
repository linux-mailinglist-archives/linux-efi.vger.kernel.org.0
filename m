Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17FE435C45E
	for <lists+linux-efi@lfdr.de>; Mon, 12 Apr 2021 12:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239689AbhDLKt6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 12 Apr 2021 06:49:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27914 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239636AbhDLKt4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 12 Apr 2021 06:49:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618224578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m7zx2DsEs4Cu6I9lqZm7M12U1186tw3UcCmKjVshQ18=;
        b=MZQDWrtmFWFIzRrM4qJQEmqOvxp1ZTMA/nVZEd5Pnrbfx92s8m7fIdGFPYVtY142bDPsU8
        /VSDUL0mcS42Q38RtZb4NJjGmdPPtdNY06V39hVV7KZFYe7Y8Al4BfCZYtBu+abl/ZsdxW
        EKXRUtQEJ6BLUxhumUier+dDhjgLbIo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-bficfnE7OxmJU2h3iHiSHQ-1; Mon, 12 Apr 2021 06:49:36 -0400
X-MC-Unique: bficfnE7OxmJU2h3iHiSHQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0DC087A826;
        Mon, 12 Apr 2021 10:49:34 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-229.pek2.redhat.com [10.72.13.229])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6326560BD8;
        Mon, 12 Apr 2021 10:49:24 +0000 (UTC)
Subject: Re: [PATCH] x86/efi: Do not release sub-1MB memory regions when the
 crashkernel option is specified
To:     Baoquan He <bhe@redhat.com>, Andy Lutomirski <luto@amacapital.net>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, x86@kernel.org,
        ardb@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dvhart@infradead.org, andy@infradead.org,
        kexec@lists.infradead.org, dyoung@redhat.com
References: <20210412011347.GA4282@MiWiFi-R3L-srv>
 <8FAA2A0E-0A09-4308-B936-CDD2C0568BAE@amacapital.net>
 <20210412095231.GC4282@MiWiFi-R3L-srv>
From:   lijiang <lijiang@redhat.com>
Message-ID: <8b3807cc-41a0-9032-e586-1fa38e6d2203@redhat.com>
Date:   Mon, 12 Apr 2021 18:49:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210412095231.GC4282@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Thank you for the comment, H. Peter, Andy and Baoquan.

在 2021年04月12日 17:52, Baoquan He 写道:
> On 04/11/21 at 06:49pm, Andy Lutomirski wrote:
>>
>>
>>> On Apr 11, 2021, at 6:14 PM, Baoquan He <bhe@redhat.com> wrote:
>>>
>>> ﻿On 04/09/21 at 07:59pm, H. Peter Anvin wrote:
>>>> Why don't we do this unconditionally? At the very best we gain half a megabyte of memory (except the trampoline, which has to live there, but it is only a few kilobytes.)
>>>
>>> This is a great suggestion, thanks. I think we can fix it in this way to
>>> make code simpler. Then the specific caring of real mode in
>>> efi_free_boot_services() can be removed too.
>>>
>>
>> This whole situation makes me think that the code is buggy before and buggy after.
>>
>> The issue here (I think) is that various pieces of code want to reserve specific pieces of otherwise-available low memory for their own nefarious uses. I don’t know *why* crash kernel needs this, but that doesn’t matter too much.
> 
> Kdump kernel also need go through real mode code path during bootup. It
> is not different than normal kernel except that it skips the firmware
> resetting. So kdump kernel needs low 1M as system RAM just as normal
> kernel does. Here we reserve the whole low 1M with memblock_reserve()
> to avoid any later kernel or driver data reside in this area. Otherwise,
> we need dump the content of this area to vmcore. As we know, when crash
> happened, the old memory of 1st kernel should be untouched until vmcore
> dumping read out its content. Meanwhile, kdump kernel need reuse low 1M.
> In the past, we used a back up region to copy out the low 1M area, and
> map the back up region into the low 1M area in vmcore elf file. In
> 6f599d84231fd27 ("x86/kdump: Always reserve the low 1M when the crashkernel
> option is specified"), we changed to lock the whole low 1M to avoid
> writting any kernel data into, like this we can skip this area when
> dumping vmcore.
> 
> Above is why we try to memblock reserve the whole low 1M. We don't want
> to use it, just don't want anyone to use it in 1st kernel.
> 
>>
>> I propose that the right solution is to give low-memory-reserving code paths two chances to do what they need: once at the very beginning and once after EFI boot services are freed.
>>
>> Alternatively, just reserve *all* otherwise unused sub 1M memory up front, then release it right after releasing boot services, and then invoke the special cases exactly once.
> 

After EFI boot services are freed, I'm worried that it's a bit late. All sub-1M memory regions need to be reserved early as soon as possible.

> I am not sure if I got both suggested ways clearly. They look a little
> complicated in our case. As I explained at above, we want the whole low
> 1M locked up, not one piece or some pieces of it.
> 
>>
>> In either case, the result is that the crashkernel mess gets unified with the trampoline mess.  One way the result is called twice and needs to be more careful, and the other way it’s called only once.
>>

That may still have a chance to allocate memory from sub-1M regions at some point, because EFI boot services will be freed after EFI enters virtual mode, it looks late.

>> Just skipping freeing boot services seems wrong.  It doesn’t unmap boot services, and skipping that is incorrect, I think. And it seems to result in a bogus memory map in which the system thinks that some crashkernel memory is EFI memory instead.
> 
> I like hpa's thought to lock the whole low 1M unconditionally since only
> a few KB except of trampoline area is there. Rethinking about it, doing
> it in can_free_region() may be risky because efi memory region could
> cross the 1M boundary, e.g [640K, 100M] with type of
> EFI_BOOT_SERVICES_CODE|EFI_BOOT_SERVICES_DATA, it could cause loss of memory.

Theoretically, yes. But so far I haven't seen the situation of crossing the 1M boundary.

Thanks.
Lianbo

> Just a wild guess, not very sure if the 1M boundary corssing can really
> happen. efi_reserve_boot_services() won't split regions.
> 
> If moving efi_reserve_boot_services() after reserve_real_mode() is not
> accepted, maybe we can call efi_mem_reserve(0, 1M) just as
> efi_esrt_init() has done.
> 

