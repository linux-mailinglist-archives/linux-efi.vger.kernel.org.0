Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3A155EA4D
	for <lists+linux-efi@lfdr.de>; Tue, 28 Jun 2022 18:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbiF1QxQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Jun 2022 12:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235069AbiF1Qvf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Jun 2022 12:51:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5573F13E30;
        Tue, 28 Jun 2022 09:51:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECA8661882;
        Tue, 28 Jun 2022 16:51:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9DAC341C6;
        Tue, 28 Jun 2022 16:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656435060;
        bh=+R7Z7M7c7dZ3tgYK/Q0K4WZLQqV/3vm/Y5n5AvYQ3lo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mAhD0LQsmrgvVnERjgG5YR8WdfUHTTBIeQclpL+sxDOEtQ7EJu/a3kQaSLbrtp5gy
         ld3g6mH/SQdLoP2GCLOGMdmqH5ElOY7wpd/xkAROIYUCYOsMhquCtxsvpw4W9gUUKq
         My6hCr1+ZqQTBNReVQVd9nsEy+AtuLW3Vsr4dGK1EODoxEJdHSWZHkhFQTNI1pVrp+
         wkW15wuFC3i8xqQO2mpgU5V3BlvfaqCBC68Z05O8FRkVkFI9dXda4uWNGpK938i7bt
         fho0Xl3IXa8XQRoVRomGj3ArekPFvKtp9cEI/lr/yd7KXMfx7DM2bgVrOd/gjo1Jvr
         LmWSyMBEFIaBQ==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-101ec2d6087so17831787fac.3;
        Tue, 28 Jun 2022 09:51:00 -0700 (PDT)
X-Gm-Message-State: AJIora9cZMRlZoNjfcbjJWiySV3hXh0oLKhcEN8DR5odFqCHwBCyiPFR
        A9jJFaUFuSbh9ujqoTT0RwOEBWrxMoIMTQAjXbc=
X-Google-Smtp-Source: AGRyM1sJloyVx+H160pshuoAURJL5ByH5V5Q0CiCD7VwcybgS3DwlDicIqOIK0lLRutnbLEL3hvQf70BB/+t2pIWkWQ=
X-Received: by 2002:a05:6870:e98b:b0:fe:219a:2449 with SMTP id
 r11-20020a056870e98b00b000fe219a2449mr313622oao.228.1656435059496; Tue, 28
 Jun 2022 09:50:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220626142958.5790-1-kevinjone25@g.ncu.edu.tw>
In-Reply-To: <20220626142958.5790-1-kevinjone25@g.ncu.edu.tw>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 28 Jun 2022 18:50:48 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGNgWAqX-6tG36iRLFf1TKY7wOp=x_uFZWJCbTvQwrkAQ@mail.gmail.com>
Message-ID: <CAMj1kXGNgWAqX-6tG36iRLFf1TKY7wOp=x_uFZWJCbTvQwrkAQ@mail.gmail.com>
Subject: Re: [PATCH] drivers: fix typo in firmware/efi/memmap.c
To:     Zheng Zhi Yuan <kevinjone25@g.ncu.edu.tw>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 26 Jun 2022 at 16:31, Zheng Zhi Yuan <kevinjone25@g.ncu.edu.tw> wrote:
>
> This patch fixes the spelling error in firmware/efi/memmap.c, changing
> it to the correct word.
>
> Signed-off-by: Zheng Zhi Yuan <kevinjone25@g.ncu.edu.tw>

Queued in efi/next, thanks.

> ---
>  drivers/firmware/efi/memmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
> index 4df55a55da84..7ff9f1e911e1 100644
> --- a/drivers/firmware/efi/memmap.c
> +++ b/drivers/firmware/efi/memmap.c
> @@ -245,7 +245,7 @@ int __init efi_memmap_install(struct efi_memory_map_data *data)
>   * @range: Address range (start, end) to split around
>   *
>   * Returns the number of additional EFI memmap entries required to
> - * accomodate @range.
> + * accommodate @range.
>   */
>  int __init efi_memmap_split_count(efi_memory_desc_t *md, struct range *range)
>  {
> --
> 2.25.1
>
