Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5E2211F265
	for <lists+linux-efi@lfdr.de>; Sat, 14 Dec 2019 16:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbfLNPV5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 14 Dec 2019 10:21:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45658 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725895AbfLNPV4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 14 Dec 2019 10:21:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576336913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8iT6hCBPOLQb2xx3N8FqS+1Kg791Vvs8gb9+fwMFPN4=;
        b=P7yC1aS56QeDxZq3qffkWmn3ASXzca70VX3dhY0SPw5vlmkxVXn1cRiJVd5Gxzv51WRfXP
        sd3rCapi7zcGKLk0XP5AJQlJZxnPMHlmRn3/TWvm89tLXw03R/SNKmKncdJJcctE7KEi7W
        6+q+xVIORzrowdVi6KzxhkDJn9WMPWA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-BanNuQl4NemioJd_qg7PCw-1; Sat, 14 Dec 2019 10:21:50 -0500
X-MC-Unique: BanNuQl4NemioJd_qg7PCw-1
Received: by mail-wr1-f72.google.com with SMTP id y7so1112952wrm.3
        for <linux-efi@vger.kernel.org>; Sat, 14 Dec 2019 07:21:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8iT6hCBPOLQb2xx3N8FqS+1Kg791Vvs8gb9+fwMFPN4=;
        b=PXRYqnME+fB96V8DV8Jkw232wmwthrzSnPBjrkz0/r0bm/awoGdaPcyq9N71TUkyv8
         mdgRiTSwLfBwDs8MzSr3oXI/WievR3aeIN91N2yEzumMtxEJFwnLf5oKeO+hOpot+CEU
         RZEsbIBmz7G7Fi5ZGDIbN6+nGCSA9eOa9KWtDHF0tv2hzOpjYyFe9BkeujytZ1L7yE6s
         ZAVq6u0NZ5GdXQQGCq/ht+tg0tqadfzItEsykblqzMOuENa9NslQLdmgUvYHe32496/j
         ywhHcipx2Zvr7q7DzcU/Cm3Ix46PD+dFN9R1J+nhMZDv9hTHG4/XfshWUblMa/i8AFWH
         Jzdw==
X-Gm-Message-State: APjAAAUk11wRYk5Y5U5xTWi6AMC57rkss3b5VRDbPhJppAFsTH3A4DA0
        msC1MHxCr8LfstTNNuHm1lehyRvVD1qHVAVmaTVKnxvNlo/wIziUNYc9Z9kkh+IOAxfJ5kJLuF8
        6YfeXDMVMgQiNMzOn+wsv
X-Received: by 2002:a5d:4b45:: with SMTP id w5mr20399264wrs.224.1576336908659;
        Sat, 14 Dec 2019 07:21:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqy/VrexA/meETvaji5gQDFIdb8RjCHKHydn3RliJ3t/rg3BvaLdwcHD6OUu9JutertFn4Ng3w==
X-Received: by 2002:a5d:4b45:: with SMTP id w5mr20399248wrs.224.1576336908405;
        Sat, 14 Dec 2019 07:21:48 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id r15sm13802215wmh.21.2019.12.14.07.21.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Dec 2019 07:21:47 -0800 (PST)
Subject: Re: [PATCH] efi/libstub: disable file loading and page deallocation
 in mixed mode
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi <linux-efi@vger.kernel.org>
References: <20191213091115.567-1-ardb@kernel.org>
 <69f21816-6dab-5abc-25f1-b2f5faf6f9e4@redhat.com>
 <CAKv+Gu9yFqtcbKa5RO_m=t2JQEaVyscBruQYSYMJpKE1JcAieA@mail.gmail.com>
 <d5917bef-929b-ee36-58b6-a8309d52f5bf@redhat.com>
 <CAKv+Gu8vWem-jTv_K3KEqkqOVDDte9QOXco2pLA999u7hxH_Yg@mail.gmail.com>
 <f276df9f-83b4-e404-bcfc-91f0212a5fc0@redhat.com>
 <CAKv+Gu_cyf5AssySDmrzKjWDN+Wa0JMnyQocKJrqj3uZKO6jQQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e216a9bd-6e37-c87a-5b14-d0cea31bfc60@redhat.com>
Date:   Sat, 14 Dec 2019 16:21:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu_cyf5AssySDmrzKjWDN+Wa0JMnyQocKJrqj3uZKO6jQQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

HI,

