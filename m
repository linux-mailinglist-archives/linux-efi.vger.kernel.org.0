Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E038F1E5799
	for <lists+linux-efi@lfdr.de>; Thu, 28 May 2020 08:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbgE1GfE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 28 May 2020 02:35:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:40382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgE1GfD (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 28 May 2020 02:35:03 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00181207D3;
        Thu, 28 May 2020 06:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590647703;
        bh=NuGCPmxAGBI2XK8Nm9wCfXWioEgp2KAM821Yx4GB6vY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hBkGKwKaOLoXTSF2wTsqB3XRiFaK9iNxYq4NWm8JGcWnlrm4CKncsJCylmJkXMdel
         SpQ/qZUXC0Z78TuhINGVMQ94Vu/RvBi4+0KYrIyOZwediIFmRY+Jv7Aol/OfdTUDgr
         ytFM2BNE7Bjq5YA7WBPLJRAsmyTMb3b37fqQLi+A=
Received: by mail-io1-f42.google.com with SMTP id c8so8427529iob.6;
        Wed, 27 May 2020 23:35:02 -0700 (PDT)
X-Gm-Message-State: AOAM530keRgFmV+8xsMlkiuBRXWK+Xl3Celi6A4oK95yBvx2H1WGzyZP
        ZO8jxFC6M0ONnrHek7cB6Guba1khrm9VUVUpjhM=
X-Google-Smtp-Source: ABdhPJznn4Cx3G1U8IfKievX2GTQvjlLB94d6qrtuij0ra7aauuhDyzjASGycwEt2xh3e/kXI5QpCJHBTCdgwh4eNYM=
X-Received: by 2002:a02:3341:: with SMTP id k1mr1322375jak.74.1590647702377;
 Wed, 27 May 2020 23:35:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4hO1XEMHPLY-W6g_=TK2Dv=rLgJoVeKrBEHP63zTeq-sA@mail.gmail.com>
 <20200527232602.21596-1-nivedita@alum.mit.edu>
In-Reply-To: <20200527232602.21596-1-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 28 May 2020 08:34:50 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH+FAdSbM7BEmMY7KOKnuUetx8zo42zPuhfnmf206AunQ@mail.gmail.com>
Message-ID: <CAMj1kXH+FAdSbM7BEmMY7KOKnuUetx8zo42zPuhfnmf206AunQ@mail.gmail.com>
Subject: Re: [PATCH] efi/x86: Don't blow away existing initrd
To:     Arvind Sankar <nivedita@alum.mit.edu>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Borislav Petkov <bp@alien8.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

(+ Stephen, Boris)

On Thu, 28 May 2020 at 01:26, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> Commit
>   987053a30016 ("efi/x86: Move command-line initrd loading to efi_main")
> moved the command-line initrd loading into efi_main, with a check to
> ensure that it was attempted only if the EFI stub was booted via
> efi_pe_entry rather than the EFI handover entry.
>
> However, in the case where it was booted via handover entry, and thus an
> initrd may have already been loaded by the bootloader, it then wrote 0
> for the initrd address and size, removing any existing initrd.
>
> Fix this by checking if size is positive before setting the fields in
> the bootparams structure.
>
> Fixes: 987053a30016 ("efi/x86: Move command-line initrd loading to efi_main")
> Reported-by: Dan Williams <dan.j.williams@intel.com>
> Tested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

Apologies to all for the breakage, and for not catching this in review.

Ingo, Thomas, Boris: please apply this directly to efi/core asap.

Stephen: gives that this breaks the boot for a lot of people, you
might want to pull this into -next directly.

Thanks,
Ard.


> ---
>  drivers/firmware/efi/libstub/x86-stub.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index 072b7cf40475..ceb8e16c8b75 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -774,10 +774,12 @@ unsigned long efi_main(efi_handle_t handle,
>                         efi_err("Failed to load initrd!\n");
>                         goto fail;
>                 }
> -               efi_set_u64_split(addr, &hdr->ramdisk_image,
> -                                 &boot_params->ext_ramdisk_image);
> -               efi_set_u64_split(size, &hdr->ramdisk_size,
> -                                 &boot_params->ext_ramdisk_size);
> +               if (size > 0) {
> +                       efi_set_u64_split(addr, &hdr->ramdisk_image,
> +                                         &boot_params->ext_ramdisk_image);
> +                       efi_set_u64_split(size, &hdr->ramdisk_size,
> +                                         &boot_params->ext_ramdisk_size);
> +               }
>         }
>
>         /*
> --
> 2.26.2
>
