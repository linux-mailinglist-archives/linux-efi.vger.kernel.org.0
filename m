Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7E61BE6F1
	for <lists+linux-efi@lfdr.de>; Wed, 29 Apr 2020 21:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgD2THo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Apr 2020 15:07:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:44590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbgD2THo (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 29 Apr 2020 15:07:44 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 935B1205C9;
        Wed, 29 Apr 2020 19:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588187263;
        bh=70/Qtp8JNfEX5//G0orLObh5VqUnEg2kq8b3aA7czoY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q/edQAiHUPqyTnynxIRYwuRac0ucWkio5V94MHB7kJseis6f1V90xV0iEu2r9m+uX
         KiuGO3wIKMzBR0aDv270D070dzx7C8O7JPNsDxe4D6B3gAEG/cU0YFoTfmP4myHWDN
         LlSyURB3frGzdbehjRakvrcIsNmhGCs1RA0wwt70=
Received: by mail-io1-f52.google.com with SMTP id w4so3455517ioc.6;
        Wed, 29 Apr 2020 12:07:43 -0700 (PDT)
X-Gm-Message-State: AGi0PuadGohAyjHpF6DUIyxovgZuG1Ce4jE3j08Og16N+2m1pCpmGt3R
        3UNcTf78CSB4eC4iWgufPpzm3qkKdSnK1VcfQQs=
X-Google-Smtp-Source: APiQypIjDe2LaryNktyvdsE5AqmMfsCyjNFIxAp+7DQaFSQDI81FXSIlPfXk/ajIyUPs96MPgeNC7JKPCMFOOO4hwBM=
X-Received: by 2002:a02:8247:: with SMTP id q7mr9982215jag.68.1588187263019;
 Wed, 29 Apr 2020 12:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200429174120.1497212-1-nivedita@alum.mit.edu> <20200429174120.1497212-11-nivedita@alum.mit.edu>
In-Reply-To: <20200429174120.1497212-11-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 29 Apr 2020 21:07:32 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF_-ZA4ghy_8Gx831UcAwn0VjFmDub5L1_h28vV+sdPDw@mail.gmail.com>
Message-ID: <CAMj1kXF_-ZA4ghy_8Gx831UcAwn0VjFmDub5L1_h28vV+sdPDw@mail.gmail.com>
Subject: Re: [PATCH 09/10] efi/x86: Support builtin command line
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 29 Apr 2020 at 19:41, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> Add support for the x86 CMDLINE_BOOL and CMDLINE_OVERRIDE configuration
> options.
>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> ---
>  drivers/firmware/efi/libstub/x86-stub.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index 85a924fecc87..0faba30d6406 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -680,7 +680,6 @@ unsigned long efi_main(efi_handle_t handle,
>         unsigned long buffer_start, buffer_end;
>         struct setup_header *hdr = &boot_params->hdr;
>         efi_status_t status;
> -       unsigned long cmdline_paddr;
>
>         efi_system_table = sys_table_arg;
>
> @@ -739,9 +738,14 @@ unsigned long efi_main(efi_handle_t handle,
>                 image_offset = 0;
>         }
>
> -       cmdline_paddr = ((u64)hdr->cmd_line_ptr |
> -                        ((u64)boot_params->ext_cmd_line_ptr << 32));
> -       efi_parse_options((char *)cmdline_paddr);
> +#ifdef CONFIG_CMDLINE_BOOL
> +       efi_parse_options(CONFIG_CMDLINE);
> +#endif

Can we use IS_ENABLED() here as well?

> +       if (!IS_ENABLED(CONFIG_CMDLINE_OVERRIDE)) {
> +               unsigned long cmdline_paddr = ((u64)hdr->cmd_line_ptr |
> +                                              ((u64)boot_params->ext_cmd_line_ptr << 32));
> +               efi_parse_options((char *)cmdline_paddr);
> +       }
>
>         /*
>          * At this point, an initrd may already have been loaded by the
> --
> 2.26.2
>
