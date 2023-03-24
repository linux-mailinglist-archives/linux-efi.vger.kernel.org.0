Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FC86C8266
	for <lists+linux-efi@lfdr.de>; Fri, 24 Mar 2023 17:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjCXQd3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Mar 2023 12:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjCXQd2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 24 Mar 2023 12:33:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA71B9004
        for <linux-efi@vger.kernel.org>; Fri, 24 Mar 2023 09:33:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71EFEB82354
        for <linux-efi@vger.kernel.org>; Fri, 24 Mar 2023 16:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48430C433EF;
        Fri, 24 Mar 2023 16:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679675604;
        bh=q8l39FP8D7qhiDxXKKrhz6oPGVeShptZvtHxj5BkHag=;
        h=From:To:Cc:Subject:Date:From;
        b=JaRquQlAie8bRT6x8c6eqLnVkFD5YK86pLJxGxU+nPwKP5H6H6gKjBiyQY+JybT6c
         jfgi28Gb387DU/hP9Ghv2D1OSbf2GJrVDqvgRV16rHaMXrQntdXwE94LONhWj++IfZ
         IRtTYjYAHZ499ITbrV7/vwgXO0p+ZxzAzE/7mVUsvRwctBM7dTrS7/ozLeBGkYm4KG
         +bE6Q49ced9d7LSqaVbwtU2faptoPYoKywEyFuhyWwhpFY2Ppr/VENJF7dRRxbXNq/
         JyrjzcAwUOm2KKsgHwY/RB7A7+Or6SPD2bzjR/eSfYf+WsoqV/TH8xoaRVMp2m3hha
         zoT8NeyupSNkQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [GIT PULL] EFI fixes for v6.3 #1
Date:   Fri, 24 Mar 2023 17:33:19 +0100
Message-Id: <20230324163319.1664833-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3463; i=ardb@kernel.org; h=from:subject; bh=q8l39FP8D7qhiDxXKKrhz6oPGVeShptZvtHxj5BkHag=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUX2wjnpzb3/dkVf1Bcvfj3heOlng3mRO1b9SXi92/5O3 oeu+M2fO0pZGMQ4GGTFFFkEZv99t/P0RKla51myMHNYmUCGMHBxCsBE1jkwMjx0kG3pF06Z++JD i1bn/OmpE85f2/THpmfDh8Czyzfq+81jZNgta1F9LJjNo2PtVt2dKRy/JgZ871M2+/OwrXjPHhd OHV4A
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Linus,

Please pull the EFI changes below - description in the tag.

Note that I recently rotated my signing subkey, so you may need to sync up with
the pgpkeys git repo, or refresh F43D03328115A198C90016883D200E9CA6329909 from
a key server.

Thanks,
Ard.


The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.3-1

for you to fetch changes up to 0b1d9debe30304f35c1211e6dcdca1935ce67240:

  efi/libstub: randomalloc: Return EFI_OUT_OF_RESOURCES on failure (2023-03-23 15:15:45 +0100)

----------------------------------------------------------------
First batch of EFI fixes for v6.3:

- Set the NX compat flag for arm64 and zboot, to ensure compatibility
  with EFI firmware that complies with tightening requirements imposed
  across the ecosystem.

- Improve identification of Ampere Altra systems based on SMBIOS data.

- Fix some issues related to the EFI framebuffer that were introduced
  as a result from some refactoring related to zboot and the merge with
  sysfb.

- Makefile tweak to avoid rebuilding vmlinuz unnecessarily.

- Fix efi_random_alloc() return value on out of memory condition.

----------------------------------------------------------------
Ard Biesheuvel (10):
      efi/libstub: zboot: Mark zboot EFI application as NX compatible
      efi/libstub: arm64: Remap relocated image with strict permissions
      arm64: efi: Set NX compat flag in PE/COFF header
      efi: earlycon: Reprobe after parsing config tables
      efi/libstub: smbios: Use length member instead of record struct size
      arm64: efi: Use SMBIOS processor version to key off Ampere quirk
      efi/libstub: smbios: Drop unused 'recsize' parameter
      efi/libstub: zboot: Add compressed image to make targets
      efi/libstub: Use relocated version of kernel's struct screen_info
      efi/libstub: randomalloc: Return EFI_OUT_OF_RESOURCES on failure

Hans de Goede (2):
      efi: sysfb_efi: Fix DMI quirks not working for simpledrm
      efi: sysfb_efi: Add quirk for Lenovo Yoga Book X91F/L

 arch/arm64/kernel/efi-header.S                |  2 +-
 drivers/firmware/efi/earlycon.c               | 16 ++++++++--
 drivers/firmware/efi/efi-init.c               |  3 ++
 drivers/firmware/efi/libstub/Makefile.zboot   |  2 +-
 drivers/firmware/efi/libstub/arm64-stub.c     |  5 +++-
 drivers/firmware/efi/libstub/arm64.c          | 39 +++++++++++++++++++-----
 drivers/firmware/efi/libstub/efi-stub-entry.c | 11 +++++++
 drivers/firmware/efi/libstub/efi-stub.c       |  5 ----
 drivers/firmware/efi/libstub/efistub.h        | 43 ++++++++++++++++++++++++---
 drivers/firmware/efi/libstub/randomalloc.c    |  1 +
 drivers/firmware/efi/libstub/screen_info.c    |  9 +-----
 drivers/firmware/efi/libstub/smbios.c         | 15 ++++++++--
 drivers/firmware/efi/libstub/zboot-header.S   |  2 +-
 drivers/firmware/efi/libstub/zboot.c          |  5 ++++
 drivers/firmware/efi/sysfb_efi.c              | 13 +++++++-
 drivers/firmware/sysfb.c                      |  4 ++-
 drivers/firmware/sysfb_simplefb.c             |  2 +-
 include/linux/efi.h                           |  1 +
 include/linux/sysfb.h                         |  9 ++++--
 19 files changed, 147 insertions(+), 40 deletions(-)