On 13-12-2019 21:16, Ard Biesheuvel wrote:
> On Fri, 13 Dec 2019 at 21:12, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 12/13/19 9:08 PM, Ard Biesheuvel wrote:
>>> On Fri, 13 Dec 2019 at 20:56, Hans de Goede <hdegoede@redhat.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> On 12/13/19 7:49 PM, Ard Biesheuvel wrote:
>>>>> On Fri, 13 Dec 2019 at 13:29, Hans de Goede <hdegoede@redhat.com> wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> On 13-12-2019 10:11, Ard Biesheuvel wrote:
>>>>>>> EFI mixed mode is a nice hack, since it allows us to run 64-bit Linux
>>>>>>> on low end x86_64 machines that shipped with 32-bit UEFI as they were
>>>>>>> built to run 32-bit Windows only.
>>>>>>>
>>>>>>> Mixed mode relies on the ability to convert calls made using the
>>>>>>> 64-bit calling convention into calls using the 32-bit one. This
>>>>>>> involves pushing a 32-bit word onto the stack for each argument
>>>>>>> passed in a 64-bit register, relying on the fact that all quantities
>>>>>>> that are the native size or smaller (including pointers) can be safely
>>>>>>> truncated to 32 bits. (In the pointer case, we rely on the fact that
>>>>>>> we are still executing in the firmware context, which uses a 1:1
>>>>>>> mapping that can only access the lower 4 GB of the address space)
>>>>>>>
>>>>>>> For types that are explicitly 64 bits wide, such as EFI_PHYSICAL_ADDRESS
>>>>>>> or UINT64, this assumption doesn't hold. The correct way to marshall
>>>>>>> such a call would be to push two consecutive 32-bit words onto the
>>>>>>> stack, but given that the naive thunking code has no knowledge
>>>>>>> whatsoever of the prototype of the function it is invoking, all we can
>>>>>>> do is avoid calling such functions altogether.
>>>>>>>
>>>>>>> The FreePages() boot service is affected by this, so we should not call
>>>>>>> that at all in mixed mode. In practice, this doesn't change much, since
>>>>>>> in the past, these calls would have been made with a bogus address, and
>>>>>>> so we were leaking this memory already. Note that the scope of this leak
>>>>>>> is the EFI execution context only, so it makes no difference for Linux.
>>>>>>>
>>>>>>> The other piece of functionality that we need to disable is loading files
>>>>>>> passed via file=xxxx on the command line, given that the Open() method
>>>>>>> takes two UINT64s as well.
>>>>>>>
>>>>>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>>>>>
>>>>>> Just ignoring the file= arguments is fine with me, as you say this has
>>>>>> been broken on mixed-mode since forever so likely no-one is using it:
>>>>>>
>>>>>> Acked-by: Hans de Goede <hdegoede@redhat.com>
>>>>>>
>>>>>
>>>>> Thanks.
>>>>>
>>>>> Do you have any recommendations on how to test this? Are you using GRUB to boot?
>>>>>
>>>>> I am trying to test the random.c failure using QEMU+OVMF, which
>>>>> implements the EFI_RNG_PROTOCOL on top of virtio-rng-pci, but I cannot
>>>>> reproduce the failure.
>>>>
>>>> I hit the random.c issue when testing a 5.5-rc1 x86_64 kernel on a Bay Trail
>>>> tablet. Almost any Bay Trail hw will come with 32 bit uefi because when Bay
>>>> Trail tablets (and 2-in-1s) first hit the market the 64 bit Windows drivers
>>>> were not ready yet and running 32 bit Windows requires a 32 bit UEFI
>>>> (Bay Trail devices do not have a classic bios mode / CSM).
>>>>
>>>> A popular model example machine of such a setup is The Asus T100TA 2-in-1.
>>>>
>>>> I'm using a standard Fedora install on these machines which goes:
>>>> UEFI -> 32-bit-secureboot-shim -> 32-bit-uefi-grub -> 64 bit kernel
>>>>
>>>
>>> And after applying the fix, do you now get a RNG=0x.... on the line
>>> that has ACPI, SMBIOS etc?
>>
>> No I get:
>>
>> [    0.000000] efi:  ACPI=0x3b71f000  ACPI 2.0=0x3b71f014  ESRT=0x3b6ed000  SMBIOS=0x3baa8310  TPMEventLog=0x37e95010
>>
>> No RNG there. Note this is on a slightly different Bay Trail device.
>>
> 
> It is slightly surprising that this mixed mode bug gets tickled even
> though the protocol in question doesn't even exist.

As mentioned I was testing on a differtent model mixed mode Bay Trail tablet
as I did not have the tablet where I originally hit this at hand.

I've just tested this on the tablet where I originally hit this; and the RNG=
bit is there:

[    0.000000] efi:  ACPI=0x39178000  ACPI 2.0=0x39178014  ESRT=0x3914f000  SMBI
OS=0x39b79290  RNG=0x39b79190  TPMEventLog=0x31847010

I've added some debugging pr_efi_error calls and on the tablet I was testing with
yesterday the locate_protocol call indeed fails on that one.

I've done quick comparison of the FW versions, both use AMI AptIO as a BIOS,
With identical core versions; and on the model *without* the RNG support the TXE FW
version is newer:

Model without RNG proto support:
TXE FW Version  01.01.00.1115

Model with RNG proto support:
TXE FW Version  01.00.04.1090

So no idea why some of these devices have RNG support and others do not,
anyways the good news is that between these 2 devices both paths have now
been tested in mixed-mode and with my fix in place both paths work.

Regards,

Hans

