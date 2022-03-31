Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63494EDECB
	for <lists+linux-efi@lfdr.de>; Thu, 31 Mar 2022 18:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbiCaQ2k (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 31 Mar 2022 12:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbiCaQ2j (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 31 Mar 2022 12:28:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54906A01F;
        Thu, 31 Mar 2022 09:26:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80105B8218D;
        Thu, 31 Mar 2022 16:26:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D55FC340F3;
        Thu, 31 Mar 2022 16:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648744009;
        bh=Fi29zH/dyHSzp3dAKxwvQUC4j76Ay7mtWm2iwZJrAdc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JKq3a/26rubuO20/NiStfyKorOy2c+93e35TjulUFXtfd16K7aYUX2FxzQCy7faMH
         j1vt1zzNlS3fjUaXqOt/9IXZGunSZvnTdgQQAaEaXI+jKiWs0mM/l2F88oA+R0irXp
         1ldglz/nsCa4qBYvhfzUzug/CwAYmw/jIxMIFbtQE2H0L5xXZN4ly2Ai2H40uduffQ
         qtft2dtkFhZSZ7kWBhsAylgb9cBKq3mc6wza6xzMZCVh0GIGl9GYnBGrYZ8whG/Kzs
         YCursU/Evv71+9L2U++31jKcCAHq23av0keh+56o7tEctzijZ3h0me9MrAy7z78SFP
         aLBxnyQZX0oQQ==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-de3eda6b5dso25952865fac.0;
        Thu, 31 Mar 2022 09:26:49 -0700 (PDT)
X-Gm-Message-State: AOAM532m20mC+qfWoMkIn00Tjiafctwdg1lGcWRuRYiqPbGc3U2HZedj
        vLKHPE0Ocv8zvMUbBKUAplOBI5GgEMIP3WX8ueU=
X-Google-Smtp-Source: ABdhPJxHe52iIX0kUeRpuEF42n49iMCyW0ZRO4wtNoSQW4gUguuVEnnICF17DZZ2EkFQjaNFGc6c7qZBJ2+mvDgaoz8=
X-Received: by 2002:a05:6870:eaa5:b0:da:b3f:2b45 with SMTP id
 s37-20020a056870eaa500b000da0b3f2b45mr3049827oap.228.1648744008366; Thu, 31
 Mar 2022 09:26:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220331151654.184433-1-javierm@redhat.com>
In-Reply-To: <20220331151654.184433-1-javierm@redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 31 Mar 2022 18:26:37 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHgyjB_BVzXx+CK0tBuJpZ3h=8XKus7nWiyovECjVQ0gw@mail.gmail.com>
Message-ID: <CAMj1kXHgyjB_BVzXx+CK0tBuJpZ3h=8XKus7nWiyovECjVQ0gw@mail.gmail.com>
Subject: Re: [PATCH v2] efi: Allow to enable EFI runtime services by default
 on RT
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Brian Masney <bmasney@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Al Stone <ahs3@redhat.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Robbie Harwood <rharwood@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Alexander Larsson <alexl@redhat.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 31 Mar 2022 at 17:17, Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> Commit d9f283ae71af ("efi: Disable runtime services on RT") disabled EFI
> runtime services by default when the CONFIG_PREEMPT_RT option is enabled.
>
> The rationale for that commit is that some EFI calls could take too much
> time, leading to large latencies which is an issue for Real-Time kernels.
>
> But a side effect of that change was that now is not possible anymore to
> enable the EFI runtime services by default when CONFIG_PREEMPT_RT is set,
> without passing an efi=runtime command line parameter to the kernel.
>
> Instead, let's add a new EFI_DISABLE_RUNTIME boolean Kconfig option, that
> would be set to n by default but to y if CONFIG_PREEMPT_RT is enabled.
>
> That way, the current behaviour is preserved but gives users a mechanism
> to enable the EFI runtimes services in their kernels if that is required.
> For example, if the firmware could guarantee bounded time for EFI calls.
>
> Also, having a separate boolean config could allow users to disable the
> EFI runtime services by default even when CONFIG_PREEMPT_RT is not set.
>
> Reported-by: Alexander Larsson <alexl@redhat.com>
> Fixes: d9f283ae71af ("efi: Disable runtime services on RT")
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
>
> Changes in v2:
> - Improve commit description to make clear the motivation for the change
>   (Sebastian Andrzej Siewior).
>

This looks ok to me. I'll queue this up once the merge window closes.

>  drivers/firmware/efi/Kconfig | 15 +++++++++++++++
>  drivers/firmware/efi/efi.c   |  2 +-
>  2 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> index 2c3dac5ecb36..243882f5e5f9 100644
> --- a/drivers/firmware/efi/Kconfig
> +++ b/drivers/firmware/efi/Kconfig
> @@ -284,3 +284,18 @@ config EFI_CUSTOM_SSDT_OVERLAYS
>
>           See Documentation/admin-guide/acpi/ssdt-overlays.rst for more
>           information.
> +
> +config EFI_DISABLE_RUNTIME
> +       bool "Disable EFI runtime services support by default"
> +       default y if PREEMPT_RT
> +       help
> +         Allow to disable the EFI runtime services support by default. This can
> +         already be achieved by using the efi=noruntime option, but it could be
> +         useful to have this default without any kernel command line parameter.
> +
> +         The EFI runtime services are disabled by default when PREEMPT_RT is
> +         enabled, because measurements have shown that some EFI functions calls
> +         might take too much time to complete, causing large latencies which is
> +         an issue for Real-Time kernels.
> +
> +         This default can be overridden by using the efi=runtime option.
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 5502e176d51b..ff57db8f8d05 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -66,7 +66,7 @@ struct mm_struct efi_mm = {
>
>  struct workqueue_struct *efi_rts_wq;
>
> -static bool disable_runtime = IS_ENABLED(CONFIG_PREEMPT_RT);
> +static bool disable_runtime = IS_ENABLED(CONFIG_EFI_DISABLE_RUNTIME);
>  static int __init setup_noefi(char *arg)
>  {
>         disable_runtime = true;
> --
> 2.35.1
>
