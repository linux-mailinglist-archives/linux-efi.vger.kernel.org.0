Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A091262F636
	for <lists+linux-efi@lfdr.de>; Fri, 18 Nov 2022 14:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242136AbiKRNdw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Nov 2022 08:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242089AbiKRNcx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 18 Nov 2022 08:32:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1758D8E096;
        Fri, 18 Nov 2022 05:32:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2FD962523;
        Fri, 18 Nov 2022 13:32:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544B8C433D6;
        Fri, 18 Nov 2022 13:32:50 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ng/ljxGR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1668778367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3Ba13+GXNlXQlY1symDczyowf433BVf2HSRAdnZzlc4=;
        b=ng/ljxGRlpcuw9DqCA97Oz3sebyeBFvUG8S3UKc3PkFP1PzUXoxGvJRo9kaeKK2JhYdjWm
        IIgbxvs28YuvF+Nn3POdhmOCZH9LJu3skNDIusTVmq/IC6UBU+bFius9IEkVDTkztbFHh2
        GTP3jTX7HfYUb9mkW3YoddC5xzf0r2o=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b8685e6e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 18 Nov 2022 13:32:47 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-efi@vger.kernel.org, linux-crypto@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v2 0/5] Use EFI variables for random seed
Date:   Fri, 18 Nov 2022 14:32:34 +0100
Message-Id: <20221118133239.2515648-1-Jason@zx2c4.com>
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

 drivers/char/random.c                 | 20 +++++++++
 drivers/firmware/efi/efi.c            | 19 +++++++++
 drivers/firmware/efi/libstub/random.c | 59 +++++++++++++++++++++------
 fs/efivarfs/inode.c                   |  4 ++
 fs/efivarfs/super.c                   |  3 ++
 include/linux/efi.h                   |  1 +
 include/linux/random.h                |  1 +
 lib/vsprintf.c                        | 14 +++----
 8 files changed, 100 insertions(+), 21 deletions(-)

-- 
2.38.1

