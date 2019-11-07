Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6B31F2A6D
	for <lists+linux-efi@lfdr.de>; Thu,  7 Nov 2019 10:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733238AbfKGJUc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 7 Nov 2019 04:20:32 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54646 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727693AbfKGJUc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 7 Nov 2019 04:20:32 -0500
Received: by mail-wm1-f65.google.com with SMTP id z26so1610696wmi.4
        for <linux-efi@vger.kernel.org>; Thu, 07 Nov 2019 01:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fi6xzuBwDslqMBEvOoSJLgLZ2eKUNykAx5rVCyKwYkY=;
        b=Xo1imTSWH2DPOskwLGJmaXoLtzlHHl5JVfqYQkKmOOa9uDLE5OHcZN7g4m5+oHdq5G
         NwftkH7SGrFIUsp1I+fjikmM/gAy+uLeGZjOgK3VYvPI0EVCMPbwzom8M2Hnw2CdqbKM
         AznMYDsGn3SuvaIA31VakGgLjitGJQgkhqHiEoey7wYyPlcsXyhjF4n1EbyMqem1jfBL
         XqrejqJGde4OQ0Ydw+Omsh0Lq2+QRdMMLypJBfEft2IuI3m7eOWLzUUxP6O5efsqmLaj
         6TvWo+C9Jm+XLS37rdrLO4sGFICqK3Sq2s+s/WWKfAwSiLgGf3PC3PHBanCDeM0ekp9R
         21BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fi6xzuBwDslqMBEvOoSJLgLZ2eKUNykAx5rVCyKwYkY=;
        b=WrAO3mRYDx75qwa/7QyAS7YrUed0KrAoX6bgSZoyIdcylrdqRmKm6RMjzGWBccJMw+
         NHcfPnKCH1opzs/FmsBfWKgaTJRC6CKUO9v2aIZKqRwkrDobQtHZbJwqnUdmvsVUAkVg
         c8gTtX6jg9r/uHcMxDem1+aqoNBQzVgeevG7M760lNXqp0t6dg0qz6FHl1JqM4NYyFET
         t0VIED5Nz9kr3548bZ+jhqOgeP3lu5YTsHI6SsqnXZxslE+OCjLPKs69tjczXIuIikBw
         XPUwr2xG+yUmIrZnFFMS863G9TMHtvDc/wJk2mGxVH4+7qSg/14nACJkQ4+U4hfX+JST
         Wxuw==
X-Gm-Message-State: APjAAAXESN/3OgY7+hFUQPokhzps4S4q7zKmLU5g1X+N16cGfMtqIocc
        pyopHrjWlFGm3phfeghF3lP+0uhOwAkBkVWZagelIA==
X-Google-Smtp-Source: APXvYqzviDjzjYdWIBVaJpSRjyKleEqm2u85x/m07Z2DV2q8u5GPTnMR/uRE5Kmk5P/uhgd17AisLoKNThhGARfz6qk=
X-Received: by 2002:a1c:3d08:: with SMTP id k8mr1722499wma.119.1573118430458;
 Thu, 07 Nov 2019 01:20:30 -0800 (PST)
MIME-Version: 1.0
References: <1573115061-34791-1-git-send-email-kong.kongxinwei@hisilicon.com>
In-Reply-To: <1573115061-34791-1-git-send-email-kong.kongxinwei@hisilicon.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 7 Nov 2019 10:20:19 +0100
Message-ID: <CAKv+Gu9vwDGeCrNYFEbQC0f6kLN1oEiKx9AjA9UpvHm1Q-0nSg@mail.gmail.com>
Subject: Re: [PATCH V2] EFI/stub: tpm: enable tpm eventlog function for ARM64 platform
To:     Xinwei Kong <kong.kongxinwei@hisilicon.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steve Capper <steve.capper@arm.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>, zoucao@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 7 Nov 2019 at 09:23, Xinwei Kong <kong.kongxinwei@hisilicon.com> wrote:
>
> this patch gets tpm eventlog information such as device boot status,event guid
> and so on, which will be from bios stage. it use "efi_retrieve_tpm2_eventlog"
> functions to get it for ARM64 platorm.
>
> Tested-by: Zou Cao <zoucao@linux.alibaba.com>
> Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>

Thanks. I'll queue this up.

> ---
>  drivers/firmware/efi/libstub/arm-stub.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
> index c382a48..817237c 100644
> --- a/drivers/firmware/efi/libstub/arm-stub.c
> +++ b/drivers/firmware/efi/libstub/arm-stub.c
> @@ -189,6 +189,8 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table,
>                 goto fail_free_cmdline;
>         }
>
> +       efi_retrieve_tpm2_eventlog(sys_table);
> +
>         /* Ask the firmware to clear memory on unclean shutdown */
>         efi_enable_reset_attack_mitigation(sys_table);
>
> --
> 2.7.4
>
