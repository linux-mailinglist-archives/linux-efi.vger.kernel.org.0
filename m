Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8F738E3F7
	for <lists+linux-efi@lfdr.de>; Mon, 24 May 2021 12:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbhEXK0O (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 24 May 2021 06:26:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232422AbhEXK0M (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 24 May 2021 06:26:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 49374611CE;
        Mon, 24 May 2021 10:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621851884;
        bh=5wBiRHHSXJ69cFUjecB+aszzqhwYw/MhJXDMzSU3aiY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pK5GXFlN+YCuMLzRkryTFyUpVJAEwnP0vbi3xwjP6jH9zyZMvzC+0XT1/9n95bQrX
         77LPElvDmRwpEyjQ+Vt2rM4mAftSlCmR3oAMqfvsLQcddtFOpEfI+5OzLlommq+unm
         c1z9WKpYVrqqyRfaU1taNHEmXE5BpBfWetH1DWWfEW/q/4tSC9ActrMFlHWvRG91xV
         Iqt+xObwQDaIb1/6PpcojSSUO5P/HgU3bRs4B/TiDYp2fpqk0zZEpP1wralYzG9VK/
         2jMz7BaHTQs3BvgixAc5+Jfiil5oTbuXt0An5RS7g5NDy1QAwgsgxn7CU3wRk9FYs+
         Fyx6wyS0qENIw==
Received: by mail-oo1-f48.google.com with SMTP id o14-20020a4a384e0000b029020ec48a2358so4146751oof.13;
        Mon, 24 May 2021 03:24:44 -0700 (PDT)
X-Gm-Message-State: AOAM5305CscHqLDZLWklxsk/nRuxHxWqyccw+83WwnJVcMwnDKLYne6s
        Dobmb6w1TN0g+WOFIXBWEcMUuanYVKFf1MRQN9s=
X-Google-Smtp-Source: ABdhPJxuRHMn0Kx2Oweu4bILN4JMFbNf9fmAY08NovL1123TdXfK6IfWv4QLAq1YGWdjz8Wx+wrSdvtwgHP/dZgbZHc=
X-Received: by 2002:a4a:b202:: with SMTP id d2mr17739259ooo.13.1621851883493;
 Mon, 24 May 2021 03:24:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210521192907.3040644-1-javierm@redhat.com>
In-Reply-To: <20210521192907.3040644-1-javierm@redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 24 May 2021 12:24:32 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGrDm5yN5eRZJ0YAjCde=0Xw7hobC9Oz5CNovo0sWuM+g@mail.gmail.com>
Message-ID: <CAMj1kXGrDm5yN5eRZJ0YAjCde=0Xw7hobC9Oz5CNovo0sWuM+g@mail.gmail.com>
Subject: Re: [PATCH 0/2] allow the sysfb support to be used in non-x86 arches
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Peter Robinson <pbrobinson@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Hans de Goede <hdegoede@redhat.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Javier,

On Fri, 21 May 2021 at 21:29, Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> The x86 architecture platform has a Generic System Framebuffers (sysfb)
> support, that register a system frambuffer platform devices. It either
> registers a "simple-framebuffer" for the simple{fb,drm} drivers or legacy
> VGA/EFI FB devices for the vgafb/efifb drivers.
>
> Besides this, the EFI initialization code used by other architectures such
> as aarch64 and riscv, has similar logic but only register an EFI FB device.
>
> The sysfb is generic enough to be reused by other architectures and can be
> moved out of the arch/x86 directory to drivers/firmware, allowing the EFI
> logic used by non-x86 architectures to be folded into sysfb as well.
>
> Patch #1 in this series do the former while patch #2 the latter. This has
> been tested on x86_64 and aarch64 machines using the efifb, simplefb and
> simpledrm drivers. But more testing will be highly appreciated, to make
> sure that no regressions are being introduced by these changes.
>
> Since this touches both arch/{x86,arm,arm64,riscv} and drivers/firmware, I
> don't know how it should be merged. But I didn't find a way to split these.
>

We could merge this via the EFI tree without too much risk of
conflicts, I think.

However, I'd like to see a better explanation of why this is an improvement.
The diffstat does not show a huge net win, and it does not enable
anything we didn't already have before, right?


>
> Javier Martinez Canillas (2):
>   drivers/firmware: move x86 Generic System Framebuffers support
>   drivers/firmware: consolidate EFI framebuffer setup for all arches
>
>  arch/arm/Kconfig                              |  1 +
>  arch/arm/include/asm/efi.h                    |  5 +-
>  arch/arm64/Kconfig                            |  1 +
>  arch/arm64/include/asm/efi.h                  |  5 +-
>  arch/riscv/Kconfig                            |  1 +
>  arch/riscv/include/asm/efi.h                  |  5 +-
>  arch/x86/Kconfig                              | 27 +-----
>  arch/x86/kernel/Makefile                      |  3 -
>  drivers/firmware/Kconfig                      | 30 +++++++
>  drivers/firmware/Makefile                     |  2 +
>  drivers/firmware/efi/Makefile                 |  2 +
>  drivers/firmware/efi/efi-init.c               | 90 -------------------
>  .../firmware/efi}/sysfb_efi.c                 | 79 +++++++++++++++-
>  {arch/x86/kernel => drivers/firmware}/sysfb.c | 42 +++++----
>  .../firmware}/sysfb_simplefb.c                | 31 ++++---
>  .../x86/include/asm => include/linux}/sysfb.h | 34 +++----
>  16 files changed, 182 insertions(+), 176 deletions(-)
>  rename {arch/x86/kernel => drivers/firmware/efi}/sysfb_efi.c (84%)
>  rename {arch/x86/kernel => drivers/firmware}/sysfb.c (70%)
>  rename {arch/x86/kernel => drivers/firmware}/sysfb_simplefb.c (82%)
>  rename {arch/x86/include/asm => include/linux}/sysfb.h (68%)
>
> --
> 2.31.1
>
