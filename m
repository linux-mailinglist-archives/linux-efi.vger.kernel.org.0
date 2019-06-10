Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73C6C3B815
	for <lists+linux-efi@lfdr.de>; Mon, 10 Jun 2019 17:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391092AbfFJPMO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 10 Jun 2019 11:12:14 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:40602 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391091AbfFJPMO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 10 Jun 2019 11:12:14 -0400
Received: by mail-it1-f196.google.com with SMTP id q14so12618473itc.5
        for <linux-efi@vger.kernel.org>; Mon, 10 Jun 2019 08:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gBFHx/+nY2qEbXMRi49DNkYIs7xUlnWB7w/2fSOEbw4=;
        b=HVI+RbLbhTV5wVCYzwaZmh8RHQ9mLEdv52RDhlCv3YWbIVHCkpZQet5tR7nPNaQ0VX
         bv5V7udMGuhhAoyI/WGk0dWZwT9/Eik+zJw5Vzkhi1vFZ9VqqXJ+xwf3WZbR+xKaGXiS
         6EzoAJdDrdwTax6mEnFnACALA8EzLvJNivDgA9xF1rfbvm7/yCtuFD9b7lrB6gv5UTsN
         NCRjzqPNXhkYQZjlEGbrHosqKSTCnn1ONjp85Qm1g6Y/2RXiUZwU/Wyzvc8pNUF84xHJ
         FpmRf2c0tdNnBQMmHnHdDMjhVvoxTIGGQnpm+s6dkOjcr9lnpz6W/1Z1f0Pg/sDeUByv
         pABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gBFHx/+nY2qEbXMRi49DNkYIs7xUlnWB7w/2fSOEbw4=;
        b=AjYxtis7xCW7cRYn1cZDnFfXieJWiyC2JcJW/iNaPVxglgbv5Phwp8KZUYYAeKTUcT
         uliX3+L68LyeGUNFlwcch0HzhnWKYOijbRibMTQL7vdQ+I0VQ2o5XedImMdpPkTTn6+0
         lgyZTpfZ5iiblfm9IyMhFjIvm4A9F0RlzcaY908VPLd4XYCy0JWyMD9ltawGIlahl4X5
         6ov9wDtCg8cDKnwmKU5h3VQmiDyNLNQH72Sc07qrDFZuaS7oaiDehkvJuMeH5PxjDpPM
         rCpKGlfoMs03TmmLgNYyXyVw3UiI6pRRstxFhFdEMllIMERnghMSWOORa6sqA3gCm5eW
         VoYw==
X-Gm-Message-State: APjAAAXg80sIvd/EiEZMOpfXoKKt6X2AVO8JwWZipP0HdwEq3OWGsnlx
        MNZRos2BgIk6vvb1GQEd1fZ3IEm1z7p1r/Jbt3qR7A==
X-Google-Smtp-Source: APXvYqwD0fuY0Rp9kDgEZEWygTYLuIOj9eakFO8ROIh9FUKb9OTMeD0HiinM6EgmuN6HIYhattKD39uJGxCjkf/GOSI=
X-Received: by 2002:a24:5f87:: with SMTP id r129mr1964365itb.104.1560179533730;
 Mon, 10 Jun 2019 08:12:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190529132828.13105-1-hdegoede@redhat.com>
In-Reply-To: <20190529132828.13105-1-hdegoede@redhat.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 10 Jun 2019 17:12:01 +0200
Message-ID: <CAKv+Gu9q_13_6CputTq-+JM3y=Wm+u7tFGM7YaiLof8BfdQRvQ@mail.gmail.com>
Subject: Re: [PATCH] efi/bgrt: Drop BGRT status field reserved bits check
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 29 May 2019 at 15:28, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Starting with ACPI 6.2 bits 1 and 2 of the BGRT status field are no longer
> reserved. These bits are now used to indicate if the image needs to be
> rotated before being displayed.
>
> The first device using these bits has now shown up (the GPD MicroPC) and
> the reserved bits check causes us to reject the valid BGRT table on this
> device.
>
> Rather then changing the reserved bits check, allowing only the 2 new bits,
> instead just completely remove it so that we do not end up with a similar
> problem when more bits are added in the future.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Thanks, Hans. I'll take this as a fix.

> ---
>  drivers/firmware/efi/efi-bgrt.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/firmware/efi/efi-bgrt.c b/drivers/firmware/efi/efi-bgrt.c
> index a2384184a7de..b07c17643210 100644
> --- a/drivers/firmware/efi/efi-bgrt.c
> +++ b/drivers/firmware/efi/efi-bgrt.c
> @@ -47,11 +47,6 @@ void __init efi_bgrt_init(struct acpi_table_header *table)
>                        bgrt->version);
>                 goto out;
>         }
> -       if (bgrt->status & 0xfe) {
> -               pr_notice("Ignoring BGRT: reserved status bits are non-zero %u\n",
> -                      bgrt->status);
> -               goto out;
> -       }
>         if (bgrt->image_type != 0) {
>                 pr_notice("Ignoring BGRT: invalid image type %u (expected 0)\n",
>                        bgrt->image_type);
> --
> 2.21.0
>
