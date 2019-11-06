Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7C77F18DD
	for <lists+linux-efi@lfdr.de>; Wed,  6 Nov 2019 15:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731652AbfKFOix (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 6 Nov 2019 09:38:53 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55033 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731665AbfKFOiu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 6 Nov 2019 09:38:50 -0500
Received: by mail-wm1-f67.google.com with SMTP id z26so3708554wmi.4
        for <linux-efi@vger.kernel.org>; Wed, 06 Nov 2019 06:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0CmhjeEoOQoK9M5oulxkBYRkuF7RbofIT7XEOkOeNWE=;
        b=ktGit0VF9Pxxc2/SjGSBp3d6X4n8cJFJ4br8gEOGqIViyC092DbDEwdKKGer70dwDc
         oU2GKqS7sdlPU6wXLYKhTFkXnij5YQ+dz0iYFoJdw8gOtIGJAw2XqKlcNZmQW1Q3EOhv
         CoBfrgfoq9g4PCYmo9Y6+VbZhP/PT0l7Kp+h3is+q7uYfzrrJSRO2rxN+8uBaL9l1zLp
         7XJl1Z+UtMGW9JajovMtp5EWoTYN9zmKQ1nYptsuH5kzE/TcU/1onD2K8odPxfR1RKyo
         tlTRURHVU0Yk4Jv31PHyU3a7qJJhoOnwegfEEH4bsesYN7JFFArT551NnzWFGEatzMop
         h3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0CmhjeEoOQoK9M5oulxkBYRkuF7RbofIT7XEOkOeNWE=;
        b=Z17T+efhUPJOz4m3XWldTMAmeSOlEGrviT7fp1VLsMefOlRqVGzQG0xXBGu/MEAJ2O
         mJBGXVADVJNYxFdx6QmJ4Pg2RkfvDR31EKq2DZFIzQV79ldxLE4C5igGXfwJ/7kH/kkw
         Dl+zP01Mcd837E1U/IvW7u5A1az+r7JxwJz1/Z+1qcwak47D/Bh2aD9xOFBMwpVweH1S
         e70tC0rSAQ1hCQO2Xc0V4P4H1ANscpfwnEVLaFyVwQ4aCSIiGznnHL+e4Zrdrj3KvxLA
         jGLOMSI/MU1ltICU8VDNdt5uXeNEyOMKWF06HtfnXnkaYJCI4ApCrmzeJf5LiAGJug0f
         9r5w==
X-Gm-Message-State: APjAAAXztT4NUCuVgU7ENr6KqLmV8iRZZV8rnV9boBPnzssmF4hSdav2
        UimDzsi5fYTriT54tvOxh/qNfw8JfsiTHZGo+1z5bw==
X-Google-Smtp-Source: APXvYqy354XW0WaNEasezP+akPpMtBVn/pAmBzbclSTi01iL8mgWfF+4/y7OkaAL60YF+aXmWnd00k3RptH4Bv2MeMg=
X-Received: by 2002:a1c:3d08:: with SMTP id k8mr2662313wma.119.1573051126981;
 Wed, 06 Nov 2019 06:38:46 -0800 (PST)
MIME-Version: 1.0
References: <20191106070613.227833-1-linux@dominikbrodowski.net>
In-Reply-To: <20191106070613.227833-1-linux@dominikbrodowski.net>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 6 Nov 2019 15:38:34 +0100
Message-ID: <CAKv+Gu-SMOXK_K-Nh3=8UtB5zbmGnaSQcQSGdC+bnWzyZ4aW8g@mail.gmail.com>
Subject: Re: [PATCH 0/2] x86, efi/random: invoke EFI_RNG_PROTOCOL in the x86
 EFI stub
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Mario Limonciello <Mario.Limonciello@dell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 6 Nov 2019 at 08:09, Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
>
> EFI v2.4 and later may provide for a EFI_RNG_PROTOCOL, which can be called
> from the EFI stubs to seed the kernel entropy pool. So far, this feature has
> only been implemented on arm/arm64. This series makes the relevant EFI
> libstub code arch-independent and enables the feature also on x86.
>
> Please note that this feature only works if Linux is booted as an EFI stub,
> and that the EFI-provided randomness is not credited as entropy unless
> RANDOM_TRUST_BOOTLOADER is set.
>
> Thanks to Ard Biesheuvel for his hints on how to test the EFI_RNG_PROTOCOL
> from the UEFI shell ( RngTest-X64.efi ), and especially to Mario Limonciello:
> he gave me highly useful hints on the implementation of the EFI_RNG_PROTOCOL
> which ultimately helped me to determine why the earlier RFC patch did not
> work out as expected.
>
> The patches are also available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git/ random
>
> Dominik Brodowski (2):
>   efi/random: use arch-independent efi_call_proto()
>   x86: efi/random: Invoke EFI_RNG_PROTOCOL to seed the UEFI RNG table
>

Thanks Dominik. I'll get these queued up.

For others reading this, it is worth mentioning that there is an open
source UEFI driver for the ChaosKey, which produces the EFI RNG
protocol and can be loaded into UEFI persistently using 'efibootmgr
-r'.

>  arch/x86/boot/compressed/eboot.c       |  3 +++
>  drivers/firmware/efi/libstub/Makefile  |  5 +++--
>  drivers/firmware/efi/libstub/efistub.h |  2 --
>  drivers/firmware/efi/libstub/random.c  | 21 ++++++++++++++++-----
>  include/linux/efi.h                    |  2 ++
>  5 files changed, 24 insertions(+), 9 deletions(-)
>
> --
> 2.24.0
>
