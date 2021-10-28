Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA6643E3B9
	for <lists+linux-efi@lfdr.de>; Thu, 28 Oct 2021 16:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbhJ1Ob0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 28 Oct 2021 10:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbhJ1Ob0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 28 Oct 2021 10:31:26 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F54FC061745
        for <linux-efi@vger.kernel.org>; Thu, 28 Oct 2021 07:28:59 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id v138so10238426ybb.8
        for <linux-efi@vger.kernel.org>; Thu, 28 Oct 2021 07:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NfqCKwSiudzoy040zfsjV59xe6Kv1QKYM+WaXee+uzk=;
        b=el/g/UEC31xUtQUXmx5KY4IiNLVFRhj53qpXZxHvClNvldCbFo/R/L0R20WN/PSekJ
         sKGZmHW9n94+h1VlYC1rM+hzpAmR6VsQU89SFYo/ghF5KR03h+mpnMV4Q65TxiD5tK/q
         dFS0QwPpuHxi1qNXPlicxJgGhSVN6E7Q0FdUXaCFpX48S6kY5d3Uj7s03AAF3SHScjPN
         upzlBnFMZkaVF98jm1gM7YLIj/Y5dNXEYUQ9RJSZXBSDv2AsibSF2rjEw5ukHpeqvLHp
         ZMAuU10fzfuLLxmFmaDvEi2SpgnIficljCYpRCjQIz78qrH/uIDu+ybY7nw2ZBjNDeA1
         ulGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NfqCKwSiudzoy040zfsjV59xe6Kv1QKYM+WaXee+uzk=;
        b=q+Y0eSaxq6bzsiTDzUhEjxdhIROCyY/cMxgXkMo0qBIk6tFq/C0kQG4rN1l2VN1pjw
         jhdlZAZH52d9s2molV1pXqVWVpiNJanvBDMmFrvgrI0c+RB8wzLCfGkA+SiScZuZJJRh
         Rh1/4shcm/gkgNb0ri1RIrWydRm8k+HBGzD1mBrlLX9pCpKkXY2qrlYmjhfwmeOLrHid
         Y3pPMckb9HtovavMy5/3qmd07XjSzVB6ui/tzbkOevZ7zbwebaL3RL0G2RCVo1iieZxo
         KR3IrmZ2OXcCSRKzHG7OJPM964+pLoa2ZbUJnFIqxU9+2kijQN4s8GDym45G6X6Dmyig
         14fg==
X-Gm-Message-State: AOAM533G1ed0hiHsQPDGgYs6RRBPB1hQV7n1aeqnGF5k2vsnbc/PxmXr
        PBDK5mz5oddq7pH5IbmyJusAWiGmgstUo3FLL2UHbw==
X-Google-Smtp-Source: ABdhPJwJXRCaJ0v6WZhe3JOeO/5btk+I/mpZxoMYb2Z/6vjvRpQ4CmDcWplAVjT1RxwzxSLTn527bI66fbSZ0N2YPOQ=
X-Received: by 2002:a25:e755:: with SMTP id e82mr4941087ybh.528.1635431338767;
 Thu, 28 Oct 2021 07:28:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a81:1f09:0:0:0:0:0 with HTTP; Thu, 28 Oct 2021 07:28:57
 -0700 (PDT)
In-Reply-To: <8a8e0743-e54d-ec96-da4e-1d101b550274@intel.com>
References: <20211027195511.207552-1-martin.fernandez@eclypsium.com> <8a8e0743-e54d-ec96-da4e-1d101b550274@intel.com>
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
Date:   Thu, 28 Oct 2021 11:28:57 -0300
Message-ID: <CAKgze5Z3fT9F0S-mogfP6is9sL3=0imtCbfy6ZYrd3zgaBUqRg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] [RFC] x86: Export information about hardware
 memory encryption to sysfs
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, ardb@kernel.org, dvhart@infradead.org,
        andy@infradead.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        daniel.gutson@eclypsium.com, hughsient@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 10/27/21, Dave Hansen <dave.hansen@intel.com> wrote:
> On 10/27/21 12:55 PM, Martin Fernandez wrote:
>> This is a serie of patches for exporting the needed information to
>> userspace to determine if a machine is using Intel's TME or MKTME.
>>
>> In a next patch I'm going to export if TME/MKTME is activated by the
>> BIOS to sysfs, since right now for the user, this information is only
>> available in the kernel logs, and it's not appropriate for fwupd to
>> scan the boot logs just to parse an integer. I'm looking for
>> suggestions for where to store this value.
>
> I didn't see any TME or MKTME-specific stuff in these patches.  Are you
> assuming that all systems with any MEMBLOCK_CRYPTO_CAPABLE regions have
> TME activated?

Yes, you are correct, I didn't do anything TME-specific. That's the
part that I still need to do, I'm planning to do something similar to
detect_tme in /arch/x86/kernel/cpu/intel.c, but showing "TME" or
"MKTME" somewhere in sysfs, don't know where. Maybe in securityfs? And
it can also show the AMD variants in the future.

And no, I'm assuming that MEMBLOCK_CRYPTO_CAPABLE implies TME
activated, it's just another check to secure that the memory is
actually being encrypted.

> This also doesn't mention how userspace plans to *use* this information.
>  I think you mentioned it before, but it needs to be in the cover letter
> and changelogs too.
>

Userspace will just read this values and conclude (as it is right now)
if your memory is able to do encryption. As I mentioned above, with
the TME part, you will conclude if your memory is being encrypted or
not, and if not, you can see why not. For example, if you have TME,
you have it enabled but you have crypto_capable = 0 in your nodes,
then you probably have an old BIOS that doesn't support UEFI 2.7, and
that's why you don't have your memory flagged with
EFI_MEMORY_CPU_CRYPTO. And then you can tell to the user that maybe a
BIOS update will fix that.

That's what fwupd will try to do.
