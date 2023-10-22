Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FB37D2448
	for <lists+linux-efi@lfdr.de>; Sun, 22 Oct 2023 18:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjJVQTA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 22 Oct 2023 12:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVQTA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 22 Oct 2023 12:19:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE24FB
        for <linux-efi@vger.kernel.org>; Sun, 22 Oct 2023 09:18:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0C5C433C8;
        Sun, 22 Oct 2023 16:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697991538;
        bh=fMlrPz52uLC0ldd65AefLJ/gGdslE+HQykxAAsvfLGs=;
        h=From:To:Cc:Subject:Date:From;
        b=L7wERav3LFpJ4JJQUFh6whGH+7YX3wVJA+OJoXMkLl+FmhuW7Kp59R08XZj/QkjHb
         toVR5RHsUA8Hgmlx/xYmI5oJtjRWwyKWIExkT8qrAOk9GsSppTaXNch2vlb6u5EovP
         A3zCnpqIcXy5UnhOIDH7V9QVlND4ZlbVWvtIqUzghelH/3TUVZTr2P7bw7ezqNcqtD
         i5FV87POwhd2n3RJcJeAnV69A9yCCx+gK1jWHiB1y2UEQjt0mzPZ+Cu9rQOpCXFy6O
         5Xks+SfLVwi0yAcUwL4zImNpEpeM6MFgeuvv8QAtDhUFRz4ArqsslfIv7ZcwAv1YFj
         SSFlDjshpka/A==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     mingo@kernel.org, linux-efi@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [GIT PULL] EFI fixes for v6.6 #3
Date:   Sun, 22 Oct 2023 18:18:46 +0200
Message-Id: <20231022161846.28311-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1795; i=ardb@kernel.org; h=from:subject; bh=fMlrPz52uLC0ldd65AefLJ/gGdslE+HQykxAAsvfLGs=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIdXUO8nmoinztJKZPwOPZfxU0J+U3L2Xfa+Uwstyx+Rds We+7X7cUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACZSG8/wT8GnfuG2DbvSuO/v /dPd/cboiMwuuRuSz8/M0v5535xX7QbD/wLVR93G37a/Tb8Q+PfxtWUmD316Ft/8/ujAsrrlj1e uXMkPAA==
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Linus,

Please pull the fixes below. The boot_params pointer fix uses a somewhat ugly
extern struct declaration but this will be cleaned up the next cycle.

The following changes since commit 8dbe33956d96c9d066ef15ca933ede30748198b2:

  efi/unaccepted: Make sure unaccepted table is mapped (2023-09-19 16:11:36 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.6-3

for you to fetch changes up to c03d21f05e76b25f907684bdf874308dcefab385:

  Merge 3rd batch of EFI fixes into efi/urgent (2023-10-20 18:11:06 +0200)

----------------------------------------------------------------
Final set of EFI tweaks for v6.6:

- don't try to print warnings to the console when it is no longer
  available
- fix theoretical memory leak in SSDT override handling
- make sure that the boot_params global variable is set before the KASLR
  code attempts to hash it for 'randomness'
- avoid soft lockups in the memory acceptance code

----------------------------------------------------------------
Ard Biesheuvel (2):
      x86/boot: efistub: Assign global boot_params variable
      Merge 3rd batch of EFI fixes into efi/urgent

Kirill A. Shutemov (1):
      efi/unaccepted: Fix soft lockups caused by parallel memory acceptance

Kuan-Wei Chiu (1):
      efi: fix memory leak in krealloc failure handling

Nikolay Borisov (1):
      x86/efistub: Don't try to print after ExitBootService()

 drivers/firmware/efi/efi.c               |  8 +++-
 drivers/firmware/efi/libstub/x86-stub.c  |  7 ++--
 drivers/firmware/efi/libstub/x86-stub.h  |  2 +
 drivers/firmware/efi/unaccepted_memory.c | 64 ++++++++++++++++++++++++++++++--
 4 files changed, 71 insertions(+), 10 deletions(-)
