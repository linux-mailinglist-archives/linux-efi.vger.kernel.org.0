Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9BE1C4FA0
	for <lists+linux-efi@lfdr.de>; Tue,  5 May 2020 09:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgEEHvL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 5 May 2020 03:51:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:43648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727784AbgEEHvK (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 5 May 2020 03:51:10 -0400
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A992E2075A;
        Tue,  5 May 2020 07:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588665069;
        bh=jc+H61N9vNsq7z6RWa8sVHyNz5abdZOteKU9Ks7UD2o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dT/T1VRCyX6urOLpGh8Qqe/AGU8FLYkvpxCqNRT3e/RZpEq7ubRnwEbK6KLodRQfK
         rOeKTs2jOdGGJdtH2s5GSKH/adp6pSYpLR0DwLWszmd07GamjXiYb1VSaezS7ILqNj
         tOHWJcBalmMJtTg35IVKzDL4yBMonGgY+JMCs38E=
Received: by mail-il1-f179.google.com with SMTP id x2so147572ilp.13;
        Tue, 05 May 2020 00:51:09 -0700 (PDT)
X-Gm-Message-State: AGi0PuYFMrKZurVXdPr5nxygwduwmXzp/n9EvKDd3j9mE1YCVxew4gFu
        nbQ+eHZHivmePQVnFEHLnNyTF8Ns22mz338miyY=
X-Google-Smtp-Source: APiQypKmBGnftntz4dokwvJE/6EYRD4xwAb8w3zjNrSiqbYOWOIaqAG+92Pnmf8Y+LYP2xpDueVpen4xanrngfwBUFA=
X-Received: by 2002:a92:405:: with SMTP id 5mr2256629ile.279.1588665069102;
 Tue, 05 May 2020 00:51:09 -0700 (PDT)
MIME-Version: 1.0
References: <091e3fc3bdbc5f480af7d3b3ac096d174a4480d0.1588273612.git.joe@perches.com>
 <ec53e67b3ac928922807db3cb1585e911971dadc.1588273612.git.joe@perches.com>
 <CAMj1kXHwdy3BTqt-q_qnezyz666BcqKiFxeumfsD+Qjy5qRzZA@mail.gmail.com> <f1926d434cdeb091405ef8c01a90c0140d296bed.camel@perches.com>
In-Reply-To: <f1926d434cdeb091405ef8c01a90c0140d296bed.camel@perches.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 5 May 2020 09:50:58 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGQ7dLNMnheWViBh7BnHd00kWw0AW2aF7i7S2wGti0qKg@mail.gmail.com>
Message-ID: <CAMj1kXGQ7dLNMnheWViBh7BnHd00kWw0AW2aF7i7S2wGti0qKg@mail.gmail.com>
Subject: Re: [trivial PATCH] efi/libstub: Reduce efi_printk object size
To:     Joe Perches <joe@perches.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 4 May 2020 at 20:29, Joe Perches <joe@perches.com> wrote:
>
> Use a few more common kernel styles.
>
> Trivially reduce efi_printk object size by using a dereference to
> a temporary instead of multiple dereferences of the same object.
>
> Use efi_printk(const char *str) and static or static const for its
> internal variables.
>
> Use the more common form of while instead of a for loop.
>
> Change efi_char16_printk argument to const.
>
> Signed-off-by: Joe Perches <joe@perches.com>

Thanks Joe.


> ---
>  drivers/firmware/efi/libstub/efi-stub-helper.c | 16 ++++++++--------
>  drivers/firmware/efi/libstub/efistub.h         |  6 +++---
>  2 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> index 1c92ac231f94..dfd72a4360ac 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> @@ -26,19 +26,19 @@ bool __pure __efi_soft_reserve_enabled(void)
>         return !efi_nosoftreserve;
>  }
>
> -void efi_printk(char *str)
> +void efi_printk(const char *str)
>  {
> -       char *s8;
> +       char s8;
>
> -       for (s8 = str; *s8; s8++) {
> -               efi_char16_t ch[2] = { 0 };
> +       while ((s8 = *str++)) {

I'm not sure I prefer the assignment-as-truth-value construct over the
original for () tbh

> +               static efi_char16_t ch[2] = {0, 0};
>

UEFI code could potentially be reentrant, so this should not be static.

> -               ch[0] = *s8;
> -               if (*s8 == '\n') {
> -                       efi_char16_t nl[2] = { '\r', 0 };
> +               if (s8 == '\n') {
> +                       static const efi_char16_t nl[2] = { '\r', 0 };
>                         efi_char16_printk(nl);

We cannot make this const, unfortunately (see below). But we can clean
this up by using L"\r" as the initializer.

>                 }
>
> +               ch[0] = s8;
>                 efi_char16_printk(ch);
>         }
>  }
> @@ -284,7 +284,7 @@ void *get_efi_config_table(efi_guid_t guid)
>         return NULL;
>  }
>
> -void efi_char16_printk(efi_char16_t *str)
> +void efi_char16_printk(const efi_char16_t *str)
>  {
>         efi_call_proto(efi_table_attr(efi_system_table, con_out),
>                        output_string, str);
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index 5ff63230a1f1..a03a92c665f0 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -251,7 +251,7 @@ union efi_simple_text_output_protocol {
>         struct {
>                 void *reset;
>                 efi_status_t (__efiapi *output_string)(efi_simple_text_output_protocol_t *,
> -                                                      efi_char16_t *);
> +                                                      const efi_char16_t *);

This prototype comes straight from the UEFI specification, and even
though it is dumb that they forgot about const-qualified pointers
entirely, I would prefer not to deviate from this.

>                 void *test_string;
>         };
>         struct {
> @@ -599,7 +599,7 @@ efi_status_t efi_exit_boot_services(void *handle,
>                                     void *priv,
>                                     efi_exit_boot_map_processing priv_func);
>
> -void efi_char16_printk(efi_char16_t *);
> +void efi_char16_printk(const efi_char16_t *str);
>
>  efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
>                                             unsigned long *new_fdt_addr,
> @@ -624,7 +624,7 @@ efi_status_t check_platform_features(void);
>
>  void *get_efi_config_table(efi_guid_t guid);
>
> -void efi_printk(char *str);
> +void efi_printk(const char *str);
>
>  void efi_free(unsigned long size, unsigned long addr);
>
>
