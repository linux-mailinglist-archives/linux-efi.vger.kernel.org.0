Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC36065AFE2
	for <lists+linux-efi@lfdr.de>; Mon,  2 Jan 2023 11:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbjABKuW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 Jan 2023 05:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbjABKuE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 2 Jan 2023 05:50:04 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2BAC4C;
        Mon,  2 Jan 2023 02:50:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 23B13CE0E30;
        Mon,  2 Jan 2023 10:50:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E8FC433D2;
        Mon,  2 Jan 2023 10:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672656599;
        bh=BuamJpxz7DXOVC9l0PQaBn/iD8PRHWXgD7UEhNzgLBA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FUCQAJpVkdxq7InQe+EFb+dA4UgvMdt6Ust1q4eodZdZDdJ/cCl6QJPQHfXNmbwkS
         tdx2IYZAS+Z4g0HJIO4jsJQ/43yL5KT3Mg+ZYagb5BiZ+mSdPVxvce9qo6yMwwl5Jy
         sQmD5m2PEXvBCGfLZG202kpYcJv+g/38fWaeRfy1JJcWA0YuEJDNHZ2D3xeFQUVX1G
         gdxE31Z+PjWPSi7zss5Dn1ywkmERq91O2TpOxvyV0PZwPFEw1jYPDOPd5LSF/bbqf6
         /Q2l6veHX5XeugmEZkLVOVIN7YsCD8WVw31itUWqOzoXaPPSxFMIViM0CR+0hRKHPg
         n6k/Gm/qszO9Q==
Received: by mail-lf1-f51.google.com with SMTP id bp15so41081740lfb.13;
        Mon, 02 Jan 2023 02:49:59 -0800 (PST)
X-Gm-Message-State: AFqh2kru0msKBzJJv9wOG54lOFhBUa2BimIvwvrRL/2lEBnjgY7sZSg6
        26VrbDGabtOocgiXz5/a054TzKP+aCF4BeBOot0=
X-Google-Smtp-Source: AMrXdXtMMKoFZhWJzoGgtUX9+6W+syj5zeF2H09icN9cF8KAMuFxzGzGmunpkUcrOtjZBGa/CyDmdlUb+fkB8aD4GR0=
X-Received: by 2002:ac2:5dfa:0:b0:4b7:3a0:45d2 with SMTP id
 z26-20020ac25dfa000000b004b703a045d2mr2064999lfq.228.1672656597375; Mon, 02
 Jan 2023 02:49:57 -0800 (PST)
MIME-Version: 1.0
References: <20221227150936.19242-1-dinghui@sangfor.com.cn>
In-Reply-To: <20221227150936.19242-1-dinghui@sangfor.com.cn>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 2 Jan 2023 11:49:46 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFFA0SVa1_Zw+jT4Tqm2XynutN=T9BjaDxfaSR-ataoUg@mail.gmail.com>
Message-ID: <CAMj1kXFFA0SVa1_Zw+jT4Tqm2XynutN=T9BjaDxfaSR-ataoUg@mail.gmail.com>
Subject: Re: [PATCH] efi: fix userspace infinite retry read efivars after EFI
 runtime services page fault
To:     Ding Hui <dinghui@sangfor.com.cn>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        sai.praneeth.prakhya@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 27 Dec 2022 at 16:18, Ding Hui <dinghui@sangfor.com.cn> wrote:
>
> After [1][2], if we catch exceptions due to EFI runtime service, we will
> clear EFI_RUNTIME_SERVICES bit to disable EFI runtime service, then the
> subsequent routine which invoke the EFI runtime service should fail.
>
> But the userspace cat efivars through /sys/firmware/efi/efivars/ will stuck
> and infinite loop calling read() due to efivarfs_file_read() return -EINTR.
>
> The -EINTR is converted from EFI_ABORTED by efi_status_to_err(), and is
> an improper return value in this situation, so let virt_efi_xxx() return
> EFI_DEVICE_ERROR and converted to -EIO to invoker.
>
> [1]: commit 3425d934fc03 ("efi/x86: Handle page faults occurring while running EFI runtime services")
> [2]: commit 23715a26c8d8 ("arm64: efi: Recover from synchronous exceptions occurring in firmware")
>
> Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>

Thanks for the fix, queued up in efi/urgent now.

> ---
>  drivers/firmware/efi/runtime-wrappers.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
> index 7feee3d9c2bf..1fba4e09cdcf 100644
> --- a/drivers/firmware/efi/runtime-wrappers.c
> +++ b/drivers/firmware/efi/runtime-wrappers.c
> @@ -62,6 +62,7 @@ struct efi_runtime_work efi_rts_work;
>                                                                         \
>         if (!efi_enabled(EFI_RUNTIME_SERVICES)) {                       \
>                 pr_warn_once("EFI Runtime Services are disabled!\n");   \
> +               efi_rts_work.status = EFI_DEVICE_ERROR;                 \
>                 goto exit;                                              \
>         }                                                               \
>                                                                         \
> --
> 2.17.1
>
