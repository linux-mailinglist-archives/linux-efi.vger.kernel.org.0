Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 954051DBACC
	for <lists+linux-efi@lfdr.de>; Wed, 20 May 2020 19:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgETRKC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 May 2020 13:10:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:52812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbgETRKC (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 20 May 2020 13:10:02 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BA76206B6
        for <linux-efi@vger.kernel.org>; Wed, 20 May 2020 17:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589994601;
        bh=JnsRf18G+G15FwJFqPdevVrNgkWn5AcgqK/h0uzfPIw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Hl+oagv0K418hPIWJMR9/uYhBX5r5Ch/ycLgT8NbZI0mvbGR4YRSZsSMxca29RBnM
         dLoaAJvSu9jUEkuf7vUFGcocJRb4WaS7PSUClLiOYHqLSXK536ucavLGnPggOafPVi
         R0sfS51El/XXCIv5qnfF9M62kDAXDPUPu2qsYbHg=
Received: by mail-io1-f50.google.com with SMTP id d7so3983150ioq.5
        for <linux-efi@vger.kernel.org>; Wed, 20 May 2020 10:10:01 -0700 (PDT)
X-Gm-Message-State: AOAM533y7wP04Ba3nVi0NkQg5BpwsmKV1y7ZyTHKHi2WJidcXDAVImw4
        F/ggmql+guTN77a0BjpXqJgLAS3BunwuoYTVjEs=
X-Google-Smtp-Source: ABdhPJzqDulrgoeNHOwOV3D5GcOsQ0BtKcNGkMRtdTBx40oI596En9cXO2N6rCBMIIAAbsjcAzsB9vw0ypZU6x9LroM=
X-Received: by 2002:a5e:8705:: with SMTP id y5mr4325009ioj.142.1589994600847;
 Wed, 20 May 2020 10:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200518190716.751506-1-nivedita@alum.mit.edu>
 <20200518190716.751506-18-nivedita@alum.mit.edu> <CAMj1kXE=YowWg2CbqXVhPcXoq3eZdowzTnGxLkpD5xcf29fHhw@mail.gmail.com>
 <20200519150755.GC1526900@rani.riverdale.lan> <20200520163808.GA3274869@rani.riverdale.lan>
 <CAMj1kXG2h=x9sfu0ELyUyveu_1hU5qiuRkQXf8Y4dnRPErb3Xw@mail.gmail.com> <20200520170223.GA3333632@rani.riverdale.lan>
In-Reply-To: <20200520170223.GA3333632@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 20 May 2020 19:09:49 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEZv7u8+eTXOLBGZwbdVff-sP3PTNN73gib85VqvACcEQ@mail.gmail.com>
Message-ID: <CAMj1kXEZv7u8+eTXOLBGZwbdVff-sP3PTNN73gib85VqvACcEQ@mail.gmail.com>
Subject: Re: [PATCH 17/24] efi/libstub: Implement printk-style logging
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 20 May 2020 at 19:02, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Wed, May 20, 2020 at 06:38:53PM +0200, Ard Biesheuvel wrote:
> > On Wed, 20 May 2020 at 18:38, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > On Tue, May 19, 2020 at 11:07:55AM -0400, Arvind Sankar wrote:
> > > > On Tue, May 19, 2020 at 10:22:40AM +0200, Ard Biesheuvel wrote:
> > > > > On Mon, 18 May 2020 at 21:07, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > > > > @@ -100,7 +123,9 @@ efi_status_t efi_parse_options(char const *cmdline)
> > > > > >                 if (!strcmp(param, "nokaslr")) {
> > > > > >                         efi_nokaslr = true;
> > > > > >                 } else if (!strcmp(param, "quiet")) {
> > > > > > -                       efi_quiet = true;
> > > > > > +                       efi_loglevel = CONSOLE_LOGLEVEL_QUIET;
> > > > > > +               } else if (!strcmp(param, "debug")) {
> > > > > > +                       efi_loglevel = CONSOLE_LOGLEVEL_DEBUG;
> > > > >
> > > > > Should we wire this to 'efi=debug' instead?
> > > > >
> > > >
> > > > Sure.
> > >
> > > Do you prefer it wired up to both or just efi=debug?
> > >
> >
> > Let's stick with efi=debug, that is what all other EFI code uses.
>
> Ok -- you can replace the patch with the attached version. Only change
> is in efi_parse_options.
>

Done - thanks!


> Author: Arvind Sankar <nivedita@alum.mit.edu>
> Date:   Thu May 14 19:33:39 2020 -0400
>
>     efi/libstub: Implement printk-style logging
>
>     Use the efi_printk function in efi_info/efi_err, and add efi_debug. This
>     allows formatted output at different log levels.
>
>     Add the notion of a loglevel instead of just quiet/not-quiet, and
>     parse the efi=debug kernel parameter in addition to quiet.
>
>     Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
>
> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> index 5ecafc57619a..1f5a00b4f201 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> @@ -11,6 +11,7 @@
>
>  #include <linux/efi.h>
>  #include <linux/kernel.h>
> +#include <linux/printk.h> /* For CONSOLE_LOGLEVEL_* */
>  #include <asm/efi.h>
>
>  #include "efistub.h"
> @@ -18,7 +19,7 @@
>  bool efi_nochunk;
>  bool efi_nokaslr;
>  bool efi_noinitrd;
> -bool efi_quiet;
> +int efi_loglevel = CONSOLE_LOGLEVEL_DEFAULT;
>  bool efi_novamap;
>
>  static bool efi_nosoftreserve;
> @@ -58,6 +59,28 @@ int efi_printk(const char *fmt, ...)
>         char printf_buf[256];
>         va_list args;
>         int printed;
> +       int loglevel = printk_get_level(fmt);
> +
> +       switch (loglevel) {
> +       case '0' ... '9':
> +               loglevel -= '0';
> +               break;
> +       default:
> +               /*
> +                * Use loglevel -1 for cases where we just want to print to
> +                * the screen.
> +                */
> +               loglevel = -1;
> +               break;
> +       }
> +
> +       if (loglevel >= efi_loglevel)
> +               return 0;
> +
> +       if (loglevel >= 0)
> +               efi_puts("EFI stub: ");
> +
> +       fmt = printk_skip_level(fmt);
>
>         va_start(args, fmt);
>         printed = vsnprintf(printf_buf, sizeof(printf_buf), fmt, args);
> @@ -100,7 +123,7 @@ efi_status_t efi_parse_options(char const *cmdline)
>                 if (!strcmp(param, "nokaslr")) {
>                         efi_nokaslr = true;
>                 } else if (!strcmp(param, "quiet")) {
> -                       efi_quiet = true;
> +                       efi_loglevel = CONSOLE_LOGLEVEL_QUIET;
>                 } else if (!strcmp(param, "noinitrd")) {
>                         efi_noinitrd = true;
>                 } else if (!strcmp(param, "efi") && val) {
> @@ -114,6 +137,8 @@ efi_status_t efi_parse_options(char const *cmdline)
>                                 efi_disable_pci_dma = true;
>                         if (parse_option_str(val, "no_disable_early_pci_dma"))
>                                 efi_disable_pci_dma = false;
> +                       if (parse_option_str(val, "debug"))
> +                               efi_loglevel = CONSOLE_LOGLEVEL_DEBUG;
>                 } else if (!strcmp(param, "video") &&
>                            val && strstarts(val, "efifb:")) {
>                         efi_parse_option_graphics(val + strlen("efifb:"));
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index caa7dcc71c69..3a323a009836 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -6,6 +6,7 @@
>  #include <linux/compiler.h>
>  #include <linux/efi.h>
>  #include <linux/kernel.h>
> +#include <linux/kern_levels.h>
>  #include <linux/types.h>
>  #include <asm/efi.h>
>
> @@ -34,7 +35,7 @@
>  extern bool efi_nochunk;
>  extern bool efi_nokaslr;
>  extern bool efi_noinitrd;
> -extern bool efi_quiet;
> +extern int efi_loglevel;
>  extern bool efi_novamap;
>
>  extern const efi_system_table_t *efi_system_table;
> @@ -49,11 +50,12 @@ extern const efi_system_table_t *efi_system_table;
>
>  #endif
>
> -#define efi_info(msg)          do {                    \
> -       if (!efi_quiet) efi_puts("EFI stub: "msg);      \
> -} while (0)
> -
> -#define efi_err(msg) efi_puts("EFI stub: ERROR: "msg)
> +#define efi_info(fmt, ...) \
> +       efi_printk(KERN_INFO fmt, ##__VA_ARGS__)
> +#define efi_err(fmt, ...) \
> +       efi_printk(KERN_ERR "ERROR: " fmt, ##__VA_ARGS__)
> +#define efi_debug(fmt, ...) \
> +       efi_printk(KERN_DEBUG "DEBUG: " fmt, ##__VA_ARGS__)
>
>  /* Helper macros for the usual case of using simple C variables: */
>  #ifndef fdt_setprop_inplace_var
