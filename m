Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFEB1DE7CD
	for <lists+linux-efi@lfdr.de>; Fri, 22 May 2020 15:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbgEVNN1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 22 May 2020 09:13:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:48784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729334AbgEVNN0 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 22 May 2020 09:13:26 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B4FB206B6
        for <linux-efi@vger.kernel.org>; Fri, 22 May 2020 13:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590153206;
        bh=4Ix3Yd4jxfj9dXNrnRqLAF0rlISJYziH1M/Nj5bJRuk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h3vtnMfIhHnHl6pG3Gn8dsinWuyfWuc6YqEd7xDT2mnidsV7gEDCfR5XGfrtUbqCt
         tZOA/ifWP7Kknp7A6//5DQz5tVnFhkl4OjGiMfnRyhTh7pBT3X5wmaGLw43dWSmSIS
         9Kbl0qcenGlk4WACfyLD3qHPtPDyZ2UOcWmNW08c=
Received: by mail-io1-f44.google.com with SMTP id h10so11249385iob.10
        for <linux-efi@vger.kernel.org>; Fri, 22 May 2020 06:13:26 -0700 (PDT)
X-Gm-Message-State: AOAM532GKLivc8Pel4jtYJim/beUUuVqqIi93y7V4rWK8dS0uxmA/w5e
        o8yckar6BTurLH9P5UhTY/t31Qay7K2tzJF5y0Y=
X-Google-Smtp-Source: ABdhPJygKX0VbE7/2IrBNpx7XiupEjZeqrw/D8VhDHQV1vGvcazUBlENrGbPzK+8+1SYT/RIoPdKYsRRaVJN5UVcmCU=
X-Received: by 2002:a05:6602:2dcd:: with SMTP id l13mr3014721iow.203.1590153205732;
 Fri, 22 May 2020 06:13:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj1kXGuM6sEE5HoAmGP7EZDnyUsW73FH+f2C_MvH76UCMYkpg@mail.gmail.com>
 <20200521002921.69650-1-nivedita@alum.mit.edu>
In-Reply-To: <20200521002921.69650-1-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 22 May 2020 15:13:14 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFCfPiA+WMsuTVDRtVCib2n06aHasXCiewdsB=KsqinLA@mail.gmail.com>
Message-ID: <CAMj1kXFCfPiA+WMsuTVDRtVCib2n06aHasXCiewdsB=KsqinLA@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: Don't parse overlong command lines
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 21 May 2020 at 02:29, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> Check if the command line passed in is larger than COMMAND_LINE_SIZE,
> and truncate it to the last full argument if so.
>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

Queued up in efi/next, thanks.

> ---
>  .../firmware/efi/libstub/efi-stub-helper.c    | 28 +++++++++++++++----
>  1 file changed, 23 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> index 2a6aded4f2a9..89f075275300 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> @@ -9,10 +9,12 @@
>
>  #include <stdarg.h>
>
> +#include <linux/ctype.h>
>  #include <linux/efi.h>
>  #include <linux/kernel.h>
>  #include <linux/printk.h> /* For CONSOLE_LOGLEVEL_* */
>  #include <asm/efi.h>
> +#include <asm/setup.h>
>
>  #include "efistub.h"
>
> @@ -216,22 +218,33 @@ char *efi_convert_cmdline(efi_loaded_image_t *image, int *cmd_line_len)
>         unsigned long cmdline_addr = 0;
>         int options_chars = efi_table_attr(image, load_options_size) / 2;
>         const u16 *options = efi_table_attr(image, load_options);
> -       int options_bytes = 0;  /* UTF-8 bytes */
> +       int options_bytes = 0, safe_options_bytes = 0;  /* UTF-8 bytes */
> +       bool in_quote = false;
>         efi_status_t status;
>
>         if (options) {
>                 s2 = options;
> -               while (options_chars--) {
> +               while (options_bytes < COMMAND_LINE_SIZE && options_chars--) {
>                         u16 c = *s2++;
>
> -                       if (c == L'\0' || c == L'\n')
> -                               break;
> +                       if (c < 0x80) {
> +                               if (c == L'\0' || c == L'\n')
> +                                       break;
> +                               if (c == L'"')
> +                                       in_quote = !in_quote;
> +                               else if (!in_quote && isspace((char)c))
> +                                       safe_options_bytes = options_bytes;
> +
> +                               options_bytes++;
> +                               continue;
> +                       }
> +
>                         /*
>                          * Get the number of UTF-8 bytes corresponding to a
>                          * UTF-16 character.
>                          * The first part handles everything in the BMP.
>                          */
> -                       options_bytes += 1 + (c >= 0x80) + (c >= 0x800);
> +                       options_bytes += 2 + (c >= 0x800);
>                         /*
>                          * Add one more byte for valid surrogate pairs. Invalid
>                          * surrogates will be replaced with 0xfffd and take up
> @@ -252,6 +265,11 @@ char *efi_convert_cmdline(efi_loaded_image_t *image, int *cmd_line_len)
>                                 }
>                         }
>                 }
> +               if (options_bytes >= COMMAND_LINE_SIZE) {
> +                       options_bytes = safe_options_bytes;
> +                       efi_err("Command line is too long: truncated to %d bytes\n",
> +                               options_bytes);
> +               }
>         }
>
>         options_bytes++;        /* NUL termination */
> --
> 2.26.2
>
