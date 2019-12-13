Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7770211EB55
	for <lists+linux-efi@lfdr.de>; Fri, 13 Dec 2019 20:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbfLMT4M (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Dec 2019 14:56:12 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38505 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728696AbfLMT4L (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Dec 2019 14:56:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576266970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fYFoBO31K89MhfGMWnlynqQGUOW5hzAMCsBFNAeX8Q8=;
        b=MQKrpJFgiNHjRMoGnjA8chPU7KzGdZesH1+4AE8VL2fU3pQuTXkGNDX/1ACsJi95z9776e
        XJZaRrs5ryggNLeCD5s62rfbxhPeWvGM66mMXGe9uv4OWcV+lLw2DHovg5HoHlCD10goln
        BpxRT8O9PB7+VCZJrFCz0u2Cx1qT62w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-gKNkoVFoMtSRKDFmJsgalg-1; Fri, 13 Dec 2019 14:56:08 -0500
X-MC-Unique: gKNkoVFoMtSRKDFmJsgalg-1
Received: by mail-wr1-f71.google.com with SMTP id c17so156962wrp.10
        for <linux-efi@vger.kernel.org>; Fri, 13 Dec 2019 11:56:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fYFoBO31K89MhfGMWnlynqQGUOW5hzAMCsBFNAeX8Q8=;
        b=aEB4OxQ/bPfajprEWxR+zxbf5MMq7vKEukKrQuMeGt1+QZ8jwe9TMec0jGBrE1WCHP
         LzZrEWJFP0cmAsuXkj+7H1N3Z6Y5bkMu3HKqm2tuq/3jr3ay/q1sZukY3iPL67c2UduL
         8BW2JbZPok1Pehftz2p8FEsadYuBilS/VEbR/e/9YqmJ14LKA3j5yBt5ibQ9giuKH9W8
         +5DyrX1d4p1m2PjVEEYzjY2GQqqBEB3vQQJBPBHAZ79MVPOx+XmskY1Q7y4Me3020nLX
         oCFE3f+jPA2nXXErPxZ59zmJxtimRHat2hhMsFHjgWy7pb+kCSvqi6tVl7OBmcZM6Yvz
         b4EQ==
X-Gm-Message-State: APjAAAXjbwVGwKFng//dEDmrBkqltY9wopMCO3/E4TBpQHtWodw4Ni0D
        WDM16qm+h5Ssp6Yl4AzIsDOz5FKurtlJo9caWt+xAF3amvhKdRve+S63HpYqy4UbaiVeiUtl7SL
        E1w46X8M2ZxQhKUQSpXWE
X-Received: by 2002:a1c:ed09:: with SMTP id l9mr16417281wmh.101.1576266967753;
        Fri, 13 Dec 2019 11:56:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqy5YFwh5sS2NcMlnm9hJ/LMexv0IY3pNa2fmq/B8EQu8isDEtei+50KnCYPZpBA6OyeH6K0Dg==
X-Received: by 2002:a1c:ed09:: with SMTP id l9mr16417272wmh.101.1576266967509;
        Fri, 13 Dec 2019 11:56:07 -0800 (PST)
Received: from dhcp-44-196.space.revspace.nl ([2a0e:5700:4:11:6eb:1143:b8be:2b8])
        by smtp.gmail.com with ESMTPSA id c9sm10946834wmc.47.2019.12.13.11.56.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2019 11:56:06 -0800 (PST)
Subject: Re: [PATCH] efi/libstub: disable file loading and page deallocation
 in mixed mode
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Matthew Garrett <matthewgarrett@google.com>
References: <20191213091115.567-1-ardb@kernel.org>
 <69f21816-6dab-5abc-25f1-b2f5faf6f9e4@redhat.com>
 <CAKv+Gu9yFqtcbKa5RO_m=t2JQEaVyscBruQYSYMJpKE1JcAieA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d5917bef-929b-ee36-58b6-a8309d52f5bf@redhat.com>
Date:   Fri, 13 Dec 2019 20:56:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu9yFqtcbKa5RO_m=t2JQEaVyscBruQYSYMJpKE1JcAieA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On 12/13/19 7:49 PM, Ard Biesheuvel wrote:
> On Fri, 13 Dec 2019 at 13:29, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 13-12-2019 10:11, Ard Biesheuvel wrote:
>>> EFI mixed mode is a nice hack, since it allows us to run 64-bit Linux
>>> on low end x86_64 machines that shipped with 32-bit UEFI as they were
>>> built to run 32-bit Windows only.
>>>
>>> Mixed mode relies on the ability to convert calls made using the
>>> 64-bit calling convention into calls using the 32-bit one. This
>>> involves pushing a 32-bit word onto the stack for each argument
>>> passed in a 64-bit register, relying on the fact that all quantities
>>> that are the native size or smaller (including pointers) can be safely
>>> truncated to 32 bits. (In the pointer case, we rely on the fact that
>>> we are still executing in the firmware context, which uses a 1:1
>>> mapping that can only access the lower 4 GB of the address space)
>>>
>>> For types that are explicitly 64 bits wide, such as EFI_PHYSICAL_ADDRESS
>>> or UINT64, this assumption doesn't hold. The correct way to marshall
>>> such a call would be to push two consecutive 32-bit words onto the
>>> stack, but given that the naive thunking code has no knowledge
>>> whatsoever of the prototype of the function it is invoking, all we can
>>> do is avoid calling such functions altogether.
>>>
>>> The FreePages() boot service is affected by this, so we should not call
>>> that at all in mixed mode. In practice, this doesn't change much, since
>>> in the past, these calls would have been made with a bogus address, and
>>> so we were leaking this memory already. Note that the scope of this leak
>>> is the EFI execution context only, so it makes no difference for Linux.
>>>
>>> The other piece of functionality that we need to disable is loading files
>>> passed via file=xxxx on the command line, given that the Open() method
>>> takes two UINT64s as well.
>>>
>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>
>> Just ignoring the file= arguments is fine with me, as you say this has
>> been broken on mixed-mode since forever so likely no-one is using it:
>>
>> Acked-by: Hans de Goede <hdegoede@redhat.com>
>>
> 
> Thanks.
> 
> Do you have any recommendations on how to test this? Are you using GRUB to boot?
> 
> I am trying to test the random.c failure using QEMU+OVMF, which
> implements the EFI_RNG_PROTOCOL on top of virtio-rng-pci, but I cannot
> reproduce the failure.

I hit the random.c issue when testing a 5.5-rc1 x86_64 kernel on a Bay Trail
tablet. Almost any Bay Trail hw will come with 32 bit uefi because when Bay
Trail tablets (and 2-in-1s) first hit the market the 64 bit Windows drivers
were not ready yet and running 32 bit Windows requires a 32 bit UEFI
(Bay Trail devices do not have a classic bios mode / CSM).

A popular model example machine of such a setup is The Asus T100TA 2-in-1.

I'm using a standard Fedora install on these machines which goes:
UEFI -> 32-bit-secureboot-shim -> 32-bit-uefi-grub -> 64 bit kernel

Regards,

Hans

