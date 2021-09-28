Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F59D41B015
	for <lists+linux-efi@lfdr.de>; Tue, 28 Sep 2021 15:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240856AbhI1NcY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Sep 2021 09:32:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:37668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240833AbhI1NcY (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 28 Sep 2021 09:32:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D1C81611CE
        for <linux-efi@vger.kernel.org>; Tue, 28 Sep 2021 13:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632835844;
        bh=DmLOHDiCAdZfM4ufPqMjyXH/X80JDRebHwOof7vDONQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H9Gd23vQmMvBHZ0xWo2z6wkATuyXZe36TlizmDTD8Quq09Ba52edL1X/ovevRGaF4
         bt4jvhpdjB7uKu+jmFW7xeo1Nsp2KJwwIl616TVVXfNPCnF/OR1NhtlxHcCGmF/kDD
         +RZzzq8mM9Rd8MwD5ipstPJO6kFX+878pD2GZpySGWUQcOh8kS8deQqpceNYtRwyvn
         KRS87RpWlkPrpViEMdAiBzf1YvBQF6tH4kM8Y3jwS4KEGJ96XJ0CcQFbW3hCOizbnx
         wAgA/txlHgZKv/UKq6Lwc6wOTTJ8DGVNXkL9OD9Lij+tN/mfbkBJdq/GosbpOipAMD
         Jg8sIxyLm213Q==
Received: by mail-oi1-f169.google.com with SMTP id z11so30000749oih.1
        for <linux-efi@vger.kernel.org>; Tue, 28 Sep 2021 06:30:44 -0700 (PDT)
X-Gm-Message-State: AOAM530VC+kiRkQRHnrCJcPcCaJ2BGOoPUksWHH56YOoklz6pQcwHdHf
        NwyPGLADTLUKmSQ5ptETP41JEg+R4QZC2XRdANs=
X-Google-Smtp-Source: ABdhPJxWw9eImyUy3bozEy0OpqF83vpux2N1e6XlG8T9pll7ZaI8+S6/oUUFpwO3ZP31T5NoHsAFRdnNd63YzhEhGT8=
X-Received: by 2002:aca:3114:: with SMTP id x20mr3656474oix.174.1632835844241;
 Tue, 28 Sep 2021 06:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210924134919.1913476-1-bigeasy@linutronix.de> <20210924134919.1913476-2-bigeasy@linutronix.de>
In-Reply-To: <20210924134919.1913476-2-bigeasy@linutronix.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 28 Sep 2021 15:30:32 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFJm-su9tc20n+DyJjMwrhK6R4BR0Kd_ov62NqXd-jwUw@mail.gmail.com>
Message-ID: <CAMj1kXFJm-su9tc20n+DyJjMwrhK6R4BR0Kd_ov62NqXd-jwUw@mail.gmail.com>
Subject: Re: [PATCH 1/2] efi: Disable runtime services on RT
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 24 Sept 2021 at 15:49, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> Based on measurements the EFI functions get_variable /
> get_next_variable take up to 2us which looks okay.
> The functions get_time, set_time take around 10ms. These 10ms are too
> much. Even one ms would be too much.
> Ard mentioned that SetVariable might even trigger larger latencies if
> the firmware will erase flash blocks on NOR.
>
> The time-functions are used by efi-rtc and can be triggered during
> run-time (either via explicit read/write or ntp sync).
>
> The variable write could be used by pstore.
> These functions can be disabled without much of a loss. The poweroff /
> reboot hooks may be provided by PSCI.
>
> Disable EFI's runtime wrappers on PREEMPT_RT.
>
> This was observed on "EFI v2.60 by SoftIron Overdrive 1000".
>
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/firmware/efi/efi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 847f33ffc4aed..39031cfcb6b92 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -66,7 +66,7 @@ struct mm_struct efi_mm = {
>
>  struct workqueue_struct *efi_rts_wq;
>
> -static bool disable_runtime;
> +static bool disable_runtime = IS_ENABLED(CONFIG_PREEMPT_RT);
>  static int __init setup_noefi(char *arg)
>  {
>         disable_runtime = true;



This is generic code and the commit log only talks about arm64. How
about other architectures?
