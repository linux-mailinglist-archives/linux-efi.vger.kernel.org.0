Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 089C614B08A
	for <lists+linux-efi@lfdr.de>; Tue, 28 Jan 2020 08:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgA1Hs7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Jan 2020 02:48:59 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33794 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgA1Hs7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Jan 2020 02:48:59 -0500
Received: by mail-wr1-f68.google.com with SMTP id t2so14806319wrr.1
        for <linux-efi@vger.kernel.org>; Mon, 27 Jan 2020 23:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P51eYV6xfMKHJtmz3fBCU++fn1Qf38M/P+AHapHYGAU=;
        b=y9eXMqMuTmUqLyuYz6tA7xfsMub5NWGA9gukC82/6CbTvuwE5tyIHg0y4gSJIdT9XO
         QaMQikKhT4RJhDCpMWqj7S1CskChzl/Abjej/Aeoi/ZuXrXcxdjH1e09CrobnqBadfBv
         +sUBJfEzKcuHq5Vsbe3S193T9efhcA0A2mfLv5mjYiSO0b+t/9eD8OHwxSad/NWHOubD
         uXQYuIovSy/ZWIaZIM/inGClwcU3o6UIj2BGPBONnrZhSPI35rGK9YDHrX2+HquFLd4D
         Xn3+Q8C++k9Dm0HybvEG1kmDHrXOz+IoJRxBMh12RdfJvndjqr9Ph0vTluJQacFPqCz8
         mtWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P51eYV6xfMKHJtmz3fBCU++fn1Qf38M/P+AHapHYGAU=;
        b=Q14a+E94E7OnUNoKgs9pJjI4OKS+2Hr7jw4TLAWyylF6OeTT+M2eEjwWTvsnCFiWvT
         To0fqBAyKX74sQCwWKfjiMufXSXpK72+Gxa8OXQb1mub5nZdJ1PfvEDcTA8l8dim2y4+
         kEC1xRT9qUomGIVg9w6F35vZyiGaMLIuly24LC52jk7k/8aJVoQwhcX3lH2h/zn0e/2P
         ebUiyUULbtw7ZrJL3sPpwgIGUD41Bk/1NLIfwy0ggH4Mw8Ll2Is7uB/x5kuQ/iU/nCq+
         g8uyQ5jkFjs4ddAV3mWbipxorayBK11jIfGiHXbYQBUc4vTuCXVRjps/9u2Nw3UFL+z+
         m+pw==
X-Gm-Message-State: APjAAAXzq9XVNKi6a92e+wfxXL6MB0iQIrRyOe7iFGSUYypNHA8OVsaD
        xzvIDmOI47pJ4uYuH3PYf8HFFN+DseViXHBrkzG07A==
X-Google-Smtp-Source: APXvYqwlI/CMxioVRnXmP31TfUGLSeLIaF8jir48ryqliWY11yiEVhBEyoOG1Ia71WmOc1XYPfWTI2y8ZR4f9BG5uk8=
X-Received: by 2002:a5d:65cf:: with SMTP id e15mr26360242wrw.126.1580197737006;
 Mon, 27 Jan 2020 23:48:57 -0800 (PST)
MIME-Version: 1.0
References: <20200126150231.6021-1-hdegoede@redhat.com>
In-Reply-To: <20200126150231.6021-1-hdegoede@redhat.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 28 Jan 2020 08:48:46 +0100
Message-ID: <CAKv+Gu_dE+pi7CSANOXEP2xenRirWQg5H71t5f4eah8-XZpbxQ@mail.gmail.com>
Subject: Re: [PATCH] efi/bgrt: Accept BGRT tables with a version of 0 on
 Lenovo laptops
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 26 Jan 2020 at 16:02, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Some (somewhat older) Lenovo laptops have a correct BGRT table, except
> that the version field is 0 instead of 1.
>
> Quickly after finding this out, even before submitting a first version of
> this patch upstream, the list of DMI matches for affected models grew to
> 3 models (all Ivy Bridge based).
>
> So rather then maintaining an ever growing list with DMI matches for
> affected Lenovo models, this commit simply checks if the vendor is Lenovo
> when the version is 0 and in that case accepts the out of spec version
> working around the Lenovo firmware bug.
>
> Cc: stable@vger.kernel.org
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1791273
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/firmware/efi/efi-bgrt.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/efi-bgrt.c b/drivers/firmware/efi/efi-bgrt.c
> index b07c17643210..3a2d6d3a590b 100644
> --- a/drivers/firmware/efi/efi-bgrt.c
> +++ b/drivers/firmware/efi/efi-bgrt.c
> @@ -15,6 +15,7 @@
>  #include <linux/acpi.h>
>  #include <linux/efi.h>
>  #include <linux/efi-bgrt.h>
> +#include <linux/dmi.h>
>
>  struct acpi_table_bgrt bgrt_tab;
>  size_t bgrt_image_size;
> @@ -42,7 +43,12 @@ void __init efi_bgrt_init(struct acpi_table_header *table)
>                 return;
>         }
>         *bgrt = *(struct acpi_table_bgrt *)table;
> -       if (bgrt->version != 1) {
> +       /*
> +        * Some older Lenovo laptops have a correct BGRT table, except that
> +        * the version field is 0 instead of 1.
> +        */
> +       if (bgrt->version != 1 &&
> +           !(bgrt->version == 0 && dmi_name_in_vendors("LENOVO"))) {
>                 pr_notice("Ignoring BGRT: invalid version %u (expected 1)\n",
>                        bgrt->version);
>                 goto out;

Hi Hans,

Given that the ACPI spec only defines a single version for this table,
which is version #1, wouldn't it be simpler to just assume that
version #0 means version #1 in all cases, rather than using DMI
matches for that? There is no risk of misidentifying another table
version, since none exist ...
