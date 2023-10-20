Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F857D0624
	for <lists+linux-efi@lfdr.de>; Fri, 20 Oct 2023 03:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346758AbjJTBZb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Oct 2023 21:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233387AbjJTBZa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Oct 2023 21:25:30 -0400
Received: from w4.tutanota.de (w4.tutanota.de [81.3.6.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BA2112;
        Thu, 19 Oct 2023 18:25:24 -0700 (PDT)
Received: from tutadb.w10.tutanota.de (unknown [192.168.1.10])
        by w4.tutanota.de (Postfix) with ESMTP id 96A951060136;
        Fri, 20 Oct 2023 01:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1697765123;
        s=s1; d=bens.haus;
        h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
        bh=1jxNhGDyMeJS0OqpiE+P/Rwnl5U2rvW+F1eQUv3MgS8=;
        b=GJGPgQmUcUlpwCwOMIf3JysAHVDLV2sAWhZ+n1Xy5aeXVS2vFvw5H4n5yFejfZZb
        VLXjgLQPofhGyjEbRtOcKhzu71mZ5g1kJBc7i4mqzZD/444iby15s2U3Q1w7YJ2uYEJ
        GXd+oGWYFGaTVOXam5KZvPq0p4Slmtf9ISRjITi4Zy6f5TUVyuMvbCG3G+5/YH657mb
        Eyzi+4geHdOpx762XuoRvvEPMCi1IkxsvzZyzqdZDhAAD0t8aGQzk5Fp1u8CszdQprf
        2CW1psS2i/lknRaDa3Xzof8gkgYuguGLQvqQjL8PQBsYkPrsdustc1etVWcEPpJhMp+
        X4aOWzAXxQ==
Date:   Fri, 20 Oct 2023 03:25:23 +0200 (CEST)
From:   Ben Schneider <ben@bens.haus>
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc:     Regressions <regressions@lists.linux.dev>,
        Linux Efi <linux-efi@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Message-ID: <Nh8pThy--3-9@bens.haus>
In-Reply-To: <57062702-f858-46d3-bccc-f0f96891128b@canonical.com>
References: <Nh-DzlX--3-9@bens.haus> <CAMj1kXFKe6piagNLdSUhxUhwLB+RfNHqjNWt8-r2CNS-rBdJKA@mail.gmail.com> <817366c2-33e0-4908-90ec-57c63e3eb471@canonical.com> <CAC_iWjJB3OTWiYX5YsJmNcPQw+rHSm955c1Z5pUajedWGM5QgA@mail.gmail.com> <Nh30qsF--3-9@bens.haus> <57062702-f858-46d3-bccc-f0f96891128b@canonical.com>
Subject: Re: [REGRESSION] boot fails for EFI boot stub loaded by u-boot
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Oct 19, 2023, 07:21 by heinrich.schuchardt@canonical.com:

> To which kernel and device-tree are the messages below related?
>
Sorry. I'm building/testing with v6.5.7 right now, but I have not been able=
 to boot any kernel version >=3D 6.1. The device tree I used also came from=
 linux v6.5.7. Its source is at arch/arm64/boot/dts/marvell/armada-3720-esp=
ressobin-ultra.dts.

> Something in the structure of your device-tree is invalid.
>
The device does boot using kernel v5.15 and the device tree compiled from l=
inux v6.5.7. The device tree could still very well be a problem. I just did=
n't start there because whatever problems the device tree may have don't pr=
event the device from booting for kernels prior to v6.1.

> Please, check the load addresses in U-Boot. Is something overwriting the =
tail of the device-tree?
>
I have always loaded the device tree to 0x1000000 (16MiB) and the kernel to=
=C2=A00x2000000 (32MiB) for no particular reason except that's what the man=
ufacturer did.=C2=A0armada-3720-espressobin-ultra.dtb is only 14K. I don't =
load an initramfs or anything else to memory with u-boot and the address us=
ed to load u-boot environment is 0x6000000.

> Compiling upstream U-Boot's qemu_arm64_defconfig yields lib/efi_loader/dt=
bdump.efi. If you run this instead of the kernel, you can write the device-=
tree as it is passed in a configuration table to the ESP.
>
I compiled and ran this fine, but I was unable to save the device tree. I s=
uspect this is because the program searches for an ESP, and there is none o=
n the device. U-boot was compiled with support to load directly from an ext=
4 filesystem so I didn't bother setting one up. I will work on it. I can co=
nvert the .dtb on disk back to a human-readable .dts easily with dtc if tha=
t is helpful.

Thanks!

Ben
