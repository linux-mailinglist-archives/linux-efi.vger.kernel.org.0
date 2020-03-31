Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F00C199ED5
	for <lists+linux-efi@lfdr.de>; Tue, 31 Mar 2020 21:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbgCaTUj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Mar 2020 15:20:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20516 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727509AbgCaTUj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 31 Mar 2020 15:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585682438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EePuS6hJnpigKkKFfbeY5lY7BtvEx2PU+2Avp7mwnxU=;
        b=YZKLh9Vvcefc3KcVXCTo1blConIMz6JvfAp1xq+OjPg0pSLd5sZWXL+zFBJ146SLd4c1bS
        LaDA36DeshdXJOyDOiu3z2Oj7OfOXMZa1694fXhBGnR4BguLOMxf2gGfq/MhsfxSf6SAk6
        jJBmq1dL6+S7mF7DYhsgZR8L4zm/nM8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-i2TYWn2eM76Y66Yn5Kyc8g-1; Tue, 31 Mar 2020 15:20:34 -0400
X-MC-Unique: i2TYWn2eM76Y66Yn5Kyc8g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9593C149FB;
        Tue, 31 Mar 2020 19:20:09 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-115-131.ams2.redhat.com [10.36.115.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 03838DA0E0;
        Tue, 31 Mar 2020 19:20:07 +0000 (UTC)
Subject: Re: [PATCH] efi/libstub/arm64: avoid image_base value from
 efi_loaded_image
To:     Ard Biesheuvel <ardb@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Cc:     Leif Lindholm <leif@nuviainc.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Boqun Feng <Boqun.Feng@microsoft.com>
References: <20200328205809.23825-1-ardb@kernel.org>
 <20200330074721.GV22097@bivouac.eciton.net>
 <CAMj1kXFPtY20afbAZgXT3As4TUuAqi3=pG8u19hjMjFxgN6HWA@mail.gmail.com>
 <CAMj1kXEf5rT1pmDNQoOd5Tx9xQ=fUMT0xo4JXZNfz=VDY9268Q@mail.gmail.com>
 <DM5PR2101MB104760D03E632DD4DBE99AE1D7CB0@DM5PR2101MB1047.namprd21.prod.outlook.com>
 <CAMj1kXF+2O5cDC9zuNp9Lx9Oe6WyxRghPqSi63CnF+KCcGUZyw@mail.gmail.com>
 <CAMj1kXFJB9ciJ41V2tpQNX_mN7S8BweV9_ME3sDxKjwnR2Jwbg@mail.gmail.com>
From:   Laszlo Ersek <lersek@redhat.com>
Message-ID: <91ce0460-ae47-8092-0dfa-4b7ff6edc283@redhat.com>
Date:   Tue, 31 Mar 2020 21:20:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAMj1kXFJB9ciJ41V2tpQNX_mN7S8BweV9_ME3sDxKjwnR2Jwbg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 03/31/20 09:56, Ard Biesheuvel wrote:
> On Mon, 30 Mar 2020 at 20:24, Ard Biesheuvel <ardb@kernel.org> wrote:
>>
>> On Mon, 30 Mar 2020 at 20:12, Michael Kelley <mikelley@microsoft.com> wrote:
>>>
>>> From: Ard Biesheuvel <ardb@kernel.org>  Sent: Monday, March 30, 2020 12:51 AM
>>>>
>>>> On Mon, 30 Mar 2020 at 09:50, Ard Biesheuvel <ardb@kernel.org> wrote:
>>>>>
>>>>> On Mon, 30 Mar 2020 at 09:47, Leif Lindholm <leif@nuviainc.com> wrote:
>>>>>>
>>>>>> On Sat, Mar 28, 2020 at 21:58:09 +0100, Ard Biesheuvel wrote:
>>>>>>> Commit 9f9223778ef3 ("efi/libstub/arm: Make efi_entry() an ordinary
>>>>>>> PE/COFF entrypoint") did some code refactoring to get rid of the
>>>>>>> EFI entry point assembler code, and in the process, it got rid of the
>>>>>>> assignment of image_addr to the value of _text. Instead, it switched
>>>>>>> to using the image_base field of the efi_loaded_image struct provided
>>>>>>> by UEFI, which should contain the same value.
>>>>>>>
>>>>>>> However, Michael reports that this is not the case: older GRUB builds
>>>>>>> corrupt this value in some way, and since we can easily switch back to
>>>>>>> referring to _text to discover this value, let's simply do that.
>>>>>>
>>>>>> It is not clear to me how "older GRUB builds" would differ here.
>>>>>> I think more investigation is needed before making that claim.
>>>>>> My suspicion is that some (old) version of non-upstream, shim-enabled
>>>>>> distro-specific build is playing a part.
>>>>>>
>>>>>> So, do we have the option for more detailed investigations, or can we
>>>>>> vague the claim up to say "some GRUB builds seen in the wild, based
>>>>>> on an upstream 2.02" or suchlike?
>>>>>>
>>>>>
>>>>> I've queued a fix that prints a nastygram if the value deviates from
>>>>> the expected one. Let's see if this triggers any reports.
>>>>
>>>> (/me looks at context)
>>>>
>>>> *This* is the fix that prints a nastygram.
>>>
>>> FWIW, I pulled the BOOTAA64.EFI and grubaa64.efi files from CentOS 7.6
>>> and CentOS 8.0 binary packages and tested both in my Hyper-V VM.
>>> Using strings | grep '2\.' to get version info, the CentOS 7.6 grubaa64.efi
>>> shows:
>>>
>>>         User-Agent: GRUB 2.02~beta2
>>>
>>> The CentOS 8.0 grubaa64.efi shows:
>>>
>>>         User-Agent: GRUB 2.03
>>>
>>> Both versions produce the FIRMWARE BUG warning when using Ard's
>>> latest patch.  I'll assume the equivalent RHEL versions are the same.
>>> So we've got official distro releases that show the problem.
>>>
>>> As reported earlier, the BOOTAA64.EFI and grubaa64.efi from a
>>> Debian release (not exactly sure which one) do not produce the
>>> FIRMWARE BUG warning.  The grubaa64.efi reports as 2.04-4.
>>>
>>
>> Thanks a lot Michael, that is really helpful.
> 
> I could not reproduce the issue with Debian Stretch's
> 2.02~beta3-5+deb9u2, so it does appear to be RedHat's value add that
> is to blame here.
> 
> @Laszlo: TL;DR RedHat's GRUB for arm64 appears to clobber the
> image_base field of the efi_loaded_image struct passed to the kernel.
> Could you please recommend a way to report this?

Yes. I seem to recall that you already have an account at
<https://bugzilla.redhat.com/>. Please log in, then go to the following
link:

https://bugzilla.redhat.com/enter_bug.cgi?product=Red%20Hat%20Enterprise%20Linux%208

In the "Component" field, please enter "grub2", then fill in Summary /
Description / etc.

Please be thorough, as if you wanted me to reproduce the issue :)

After filing the bug, please send the BZ link to me (or add me to the
bug's CC list), so I can ping some RH bootloader folks directly.

Thanks!
Laszlo

