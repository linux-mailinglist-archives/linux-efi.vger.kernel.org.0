Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B19223D89E9
	for <lists+linux-efi@lfdr.de>; Wed, 28 Jul 2021 10:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbhG1IjO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-efi@lfdr.de>); Wed, 28 Jul 2021 04:39:14 -0400
Received: from mail-vs1-f52.google.com ([209.85.217.52]:34632 "EHLO
        mail-vs1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234207AbhG1IjO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 28 Jul 2021 04:39:14 -0400
Received: by mail-vs1-f52.google.com with SMTP id y18so990934vsc.1;
        Wed, 28 Jul 2021 01:39:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yVmhrRbJkvgpIhHEAfbGhWQBI7I0jYe3w6v9jo77iwE=;
        b=sKxXEB0p7o0zlVd0I4e2lBNZObdJdxiYaMBNWcPzpfIZIR5xPiuvC56P9cvCuu9ILx
         Vhc9QBsbpYbrgfz6H37IzDkWv6FjlOoacwz680mKx3DBM280LXXGB4n+q3lPwRmQJt9F
         yElBNeqfpOtQMzqhtHcHPfAcpBGOrMYNUXHKhgBpYccyoQha5ROMMpgAQ1GS9QbmTHvC
         pTl2syQYQukzDCud3ivxQXE5WsLaXTJ4lMb5ubrQbfhmvkG417imY7W7ekJ07to+f/7C
         HlS4oQZtKmHAKRr8sGSBn9yH0WHntC9/WX/HJ0ioV6XTHfKXLTM6HbnPe7sEhxxNr+BO
         HHpg==
X-Gm-Message-State: AOAM532ekmn8Ph23vhgpUrtKee6Kn/zIh/gWfFYI9aRuIUEcc52m2wTv
        uwHV8FdyoV5FzLdm3zrbwNbaRO9EIhFQeseaC5Q=
X-Google-Smtp-Source: ABdhPJxBvXkiNS/OAZjMRCgmqbqSWehnUkEclqwsoSHvLr0T9EfEWNQPPBEhYZvfHmNNmJI9lZ0l29OGsFVNYdIokAI=
X-Received: by 2002:a05:6102:2828:: with SMTP id ba8mr20835288vsb.18.1627461552305;
 Wed, 28 Jul 2021 01:39:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210727050447.7339-1-rdunlap@infradead.org>
In-Reply-To: <20210727050447.7339-1-rdunlap@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 28 Jul 2021 10:39:00 +0200
Message-ID: <CAMuHMdXrDLvPRNMy_pEtu1u=7ML8GT3mpKLba8vRnHU3iF8U+w@mail.gmail.com>
Subject: Re: [PATCH] efi: sysfb_efi: fix build when EFI is not set
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Mark Brown <broonie@kernel.org>,
        Linux-Next <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Randy,

On Tue, Jul 27, 2021 at 7:06 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> When # CONFIG_EFI is not set, there are 2 definitions of
> sysfb_apply_efi_quirks(). The stub from sysfb.h should be used
> and the __init function from sysfb_efi.c should not be used.
>
> ../drivers/firmware/efi/sysfb_efi.c:337:13: error: redefinition of ‘sysfb_apply_efi_quirks’
>  __init void sysfb_apply_efi_quirks(struct platform_device *pd)
>              ^~~~~~~~~~~~~~~~~~~~~~
> In file included from ../drivers/firmware/efi/sysfb_efi.c:26:0:
> ../include/linux/sysfb.h:65:20: note: previous definition of ‘sysfb_apply_efi_quirks’ was here
>  static inline void sysfb_apply_efi_quirks(struct platform_device *pd)
>                     ^~~~~~~~~~~~~~~~~~~~~~
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Thanks for your patch!

> --- linext-20210726.orig/drivers/firmware/efi/sysfb_efi.c
> +++ linext-20210726/drivers/firmware/efi/sysfb_efi.c
> @@ -332,6 +332,7 @@ static const struct fwnode_operations ef
>         .add_links = efifb_add_links,
>  };
>
> +#ifdef CONFIG_EFI
>  static struct fwnode_handle efifb_fwnode;
>
>  __init void sysfb_apply_efi_quirks(struct platform_device *pd)
> @@ -354,3 +355,4 @@ __init void sysfb_apply_efi_quirks(struc
>                 pd->dev.fwnode = &efifb_fwnode;
>         }
>  }
> +#endif

How come you enter drivers/firmware/efi/ without CONFIG_EFI?

Oh:

drivers/firmware/Makefile:obj-$(CONFIG_EFI)             += efi/
drivers/firmware/Makefile:obj-$(CONFIG_UEFI_CPER)               += efi/

Looks like UEFI_CPER is not related to EFI at all (it's not set in
my arm64 config which has CONFIG_EFI=y). Perhaps it should be moved
to drivers/acpi/ instead?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
