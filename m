Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 791071A3B12
	for <lists+linux-efi@lfdr.de>; Thu,  9 Apr 2020 22:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgDIUFr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Apr 2020 16:05:47 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:37486 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgDIUFq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 9 Apr 2020 16:05:46 -0400
Received: by mail-il1-f195.google.com with SMTP id a6so931796ilr.4;
        Thu, 09 Apr 2020 13:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eY4NXfWdxU2CUwlEll88egn0KhohAKVRNqZHn1rtHs0=;
        b=D84IgnWFav8SFYOz9KRCkia4lQVBPZRp0les6nxG/JqT03joqeJisIs/NINduHOlIS
         Byot5Jb6lZjWzexapLrYDGroa/W6CZDSMoiubF2FbFqqMllFy+e3/WsmCGxijA4h2HAD
         Z/n02O0025+PtcL93fQHrkxUjMPl48eAqQXI+ANwU76p4uruERr7nQI3kKS79MRARoQN
         4AAGPL5iJ7i2agq8UeSdtkwEwphwUp7LpxIz3Lo3UoftnMKSxBIxM8bl7S+vPvw5yDzG
         +5UhzR2Ceyo3xyD94QzpIjGNRRl2dd4GLxLddZO5uO/RALjxskbw7R6xQIj6vwwnJ7un
         YOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eY4NXfWdxU2CUwlEll88egn0KhohAKVRNqZHn1rtHs0=;
        b=gzZ6kaT281/gdN7rh/V/9A6CTtc5F7eG+LLL36aXyrhhWCqmGubUca4eC3d9/rUVGM
         jDmZaezmVhkywMkC+7nJyFtVaYRQovPt+Muw9o7xNLqhLVDu4kSfUmUhDTLPJstexVuI
         q5jrTeJoWvfLiLOIpfeh14C/dOK3xgbxNA81qsE1Ld2NOPSTtsesnKBhXIUuk3qGqpTl
         FWfZkDE+O8S8DwNKqDsgDmj243L0nBOpQ4hnB/0jAbMmJ0Vq6ce6gooGzjuv+OtG+RG4
         8HrJl5/uBfUpWjVhTKGhE82C2Y9ypmub7XonkUvIfOjE2+TBKL9KOSEvjVrnxIWiLTgJ
         MMWQ==
X-Gm-Message-State: AGi0PuY+u2or/R+gW25NW/N5JjRtc/O+s1Kp7sG78SlGBC38WBSu8pX3
        v3f7slthZasPSwvoj6IFPvM/LxzqOudRxWJ19g==
X-Google-Smtp-Source: APiQypICxnCx+0c7cm22qQLPOolW5rvfQfgQHaWxlvxF+vJF9GXwvBC7P76mDWFhkSXFGlLHH6n0/6+7it/HkVP0GOQ=
X-Received: by 2002:a92:d28a:: with SMTP id p10mr1456675ilp.191.1586462744487;
 Thu, 09 Apr 2020 13:05:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200409130434.6736-1-ardb@kernel.org> <20200409130434.6736-4-ardb@kernel.org>
In-Reply-To: <20200409130434.6736-4-ardb@kernel.org>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Thu, 9 Apr 2020 16:05:33 -0400
Message-ID: <CAMzpN2gJWwVun1Kp6vGuza9LM5KpB=0EwsP8x8eOJQuDGh38Hg@mail.gmail.com>
Subject: Re: [PATCH 3/9] efi/x86: Move efi stub globals from .bss to .data
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>,
        Colin Ian King <colin.king@canonical.com>,
        Gary Lin <glin@suse.com>, Jiri Slaby <jslaby@suse.cz>,
        Sergey Shatunov <me@prok.pw>, Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Apr 9, 2020 at 9:07 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> From: Arvind Sankar <nivedita@alum.mit.edu>
>
> Commit
>
>   3ee372ccce4d ("x86/boot/compressed/64: Remove .bss/.pgtable from bzImage")
>
> removed the .bss section from the bzImage.
>
> However, while a PE loader is required to zero-initialize the .bss
> section before calling the PE entry point, the EFI handover protocol
> does not currently document any requirement that .bss be initialized by
> the bootloader prior to calling the handover entry.
>
> When systemd-boot is used to boot a unified kernel image [1], the image
> is constructed by embedding the bzImage as a .linux section in a PE
> executable that contains a small stub loader from systemd together with
> additional sections and potentially an initrd. As the .bss section
> within the bzImage is no longer explicitly present as part of the file,
> it is not initialized before calling the EFI handover entry.
> Furthermore, as the size of the embedded .linux section is only the size
> of the bzImage file itself, the .bss section's memory may not even have
> been allocated.
>
> In particular, this can result in efi_disable_pci_dma being true even
> when it was not specified via the command line or configuration option,
> which in turn causes crashes while booting on some systems.
>
> To avoid issues, place all EFI stub global variables into the .data
> section instead of .bss. As of this writing, only boolean flags for a
> few command line arguments and the sys_table pointer were in .bss and
> will now move into the .data section.
>
> [1] https://systemd.io/BOOT_LOADER_SPECIFICATION/#type-2-efi-unified-kernel-images
>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> Reported-by: Sergey Shatunov <me@prok.pw>
> Fixes: 3ee372ccce4d ("x86/boot/compressed/64: Remove .bss/.pgtable from bzImage")
> Link: https://lore.kernel.org/r/20200406180614.429454-1-nivedita@alum.mit.edu
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/firmware/efi/libstub/efistub.h  | 2 +-
>  drivers/firmware/efi/libstub/x86-stub.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index cc90a748bcf0..67d26949fd26 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -25,7 +25,7 @@
>  #define EFI_ALLOC_ALIGN                EFI_PAGE_SIZE
>  #endif
>
> -#ifdef CONFIG_ARM
> +#if defined(CONFIG_ARM) || defined(CONFIG_X86)
>  #define __efistub_global       __section(.data)
>  #else
>  #define __efistub_global
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index e02ea51273ff..867a57e28980 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -20,7 +20,7 @@
>  /* Maximum physical address for 64-bit kernel with 4-level paging */
>  #define MAXMEM_X86_64_4LEVEL (1ull << 46)
>
> -static efi_system_table_t *sys_table;
> +static efi_system_table_t *sys_table __efistub_global;
>  extern const bool efi_is64;
>  extern u32 image_offset;
>
> --
> 2.17.1
>

Can we use the -fno-zero-initialized-in-bss compiler flag instead of
explicitly marking global variables?

--
Brian Gerst
