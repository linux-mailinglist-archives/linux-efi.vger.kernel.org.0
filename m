Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE4941295AF
	for <lists+linux-efi@lfdr.de>; Mon, 23 Dec 2019 12:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfLWLty (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 23 Dec 2019 06:49:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32607 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726257AbfLWLty (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 23 Dec 2019 06:49:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577101792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SMoEiNKfuy39gObBt47ZuCvrXYRo3TqPONm3TaZK2hA=;
        b=MomYI9i0+H3BajkXgR1eF0HY0EWHWcbaLmrMjCRzIJqoSzLOaiyWJ3Dt6wyNMVjisKrOaZ
        PMl5Qps9MMponmcYq0InI/zUDCFo7EJvMfGDZ6ktuTe9dUHVNgc+kRpn3ZFKbrFaZR8xkX
        8IjvGfi8hjlCi5XL8ppmUmgaoP4r5EQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-pefp273zPE2fs3DhC1Pc8A-1; Mon, 23 Dec 2019 06:49:51 -0500
X-MC-Unique: pefp273zPE2fs3DhC1Pc8A-1
Received: by mail-wr1-f70.google.com with SMTP id c6so7831051wrm.18
        for <linux-efi@vger.kernel.org>; Mon, 23 Dec 2019 03:49:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SMoEiNKfuy39gObBt47ZuCvrXYRo3TqPONm3TaZK2hA=;
        b=Yv+8ypBAp0wKOhA5a2af3xo9v4H4Bi4+b6xcTGqTYq01IE02fQXam1ZWpwE9/QuVhm
         rvNLkmedHap0f6ksF2I3aufD9rPmtjX5kDF2py0x8Qb7NU09RxA8aaNPdowO9T/5vt5q
         XVYJtiR7mPx5/7uPJor5HG0Ho2SQi/i3qjMNqTnDabO49RQtv2CUWNbrj2jbP3JKhzIO
         bZTuPRFYgJUw7DzDm07d4H94LtW78VIx/kYk2RgfcOuclWmS9Rl7DrhlfN/LwSvKi0IX
         OhV0Lt/wokKT4x8l1Jpe6LBkHmZ45hS4E5f/oYnOGTWJ9edyWxilZnWoqWwDTgrhT16l
         +Ffw==
X-Gm-Message-State: APjAAAUD/CQSV3KBEsNmeQRaZ8xVxDzqyUOf/hab0QncGbaqJW01t7/K
        Y99p7dH4yoDkalgrK5JBwZQDv+S8TbNJvylnnQoUuqOhfYN7T0/SHrdLTIXGo8Ee58sCzy5661h
        BmI8UvFers+bS29SL+0ys
X-Received: by 2002:a5d:620b:: with SMTP id y11mr28999469wru.230.1577101789965;
        Mon, 23 Dec 2019 03:49:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqyI9UDMnFjrn7Iq36T7duj6MFb9N0Jz3HsUJUeZHcD+8+Bksef3JW6I4uBC4Kn7Z6DTpi22eg==
X-Received: by 2002:a5d:620b:: with SMTP id y11mr28999451wru.230.1577101789726;
        Mon, 23 Dec 2019 03:49:49 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id d16sm22192450wrg.27.2019.12.23.03.49.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Dec 2019 03:49:49 -0800 (PST)
Subject: Re: [PATCH v2 10/21] efi/libstub/x86: avoid thunking for native
 firmware calls
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
References: <20191218170139.9468-1-ardb@kernel.org>
 <20191218170139.9468-11-ardb@kernel.org>
 <e7fc88c6-6281-f69b-ef9b-71572e40d6b9@redhat.com>
 <CAKv+Gu8gWLw5-LkKwU0reUcreLyC8s1hQSzrR__-myuHrdVr7Q@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c82d02c3-c6e7-70af-37ad-5a8209ab8f22@redhat.com>
Date:   Mon, 23 Dec 2019 12:49:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu8gWLw5-LkKwU0reUcreLyC8s1hQSzrR__-myuHrdVr7Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

On 22-12-2019 13:02, Ard Biesheuvel wrote:
> On Sat, 21 Dec 2019 at 22:22, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi Ard,
>>
>> On 18-12-2019 18:01, Ard Biesheuvel wrote:
>>> We use special wrapper routines to invoke firmware services in the
>>> native case as well as the mixed mode case. For mixed mode, the need
>>> is obvious, but for the native cases, we can simply rely on the
>>> compiler to generate the indirect call, given that GCC now has
>>> support for the MS calling convention (and has had it for quite some
>>> time now). Note that on i386, the decompressor and the EFI stub are not
>>> built with -mregparm=3 like the rest of the i386 kernel, so we can
>>> safely allow the compiler to emit the indirect calls here as well.
>>>
>>> So drop all the wrappers and indirection, and switch to either native
>>> calls, or direct calls into the thunk routine for mixed mode.
>>>
>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>
>> I'm afraid that this patch breaks the boot on one of my machines.
>>
>> Specifically this patch breaks my GDP pocket machine. This is a Cherry
>> Trail device with a 64 UEFI running a 64 bit kernel build.
>>
>> As soon as I cherry pick this patch into my personal 5.5.0-rc2 based
>> tree, the GPD pocket stops booting and it stop so early on that I get 0
>> debug output. I guess I could try adding a few pr_efi_err calls
>> and see if those still do something.
>>
>> I noticed that you have made some changes to this patch, I've
>> tried updating it to the version from your efistub-x86-cleanup-v3
>> branch, commit id a37d90a2c570a25926fd1645482cb9f3c1d042a0
>> and I have also cherry-picked the latest version of all preceding
>> commits, unfortunately even with the new version, the GPD pocket
>> still hangs at boot.
>>
>> Unfortunately the nature of this patch makes it hard to figure
>> out the root cause of this issue...
>>
>> I've also tried another Cherry Trail device with 64 bit UEFI and
>> that does not suffer from this problem.
>>
> 
> Thanks Hans.
> 
> There are a number of things that change in the way the calls are
> made, but the most obvious thing to check is whether the stack needs
> to be aligned, since that is no longer being done.
> 
> If you have time to experiment a bit more, could you check whether
> doing 'and $~0xf %rsp' before 'call efi_main' in the .S stub code for
> x86_64 makes a difference?

Ok, so I made this change on top of a37d90a2c570a25926fd1645482cb9f3c1d042a0
(the last "efi/libstub/x86: avoid thunking for native firmware calls" version
I tried before reporting this problem) :

--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -464,6 +464,7 @@ SYM_FUNC_START(efi_pe_entry)

  handover_entry:
         movq    efi_config(%rip), %rdi
+       and     $~0xf, %rsp
         call    efi_main
         movq    %rax,%rsi
         cmpq    $0,%rax

And that does the trick, the GPD pocket boots successfully with commit
a37d90a2c570a25926fd1645482cb9f3c1d042a0 + the above change.

So it looks like your first hunch on how to fix this is correct :)

Regards,

Hans

