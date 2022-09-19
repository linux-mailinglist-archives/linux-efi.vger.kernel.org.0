Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A6A5BD1E1
	for <lists+linux-efi@lfdr.de>; Mon, 19 Sep 2022 18:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiISQJr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 19 Sep 2022 12:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiISQJp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 19 Sep 2022 12:09:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9912F13CED
        for <linux-efi@vger.kernel.org>; Mon, 19 Sep 2022 09:09:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA7AD61CB5
        for <linux-efi@vger.kernel.org>; Mon, 19 Sep 2022 16:09:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD310C433D6;
        Mon, 19 Sep 2022 16:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663603782;
        bh=ij6+JMeqL+ML9w5DpKSxm4LDi7jtFSsBgrtiIsZ7yMU=;
        h=From:To:Cc:Subject:Date:From;
        b=cyVGnspxY6tYLRVqHF4YSCd9uDPcFVH0P4TnY0hl/5mSPJfCLaXrkxZipHFdVKwlt
         O+o/lr7z5WhzBIpdxCEwXhFPpntseChOXw0sYEyCsPY/XQoVkF7uHBgoRWqVMmEwEM
         RvrvCEKC6gJTVn+vozI/fNtXxig2ss41oy7pKGL7Guch6kci7FrM0Hj4l27Q9AM9pd
         xBkVxM/hYnxr9OKUap0x7LBaZQ6Wl0F353pjuFu4B6aCsRXHfMcwbdEFD/lpHXGYMp
         X61jUcZaCApM2HpgnCnI6vLlVpXva697Fro1Ul0Nstzz51jx5EA4ref1uX7YvV4NI8
         dkedCe163iZbQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Lennart Poettering <lennart@poettering.net>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 0/3] efi: consume random seed provided by loader
Date:   Mon, 19 Sep 2022 18:09:28 +0200
Message-Id: <20220919160931.2945427-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2314; i=ardb@kernel.org; h=from:subject; bh=ij6+JMeqL+ML9w5DpKSxm4LDi7jtFSsBgrtiIsZ7yMU=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjKJQ1FMFzLyVtNNTRMQ9AXW6E0E91qpD859k+DccV bBGFLAKJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYyiUNQAKCRDDTyI5ktmPJKW+C/ 9h7OOuNNAvsEfdmxeqhnDl9IY68Kbb/cuxRA+n0vNdu5ZZexilRvgzC+KxXfdKt3LjZ5y3mxcTA734 5ItlTdSQbc9B/gxI36v0RBHDadgb+fRtzeWRPzMfZnVOjNshDFEmPk+KtH+2Jx2o2bEPfT/coYOsk2 JvPgkOzfOLDLPmqDcIEWWE0UajyhTF1EZfdUn0tsDo6J55y58N/o5aiETW0+vKCfQ4Ep8eMIils070 DK/s56ZCU2sP2TR9fxaqndwE7F/5/mA1fCmjye9WzwTO573+XEdKWBtYFoj8nT9icpUDHNlIiORgEt QDy86RC/tNMOKH97PRR9Nu52Ja2lUoHvG19gYzpNTRHySF3Cf23+NCvfqcobxloR/i8X1Rgeh9CNOC QWMjUdxPkL3YRP4I5JmPGGWJfeX/pYDEBqqNz7Qg7VydLlAd8rXWWTTzp+47SDpXikPEtjR/FJoHJb H8gTeFtmEo0H/828APIfArjkN5NLA2aJt2UHHKeRZrxyY=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Getting a random seed into the kernel very early is important for data
structures that rely on the random number generator at initialization
time, but hardware based RNGs may not become available until much later
in the boot.

For this reason, the EFI stub will currently invoke the EFI RNG protocol
to get a random seed from the hardware before tearing down the EFI boot
services and performing the low level boot of the kernel proper. The
generated seed is passed via a EFI configuration table, which is
available very early, and so the random number generator comes up much
earlier as well.

Any boot stage preceding the EFI stub can install configuration tables,
so we can decide to expose the same mechanism to other loaders.  This
allows, e.g., systemd-boot to pass the seed it keeps in a file on the
ESP without having to rely on PID #1 dd'ing it into /dev/random, which
is much too late to be useful.

As suggested by Jason, let's use blake2s to combine seeds obtained via
the config table and via the protocol if both are available, and throw
in a personalization string for good measure.

Older kernels will simply supersede the bootloader provided seed, unless
the RNG protocol is not available, in which case the bootloader seed
will be forwarded untouched if one is present. This should not be an
issue, but let's reduce the seed size to blake2's output size, and
switch to the correct memory type in separate changes so they can be
backported.

Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Lennart Poettering <lennart@poettering.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>

Ard Biesheuvel (3):
  efi: random: reduce seed size to 32 bytes
  efi: random: Use 'ACPI reclaim' memory for random seed
  efi: random: combine bootloader provided RNG seed with RNG protocol
    output

 drivers/firmware/efi/efi.c             |  2 +-
 drivers/firmware/efi/libstub/Makefile  |  4 +
 drivers/firmware/efi/libstub/efistub.h |  2 +
 drivers/firmware/efi/libstub/random.c  | 83 ++++++++++++--------
 include/linux/efi.h                    |  4 +-
 lib/crypto/blake2s-generic.c           |  2 +
 lib/crypto/blake2s.c                   |  7 +-
 7 files changed, 64 insertions(+), 40 deletions(-)

-- 
2.35.1

