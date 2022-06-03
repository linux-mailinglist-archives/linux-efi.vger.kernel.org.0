Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C9553C726
	for <lists+linux-efi@lfdr.de>; Fri,  3 Jun 2022 10:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242901AbiFCItl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 Jun 2022 04:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242900AbiFCItb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 3 Jun 2022 04:49:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903C636E3E
        for <linux-efi@vger.kernel.org>; Fri,  3 Jun 2022 01:49:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46FC2B81DFD
        for <linux-efi@vger.kernel.org>; Fri,  3 Jun 2022 08:49:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 377E5C385A9;
        Fri,  3 Jun 2022 08:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654246167;
        bh=I+Ep7QGufxAJjzcYkalB7tHopp1n2fhsvt4Ae0wVeqU=;
        h=From:To:Cc:Subject:Date:From;
        b=vDW2nZWzW0tMmdBom1cw0GwYQKjIkNeJ9PS+Rt8rUGywpHZ/IS0sWEaySHjg/8AYI
         1Ug7MQyKEQxBa/1XO+JArVj+y5ZCNq9zszgxULmxbupN6pUJFb7JKBxxeZpAsopK5P
         wTcjwJbAcC+73WiLmvFPUw5z4vaG8pnJnCy3el60otQtLUYqKnuEnZyCsJ9kzjbExW
         uZOTFKdgJhwnEoJrUqOab96+QSvfGUfXdLQej1edLt7XJKSSlnj0tg1/0rTuvd3uMu
         So9+cEc76iaoSeyiGl6OMVoJw5159cbMFXcO0qC2U+nGfkyQTgiYeBnn/cjNZAhXYB
         2OgNQN++AvRFQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [GIT PULL] EFI updates for v5.19 #2
Date:   Fri,  3 Jun 2022 10:49:10 +0200
Message-Id: <20220603084910.130410-1-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1896; h=from:subject; bh=I+Ep7QGufxAJjzcYkalB7tHopp1n2fhsvt4Ae0wVeqU=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBimcsGtbepo3j9ab5kXu1d+W/qD00F7cYx01rIOuTf DOzw/OqJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYpnLBgAKCRDDTyI5ktmPJPhfC/ 9tZfBAYmgJqj+ELA7U70bD/a5gotGBHxNEQvB+EgnCflnpbQZfYlL/G8HyL50jPmsRK99oDiisT3jE x4XT8qlGtYQcnI9ZDZmU9uLBHRX7evYAkLg7bbhu+QpfoS6O8Yz9ES5m1oMmnE1hbs3F2yxtvi5W/j L51skug1HEfmDlW4lcK7K2UoP5FdDiOexymT90rK7cufdfR1CR3kHWZO2GU3RT3vmvkx7W5cE60FPI B2L0483JMe4e2nUAbj5pmqf43WzWq739fRw55x5GNoG6SB/AzPrcyIFjC30SkBM2w1AHwNi4hs5Jgi hQteofd7YussLB3fTc0AHTrpfRH+zC595A7b8xMw9ru1Ol+l/oc+9sRtNiCCDa8JI8E05BrlrsOV1z 6rSLsrD9L9UQ8+Y0qK0oWox99Ofywx0MC2ySyLrvbgebozCRzaIFx49p6PHyg5hfcZksG5iHNsBP8I Zv9jdkz5kiu3saaHb7OlwOEtm+0bhcE2Pg4Qjo+xKi1oo=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Linus,

Please pull the changes below - they mostly address issues introduced this
merge window, except for Heinrich's patch.

The following changes since commit 3f68e69520d3d52d66a6ad872a75b7d8f2ea7665:

  riscv/efi_stub: Add support for RISCV_EFI_BOOT_PROTOCOL (2022-05-19 10:22:17 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v5.19-2

for you to fetch changes up to 75ed63d919400b803691a0c757ee23c6f767a625:

  efi: clean up Kconfig dependencies on CONFIG_EFI (2022-06-01 14:08:13 +0200)

----------------------------------------------------------------
Follow-up tweaks for the EFI changes in v5.19

- fix new DXE service invocations for mixed mode
- use correct Kconfig symbol when setting PE header flag
- clean up the drivers/firmware/efi Kconfig dependencies so that
  features that depend on CONFIG_EFI are hidden from the UI when the
  symbol is not enabled.

Also included is a RISC-V bugfix from Heinrich to avoid read-write
mappings of read-only firmware regions in the EFI page tables.

----------------------------------------------------------------
Ard Biesheuvel (2):
      efi/x86: libstub: Make DXE calls mixed mode safe
      efi: clean up Kconfig dependencies on CONFIG_EFI

Heinrich Schuchardt (1):
      riscv: read-only pages should not be writable

Lukas Bulwahn (1):
      efi: x86: Fix config name for setting the NX-compatibility flag in the PE header

 arch/riscv/kernel/efi.c                 |  2 +-
 arch/x86/boot/header.S                  |  2 +-
 arch/x86/include/asm/efi.h              |  9 ++++++
 drivers/firmware/Makefile               |  3 +-
 drivers/firmware/efi/Kconfig            | 52 +++++++++++++++------------------
 drivers/firmware/efi/libstub/x86-stub.c |  4 +--
 6 files changed, 38 insertions(+), 34 deletions(-)
