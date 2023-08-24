Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC65B786C1C
	for <lists+linux-efi@lfdr.de>; Thu, 24 Aug 2023 11:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240366AbjHXJgz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Aug 2023 05:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240610AbjHXJgn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Aug 2023 05:36:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A82010DA;
        Thu, 24 Aug 2023 02:36:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3BD763879;
        Thu, 24 Aug 2023 09:36:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2A0C433C7;
        Thu, 24 Aug 2023 09:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692869800;
        bh=a4WM35KDIx9u2vIQWbx5TpnqxyINKnrnAWFNYPvujLs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V70/DIn+dP/B+UgCZtuMEuNczXQxgInNYnXeyNbONvHj0vlkZ20eFadCW47nNo/IV
         0d4APK6vgqBSS9bt4cU91r68XuvwUYHudHHa1PtDeQPGyrdocmbTv8bi4/MXbWvdPa
         RgLlQYukncys6CZZoExSESqeUgBHSTB1PfJKATAViU+2F214yI7d1PgWrzsUzY+Bbr
         CIElFeH+cEVJsG0Vh2+cdcF0RMtIpa1CyluWJI/vtGwuoCvPPgS1WcVh0PO6B3xLJ5
         Hr7i19oWkk9/odoJj8TMqCS4S5cpPymhKD7MncnQojrYdByFHo/O4o9Zd2x7wlSX3F
         EqSMADzLpdRwg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4ff8f2630e3so10395890e87.1;
        Thu, 24 Aug 2023 02:36:40 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw4xtj3DAP6bk9TZIYLP5CMTZkgYoakXih8jtBfvL7pir1THyh2
        eIl0Krgt8LUnCS0Ey7qMQ15//H9f+MyZxcvChfk=
X-Google-Smtp-Source: AGHT+IEDjp4tvUZBDNVVjbgpu7zoJGI6qrScodL2WqnvOWVnQR8xPb2yhK9UzribHjY2bnTfEAZzejMN1oekQgB54Dc=
X-Received: by 2002:a05:6512:2247:b0:500:83d0:a0ee with SMTP id
 i7-20020a056512224700b0050083d0a0eemr9871915lfu.69.1692869798252; Thu, 24 Aug
 2023 02:36:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230823215159.29082-1-mikel@mikelr.com>
In-Reply-To: <20230823215159.29082-1-mikel@mikelr.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 24 Aug 2023 11:36:26 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGVMcMqQwaFizX+T+YUKrFcVfPgWhU3GuPfdH=CbFV4sg@mail.gmail.com>
Message-ID: <CAMj1kXGVMcMqQwaFizX+T+YUKrFcVfPgWhU3GuPfdH=CbFV4sg@mail.gmail.com>
Subject: Re: [PATCH] x86/efistub: Fix PCI ROM preservation in mixed mode
To:     Mikel Rychliski <mikel@mikelr.com>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 23 Aug 2023 at 23:53, Mikel Rychliski <mikel@mikelr.com> wrote:
>
> preserve_pci_rom_image() was accessing the romsize field in
> efi_pci_io_protocol_t directly instead of using the efi_table_attr()
> helper. This prevents the ROM image from being saved correctly during a
> mixed mode boot.
>
> Fixes: 2c3625cb9fa2 ("efi/x86: Fold __setup_efi_pci32() and __setup_efi_pci64() into one function")
> Signed-off-by: Mikel Rychliski <mikel@mikelr.com>

Thanks, I've queued this up as a fix.


> ---
>  drivers/firmware/efi/libstub/x86-stub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index e976288728e9..2fee52ed335d 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -72,7 +72,7 @@ preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
>         rom->data.type  = SETUP_PCI;
>         rom->data.len   = size - sizeof(struct setup_data);
>         rom->data.next  = 0;
> -       rom->pcilen     = pci->romsize;
> +       rom->pcilen     = romsize;
>         *__rom = rom;
>
>         status = efi_call_proto(pci, pci.read, EfiPciIoWidthUint16,
> --
> 2.35.3
>
