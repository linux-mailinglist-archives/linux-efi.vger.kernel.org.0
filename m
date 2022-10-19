Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA08604BB6
	for <lists+linux-efi@lfdr.de>; Wed, 19 Oct 2022 17:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbiJSPiL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Oct 2022 11:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiJSPhw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 19 Oct 2022 11:37:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25697159945;
        Wed, 19 Oct 2022 08:34:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1E8861919;
        Wed, 19 Oct 2022 15:32:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37FCFC4347C;
        Wed, 19 Oct 2022 15:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666193555;
        bh=kji4rxqvRz+Go/DtMe396VRJ+YBbpbvKDQh/TscxArg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cIiBukafmleVCO6ydm6mLjVQgp9k6gwAwPDpZWrxpMSdnNcm+pq/9DS3/7aO1+HFX
         uxcjqxFt5e0QzjQOlj5lJsHSH982yKz1xBrm7zEwRyyKOC7osI3RO0WTikfUIgr2/6
         iZpqxDQuQvIpJxSN/+Wp7DxG3co+pBfD828bfft9q9PzHmqnQgdcE05igZAkYLHZjB
         3qmYUXKg9P0fmEOKV90QL1i5nD0ZfMp+0bLJVjNDiiNZ53PwHvXmA1w/ixpA7ZnkOl
         tWRkqvXCoI3T1Dh1o4E1m2QbHQVWFW8G9NBABQV8YhZHQ2d59i+sd9RpGM5hQ/ti9x
         GkhlfNvQRnTgw==
Received: by mail-lj1-f173.google.com with SMTP id b18so22642660ljr.13;
        Wed, 19 Oct 2022 08:32:35 -0700 (PDT)
X-Gm-Message-State: ACrzQf3b4+F83JUabWlQmJ1dEVEq4Mlljq1L3WH0kbiJEz/5yAFdEbEN
        rDgWFwXh/6gx+O2yObq4mkSZAYJ3UEfrK3WdfL0=
X-Google-Smtp-Source: AMsMyM7pzsDICECY9wJRebAiUkJTVqzR4AR221ztThbfN+7YG3MPEXA9aQA5M/ETmfLlBvvoLOyVW4Nr1G5+Mwu3hrA=
X-Received: by 2002:a05:651c:1590:b0:26c:4311:9b84 with SMTP id
 h16-20020a05651c159000b0026c43119b84mr3365582ljq.152.1666193553169; Wed, 19
 Oct 2022 08:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <20221019145600.1282823-1-john.ogness@linutronix.de> <20221019145600.1282823-9-john.ogness@linutronix.de>
In-Reply-To: <20221019145600.1282823-9-john.ogness@linutronix.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 19 Oct 2022 17:32:22 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFuzV9jRfbGvS0MLVVRHrB6nXDE+HKMWYrKEsD2ONLGsw@mail.gmail.com>
Message-ID: <CAMj1kXFuzV9jRfbGvS0MLVVRHrB6nXDE+HKMWYrKEsD2ONLGsw@mail.gmail.com>
Subject: Re: [PATCH printk v2 08/38] efi: earlycon: use console_is_enabled()
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 19 Oct 2022 at 16:56, John Ogness <john.ogness@linutronix.de> wrote:
>
> Replace (console->flags & CON_ENABLED) usage with console_is_enabled().
>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Acked-by: Ard BIesheuvel <ardb@kernel.org>

> ---
>  drivers/firmware/efi/earlycon.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/efi/earlycon.c b/drivers/firmware/efi/earlycon.c
> index a52236e11e5f..8c27eb941d8e 100644
> --- a/drivers/firmware/efi/earlycon.c
> +++ b/drivers/firmware/efi/earlycon.c
> @@ -30,7 +30,7 @@ static void *efi_fb;
>  static int __init efi_earlycon_remap_fb(void)
>  {
>         /* bail if there is no bootconsole or it has been disabled already */
> -       if (!earlycon_console || !(earlycon_console->flags & CON_ENABLED))
> +       if (!earlycon_console || !console_is_enabled(earlycon_console))
>                 return 0;
>
>         efi_fb = memremap(fb_base, screen_info.lfb_size,
> @@ -43,7 +43,7 @@ early_initcall(efi_earlycon_remap_fb);
>  static int __init efi_earlycon_unmap_fb(void)
>  {
>         /* unmap the bootconsole fb unless keep_bootcon has left it enabled */
> -       if (efi_fb && !(earlycon_console->flags & CON_ENABLED))
> +       if (efi_fb && !console_is_enabled(earlycon_console))
>                 memunmap(efi_fb);
>         return 0;
>  }
> --
> 2.30.2
>
