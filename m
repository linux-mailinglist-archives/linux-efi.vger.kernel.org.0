Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 787E02E7EF4
	for <lists+linux-efi@lfdr.de>; Thu, 31 Dec 2020 10:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgLaJ2u (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 31 Dec 2020 04:28:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:48448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgLaJ2u (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 31 Dec 2020 04:28:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3964322262
        for <linux-efi@vger.kernel.org>; Thu, 31 Dec 2020 09:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609406889;
        bh=l+PkxWK6JPz53FOwYdtJPM8w8hVwjGJ4JLilVB7yuQA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TwdbsLGEvQ03Y9XxrYu8/bdU0kGY/X4K5ndgCxb9UvQ/bk93l+yTBFzWKbMdAu8SS
         8w+npN5m0Q9F49xiD14es+flj6aZbBQznfhChA88X51kACvNJl7T+uaVlTPRDwuPCu
         qQmGKerSGRBoeTHb43N6RjbnGyxyHLd0rLklh4XHCGF6B5tHCfvF341mz6ii/wKzBe
         5OgwRXRfnCvJVbLz8PaETNpDOWSGlf5/dP/MpvwbghbGQM3JrUNmBV+m6pmf8PWMI0
         htDya/lZQRL0EXFkrxiIBrXdNCOmj1lzdfwJwOVgwrkIoIrxpLpmTDeELao1KudiKK
         Fs2s+0CkmgpiA==
Received: by mail-oi1-f170.google.com with SMTP id 15so21384193oix.8
        for <linux-efi@vger.kernel.org>; Thu, 31 Dec 2020 01:28:09 -0800 (PST)
X-Gm-Message-State: AOAM532Bff/iWG+6TJGJnbesxepzt7ZAyyPF3Gw7KFyH+NeP2Zos06IT
        IuDbP3RAjgHA6Rsu93N7eSX+bqO6vf+dLH+nrww=
X-Google-Smtp-Source: ABdhPJxHeBEmzTXWeb821ozMEvGXtiRLXTsZdmMUpNIvtB7ik3dA/BBy99TLNLf3zske6w0yuHWLZWViAIeolHUSl7I=
X-Received: by 2002:aca:d98a:: with SMTP id q132mr7546409oig.33.1609406888532;
 Thu, 31 Dec 2020 01:28:08 -0800 (PST)
MIME-Version: 1.0
References: <be958bda75331a011d53c696d1deec8dccd06fd2.1609388549.git.lukas@wunner.de>
In-Reply-To: <be958bda75331a011d53c696d1deec8dccd06fd2.1609388549.git.lukas@wunner.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 31 Dec 2020 10:27:57 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHp6f70a1kPEwgSz9ZvhDTZttX6b2Jabsx1sC-Bm3nCCA@mail.gmail.com>
Message-ID: <CAMj1kXHp6f70a1kPEwgSz9ZvhDTZttX6b2Jabsx1sC-Bm3nCCA@mail.gmail.com>
Subject: Re: [PATCH v2] efi/apple-properties: Reinstate support for boolean properties
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 31 Dec 2020 at 06:19, Lukas Wunner <lukas@wunner.de> wrote:
>
> Since commit 4466bf82821b ("efi/apple-properties: use
> PROPERTY_ENTRY_U8_ARRAY_LEN"), my MacBook Pro issues a -ENODATA error
> when trying to assign EFI properties to the discrete GPU:
>
> pci 0000:01:00.0: assigning 56 device properties
> pci 0000:01:00.0: error -61 assigning properties
>
> That's because some of the properties have no value.  They're booleans
> whose presence can be checked by drivers, e.g. "use-backlight-blanking".
>
> Commit 6e98503dba64 ("efi/apple-properties: Remove redundant attribute
> initialization from unmarshal_key_value_pairs()") employed a trick to
> store such booleans as u8 arrays (which is the data type used for all
> other EFI properties on Macs):  It cleared the property_entry's
> "is_array" flag, thereby denoting that the value is stored inline in the
> property_entry.
>
> Commit 4466bf82821b erroneously removed that trick.  It was probably a
> little fragile to begin with.
>
> Reinstate support for boolean properties by explicitly invoking the
> PROPERTY_ENTRY_BOOL() initializer for properties with zero-length value.
>
> Fixes: 4466bf82821b ("efi/apple-properties: use PROPERTY_ENTRY_U8_ARRAY_LEN")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: stable@vger.kernel.org # v5.5+
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> v1 -> v2: Check for entry_len instead of !entry_len. (Andy)

Thanks Lukas. I will queue this as a fix.


>
>  drivers/firmware/efi/apple-properties.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/firmware/efi/apple-properties.c b/drivers/firmware/efi/apple-properties.c
> index 34f53d898acb..e1926483ae2f 100644
> --- a/drivers/firmware/efi/apple-properties.c
> +++ b/drivers/firmware/efi/apple-properties.c
> @@ -3,8 +3,9 @@
>   * apple-properties.c - EFI device properties on Macs
>   * Copyright (C) 2016 Lukas Wunner <lukas@wunner.de>
>   *
> - * Note, all properties are considered as u8 arrays.
> - * To get a value of any of them the caller must use device_property_read_u8_array().
> + * Properties are stored either as:
> + * u8 arrays which can be retrieved with device_property_read_u8_array() or
> + * booleans which can be queried with device_property_present().
>   */
>
>  #define pr_fmt(fmt) "apple-properties: " fmt
> @@ -88,8 +89,12 @@ static void __init unmarshal_key_value_pairs(struct dev_header *dev_header,
>
>                 entry_data = ptr + key_len + sizeof(val_len);
>                 entry_len = val_len - sizeof(val_len);
> -               entry[i] = PROPERTY_ENTRY_U8_ARRAY_LEN(key, entry_data,
> -                                                      entry_len);
> +               if (entry_len)
> +                       entry[i] = PROPERTY_ENTRY_U8_ARRAY_LEN(key, entry_data,
> +                                                              entry_len);
> +               else
> +                       entry[i] = PROPERTY_ENTRY_BOOL(key);
> +
>                 if (dump_properties) {
>                         dev_info(dev, "property: %s\n", key);
>                         print_hex_dump(KERN_INFO, pr_fmt(), DUMP_PREFIX_OFFSET,
> --
> 2.29.2
>
