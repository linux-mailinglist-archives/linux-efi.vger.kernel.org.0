Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A82244658
	for <lists+linux-efi@lfdr.de>; Fri, 14 Aug 2020 10:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgHNIRZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 14 Aug 2020 04:17:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726641AbgHNIRY (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 14 Aug 2020 04:17:24 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EF4222BED;
        Fri, 14 Aug 2020 08:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597393043;
        bh=HY+m6iT/uKtSV5so9rt7C5SbeoJZc1Tb9Nu33p1f+dI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zjAF2U3QtvbdVbmBZL64LWKNRCIfq2QOSRlURJtS+XX0RvrrqQ39DmDlicM3G7j4L
         cW1rNC9hufaJk/Mqi1+xKr+EcLsnQZ50Vvn9nG7GNwZ4KmgSxStXhX3AyQTRjgqPWv
         nlDiYXrfYQXYktHs5DZPAk6FC0jm2ZlFJQXVg3iw=
Received: by mail-ot1-f47.google.com with SMTP id h16so6971193oti.7;
        Fri, 14 Aug 2020 01:17:23 -0700 (PDT)
X-Gm-Message-State: AOAM533ccws27WcL5IDlR2Hi3Dtp5/SV/l6lPTvd0lr6yVfGBj0cL6U1
        P3P5g4MEfwp0tGUFO58tTFovP+wsQUAL0pdw2tg=
X-Google-Smtp-Source: ABdhPJzRybShq6srZ6XFNiYV43pOVqNtu3RNcUAnCec0hfJX8drqSxl/WwXak700MtVkwfkN6afAHT2A49b8QcP/RmU=
X-Received: by 2002:a05:6830:1d8c:: with SMTP id y12mr1175113oti.77.1597393042323;
 Fri, 14 Aug 2020 01:17:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200812234758.3563-1-atish.patra@wdc.com> <20200812234758.3563-8-atish.patra@wdc.com>
In-Reply-To: <20200812234758.3563-8-atish.patra@wdc.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 14 Aug 2020 10:17:11 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHH6sn+9EiOPi4ViHgLn3SYQ7GOCaRf1c2GJ6YDC1uavw@mail.gmail.com>
Message-ID: <CAMj1kXHH6sn+9EiOPi4ViHgLn3SYQ7GOCaRf1c2GJ6YDC1uavw@mail.gmail.com>
Subject: Re: [PATCH v5 7/9] efi: Rename arm-init to efi-init common for all arch
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <alistair.francis@wdc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup.patel@wdc.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>,
        Greentime Hu <greentime.hu@sifive.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        fwts-devel@lists.ubuntu.com, Mao Han <han_mao@c-sky.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Mike Rapoport <rppt@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Steven Price <steven.price@arm.com>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>,
        Daniel Schaefer <daniel.schaefer@hpe.com>,
        "abner.chang@hpe.com" <abner.chang@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 13 Aug 2020 at 01:48, Atish Patra <atish.patra@wdc.com> wrote:
>
> arm-init is responsible for setting up efi runtime and doesn't actually
> do any ARM specific stuff. RISC-V can use the same source code as it is.
>
> Rename it to efi-init so that RISC-V can use it.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

Note to the maintainer: to the extent possible, please put the patches
in this series that touch drivers/firmware/efi on a separate branch
based on v5.9-rc1, and merge that into your for-v5.10 branch at the
appropriate spot. I don't have anything queued in the EFI tree at the
moment, and so these changes can happily go through the riscv tree, as
long as I am not forced to merge a bunch of unrelated changes on the
off chance that something does come up.


> ---
>  drivers/firmware/efi/Makefile                   | 2 +-
>  drivers/firmware/efi/{arm-init.c => efi-init.c} | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename drivers/firmware/efi/{arm-init.c => efi-init.c} (100%)
>
> diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
> index 7a216984552b..61fd1e8b26fb 100644
> --- a/drivers/firmware/efi/Makefile
> +++ b/drivers/firmware/efi/Makefile
> @@ -32,7 +32,7 @@ obj-$(CONFIG_EFI_EMBEDDED_FIRMWARE)   += embedded-firmware.o
>  fake_map-y                             += fake_mem.o
>  fake_map-$(CONFIG_X86)                 += x86_fake_mem.o
>
> -arm-obj-$(CONFIG_EFI)                  := arm-init.o arm-runtime.o
> +arm-obj-$(CONFIG_EFI)                  := efi-init.o arm-runtime.o
>  obj-$(CONFIG_ARM)                      += $(arm-obj-y)
>  obj-$(CONFIG_ARM64)                    += $(arm-obj-y)
>  obj-$(CONFIG_EFI_CAPSULE_LOADER)       += capsule-loader.o
> diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/efi-init.c
> similarity index 100%
> rename from drivers/firmware/efi/arm-init.c
> rename to drivers/firmware/efi/efi-init.c
> --
> 2.24.0
>
