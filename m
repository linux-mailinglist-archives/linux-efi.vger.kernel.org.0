Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF42BE118
	for <lists+linux-efi@lfdr.de>; Wed, 25 Sep 2019 17:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439413AbfIYPU4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 Sep 2019 11:20:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43103 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfIYPU4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 25 Sep 2019 11:20:56 -0400
Received: by mail-wr1-f66.google.com with SMTP id q17so7426980wrx.10
        for <linux-efi@vger.kernel.org>; Wed, 25 Sep 2019 08:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ih7TKOYfBLPKOMFm2CoimjQft6GV1JfCO8eV/MUJwrU=;
        b=FMXKM9s6XrtYvQ88Ib0+IVZFHiUBU8cGTTuRi4LCBQoaPe9EksZ4oD43F2pxQVXQZ1
         pbA+NK4hNDaFGhpkGW7uvJITGoMw6qK0nTwR4MZuYnoOpluBn9DT+oNjBgAYk+fyv1du
         Zdz+H7/TvhBJR0EqaIagAXAWMOuMluTqkHQGmUtTnn4yjktlVDmp+M3WgiW2VFul+H0Q
         L3NTsp9pgPhgnIsll7DTwZoFUeddgK50/oUvXP5tL/fBRZdm58k4hirAq7HfO6v6B9+l
         9Xzzfpg1uQGivuIpIELbgh40/8G9FmACqsr8UQ3NtTymY2JEFloDxnBAq0eAoTU2HKXY
         y2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ih7TKOYfBLPKOMFm2CoimjQft6GV1JfCO8eV/MUJwrU=;
        b=ZMnx8zqmihjBni4UeMnNJBdve7KwPyFBK4GsGFnH3SFpDkawie3cIyyUGb8BEBjGnI
         KiL+W+c1Q5tA145O0mYVCmJxhTVbr7/ctF0gMBXLX9MOR7jeWkYF/MK7jz0IDZ+WlxRe
         9x3dqpdRyqePBSgcBuT1CyM1aqwiExj+skeBJ6G425Rc1UljsNX+IR/3HwcDHkcMmFES
         kZXA8eDooxrFGSVaOCucHux5xoeMxxBFUToyvakHbB/P6JTwsmXxL1EZ3EKyxDwsVIZd
         rnUxUsRlrl6ZxWtXMcrCwuasLlVvZ9XfYfDe7tM3AWilUxKXbmt0RqKKAS+RIHlyulIp
         YdzQ==
X-Gm-Message-State: APjAAAWgQFQFKlzlGmkRN88FczB7c6H9FVLxPB3iLpAWj2ahWdElnPHo
        T2Z7b+k0LOzyJCo9FlpR7P8SKMX/Q4MJYGNf7zitIA==
X-Google-Smtp-Source: APXvYqwzNrfGTdVLE38UE68+yX95Bv3XD1XJUh1r7iu9PvauWOolAlKjz4RDxaIwvVfhnsanRYoq3o9MYYK4H87Z6Zg=
X-Received: by 2002:adf:fe88:: with SMTP id l8mr9457664wrr.32.1569424853257;
 Wed, 25 Sep 2019 08:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190925131241.27913-1-ben.dooks@codethink.co.uk>
In-Reply-To: <20190925131241.27913-1-ben.dooks@codethink.co.uk>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 25 Sep 2019 17:20:41 +0200
Message-ID: <CAKv+Gu8H6u+3Hp5HdYwoG6PwVHGK4shjC9KNsUSMRy6xQNiPoA@mail.gmail.com>
Subject: Re: [PATCH] efi: make unexported efi_rci2_sysfs_init static
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel@lists.codethink.co.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 25 Sep 2019 at 15:12, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>
> The efi_rci2_sysfs_init() is not used outside of rci2-table.c so
> make it static to silence the following sparse warning:
>
> drivers/firmware/efi/rci2-table.c:79:12: warning: symbol 'efi_rci2_sysfs_init' was not declared. Should it be static?
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  drivers/firmware/efi/rci2-table.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/rci2-table.c b/drivers/firmware/efi/rci2-table.c
> index 3e290f96620a..76b0c354a027 100644
> --- a/drivers/firmware/efi/rci2-table.c
> +++ b/drivers/firmware/efi/rci2-table.c
> @@ -76,7 +76,7 @@ static u16 checksum(void)
>         return chksum;
>  }
>
> -int __init efi_rci2_sysfs_init(void)
> +static int __init efi_rci2_sysfs_init(void)
>  {
>         struct kobject *tables_kobj;
>         int ret = -ENOMEM;
> --
> 2.23.0
>

Thanks Ben.

Queued in efi/urgent
