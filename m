Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2739F1BFE
	for <lists+linux-efi@lfdr.de>; Wed,  6 Nov 2019 18:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732384AbfKFRCI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 6 Nov 2019 12:02:08 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54139 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729004AbfKFRCI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 6 Nov 2019 12:02:08 -0500
Received: by mail-wm1-f67.google.com with SMTP id x4so4445562wmi.3
        for <linux-efi@vger.kernel.org>; Wed, 06 Nov 2019 09:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Td99yEjooCTjs2/PvMjZI2+HMS/tAjDRA3GPrGeVtEI=;
        b=jZSOsThWQQ2LwYctC8YcYPDbJ6oRY4DPiwyay5ZNoZNVDTtdmqyGYCfK7oviW4ZtcO
         JAXJxC2ftHojYtacL6taI2khb2bB84OqQd4AY+cdZJ+FS+WhNMuH3U8C0QpojuMzYC8J
         LCrBgAeDbCQrhM8h/6zogR/hXJ8oNqj8/mtlAAGRUoRzAhmaUxlAkmAqExkGpmzQ68fK
         zI5ZnHDs7yLpqxZ8Zcihf7Fh1iW3sL+Uwjl0iILXIArIbhigbYyggOc8zB0fO1DRUC/3
         0bwMkP2fDP2c+cJarcp3NwM2fagjkXnl4hCYx99vEIH+HrcpXAtN4CAWRqLjn+0bXOuo
         bH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Td99yEjooCTjs2/PvMjZI2+HMS/tAjDRA3GPrGeVtEI=;
        b=Xb0YaHjPzxE41y4jI2zVBW/oqYaU/KckgKWE6Q5drWbVRteoHh/k5ZwZayEsMS+3Wx
         O/+fkLaGj7YXqhoWjMc4PsS+y3POQ6PShrCytGxwTjmFb/TqzrdziWjA6H08WZhBDR3W
         KimpbSxZVom61i2QeElgwlBslzMQ4irq3s66hUCBJwn7gYiPOPnAEez9Q07D5pFK/Hzx
         aqKbIbVYpa4yPELLX1ykRfpVmn1e4jziqsLSpNOBm2OlTJGPsTpuklyZFE11b+UbliVY
         XVXh0kDStKU3HIcYLbXl0FYQJtoHRvajRXKusZvRGOmnGXBQFEPUi7WIxI9Ry3I3MUY0
         jPgw==
X-Gm-Message-State: APjAAAVVLeEUzRTJy+bgIxd6ko0PdPK9VK0M+e3BJRIUXUdC8Oi0LtoU
        7Nid8XxPLZEhXmIYPbPvFqIHBbk4jme39K5koeezg7L3+Iv56Fyh
X-Google-Smtp-Source: APXvYqwWWNQE9RlQ13ZOmh7HQWoRHEyqbaaMBYYVyKsS2AreAFalWLEQhhn/3Bmd7r7+YTDh7MBZtZ4hIFwtJyvXqIs=
X-Received: by 2002:a1c:64d6:: with SMTP id y205mr3227761wmb.136.1573059726914;
 Wed, 06 Nov 2019 09:02:06 -0800 (PST)
MIME-Version: 1.0
References: <1572931429-487-1-git-send-email-anshuman.khandual@arm.com>
In-Reply-To: <1572931429-487-1-git-send-email-anshuman.khandual@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 6 Nov 2019 18:01:54 +0100
Message-ID: <CAKv+Gu-q16Z=tyeb3b5NnjBkw9cRoeEM6OQaT6dGe1i+9iJa9w@mail.gmail.com>
Subject: Re: [PATCH] efi: Return EFI_RESERVED_TYPE in efi_mem_type() for
 absent addresses
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 5 Nov 2019 at 21:39, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> The function efi_mem_type() is expected (per documentation above) to return
> EFI_RESERVED_TYPE when a given physical address is not present in the EFI
> memory map. Even though EFI_RESERVED_TYPE is not getting checked explicitly
> anywhere in the callers, it is always better to return expected values.
>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: linux-efi@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

This reverts commit f99afd08a45fbbd9ce35a7624ffd1d850a1906c0.

Could you explain why it is better to fix the code than fix the comment?

> ---
>  drivers/firmware/efi/efi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 69f00f7453a3..bdda90a4601e 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -914,7 +914,7 @@ int efi_mem_type(unsigned long phys_addr)
>                                   (md->num_pages << EFI_PAGE_SHIFT))))
>                         return md->type;
>         }
> -       return -EINVAL;
> +       return EFI_RESERVED_TYPE;
>  }
>  #endif
>
> --
> 2.20.1
>
