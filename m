Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698317CEDBB
	for <lists+linux-efi@lfdr.de>; Thu, 19 Oct 2023 03:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbjJSBvS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 Oct 2023 21:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjJSBvR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 18 Oct 2023 21:51:17 -0400
Received: from w4.tutanota.de (w4.tutanota.de [81.3.6.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A3CFA;
        Wed, 18 Oct 2023 18:51:15 -0700 (PDT)
Received: from tutadb.w10.tutanota.de (unknown [192.168.1.10])
        by w4.tutanota.de (Postfix) with ESMTP id 4D6E910601FD;
        Thu, 19 Oct 2023 01:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1697680273;
        s=s1; d=bens.haus;
        h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
        bh=9D6H3JhEW+ynD4E5pk1z3agn/aWgsnPGpYm4wdnAAIs=;
        b=3mIznzc5ndBKGYtJdgqzY1eEgQycOZm6OKLUThE6fM12UANwYwO2DGEmvN+pRf/h
        DjpYdnfk8skGoGBPUuzYFlQiUMgtMoszT1GEisElNnQfw/8UJ66G/UQSY8JMo3bcXUX
        Xafj4z9o78mrLzVE3wInu1UXU04bYKfq6tQc8wownWBEWhQQC8OF5mf28QH96vZnkht
        2Egi7uJdM7IaJMosZAtM8XHppNQ7VBWSm8PJ8D9X9Q+NTBTTKdr1aJEoaGR/0gnyDbx
        3NkpqnnKPF0Y+zn+0DIsk/3IqF7oTsOK8fzvFotv7SRdUKdPjwR05RXiPEVOgJe+ZgL
        l9rZ8fCzBA==
Date:   Thu, 19 Oct 2023 03:51:13 +0200 (CEST)
From:   Ben Schneider <ben@bens.haus>
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Regressions <regressions@lists.linux.dev>,
        Linux Efi <linux-efi@vger.kernel.org>,
        Stable <stable@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Message-ID: <Nh30qsF--3-9@bens.haus>
In-Reply-To: <CAC_iWjJB3OTWiYX5YsJmNcPQw+rHSm955c1Z5pUajedWGM5QgA@mail.gmail.com>
References: <Nh-DzlX--3-9@bens.haus> <CAMj1kXFKe6piagNLdSUhxUhwLB+RfNHqjNWt8-r2CNS-rBdJKA@mail.gmail.com> <817366c2-33e0-4908-90ec-57c63e3eb471@canonical.com> <CAC_iWjJB3OTWiYX5YsJmNcPQw+rHSm955c1Z5pUajedWGM5QgA@mail.gmail.com>
Subject: Re: [REGRESSION] boot fails for EFI boot stub loaded by u-boot
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

> How old is the u-boot build on this platform?

U-Boot 2018.03-devel-18.12.3-g926d08c7ce (Apr 11 2022 - 15:48:13 +0800)

This appears to be the most recent version the manufacturer has released for this device. Source: https://github.com/globalscaletechnologies/u-boot-marvell.

>> arch/arm64/boot/marvell/armada-3720-espressobin-ultra.dts
> This is a uboot path, right? Not a linux path? Are you sure this DTS is compatible with the v6.5 kernel?

Sorry for the confusion; that is the path in the linux source to the DTS used to compile the DTB that I am using to boot the device. I booted v5.15.135 using the DTB compiled from v6.5.7 source and that works fine. I also tried to boot v6.5.7 with the factory DTB and that failed.

> Please add message inside the update_fdt() routine...

I added a bunch and here's what I got back:

EFI stub: Booting Linux Kernel...
EFI stub: ERROR: FIRMWARE BUG: efi_loaded_image_t::image_base has bogus value
EFI stub: ERROR: FIRMWARE BUG: kernel image not aligned on 64k boundary
EFI stub: ERROR: Failed to install memreserve config table!
EFI stub: Using DTB from configuration table
EFI stub: Exiting boot services...
EFI stub: Starting update_fdt()...
EFI stub: fdt_num_mem_rsv() returned 1
EFI stub: fdt_subnode_offset() returned 8944
EFI stub: Setting bootargs=console=ttyMV0,115200 earlycon=ar3700_uart,0xd0012000 root=/dev/sda1 rw rootwait
EFI stub: Adding FDT entries...
EFI stub: fdt_setprop_var() for linux,uefi-system-table returned 0
EFI stub: fdt_setprop_var() for linux,uefi-mmap-start returned -11
EFI stub: update_fdt() failed with status -11
EFI stub: ERROR: Unable to construct new device tree.
EFI stub: ERROR: Failed to update FDT and exit boot services

That's as far as I could get today but hopefully that starts to narrow it down. Appreciate the help!

Sincerely,

Ben
