Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF8C58479B
	for <lists+linux-efi@lfdr.de>; Thu, 28 Jul 2022 23:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbiG1VUh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 28 Jul 2022 17:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiG1VUf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 28 Jul 2022 17:20:35 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5DB51434;
        Thu, 28 Jul 2022 14:20:34 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id ss3so5207032ejc.11;
        Thu, 28 Jul 2022 14:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=jAkPCigVLHrBtqVHphR26WDxi2DiUpnm1/Y0dqLKCmQ=;
        b=KbVm0qMVYx6vAxplpGdfXideOWadbCD17AoB6s1oPdJt9SKVU6HKNYR+4upp5Hraox
         rKn4Zxp0+fUK/toeW5i8cJnWIhfI0ZlJoGYsTejB23pW7LPgvi2BEHFLsCJ30EI6/tpC
         Ub2FuHYTmWrmJiwVXW5rd62zdJeSf3dY11EDMoJeJs90LjYKh3CbamhFS7B6ycXjB3kp
         L35BWmWGVi7yBMK/dodfGmDAXhcPMSzTNNe8Eu9EKUMyWYxlTEztLZ+xLdQy1jL+hyX1
         lt6JMpN1t2Uam6JuAofdK4MkGDtJ7PppBxIsmz5MPyCUsCNCQeKHqF/tMphkBPD43xWL
         Nlzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=jAkPCigVLHrBtqVHphR26WDxi2DiUpnm1/Y0dqLKCmQ=;
        b=XDew0GcjYuavl/cd3wQcgFkuf1xZmb9gBt9MFhTiWhmOTlcvOvQ2AQ5P/IppKurunR
         K3hrIcICoW7sgeieFzXqiQnm2Wi167NbpIjFV3tmBsnhFuecw75G/KpptR4TkgyHngaN
         WMcTn6qZTQDbfFt6nUdd9uJct5r7S4a8Sk9Aa+pkUMKyBRebZCAv7KzEI18/A8bmclE/
         wgIyg1MM+GWTGzxlatV0LlZcU4IRMp6TYTwp+Bp6lT9vHU0XZ84iKj9hU9JO2aLk4rRM
         LghoYj+6pB42phIVM9dxV6X3fY5jNNViIpa1aMDXEmVhTdxTGyop8km/uBHZJfA/1g2P
         Egag==
X-Gm-Message-State: AJIora+ZwR2RRYoMFm5nYsb6LoVXg7bVzWfefQ2pFOWEQ0fLjU4pMXOm
        zjG3GI4/0LPhcMd68o5TfTD6k7EwpEOUS9cg7tg=
X-Google-Smtp-Source: AGRyM1te7Y5AHT6zHCE8M+M/Z37sGPGv8DKdrNYWIqZIHSDo7p9FDRZzoAwJaLCAER4a8q5/V+tMn3CP6GPk0Cf8U7Q=
X-Received: by 2002:a17:907:28d6:b0:72b:7497:76b with SMTP id
 en22-20020a17090728d600b0072b7497076bmr559720ejc.365.1659043232735; Thu, 28
 Jul 2022 14:20:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220728142824.3836-1-markuss.broks@gmail.com> <20220728142824.3836-3-markuss.broks@gmail.com>
In-Reply-To: <20220728142824.3836-3-markuss.broks@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 28 Jul 2022 23:19:55 +0200
Message-ID: <CAHp75VdaDyyqRw9fAkUOhNjsyifeozVx6JuYXSU1HpoO+VHDNA@mail.gmail.com>
Subject: Re: [PATCH 2/2] efi: earlycon: Add support for generic framebuffers
 and move to fbdev subsystem
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
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Michal Suchanek <msuchanek@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Wei Ming Chen <jj251510319013@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tony Lindgren <tony@atomide.com>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jul 28, 2022 at 4:32 PM Markuss Broks <markuss.broks@gmail.com> wrote:
>
> Add early console support for generic linear framebuffer devices.
> This driver supports probing from cmdline early parameters
> or from the device-tree using information in simple-framebuffer node.
> The EFI functionality should be retained in whole.
> The driver was disabled on ARM because of a bug in early_ioremap
> implementation on ARM.

...

> -               efifb,[options]
> +               efifb
>                         Start an early, unaccelerated console on the EFI
> -                       memory mapped framebuffer (if available). On cache
> -                       coherent non-x86 systems that use system memory for
> -                       the framebuffer, pass the 'ram' option so that it is
> -                       mapped with the correct attributes.
> +                       memory mapped framebuffer (if available).

If somebody passes those (legacy) options, what will happen?

...

>  config EFI_EARLYCON
> -       def_bool y
> -       depends on SERIAL_EARLYCON && !ARM && !IA64
> -       select FONT_SUPPORT
> -       select ARCH_USE_MEMREMAP_PROT
> +       bool "EFI early console support"
> +       depends on FB_EARLYCON && !IA64

This doesn't sound right. Previously on my configuration it was
selected automatically, now I need to select it explicitly? I mean
that for me EFI_EARLYCON should be selected by default as it was
before.

...

> +static int __init simplefb_earlycon_remap_fb(void)
> +{
> +       int is_ram;

+ blank line.

> +       /* bail if there is no bootconsole or it has been disabled already */
> +       if (!earlycon_console || !(earlycon_console->flags & CON_ENABLED))
> +               return 0;
> +
> +       is_ram = region_intersects(info.phys_base, info.size,
> +                                  IORESOURCE_SYSTEM_RAM, IORES_DESC_NONE);
> +       is_ram = is_ram == REGION_INTERSECTS;

Was it in the original code? Otherwise, I would go with plain conditional:

  if (region_intersects())
    base = ...
  else
    base = ...

> +       info.virt_base = memremap(info.phys_base, info.size,
> +                                 is_ram ? MEMREMAP_WB : MEMREMAP_WC);
> +
> +       return info.virt_base ? 0 : -ENOMEM;
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
> +               if ((x >> (7 - n)) & 1)
> +                       memset(dst, 0xff, (info.depth / 8));
> +               else
> +                       memset(dst, 0, (info.depth / 8));
> +               dst += (info.depth / 8);
> +       }
> +}

Wondering if we already have something like this in DRM/fbdev and can
split into a generic helper.

...

> +       ret = sscanf(device->options, "%u,%u,%u", &info.x, &info.y, &info.depth);
> +       if (ret != 3)
> +               return -ENODEV;

Don't we have some standard template of this, something like XxYxD,
where X, Y, and D are respective decimal numbers?

-- 
With Best Regards,
Andy Shevchenko
