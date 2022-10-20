Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34960605A0E
	for <lists+linux-efi@lfdr.de>; Thu, 20 Oct 2022 10:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiJTIkf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Oct 2022 04:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiJTIke (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 20 Oct 2022 04:40:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652BDF9879
        for <linux-efi@vger.kernel.org>; Thu, 20 Oct 2022 01:40:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF96361A88
        for <linux-efi@vger.kernel.org>; Thu, 20 Oct 2022 08:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2985EC433B5;
        Thu, 20 Oct 2022 08:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666255226;
        bh=XtIQJsCTkMPCGGxo/Q66j2lRYHPPE+WjTmD1il3tO4k=;
        h=From:To:Cc:Subject:Date:From;
        b=bgmab7kAanKEW0qMn5IXqEP4A6qMDfjO5KCV87C8Td4Uam+yBC0K0A++pYIkAdSRv
         HghYRP4JUE5itFFvqFboVXY7x79FrxSDnfz6Jakm1ORkILn5hfXDJinlunJEeY9imD
         XlCatGMmSixIR8lu4BqH7iOcwJTtEJifyVfivpcvj24yP0qtPr0+MnmAYMwVpjJIs8
         oXfqJGbNd0zI2b4yJKvhHWg+H78nG2KvCQC2mOSBjY1/j35jbcIWIS5Gy4kkfnI3s4
         lef0CiAEE0j6/kT6xxyKyJB5CP1LZxk+e2S7Gp4CVxdWFLgVzxiXvLGni3vkunvUxh
         CRddrCcPeVaVg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Lennart Poettering <lennart@poettering.net>
Subject: [PATCH v3 0/3] efi: consume random seed provided by loader
Date:   Thu, 20 Oct 2022 10:39:07 +0200
Message-Id: <20221020083910.1902009-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2436; i=ardb@kernel.org; h=from:subject; bh=XtIQJsCTkMPCGGxo/Q66j2lRYHPPE+WjTmD1il3tO4k=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjUQkowl1hHLsFT3Tn37WoAEEJFz8bqXdztLIWgkxX hjhJ9hOJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY1EJKAAKCRDDTyI5ktmPJCcwC/ 0UI2LfLW/fUh55ZT/zsIJhauFQA8s4qJXeHLlea4+I6HM84Wz9qziQEiuVKKv5jd4jc237RaqzM9RI CbvLGe1A3XBSub0BCWYJW23nBPNRzpSNdFFdN+B5zbr5N8cFYDyk85HynOjSgHDtgdgWcC/TIsheBn DZRhsbqbx/okhYQfdZtdzeXDHycQUpxNgb2WFItUd4JdtsuQoEdaeI63PjiOc+6OHvl695u9ReJiyL xLCmj5v1W5i0DttIXHo4atDcQ81FIuXxGVW4WJBlDwq3Sr108xmKatyhrD9tEXZGDTjQ7N1DJRTK4H VUxYH1RiWJH28z+kMsbVHn+Yoyi1lexjmMmnmGPif9u93w5F1Up1nWPmELSqx9qT2ZUHLYx4k3UNn3 WaNRUzXejliWDw/tt4ldr0UmXrm5n5TCIDsZrQJr3ttEbMEpP5y9WdCsHAhBXEE0ChyX6HXtiN680q xVEda2kApho6wLn/Hy89USafjA3NLDudltjUVml2Y+/Ao=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

For maximum simplicity, just concatenate the existing seed with the one
obtained from EFI_RNG_PROTOCOL if both are available, and leave it to
the core kernel code to mix it in and credit it appropriately. This way,
we have no need for copies of the Blake2s library in the EFI stub and in
the zboot decompressor.

Older kernels will simply supersede the bootloader provided seed, unless
the RNG protocol is not available, in which case the bootloader seed
will be forwarded untouched if one is present. This should not be an
issue, but let's reduce the seed size to blake2's output size, and
switch to the correct memory type in separate changes so they can be
backported.

Changes since v2:
- rebase onto v6.1-rc1
- drop blake2s library from the stub - we'd need it in two places with
  the zboot changes landed, and concatenation is fine for our needs

Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Lennart Poettering <lennart@poettering.net>

Ard Biesheuvel (3):
  efi: random: reduce seed size to 32 bytes
  efi: random: Use 'ACPI reclaim' memory for random seed
  efi: random: combine bootloader provided RNG seed with RNG protocol
    output

 drivers/firmware/efi/efi.c             |  2 +-
 drivers/firmware/efi/libstub/efistub.h |  2 ++
 drivers/firmware/efi/libstub/random.c  | 31 +++++++++++++++++---
 include/linux/efi.h                    |  4 +--
 4 files changed, 31 insertions(+), 8 deletions(-)

-- 
2.35.1

