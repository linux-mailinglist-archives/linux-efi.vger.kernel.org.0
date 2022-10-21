Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15157607B6C
	for <lists+linux-efi@lfdr.de>; Fri, 21 Oct 2022 17:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbiJUPnj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Oct 2022 11:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJUPni (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 21 Oct 2022 11:43:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D86C1A6524
        for <linux-efi@vger.kernel.org>; Fri, 21 Oct 2022 08:43:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B7E861F10
        for <linux-efi@vger.kernel.org>; Fri, 21 Oct 2022 15:40:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E977AC43140;
        Fri, 21 Oct 2022 15:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666366853;
        bh=nQ4gjILuG/VS+13xOwNyZx7iWNwi26qax5dO/X1S4hQ=;
        h=From:To:Cc:Subject:Date:From;
        b=UFqN7NDvem+Ced6jWid6u3Ez0LhVMy/bI5SXcDpNctae7Uw+lxmeuBEcKkiTWDx1n
         9gWQSf7nvYZZkTtA7AjKPzJ/M5TT/CQ4u4W+k01uhuafVTWXFUyxs4gBDj43YqyCmG
         fCezOI/qzFDUYi9vsuTT93QbvQz4H7Z7mQ6oBnxvL/TJGERUOmpzL838X+3oYjLuFe
         VKHCWvRpY/AcfneeSMBLsb50fFmyKOnnsZxhv/j8VUtZImC8BgWYPj59ykSY+JyuXD
         yASBki7aM5UnAYjK2HQAaSH0zAeMPvVfaJ40VxM7nzZStjb7pySU6V2D0pryFoqMCx
         20v+fXW+lK4Kg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [GIT PULL] EFI fixes for v6.1 #1
Date:   Fri, 21 Oct 2022 17:40:45 +0200
Message-Id: <20221021154045.2848205-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2052; i=ardb@kernel.org; h=from:subject; bh=nQ4gjILuG/VS+13xOwNyZx7iWNwi26qax5dO/X1S4hQ=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjUr18MIfryde4hvNFjAuHxTxe4qnOxWvq6eLeci2F oX/wg8WJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY1K9fAAKCRDDTyI5ktmPJENOC/ 0VK6SNt9ZQ1/y5nhCnC9MdAnI1UPj6IG7ExbDafmFfCEPYhn69bsf2aVpHLUmF36rrNPibO1I4Y2sm gpPpqCh5mxkLktvOlDAfYOPY0YXa830rmZUbbCx4n3RUFB+i2gop0mHqO5s+rmKFpnlJFUIdxJWMLy W0qNc1T9OrkNoxh6zmJp0X54K8YozARskRxA16tD1KqKDjFSeUl0w6yjR9t0ofaBZobPg/W12dad1V mGzrr0XhecT0S5eo23K8KM7gItNyio2m0rkAsvGVbdWifdC2tORIBfgpdXQj74USMvVaQ/CfGxATJr KC9h3/fqNgK1Ts7DIB4Mhlt2z1UM9mB3z8Bn2lTYjp9b+UCKd2J+Rw7UMsvlxAyCEbPNSQLTC03M9V wtS+1lxKZ6pLjRqWUHOY7LOksBO9+CFuABt8Cl/N5K0q5pdssoPccxN9S3ReGBwkJcY5nK3ALey+GR iYw2KQF+8Mv91rIc/hPAumresdh1ITutP9V3YvGbUCTCY=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.1-1

for you to fetch changes up to 37926f96302d8b6c2bc97990d33e316a3ed6d67f:

  efi: runtime: Don't assume virtual mappings are missing if VA == PA == 0 (2022-10-21 11:09:41 +0200)

----------------------------------------------------------------
First batch of EFI fixes for v6.1

- A pair of fixes for the EFI variable store refactor that landed in
  v6.0
- A couple of fixes for issue that were introduced during the merge
  window
- Back out some changes related to EFI zboot signing - we'll add a
  better solution for this during the next cycle

----------------------------------------------------------------
Ard Biesheuvel (6):
      efi: libstub: Remove zboot signing from build options
      efi: ssdt: Don't free memory if ACPI table was loaded successfully
      efi: efivars: Fix variable writes without query_variable_store()
      efi: libstub: Give efi_main() asmlinkage qualification
      efi: libstub: Fix incorrect payload size in zboot header
      efi: runtime: Don't assume virtual mappings are missing if VA == PA == 0

 drivers/firmware/efi/Kconfig                | 22 ----------------------
 drivers/firmware/efi/arm-runtime.c          |  2 +-
 drivers/firmware/efi/efi.c                  |  2 ++
 drivers/firmware/efi/libstub/Makefile.zboot | 29 ++++-------------------------
 drivers/firmware/efi/libstub/fdt.c          |  8 ++++----
 drivers/firmware/efi/libstub/x86-stub.c     |  6 +++---
 drivers/firmware/efi/libstub/zboot.lds      |  3 ++-
 drivers/firmware/efi/riscv-runtime.c        |  2 +-
 drivers/firmware/efi/vars.c                 | 10 +++++-----
 fs/efivarfs/vars.c                          | 16 ----------------
 include/linux/efi.h                         |  3 ---
 11 files changed, 22 insertions(+), 81 deletions(-)
