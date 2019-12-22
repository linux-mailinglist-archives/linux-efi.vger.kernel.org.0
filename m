Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48F1D128DCE
	for <lists+linux-efi@lfdr.de>; Sun, 22 Dec 2019 13:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfLVMCy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 22 Dec 2019 07:02:54 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50828 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfLVMCy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 22 Dec 2019 07:02:54 -0500
Received: by mail-wm1-f67.google.com with SMTP id a5so13208215wmb.0
        for <linux-efi@vger.kernel.org>; Sun, 22 Dec 2019 04:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ILdu4hm+wCMTsSZLRWsVUBeMhwGTV3PIUBRJ7gPVnxA=;
        b=qUpqjH30llm3X4D8SI+mCTJDgQvlN6SMiI9QDxd/9yQgroGs8eREjkczU8q48kCcXX
         IsLKso/3GfmnUdDX+T41Kva/RBuhPu9T8jScWdMPUhW2Zile69uOSZqMhOrLgBlPlxjm
         pY1F6E4pHjE5NVfnSPynRHU8gJmznBVLY3mr6Ey9/WdoR8SI2nMCwy7QuEFiSPifbxib
         c6KtMJrvsgYkIc6y3e40XfvAI0AkKqH2LzGBXebdhWOU0zCqSQHjVfVyLQKV4V/17LbY
         FPuhWIgBuqOcDloRXhVY/Ab6EgvKYD5HrtBapHq03OTr49OK5fprWvv+QvYsL6Qi+Qnk
         v1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ILdu4hm+wCMTsSZLRWsVUBeMhwGTV3PIUBRJ7gPVnxA=;
        b=JfV1tiIQUI8B0HdKbQx7hV8uH0ru5Tl0xst0hPaziRTcT1xYw8tmlSznUtRdo2tmbn
         RjGVYVuH5crHYFKQq3m3zqJQY3Hgm1EPcsdhck3pbPMgRbnjP2k58XFt4Dkp4Zb/nc7i
         moId+ZQgvKVG3SaAoyzUtxY2Q2j+DtpuyxjhAmINpc4iWSYU+UnCbsnxQ+KFtpftIIO0
         ddNHq2GoW3k8N8ED7FQp7wPMLJF/hHuQYiemVeg+x+rc+jzt+h3TRJ1ZzwroXXxg4UHC
         n13cCS02kFPoGTl6Ody9ROnehNguHN2KtDsIpuWeqDI89TaJIf9mpwlB4tfGOM0SZeuc
         ABQA==
X-Gm-Message-State: APjAAAWi5m0QgOEabY2ogBvmLzZPcTXJW9Sa84TeVXejh2Gb1aJCtU2G
        j+MLL/aI7LXEdmojdlk0LLveY1EZT0PtiVNh2uP36g==
X-Google-Smtp-Source: APXvYqzake0VPwvUmgivVOm8LlzVG/Up0G9mU+YJCGzHtm1OCmvSZdE8gVTngL4ryHJ/d6mu9CHMcHkXC3lySGPYUAI=
X-Received: by 2002:a1c:9d52:: with SMTP id g79mr26672701wme.148.1577016172166;
 Sun, 22 Dec 2019 04:02:52 -0800 (PST)
MIME-Version: 1.0
References: <20191218170139.9468-1-ardb@kernel.org> <20191218170139.9468-11-ardb@kernel.org>
 <e7fc88c6-6281-f69b-ef9b-71572e40d6b9@redhat.com>
In-Reply-To: <e7fc88c6-6281-f69b-ef9b-71572e40d6b9@redhat.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sun, 22 Dec 2019 13:02:41 +0100
Message-ID: <CAKv+Gu8gWLw5-LkKwU0reUcreLyC8s1hQSzrR__-myuHrdVr7Q@mail.gmail.com>
Subject: Re: [PATCH v2 10/21] efi/libstub/x86: avoid thunking for native
 firmware calls
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 21 Dec 2019 at 22:22, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Ard,
>
> On 18-12-2019 18:01, Ard Biesheuvel wrote:
> > We use special wrapper routines to invoke firmware services in the
> > native case as well as the mixed mode case. For mixed mode, the need
> > is obvious, but for the native cases, we can simply rely on the
> > compiler to generate the indirect call, given that GCC now has
> > support for the MS calling convention (and has had it for quite some
> > time now). Note that on i386, the decompressor and the EFI stub are not
> > built with -mregparm=3 like the rest of the i386 kernel, so we can
> > safely allow the compiler to emit the indirect calls here as well.
> >
> > So drop all the wrappers and indirection, and switch to either native
> > calls, or direct calls into the thunk routine for mixed mode.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> I'm afraid that this patch breaks the boot on one of my machines.
>
> Specifically this patch breaks my GDP pocket machine. This is a Cherry
> Trail device with a 64 UEFI running a 64 bit kernel build.
>
> As soon as I cherry pick this patch into my personal 5.5.0-rc2 based
> tree, the GPD pocket stops booting and it stop so early on that I get 0
> debug output. I guess I could try adding a few pr_efi_err calls
> and see if those still do something.
>
> I noticed that you have made some changes to this patch, I've
> tried updating it to the version from your efistub-x86-cleanup-v3
> branch, commit id a37d90a2c570a25926fd1645482cb9f3c1d042a0
> and I have also cherry-picked the latest version of all preceding
> commits, unfortunately even with the new version, the GPD pocket
> still hangs at boot.
>
> Unfortunately the nature of this patch makes it hard to figure
> out the root cause of this issue...
>
> I've also tried another Cherry Trail device with 64 bit UEFI and
> that does not suffer from this problem.
>

Thanks Hans.

There are a number of things that change in the way the calls are
made, but the most obvious thing to check is whether the stack needs
to be aligned, since that is no longer being done.

If you have time to experiment a bit more, could you check whether
doing 'and $~0xf %rsp' before 'call efi_main' in the .S stub code for
x86_64 makes a difference?
