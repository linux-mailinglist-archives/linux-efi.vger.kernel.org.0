Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3945A486F
	for <lists+linux-efi@lfdr.de>; Sun,  1 Sep 2019 10:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbfIAIvd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 1 Sep 2019 04:51:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42127 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728390AbfIAIvd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 1 Sep 2019 04:51:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id b16so10923682wrq.9
        for <linux-efi@vger.kernel.org>; Sun, 01 Sep 2019 01:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9CcariPg/+pDc3vARuAr459XfHnqxJ7ylPDFK3t1SRU=;
        b=l4Zdc5a5T3uC+7NbT7VCV2TWjLCp1CPk3FOlePIK5R3AmazUAiU3ADWY1M6U+LKeK7
         eCE/5uz7HjeYqU2egXkzmsb3n3dkG5ofv5wGtM+vP48tmwfeQDZLCbTKqvwfZ5Qx9WYC
         i7kH8OXP/pNvK0Luc8uxaN0krQEQimRocMiDDo1tKgj8t8f+ybCzuEdYdMqpKcJK+iCM
         KBDTmrNQ+2jRfkHFpyTTjgBC/l5AmFR4Cql7T7teWDAUmyw8VJ4o8FhAg5eRN/N+MeJe
         qskUycWwUw3TG7iUHXO5ITTiql8UfBqbx3LRmOgaypVBRg1du5+jnb1VrL2u1A9SPknv
         vLAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9CcariPg/+pDc3vARuAr459XfHnqxJ7ylPDFK3t1SRU=;
        b=BA8RYyMvqNxbFPoJ9tBr6Tcs9+OXAYM1LAfPkHnGTYl/9nvLhfu2/hYw0GYZI8Y4hd
         bDU7apgsntfKmcwdq0n8pwi6p6RL1GRjGJKEROAMr44myiuNWI6HYbWJhvSzLL7SIJc3
         VmP6ftKk5BytnAmQ6KXcYFjUVddZcPtlWmrpQhrzt2lFTk2DrGaI5ErH8YpVCmR2Vblq
         Bbh+1utjO+on1t02tKzrY+MWBELIDwz4xl9unWYuOdJRYR9kFvxPlUDasJyWuF6XA0OU
         RXGBYE49JJFKmNZHbN/olRnKOQiHrXpx1SBTR9p/zwi/+sPFXuTLK8YuEJeQYzUC3d2C
         DhIw==
X-Gm-Message-State: APjAAAW/Yu8Us3CmAIpuCYPkdiRKgoQKAGHMKHVWl7W7p9+cjlTZzE/Z
        aOQUDPJqip44DW4VwcPT4OKs7/M5vyRefQOx+9uYFlp/llaESA==
X-Google-Smtp-Source: APXvYqwy7WAV3EWICz/BU96pWHIp8rvjQUiZeHP1jCD5ai6ePvwvM1LYs2A/meGTAaMlGiBLno/qe/RVnQ0+SVTcdeA=
X-Received: by 2002:adf:ee50:: with SMTP id w16mr10843191wro.93.1567327890949;
 Sun, 01 Sep 2019 01:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <e632fb385b5e3409cf6ebc9c0100dca5b3d35ea3.1566716456.git.lukas@wunner.de>
In-Reply-To: <e632fb385b5e3409cf6ebc9c0100dca5b3d35ea3.1566716456.git.lukas@wunner.de>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sun, 1 Sep 2019 11:51:19 +0300
Message-ID: <CAKv+Gu-YhAzBne6S1FHuV53sSZAa=EXXY7Fu2jSg9kNsWQghfA@mail.gmail.com>
Subject: Re: [PATCH] efi: cper: Fix endianness of PCIe class code
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 25 Aug 2019 at 10:04, Lukas Wunner <lukas@wunner.de> wrote:
>
> The CPER parser assumes that the class code is big endian, but at least
> on this edk2-derived Intel Purley platform it's little endian:
>
>     efi: EFI v2.50 by EDK II BIOS ID:PLYDCRB1.86B.0119.R05.1701181843
>     DMI: Intel Corporation PURLEY/PURLEY, BIOS PLYDCRB1.86B.0119.R05.1701181843 01/18/2017
>
>     {1}[Hardware Error]:   device_id: 0000:5d:00.0
>     {1}[Hardware Error]:   slot: 0
>     {1}[Hardware Error]:   secondary_bus: 0x5e
>     {1}[Hardware Error]:   vendor_id: 0x8086, device_id: 0x2030
>     {1}[Hardware Error]:   class_code: 000406
>                                        ^^^^^^ (should be 060400)
>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  drivers/firmware/efi/cper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index addf0749dd8b..b1af0de2e100 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -381,7 +381,7 @@ static void cper_print_pcie(const char *pfx, const struct cper_sec_pcie *pcie,
>                 printk("%s""vendor_id: 0x%04x, device_id: 0x%04x\n", pfx,
>                        pcie->device_id.vendor_id, pcie->device_id.device_id);
>                 p = pcie->device_id.class_code;
> -               printk("%s""class_code: %02x%02x%02x\n", pfx, p[0], p[1], p[2]);
> +               printk("%s""class_code: %02x%02x%02x\n", pfx, p[2], p[1], p[0]);
>         }
>         if (pcie->validation_bits & CPER_PCIE_VALID_SERIAL_NUMBER)
>                 printk("%s""serial number: 0x%04x, 0x%04x\n", pfx,

Class codes are always in that order, so the original code is simply wrong.

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

I'll get this queued shortly.

Thanks,
