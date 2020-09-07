Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB1C125F379
	for <lists+linux-efi@lfdr.de>; Mon,  7 Sep 2020 09:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725803AbgIGHAn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Sep 2020 03:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgIGHAa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Sep 2020 03:00:30 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5BAC061573
        for <linux-efi@vger.kernel.org>; Mon,  7 Sep 2020 00:00:26 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d9so1867315pfd.3
        for <linux-efi@vger.kernel.org>; Mon, 07 Sep 2020 00:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZB01nxLyQQ2oxAI+dDxfZXKWbIvB8x5H0InVProFwEk=;
        b=iGE5Cdikz2WDHv2brLa0kGSf0Oyke/kI5FiddDBhh+ZQu4j85gbU3TlsK0oCn2Lu0w
         hqcU3iLfW5vzpOogIiR3dfTDtzFuE76qTO2JIgH6nMQmsEZEWDgI0wqCE6WIRGk6A27+
         1RLgd92imZ0HxzZxA9lXP9kFMJFZRW2WZpfLSgwQSrhJ00/4+p08wqADrOPRtjaDnyvr
         SJrJ1nKQ3a8Ey7Uov3UZhW+p/Oc/7YDmr1VHA8eib4ofkHMi4By9OyXHwRJnI9g4DPNO
         PaxzkYx0GVXvR/OOkgOhvBGUApvewi6a7MRXJ2P5p/2ZqGjOng2enxCX/DFGsnxbGP/X
         io8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZB01nxLyQQ2oxAI+dDxfZXKWbIvB8x5H0InVProFwEk=;
        b=mNfx7Qsq6hvMtqziczDi7ewOs5vh/CVLD+DiGaamBY8/puWGQYMUH5xC5HysvvTWui
         erLZ2uyQ/cT1tqSHx5y8ioWROrh+jd6FOpUJxNYggruoOVi12BkgBbLfwa+sQyCW/wlj
         4cB3avxsS9PUMqX9eng0K5OqPug0pNziiLBf7yS3CW1aJrtHPpg+H0rrB3u34TW3VqIZ
         f5+fSSx4DmgpmxYBz+C3VGT3pyyG2AfjnVeayLyLV1Ud7Vbb9iQ1yjKH3XAZZmFHm/oU
         DeQgESeVLY1ysR9FuT0hmsoL0YIbTS9Us8okomvQ0pCTXA/rD/+q/yHOs2MaOX+3M+76
         lTRg==
X-Gm-Message-State: AOAM533ZYNvMw7QL8SazsW16D3r+B11jwO+5ylpOCzAj7SE3xYFujpHr
        wzRM4GG0SZp9nG2q+hzJY7nG//FAac1KLYUUosv5bw==
X-Google-Smtp-Source: ABdhPJxuNIxHplTBaOBAdYC4reZOx0YehpPyyImzvd9PJ/q1QoVrRnICkvZUEj+F6D3F2KJO1GuoRJoMsZo/pllt2kA=
X-Received: by 2002:aa7:8756:: with SMTP id g22mr18657106pfo.37.1599462025620;
 Mon, 07 Sep 2020 00:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200904155025.55718-1-xypron.glpk@gmx.de>
In-Reply-To: <20200904155025.55718-1-xypron.glpk@gmx.de>
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
Date:   Mon, 7 Sep 2020 10:00:14 +0300
Message-ID: <CAD8XO3ZLqkuajo3GVRdvXiFXMH9P-vp-PX5s6idgA51ouVDpKQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi/libstub: DRAM base calculation
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 4 Sep 2020 at 18:50, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> In the memory map the regions with the lowest addresses may be of type
> EFI_RESERVED_TYPE. The reserved areas may be discontinuous relative to the
> rest of the memory. So for calculating the maximum loading address for the
> device tree and the initial ramdisk image these reserved areas should not
> be taken into account.
>
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  drivers/firmware/efi/libstub/efi-stub.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
> index c2484bf75c5d..13058ac75765 100644
> --- a/drivers/firmware/efi/libstub/efi-stub.c
> +++ b/drivers/firmware/efi/libstub/efi-stub.c
> @@ -106,7 +106,8 @@ static unsigned long get_dram_base(void)
>         map.map_end = map.map + map_size;
>
>         for_each_efi_memory_desc_in_map(&map, md) {
> -               if (md->attribute & EFI_MEMORY_WB) {
> +               if (md->attribute & EFI_MEMORY_WB &&
> +                   md->type != EFI_RESERVED_TYPE) {

shouldn't the type here be CONVENTIONAL?

>                         if (membase > md->phys_addr)
>                                 membase = md->phys_addr;
>                 }
> --
> 2.28.0
>
