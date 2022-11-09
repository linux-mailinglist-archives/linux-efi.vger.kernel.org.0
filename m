Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37B862269F
	for <lists+linux-efi@lfdr.de>; Wed,  9 Nov 2022 10:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiKIJRX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Nov 2022 04:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbiKIJRC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Nov 2022 04:17:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989261FCD8
        for <linux-efi@vger.kernel.org>; Wed,  9 Nov 2022 01:16:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E507AB81D1C
        for <linux-efi@vger.kernel.org>; Wed,  9 Nov 2022 09:16:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A934C433D7
        for <linux-efi@vger.kernel.org>; Wed,  9 Nov 2022 09:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667985402;
        bh=zjlG/XncGjQbfw9DcYvxIZBViHo5QQ1DfpR7iccAdGQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XXq/c/3tdmwlxEnQoWTLmiRWUohU5B+twwR4+UPqGIuqJUdlvOaXrSHQrVBXG3Y3b
         n6nf1GY9+GKnO+h/UJb5XcNu3jM8u7/MuzOTCsoqRFM5AxgIC0gKan3ZpRpTvT+rhW
         aGZXy3v2yMDTv5AQQq9yCOdStWppvRtgd2D3U/osskGs18PcKud8vvPQix0V9wrgCT
         vpB7yF7fL7xsurbUJTQA8cL2upOAqBI9Fuj6L/djmoAw8uN7oqV7kYYqWtA5qjiC+U
         h48HLXBLGSn/SK5hxfTr9oxDKTutLru27LWYLvI3gyOaT5IgOangBqgDT6Zicqt/dl
         +Flez+xLW1M9Q==
Received: by mail-lf1-f52.google.com with SMTP id b3so24758660lfv.2
        for <linux-efi@vger.kernel.org>; Wed, 09 Nov 2022 01:16:42 -0800 (PST)
X-Gm-Message-State: ACrzQf1A1JXcZhpnZ1KbFn4ydxzKOJOgqoDVzbl4AkDFkuuKDpYsRi8Q
        eECvl1wEd8tbHr/ICgpAfc/gIbPAEKPGjhj84is=
X-Google-Smtp-Source: AMsMyM4P2LJAJJFyPxwx751SoE7CVfUX543iwJwThBFwQnOOCZakt52c/eHsSHAixboaVeeu04840wdxAvvsxUR0Noc=
X-Received: by 2002:ac2:4c47:0:b0:4a2:c07b:4b62 with SMTP id
 o7-20020ac24c47000000b004a2c07b4b62mr19528046lfk.426.1667985400570; Wed, 09
 Nov 2022 01:16:40 -0800 (PST)
MIME-Version: 1.0
References: <20221108025310.1393687-1-zhangjialin11@huawei.com>
In-Reply-To: <20221108025310.1393687-1-zhangjialin11@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 9 Nov 2022 10:16:29 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEgkr-j8UD=o+_CHQQ5XWOECbo+70bsEPx8-_E_6mLRJQ@mail.gmail.com>
Message-ID: <CAMj1kXEgkr-j8UD=o+_CHQQ5XWOECbo+70bsEPx8-_E_6mLRJQ@mail.gmail.com>
Subject: Re: [PATCH] efi: libstub: fix efi_load_initrd_dev_path() kernel-doc comment
To:     Jialin Zhang <zhangjialin11@huawei.com>
Cc:     ilias.apalodimas@linaro.org, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 8 Nov 2022 at 03:54, Jialin Zhang <zhangjialin11@huawei.com> wrote:
>
> commit f4dc7fffa987 ("efi: libstub: unify initrd loading between
> architectures") merge the first and the second parameters into a
> struct without updating the kernel-doc. Let's fix it.
>
> Fixes: f4dc7fffa987 ("efi: libstub: unify initrd loading between architectures")
> Signed-off-by: Jialin Zhang <zhangjialin11@huawei.com>

Thanks, queued up in efi/next

> ---
>  drivers/firmware/efi/libstub/efi-stub-helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> index 0c493521b25b..1a42dedcce3c 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> @@ -626,8 +626,8 @@ static const struct {
>
>  /**
>   * efi_load_initrd_dev_path() - load the initrd from the Linux initrd device path
> - * @load_addr: pointer to store the address where the initrd was loaded
> - * @load_size: pointer to store the size of the loaded initrd
> + * @initrd:    pointer of struct to store the address where the initrd was loaded
> + *             and the size of the loaded initrd
>   * @max:       upper limit for the initrd memory allocation
>   *
>   * Return:
> --
> 2.25.1
>
