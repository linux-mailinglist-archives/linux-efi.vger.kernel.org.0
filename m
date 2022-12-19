Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0969C650D81
	for <lists+linux-efi@lfdr.de>; Mon, 19 Dec 2022 15:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbiLSOkU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 19 Dec 2022 09:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbiLSOkR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 19 Dec 2022 09:40:17 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06639FD
        for <linux-efi@vger.kernel.org>; Mon, 19 Dec 2022 06:40:16 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id m19so13120780edj.8
        for <linux-efi@vger.kernel.org>; Mon, 19 Dec 2022 06:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ua8Y8Z4pBPkKAQrNbMtdprGt9Mnzjiq5jD7V9dAC+Y0=;
        b=G3jXAcTBG6DW2mXzZQy+MnSYx8QarWdNCLBbbNBf4dhSNyVBq7+tEuaA8nyoaQzHSC
         T2/AIr30A5/xKEqRRe96P6L1Kz8ZiWzCzLOw0JTafXjpX47GhUMZYFYBTmWyndCj6FYi
         QcyLrVVakhlCJTGDmmXtF61fQr0qclIZ02oGkotXAUi4QmRdWjIjXzedXDc76uwZmtVv
         5dobDMpTQsN/K4hVVIZO7KFQjnIqkV8OEpf85/eKN00wxZ4v7c+gRFwKuma8TlvrgAQn
         xXQIkYf5FFIpu4sCY6SgYscXB2g1shNDKxSaI0FMWEEYAm5iphgy7A0g3hGJT//i2T1S
         x2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ua8Y8Z4pBPkKAQrNbMtdprGt9Mnzjiq5jD7V9dAC+Y0=;
        b=XeoioUykKaxWAvHgcxBJ+NY2XXkGLEpCaYEbaTo9Si2LPdU39wQbnFAwObY+SbwDtT
         wqRrpBpe3nGkpWaUKvjA0zHa2WewMS491GfSXAOB6zDRfR0jhf2AYXD1LfIcS7d7C4PZ
         QnhQ5xoJvcpJUAJiSkkkq0m18P8Zf8DHZ+B/VtMf81Csfmj5f+yjiXcRmkb9JgeY0S+k
         G6c9cHKx1wL4rs/UN33MifFug2iUguAax/MwnkEcjuYrI6uWeROSDU+m6mSNIB0sdaAS
         HPUETM7YWATMmVBHqL8iorYT5OqYABMzYJw36ft+VQCGha0wWQ59iKEiJM6Hm/5zy2d+
         u4Lw==
X-Gm-Message-State: ANoB5pmA1AHMGwLL32Ai1qtjqKuOMKLO0inXNpqTJsufsAC8cp4Xi9Nj
        TbscA1MKdlfW3qmiRmz4EdwxgP7xOSGmI8ACW9p86w==
X-Google-Smtp-Source: AA0mqf7TLwr4RwvBIZNE9XLvZOJZLpbzN3o7oBcTc6f2+HcefZvPXkuFp5X4hDGTMYSF6KZgK/oIBfpMQTQclJUTTVA=
X-Received: by 2002:aa7:cd04:0:b0:46b:34c:5574 with SMTP id
 b4-20020aa7cd04000000b0046b034c5574mr52252953edw.175.1671460814633; Mon, 19
 Dec 2022 06:40:14 -0800 (PST)
MIME-Version: 1.0
References: <20221219101237.9872-1-johan+linaro@kernel.org>
In-Reply-To: <20221219101237.9872-1-johan+linaro@kernel.org>
From:   Steev Klimaszewski <steev@kali.org>
Date:   Mon, 19 Dec 2022 08:40:03 -0600
Message-ID: <CAKXuJqjBUnW_6P8SQ2jePA9n3UddgPOpe3EwoC+k=_5KRno1wQ@mail.gmail.com>
Subject: Re: [PATCH v2] efi: random: fix NULL-deref when refreshing seed
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Andrew Halaney <ahalaney@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Dec 19, 2022 at 4:13 AM Johan Hovold <johan+linaro@kernel.org> wrote:
>
> Do not try to refresh the RNG seed in case the firmware does not support
> setting variables.
>
> This is specifically needed to prevent a NULL-pointer dereference on the
> Lenovo X13s with some firmware revisions, or more generally, whenever
> the runtime services have been disabled (e.g. efi=noruntime or with
> PREEMPT_RT).
>
> Fixes: e7b813b32a42 ("efi: random: refresh non-volatile random seed when RNG is initialized")
> Reported-by: Steev Klimaszewski <steev@kali.org>
> Reported-by: Bjorn Andersson <andersson@kernel.org>
> Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-thinkpad-x13s
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>
> Changes in v2
>  - amend commit message with a comment on this being needed whenever the
>    runtime services have been disabled
>
>
>  drivers/firmware/efi/efi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 31a4090c66b3..09716eebe8ac 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -429,7 +429,9 @@ static int __init efisubsys_init(void)
>                 platform_device_register_simple("efi_secret", 0, NULL, 0);
>  #endif
>
> -       execute_with_initialized_rng(&refresh_nv_rng_seed_nb);
> +       if (efi_rt_services_supported(EFI_RT_SUPPORTED_SET_VARIABLE))
> +               execute_with_initialized_rng(&refresh_nv_rng_seed_nb);
> +
>         return 0;
>
>  err_remove_group:
> --
> 2.37.4
>
Andrew already sent one, but also confirming since I reported it, this
fixes the issue for me as well.
Tested-by: Steev Klimaszewski <steev@kali.org>
