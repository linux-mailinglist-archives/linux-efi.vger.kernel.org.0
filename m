Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29984743116
	for <lists+linux-efi@lfdr.de>; Fri, 30 Jun 2023 01:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjF2X1u (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 29 Jun 2023 19:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjF2X1t (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 29 Jun 2023 19:27:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23C42680
        for <linux-efi@vger.kernel.org>; Thu, 29 Jun 2023 16:27:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87A0C61668
        for <linux-efi@vger.kernel.org>; Thu, 29 Jun 2023 23:27:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 143BBC433C8;
        Thu, 29 Jun 2023 23:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688081267;
        bh=uJ5O4icOSYnFqdJREgW/QI2smpxlrfK3CEG+d8rEBpY=;
        h=From:To:Cc:Subject:Date:From;
        b=ftcYukSD2W34JL+p/KIKkWI7r+p35R+qhR0vNpUROqthsLpeYgLjfivLi+n4w1jlT
         iY+6jDxUKrnkzTxi3te0sJuz0mwzy4mgMitEGAmCeKk1oenPyoESlOYwIFXmDao5f8
         ZyDr3ocv0IVlMGywCDToSIq8dbbKSGdRcfTCE1UYztSko40qalZPl4RSbRvYDeAg/X
         2CB8YI8WDyLN7yXDxgK5ycvIWsR9qF5vRbeEURwI2eeGCNV02eOLwPBfOQgTcRd7Jp
         C0BU6mnhXH6keFsnCLxNXAj27yTmK0khadyZYpXqjMb59ZUe8F1nearskGCT8EY/dl
         5MKQqqV7BQxAQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [GIT PULL] EFI updates for v6.5
Date:   Fri, 30 Jun 2023 01:27:30 +0200
Message-Id: <20230629232730.1484117-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1910; i=ardb@kernel.org; h=from:subject; bh=uJ5O4icOSYnFqdJREgW/QI2smpxlrfK3CEG+d8rEBpY=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIWWecEwFr8Kx5XeFeJIUbjgwrnjCGPNWPLfx95Xy4hL9i WKPtX52lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIncamP4Z63Z3GC6tHPhhA/q Ig5RIYe3Rb58sazt1mZJtRD2gn3H5jIy3F1jsPnd6d6tb6druqoYpiju/tgT9HnRkZkODX8L+mx zGAE=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Linus,

Please pull - notes are in the tag.

Thanks,
Ard.


The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.5

for you to fetch changes up to 2e28a798c3092ea42b968fa16ac835969d124898:

  efi/libstub: Disable PCI DMA before grabbing the EFI memory map (2023-06-27 12:27:06 +0200)

----------------------------------------------------------------
EFI updates for v6.5

Although some more stuff is brewing, the EFI changes that are ready for
mainline are few, so not a lot to pull this cycle:

- improve the PCI DMA paranoia logic in the EFI stub
- some constification changes
- add statfs support to efivarfs
- allow user space to enumerate updatable firmware resources without
  CAP_SYS_ADMIN

----------------------------------------------------------------
Anisse Astier (1):
      efivarfs: expose used and total size

Ard Biesheuvel (1):
      efi/libstub: Disable PCI DMA before grabbing the EFI memory map

Nicholas Bishop (1):
      efi/esrt: Allow ESRT access without CAP_SYS_ADMIN

Thomas Weißschuh (2):
      efi: x86: make kobj_type structure constant
      efi: make kobj_type structure constant

 arch/x86/platform/efi/quirks.c                 |  8 ++++++
 arch/x86/platform/efi/runtime-map.c            |  2 +-
 drivers/firmware/efi/efi.c                     |  1 +
 drivers/firmware/efi/esrt.c                    |  6 +---
 drivers/firmware/efi/libstub/efi-stub-helper.c |  6 ++--
 drivers/firmware/efi/vars.c                    | 12 ++++++++
 fs/efivarfs/super.c                            | 39 +++++++++++++++++++++++++-
 include/linux/efi.h                            | 11 ++++++++
 8 files changed, 75 insertions(+), 10 deletions(-)
