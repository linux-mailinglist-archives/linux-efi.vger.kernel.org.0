Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89EFE1616F9
	for <lists+linux-efi@lfdr.de>; Mon, 17 Feb 2020 17:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbgBQQHK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Feb 2020 11:07:10 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37655 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbgBQQHK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 17 Feb 2020 11:07:10 -0500
Received: by mail-wr1-f65.google.com with SMTP id w15so20407972wru.4
        for <linux-efi@vger.kernel.org>; Mon, 17 Feb 2020 08:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NoTcUJNOmTnmW8MfOyrWNWTU1kRF1g/1PHuBsSd2zGU=;
        b=jPOTaie7a/J+VW3BHpEwtEOQxHijWh3afiLM0FSQBJAYrLpZ+q3/7D8eiVQHH3lL+I
         dY0KdVxvoY1+mEM16tRqYmH2yXp/jzD96LIghIigYjWkvB4vjkbILzkx3UxtUihY5ppb
         M6oLapTFYLZajr4L1k1lpqXBkDRZRJ83T4W1sEnY6LznanFh8HLxTZfbh6uq5Il+4Iwe
         xOKFTB/5AU2hl8UtpNahaeEiguYCjBI4WfZl5gH/dlOiGnECzC5aaD53gEZ9sKnpTBMB
         DFm7ZbmUWle7h90Raxci+kCkaLFaFWBnzCAr531+rVH5wbSOZlK+AN4yzZOsdcOXwWD4
         9/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NoTcUJNOmTnmW8MfOyrWNWTU1kRF1g/1PHuBsSd2zGU=;
        b=iOnM/1JWUTBVpJlpPFkMopKzwdMTCx/1rgPIl/BKADiq/FNIgT7gWlh4d20z052I2G
         svCF4Onceiz8v4cDU51ZY03u+t1RZbr0jGN7lG6G4IPwd03fg82IsN5vOw/Z+5b2TSmU
         iC5oa7n2Fnbv5Rp2bFnRiNLQ4M/8HGXHl+c69QvYz82BRCkIjG4jY+ftFVStiyrq9zt7
         y3Re/eFZQyzhN5oR9HF3zgj1WM1xmH/KUxj35VjPq15DoG/y3uQROIQxE6WYsXagVBpN
         NMBGyfMnyySDo7Ypf8FBzCiBKDa+NtDB+cdkKVAsGDyGobeLT9rdQAVqB757Onp8n5b+
         0Beg==
X-Gm-Message-State: APjAAAXxMs9zYnIKiCgY/uvivfRLpXv1CTO6LYfaGFZMnN2osRB4l2pJ
        ARq784lvzoXqF/zDE0/jk74V1t98idQXsBNqOMGF8vKLtdGjMQ==
X-Google-Smtp-Source: APXvYqy1lU43nGfuVi+0t+0kIeBYa5bi0B7zpnZvihj6Xe5Dqp1ME7CD5EYKpkeLjydjSZNkML5nEZwKDBgWy6COt9o=
X-Received: by 2002:a5d:6a4b:: with SMTP id t11mr22659366wrw.262.1581955628501;
 Mon, 17 Feb 2020 08:07:08 -0800 (PST)
MIME-Version: 1.0
References: <20200217154549.20895-1-tiwai@suse.de>
In-Reply-To: <20200217154549.20895-1-tiwai@suse.de>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 17 Feb 2020 17:06:57 +0100
Message-ID: <CAKv+Gu_9AqVnhwUUOGyL1HMUYgemp6SD2O5CJjy2vKpeuP4eOA@mail.gmail.com>
Subject: Re: [PATCH] efi: Suppress spurious "Couldn't get size" error
To:     Takashi Iwai <tiwai@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>, Joey Lee <jlee@suse.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 17 Feb 2020 at 16:45, Takashi Iwai <tiwai@suse.de> wrote:
>
> The current efi code emits the error message like
>    Couldn't get size: 0x800000000000000e
> on various Dell and other machines.  Although the whole problem is the
> buggy firmware, showing this as an error level is rather annoying, as
> the error message appears over the boot splash.  Basically this is the
> result of missing entry and we have no explicit way to fix it for such
> a firmware problem, the error message may be suppressed.
>
> This patch changes the error print condition and suppresses the error
> message if status is EFI_NOT_FOUND.  It's a partial patch from the
> more comprehensive one Joey Lee submitted in the past.
>
> Link: https://lore.kernel.org/linux-efi/20190322103350.27764-2-jlee@suse.com/
> Cc: Joey Lee <jlee@suse.com>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Hello Takashi,

Javier sent a more comprehensive fix for this today. The problem is
not buggy firmware, but buggy kernel :-)
(the code assumes that all systems boot via shim, and that certain EFI
variables are therefore guaranteed to exist, which is not the case)

https://lore.kernel.org/linux-efi/CAKv+Gu-a5Bo9i=K55pa3jEXRq-u5JYVGp1jFEE=UY5B=6eUkRQ@mail.gmail.com

-- 
Ard.


> ---
>  security/integrity/platform_certs/load_uefi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
> index 111898aad56e..8501ea62cb3e 100644
> --- a/security/integrity/platform_certs/load_uefi.c
> +++ b/security/integrity/platform_certs/load_uefi.c
> @@ -44,7 +44,8 @@ static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
>
>         status = efi.get_variable(name, guid, NULL, &lsize, &tmpdb);
>         if (status != EFI_BUFFER_TOO_SMALL) {
> -               pr_err("Couldn't get size: 0x%lx\n", status);
> +               if (status != EFI_NOT_FOUND)
> +                       pr_err("Couldn't get size: 0x%lx\n", status);
>                 return NULL;
>         }
>
> --
> 2.16.4
>
