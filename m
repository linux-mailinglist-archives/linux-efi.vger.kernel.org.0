Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B0662C3CC
	for <lists+linux-efi@lfdr.de>; Wed, 16 Nov 2022 17:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbiKPQRV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 16 Nov 2022 11:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234776AbiKPQRB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 16 Nov 2022 11:17:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B303E57B7C;
        Wed, 16 Nov 2022 08:16:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A3AFB81DE0;
        Wed, 16 Nov 2022 16:16:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 708CFC433C1;
        Wed, 16 Nov 2022 16:16:56 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="L3qpjO+h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1668615414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7081WT2vIv2P593Em1s6an5/PNnBOO7eRlHKQoDe8bM=;
        b=L3qpjO+hA//nPICVxX6CEoFke5uoMjJPXe77EoYqr8paiIG2qZARvNIxdH2kXppvCokuzO
        t3D6umAOT59195cQnZ3y3NYCT5LrvJad7gpDHbq++Zip2Bwpyu57wXsHEEQm0dbhOHsF/4
        mIOkuGtdbh1b0ZOpC3kGn4b1D8KxeoQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d4ea79a6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 16 Nov 2022 16:16:53 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-efi@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Lennart Poettering <lennart@poettering.net>
Subject: [PATCH RFC v1 0/6] Use EFI variables for random seed
Date:   Wed, 16 Nov 2022 17:16:36 +0100
Message-Id: <20221116161642.1670235-1-Jason@zx2c4.com>
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

This is a rough sketch of a proposal to use non-volatile EFI variables
as random seeds for EFISTUB to manage.

Patch 1 adds (back) the random.c async notifier, so we can learn when
the RNG is initialized.

Patch 2 uses it in vsprintf, because I promised Sebastian we'd do that
if it ever gets added back for whatever reason.

Patch 3 is already in efi.git and isn't new here, but is a pre-req for
the next patch.

Patch 4 uses the random seed from an EFI variable to pass to Linux.

Patch 5 prevents the variable from being read by efivarfs. [Note:
probably the legacy efifs needs updating too? Or has this been removed?]

Patch 6 uses patch 1 to refresh the EFI variable when the RNG is
initialized.

If folks like this idea and it moves forward, 1,2,6 will be taken into
my tree, and 3,4,5 will go via Ard's.

Commit messages are rather sparse at the moment. I'll fill those out for
the next non-RFC patchset if this idea isn't immediately demolished.

The biggest consideration is wear leveling on the EFI variable flash
chips. However, EFI *already* winds up writing to non-volatile memory on
every single boot anyway, so maybe it's not actually a big deal?

Thoughts?

Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Lennart Poettering <lennart@poettering.net>

Ard Biesheuvel (1):
  efi: random: combine bootloader provided RNG seed with RNG protocol
    output

Jason A. Donenfeld (5):
  random: add back async readiness notifier
  vsprintf: initialize siphash key using notifier
  efi: stub: use random seed from EFI variable
  efi: efivarfs: prohibit reading random seed variables
  efi: refresh non-volatile random seed when RNG is initialized

 drivers/char/random.c                  | 30 +++++++++
 drivers/firmware/efi/efi.c             | 14 +++++
 drivers/firmware/efi/libstub/efistub.h |  2 +
 drivers/firmware/efi/libstub/random.c  | 85 +++++++++++++++++++++++---
 fs/efivarfs/file.c                     |  3 +
 include/linux/efi.h                    |  3 +-
 include/linux/random.h                 |  1 +
 lib/vsprintf.c                         | 14 ++---
 8 files changed, 131 insertions(+), 21 deletions(-)

-- 
2.38.1

