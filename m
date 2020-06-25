Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B1320A2A5
	for <lists+linux-efi@lfdr.de>; Thu, 25 Jun 2020 18:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403863AbgFYQK3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 25 Jun 2020 12:10:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:52692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403837AbgFYQK2 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 25 Jun 2020 12:10:28 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A6B2208C9
        for <linux-efi@vger.kernel.org>; Thu, 25 Jun 2020 16:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593101428;
        bh=QRWwVP2N/HK2xnL6Es861opcmxoYKPQznhrv8Get51k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oOkO95/N6J0eueCrh1cPEk+p8Rrbjf7TX9AuQBdWXDX2dCae5Dg2YiqhkEARf64wo
         6wGfLiXqKwh48MM+74oe3uJ3Hr7bfmqx1QsklzcL+HF3cwJWYkttDWxV6rFSa7XfTK
         xgfnm3dLde/L1nra19qlySUKDFMGjFKZPb4iQpYw=
Received: by mail-ot1-f46.google.com with SMTP id k15so5744656otp.8
        for <linux-efi@vger.kernel.org>; Thu, 25 Jun 2020 09:10:28 -0700 (PDT)
X-Gm-Message-State: AOAM530NoVOR8mm682043kPdyvS/CJUn3/ppmGaCJ6rax5CsVdO6Rqs+
        MO0NcULAA1GyZXDg/fDZy7IHEIZUDwf78iiX3K0=
X-Google-Smtp-Source: ABdhPJyDVdi68dHK7fWuN6SAV484MBQ0RTgKlMSLgFqy7iKm8Lsfj/vM7fEgRf+A5nPleuemc+MP1A1O5s4rTfn3qgo=
X-Received: by 2002:a9d:688:: with SMTP id 8mr7243184otx.108.1593101427432;
 Thu, 25 Jun 2020 09:10:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200618204315.3854787-1-nivedita@alum.mit.edu>
In-Reply-To: <20200618204315.3854787-1-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 25 Jun 2020 18:10:15 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFhsXz3xTY5JWiA_mfdZ_EsMaLm6zXHVDitSCF5o7-obg@mail.gmail.com>
Message-ID: <CAMj1kXFhsXz3xTY5JWiA_mfdZ_EsMaLm6zXHVDitSCF5o7-obg@mail.gmail.com>
Subject: Re: [PATCH] efi/x86: Only copy upto the end of setup_header
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 18 Jun 2020 at 22:43, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> When copying the setup_header into the boot_params buffer, only the data
> that is actually part of the setup_header should be copied.
>
> efi_pe_entry() currently copies the entire second sector, which
> initializes some of the fields in boot_params beyond the setup_header
> with garbage (i.e. part of the real-mode boot code gets copied into
> those fields).
>
> This does not cause any issues currently because the fields that are
> overwritten are padding, BIOS EDD information that won't get used, and
> the E820 table which will get properly filled in later.
>
> Fix this to only copy data that is actually part of the setup_header
> structure.
>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

Queued as a fix, thanks,

> ---
>  drivers/firmware/efi/libstub/x86-stub.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index 37e82bf397aa..3672539cb96e 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -8,6 +8,7 @@
>
>  #include <linux/efi.h>
>  #include <linux/pci.h>
> +#include <linux/stddef.h>
>
>  #include <asm/efi.h>
>  #include <asm/e820/types.h>
> @@ -388,8 +389,9 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
>
>         hdr = &boot_params->hdr;
>
> -       /* Copy the second sector to boot_params */
> -       memcpy(&hdr->jump, image_base + 512, 512);
> +       /* Copy the setup header from the second sector to boot_params */
> +       memcpy(&hdr->jump, image_base + 512,
> +              sizeof(struct setup_header) - offsetof(struct setup_header, jump));
>
>         /*
>          * Fill out some of the header fields ourselves because the
> --
> 2.26.2
>
