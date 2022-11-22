Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828196332A4
	for <lists+linux-efi@lfdr.de>; Tue, 22 Nov 2022 03:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbiKVCET (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 21 Nov 2022 21:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbiKVCES (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 21 Nov 2022 21:04:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07C0DEAC8;
        Mon, 21 Nov 2022 18:04:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D2A9B8136A;
        Tue, 22 Nov 2022 02:04:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3870EC433C1;
        Tue, 22 Nov 2022 02:04:13 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="mx625ZE9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669082651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OTrT7Oy+UwX6tDTXDcuWMWfrXPh69Y+d/UxvhkUJhAQ=;
        b=mx625ZE9WhJJXgLhEe74RQYgx+11/NV6nAKPCkZrbjtl8nAz3nnmCVZijkACKdDgP9isRW
        pBvqNF1MkR2u+m1SCr7OzkjfdsBf6reldCixRUPOM+KNhDiNqQpZOpoZPviIVdsCyYu/3b
        MphBDiqw4UlMY1Gp7GvTyrh7NaaLK/g=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ef1f4edb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 22 Nov 2022 02:04:10 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-efi@vger.kernel.org, linux-crypto@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        ardb@kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v3 0/5] Use EFI variables for random seed
Date:   Tue, 22 Nov 2022 03:03:59 +0100
Message-Id: <20221122020404.3476063-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

EFI has a rather unique benefit that it has access to some limited
non-volatile storage, where the kernel can store a random seed. This
series wires that up, with EFISTUB reading the seed and passing it to
the kernel, and with the kernel writing a new seed when the RNG is
initialized.

Patches 1 and 2 are to go through Ard's EFI tree, while patches 3, 4,
and 5 are to go through my RNG tree.

Jason A. Donenfeld (5):
  efi: vars: prohibit reading random seed variables
  efi: stub: use random seed from EFI variable
  random: add back async readiness notifier
  vsprintf: initialize siphash key using notifier
  efi: random: refresh non-volatile random seed when RNG is initialized

 drivers/char/random.c                 | 22 +++++++++++
 drivers/firmware/efi/efi.c            | 19 +++++++++
 drivers/firmware/efi/libstub/random.c | 55 +++++++++++++++++++++------
 fs/efivarfs/inode.c                   |  4 ++
 fs/efivarfs/super.c                   |  3 ++
 include/linux/random.h                |  1 +
 lib/vsprintf.c                        | 14 +++----
 7 files changed, 97 insertions(+), 21 deletions(-)

-- 
2.38.1

