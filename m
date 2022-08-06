Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0999A58B874
	for <lists+linux-efi@lfdr.de>; Sat,  6 Aug 2022 23:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbiHFViQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 6 Aug 2022 17:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiHFViP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 6 Aug 2022 17:38:15 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE53FB1CB;
        Sat,  6 Aug 2022 14:38:13 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id o1so4166653qkg.9;
        Sat, 06 Aug 2022 14:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=MfKNCdoirxc2xo2dJ2ZnrKHYVycXxfrXH8JNH8fm1Y8=;
        b=YBzle4Bzk8bMM2eG1wG0QftAx91m2KHC2NzsZY+bkn3ddnh1U940M/jxSnYcV7UjIc
         pKdr3JCm6dxKjr9Hb2YoyGGOlso4bztjd2UILk6zq6O2FGtlS2u6FlMhyadpHXVi+OQ4
         VLFnXJt0xdQYzrfMfNi5GuvEG+2nm5LIWyd/WwVe/+vURptktX6hP5gZ+kqvBnq5GW/x
         uOYMEySPd9JJ4EjR9eel8ie2TJuDeTQgonSosqk441GIXY39IMjaq9ezX4siGpJPGaNe
         dumUqe4+XqL9xkAHhTVD7Bi6ZhQIocYnNbNY/wY9R8aWANkblzYAgHFibHzxlMWRpxl6
         C9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=MfKNCdoirxc2xo2dJ2ZnrKHYVycXxfrXH8JNH8fm1Y8=;
        b=jhXM5SpUEo1eSYdwewxz8vqPPgQxhOtjLvk2RQ9XT9GeovHojp1n8IyQhoWaoDt351
         NtFkS1z8g9qheIUKE14Z81XNPmrjf/+qQSIV4EMzYCoGYkiniaxgrSVXmggwBtGIzxWG
         0ig8eQpBDnnFvtH/Mj/FUGC79hnEDLtp0XPC+iceRWD9Wd9L5uOzN6rXhtmfbBy0zcZ1
         dIjmLThx4kmW0zhugu+YCSgfQEBxFTOlsUBOxlUVjktITgacOobFYRiFQ+IfNQjTnsvJ
         ketooLWNvWJdU4KyJVMx2JbcC3DO7GnQzi/ios7D9k2wPtuBMJduQfF4itSX+fvQAt2k
         2Xhg==
X-Gm-Message-State: ACgBeo3rPao2uXUDYvenAs/rDHa+mMWQbEiQmDPj36DVQZAO7IEcw+QD
        PX9Hg1x/2sUV7resEc7qTaNHSevmmAo3RY6VfL8=
X-Google-Smtp-Source: AA6agR56Da74aJjiF+4nLUKRTvJqjbVZJG6Bbd44zgX3ASwhuBBjAStAwYDAMCCSp6ij5AOPtil/tLlaj2OWYcKKILA=
X-Received: by 2002:a05:620a:8018:b0:6b6:5df:977 with SMTP id
 ee24-20020a05620a801800b006b605df0977mr9477710qkb.320.1659821892589; Sat, 06
 Aug 2022 14:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220806163255.10404-1-markuss.broks@gmail.com> <20220806163255.10404-4-markuss.broks@gmail.com>
In-Reply-To: <20220806163255.10404-4-markuss.broks@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 6 Aug 2022 23:37:35 +0200
Message-ID: <CAHp75VcMgFQJoFC68GCTej--44+iFWXEpjh2Q7O0XbHk588OCw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] efi: earlycon: Add support for generic
 framebuffers and move to console subsystem
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Helge Deller <deller@gmx.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Michal Suchanek <msuchanek@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Wei Ming Chen <jj251510319013@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tony Lindgren <tony@atomide.com>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Aug 6, 2022 at 6:38 PM Markuss Broks <markuss.broks@gmail.com> wrote:
>
> Add early console support for generic linear framebuffer devices.
> This driver supports probing from cmdline early parameters
> or from the device-tree using information in simple-framebuffer node.
> The EFI functionality should be retained in whole.
> The driver was disabled on ARM because of a bug in early_ioremap

We refer to functions like func().

> implementation on ARM and on IA64 because of lack of early_memremap_prot.

Ditto.

...

> +#include <asm/early_ioremap.h>

Can it be placed after linux/* ones?

> +#include <linux/console.h>
> +#include <linux/efi.h>
> +#include <linux/font.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/mm.h>
> +#include <linux/of.h>
> +#include <linux/of_fdt.h>
> +#include <linux/serial_core.h>
> +#include <linux/screen_info.h>

...

> +static int __init simplefb_earlycon_remap_fb(void)
> +{
> +       unsigned long mapping;

+ Blank line.

> +       /* bail if there is no bootconsole or it has been disabled already */
> +       if (!earlycon_console || !(earlycon_console->flags & CON_ENABLED))
> +               return 0;
> +
> +       if (region_intersects(info.phys_base, info.size,
> +                             IORESOURCE_SYSTEM_RAM, IORES_DESC_NONE) == REGION_INTERSECTS)
> +               mapping = MEMREMAP_WB;
> +       else
> +               mapping = MEMREMAP_WC;

> +       info.virt_base = memremap(info.phys_base, info.size, mapping);
> +
> +       return info.virt_base ? 0 : -ENOMEM;

Easier to read the standard pattern:

  if (!info.virt_base)
    return -ENOMEM;

  return 0;

> +}

...

> +static void simplefb_earlycon_write_char(u8 *dst, unsigned char c, unsigned int h)
> +{
> +       const u8 *src;
> +       int m, n, bytes;
> +       u8 x;
> +
> +       bytes = BITS_TO_BYTES(font->width);
> +       src = font->data + c * font->height * bytes + h * bytes;
> +
> +       for (m = 0; m < font->width; m++) {
> +               n = m % 8;
> +               x = *(src + m / 8);

I would write it as

  x = src[m / 8];

> +               if ((x >> (7 - n)) & 1)

> +                       memset(dst, 0xff, (info.depth / 8));

Too many parentheses.

> +               else
> +                       memset(dst, 0, (info.depth / 8));

Ditto.

> +               dst += (info.depth / 8);

Ditto.

> +       }
> +}

-- 
With Best Regards,
Andy Shevchenko
