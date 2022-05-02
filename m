Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594A6517400
	for <lists+linux-efi@lfdr.de>; Mon,  2 May 2022 18:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386224AbiEBQSb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 May 2022 12:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357459AbiEBQSa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 2 May 2022 12:18:30 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1DABC93;
        Mon,  2 May 2022 09:15:00 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1nlYhM-00085n-QZ; Mon, 02 May 2022 18:14:57 +0200
Date:   Mon, 2 May 2022 17:14:48 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-block@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tom Rini <trini@konsulko.com>, Jens Axboe <axboe@kernel.dk>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 0/5] partition parser for U-Boot's uImage.FIT
Message-ID: <YnADeJSWFYmP8ekM@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,PDS_OTHER_BAD_TLD,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add uImage.FIT partition parser and wire it up to allow mounting
filesystem sub-images from uImage.FIT in GPT partitions as well as
mtdblock and ubiblock devices within Linux (e.g. as root filesystem).

Using uImage.FIT to store the root filesystem besides kernel and dtb has
several obvious advantages which are hard to obtain in any other way:
 * single image accross different storage types
 * dynamically sized partitions for kernel and rootfs
 * hash also for rootfs checked by U-Boot before launching kernel
 * images may include additional filesystems e.g. for localization or
   branding

For this to work, the image has to be created with external data and
sub-images aligned to the system's memory page boundaries, ie.
 mkimage -E -B 0x1000 -p 0x1000 ...

Booting such images has been supported by U-Boot since v2018.01.

A previous version of this partition parser is in production use on
some OpenWrt devices, eg. the BananaPi R64 where using the FIT parser
allows booting the very same image from eMMC, SD Card or SPI-NAND/UBI
and also using it as a firmware-upgrade image at the same time.
The Ubiquiti UniFi 6 LR access served as a reference board with SPI-NOR
flash and use of the partition parser on top of a mtdblock device.

Most recently U-Boot now passes down the selected configuration
node name via device tree to allow the partition parser (or userspace
process via sysfs) to identify the image configuration.

Device Tree schema for that:
https://github.com/devicetree-org/dt-schema/commit/a24d97d43491e55d4def006213213a6c4045b646

In most cases this partition parser can be used without relying on the
bootloader to pass-down the configuration node name. The default
configuration node is used then.

Changes since RFC:
 * fixed wrong variable used in error path
 * introduced dedicated Kconfig options to enable partition
   parsers on mtdblock and ubiblock
 * drop #ifdef'ery, use IS_ENABLED(...) where needed

Daniel Golle (5):
  block: add new flag to add partitions read-only
  block: add partition parser for U-Boot uImage.FIT
  partitions/efi: add support for uImage.FIT sub-partitions
  mtd_blkdevs: add option to enable scanning for partitions
  mtd: ubi: block: add option to enable scanning for partitions

 MAINTAINERS               |   6 +
 block/blk.h               |   1 +
 block/partitions/Kconfig  |  14 ++
 block/partitions/Makefile |   1 +
 block/partitions/check.h  |   5 +
 block/partitions/core.c   |   6 +
 block/partitions/efi.c    |   9 +
 block/partitions/efi.h    |   3 +
 block/partitions/fit.c    | 352 ++++++++++++++++++++++++++++++++++++++
 drivers/mtd/Kconfig       |  11 ++
 drivers/mtd/mtd_blkdevs.c |   4 +-
 drivers/mtd/ubi/Kconfig   |  10 ++
 drivers/mtd/ubi/block.c   |   5 +-
 13 files changed, 425 insertions(+), 2 deletions(-)
 create mode 100644 block/partitions/fit.c

-- 
2.36.0

