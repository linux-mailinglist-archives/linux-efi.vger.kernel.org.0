Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF5A552B8
	for <lists+linux-efi@lfdr.de>; Tue, 25 Jun 2019 17:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731968AbfFYPAg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Jun 2019 11:00:36 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45599 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731959AbfFYPAg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 25 Jun 2019 11:00:36 -0400
Received: by mail-io1-f68.google.com with SMTP id e3so164381ioc.12
        for <linux-efi@vger.kernel.org>; Tue, 25 Jun 2019 08:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WCu2izc+AwFs8dxkBWfG0kU/xQQY4HsLibUm2/EhQEg=;
        b=XEkdwu9tbyxynV2UESVQpvwU3iwK3hOE1k9Q1V76kobtha4OFJg8EuxOwyr9iFmFCF
         03+IP8ze/+IkOWgqwTpYK3IA+caa2YfQYz/eo6KfpwPMDhq0+7/rvOJSrpLmt6w+CQny
         NEdRK0dC/Ou/b9ECjr3caBsF5fwJhkr+xfFWaaDRwrRWL3rhMeeWH8HFoBrAKmYGIkva
         h4nN/l3U6DtLZdNSOnQL9Ih7R4Vh9q25kWm87wwuDzJtxPiQd0g9nyeidql+/whr0yY8
         hRSCFlzTYLEpYV2kxsIbsi+thmD6DyDRJf9PwCSIWPW0GUf18A1wZrVKYFPGX3EEcJNl
         GGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WCu2izc+AwFs8dxkBWfG0kU/xQQY4HsLibUm2/EhQEg=;
        b=JgsmHwIc3fVpkKzvYhsV5L7m1QlhgIo0J6vt4+hSykeeL5wLs8aS0tfreoXrZddrUY
         2qOEx5BRK+UNrAhZJLuV3ANufJWVkJmItf4+tl2j2o5L/ZexFl/AY/uYn4E30XPR/xWT
         AOsCyrLYsWZjhp3ehPKocJRhLe5XbbA3NlDpyVy+SrnLdBlMRfoj8ErwNyTisuHspTjf
         t4X0g6xceQT9rNnGY1n8qi6SavTfyehBLJ281i5/xe3RtmsOVsPy/yfzY1xHIgjCZY0h
         UGPzJgupR9fF4L+w4D/R/FCMeROTwWcEhvo6nSlGleQx0fCCZ3wfOETtqT9SH/UOIufR
         I0nw==
X-Gm-Message-State: APjAAAWkjLNIhiP1tQtCyqLNdkNfjgU8L0Rq6YrIVCJOqjgKlAyaFY2F
        xeRyI4teUs2HPhQCEXBXOBADkYeaXKsb1IKK8R81+A==
X-Google-Smtp-Source: APXvYqzeVOugDrWRv5GZLuCebGXK5dE6WckDZUY2y3Mwk6wopB+mgprQm2ZWsgT4yJQvT/jz99cbIBKpq58fNj+5zo0=
X-Received: by 2002:a02:c90d:: with SMTP id t13mr112928904jao.62.1561474835326;
 Tue, 25 Jun 2019 08:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com> <20190622000358.19895-29-matthewgarrett@google.com>
In-Reply-To: <20190622000358.19895-29-matthewgarrett@google.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 25 Jun 2019 17:00:24 +0200
Message-ID: <CAKv+Gu_0bSCdeUGQo=nnKU=mfHXu+-U+qXWqJpJGUd6dVZF61Q@mail.gmail.com>
Subject: Re: [PATCH V34 28/29] efi: Restrict efivar_ssdt_load when the kernel
 is locked down
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     James Morris <jmorris@namei.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Matthew Garrett <mjg59@google.com>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 22 Jun 2019 at 02:05, Matthew Garrett <matthewgarrett@google.com> wrote:
>
> efivar_ssdt_load allows the kernel to import arbitrary ACPI code from an
> EFI variable, which gives arbitrary code execution in ring 0. Prevent
> that when the kernel is locked down.
>
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: linux-efi@vger.kernel.org

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  drivers/firmware/efi/efi.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 55b77c576c42..9f92a013ab27 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -31,6 +31,7 @@
>  #include <linux/acpi.h>
>  #include <linux/ucs2_string.h>
>  #include <linux/memblock.h>
> +#include <linux/security.h>
>
>  #include <asm/early_ioremap.h>
>
> @@ -242,6 +243,11 @@ static void generic_ops_unregister(void)
>  static char efivar_ssdt[EFIVAR_SSDT_NAME_MAX] __initdata;
>  static int __init efivar_ssdt_setup(char *str)
>  {
> +       int ret = security_locked_down(LOCKDOWN_ACPI_TABLES);
> +
> +       if (ret)
> +               return ret;
> +
>         if (strlen(str) < sizeof(efivar_ssdt))
>                 memcpy(efivar_ssdt, str, strlen(str));
>         else
> --
> 2.22.0.410.gd8fdbe21b5-goog
>
