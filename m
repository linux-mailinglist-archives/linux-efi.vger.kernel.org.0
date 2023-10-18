Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514D67CD6AB
	for <lists+linux-efi@lfdr.de>; Wed, 18 Oct 2023 10:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344707AbjJRIeg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 Oct 2023 04:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344691AbjJRIef (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 18 Oct 2023 04:34:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97CFEA;
        Wed, 18 Oct 2023 01:34:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95740C433CC;
        Wed, 18 Oct 2023 08:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697618073;
        bh=e0/tLgWp3Fu9ToI74EjHZd9g3HhzexfIH4YlFtIwZkI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HMRxHCPY25ubWalUxxnntH7qnUnFPgtAWbMUiqchX5mingejzAtUfrmHRnXORZIIk
         WPNX0XEaKPuxXQsfQirLz/312tsDrnB+I9+V5wUa3wg1iPO7fjSmigEmJMzKgYY6wB
         aR07GhLIIrrQD1bUzLSZqBCS81hjDIsi2S/rWYVQ3RuJqK6nEC1nwBFBDE43hc538s
         RMz3Vklr35OH4ZwmypPEcIpaVvAUiyp/SIAMzl032Nfb1WsquABcZDoEo6IjNxQ0+e
         HnTOB8kHn7eQUGHjPByVFkAvGcOIxJ/1MHJjwHRbJDnhhIW3as9XGmp/OMd3xUkvtE
         JCxZ9HbtFc9bw==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2c503dbe50dso78025931fa.1;
        Wed, 18 Oct 2023 01:34:33 -0700 (PDT)
X-Gm-Message-State: AOJu0YzbDOz2EVjpi6LsuQBjvT9As20zl5S7/QsVOKtSp/58/SzTwtRf
        XAyBuw7x9kz3etd/f4XnXsSFDUlRruXIBrBVuUE=
X-Google-Smtp-Source: AGHT+IE5a2lrvw2Wt7BeIGgD9Uaeung7naZoNcvR7dRD7rq0Odugb9Bi43NOhKmXgImP9IVoEkj3DilxGWRbTbPrtRI=
X-Received: by 2002:a2e:8750:0:b0:2c5:2813:5534 with SMTP id
 q16-20020a2e8750000000b002c528135534mr3664290ljj.51.1697618071819; Wed, 18
 Oct 2023 01:34:31 -0700 (PDT)
MIME-Version: 1.0
References: <Nh-DzlX--3-9@bens.haus>
In-Reply-To: <Nh-DzlX--3-9@bens.haus>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 18 Oct 2023 10:34:20 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFKe6piagNLdSUhxUhwLB+RfNHqjNWt8-r2CNS-rBdJKA@mail.gmail.com>
Message-ID: <CAMj1kXFKe6piagNLdSUhxUhwLB+RfNHqjNWt8-r2CNS-rBdJKA@mail.gmail.com>
Subject: Re: [REGRESSION] boot fails for EFI boot stub loaded by u-boot
To:     Ben Schneider <ben@bens.haus>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc:     Regressions <regressions@lists.linux.dev>,
        Linux Efi <linux-efi@vger.kernel.org>,
        Stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

(cc Heinrich)

Hello Ben,

Thanks for the report.

On Wed, 18 Oct 2023 at 03:19, Ben Schneider <ben@bens.haus> wrote:
>
> Hi Ard,
>
> I have an ESPRESSObin Ultra (aarch64) that uses U-Boot as its bootloader.=
 It shipped from the manufacturer with with v5.10, and I've been trying to =
upgrade. U-Boot supports booting Image directly via EFI (https://u-boot.rea=
dthedocs.io/en/latest/usage/cmd/bootefi.html), and I have been using it tha=
t way to successfully boot the system up to and including v6.0.19. However,=
 v6.1 and v6.5 kernels fail to boot.
>
> When booting successfully, the following messages are displayed:
>
> EFI stub: Booting Linux Kernel...EFI stub: ERROR: FIRMWARE BUG: efi_loade=
d_image_t::image_base has bogus value
> EFI stub: ERROR: FIRMWARE BUG: kernel image not aligned on 64k boundary
> EFI stub: Using DTB from configuration table
> EFI stub: ERROR: Failed to install memreserve config table!
> EFI stub: Exiting boot services...
> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
>
> I suspect many of the above error messages are simply attributable to usi=
ng U-Boot to load an EFI stub and can be safely ignored given that the syst=
em boots and runs fine.
>

I suspect that these are not as harmless as you think. How old is the
u-boot build on this platform?

> When boot fails (v6.5), the following messages are displayed:
>
> EFI stub: Booting Linux Kernel...
> EFI stub: ERROR: FIRMWARE BUG: efi_loaded_image_t::image_base has bogus v=
alue
> EFI stub: ERROR: FIRMWARE BUG: kernel image not aligned on 64k boundary
> EFI stub: ERROR: Failed to install memreserve config table!
> EFI stub: Using DTB from configuration table
> EFI stub: Exiting boot services...
> EFI stub: ERROR: Unable to construct new device tree.
> EFI stub: ERROR: Failed to update FDT and exit boot services
>
> In case it's relevant, the device tree for this device is arch/arm64/boot=
/marvell/armada-3720-espressobin-ultra.dts
>

This is a uboot path, right? Not a linux path? Are you sure this DTS
is compatible with the v6.5 kernel?

> Hopefully I've reported this in the correct place or that the information=
 provided is sufficient to get it where it needs to be. Let me know if ther=
e is additional information I can provide. I am also able to use the device=
 to test.
>

Please add some efi_warn() message inside the update_fdt() routine in
drivers/firmware/efi/libstub/fdt.c to narrow down which call is
causing it to return an error. Nothing in that code jumps out to me,
but we regularly update libfdt in the kernel as well, so it might be a
change in there that triggers this.
