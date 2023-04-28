Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178056F1F31
	for <lists+linux-efi@lfdr.de>; Fri, 28 Apr 2023 22:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345730AbjD1UR5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Apr 2023 16:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345755AbjD1UR5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 28 Apr 2023 16:17:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B882700
        for <linux-efi@vger.kernel.org>; Fri, 28 Apr 2023 13:17:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A285F612C5
        for <linux-efi@vger.kernel.org>; Fri, 28 Apr 2023 20:17:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3597CC433EF;
        Fri, 28 Apr 2023 20:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682713075;
        bh=CT0pZdXrP9ItjYOPultfMgduSdiHf/p5IKTXXaSUy/I=;
        h=From:To:Cc:Subject:Date:From;
        b=JFI4hBKERGTSZycIeuHFIuUAYvASUAz1GfGxYQiNEOfscQcSsTKvk7Gm/OAywu++6
         wPMv2lCM2rk0R3XZSkEbYXjPBPJPPlQi8DWJVooPJ25LoO1V5sMU5YZyTIvre2xNZ3
         IEZV0pos61Y2fth1xCmKhXZxs2d3DLs7iD/QrOGHH/erisH4/uKh4+fmvSUQxOZSRn
         aXbFqXg4pgmrl/22zMfEI+cqnM/s63DygHfW5Q7qZHkudRoCHH8d+lcPFfpbA951Gd
         ZVn3Vcx6YqRT/9I3gWinmPhiHfXIsFK3wypz6BNAsUKAT3gDCpuxCvsMqr9bdIT6pd
         qFBsRnbsg8ZGA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [GIT PULL] EFI updates for v6.4
Date:   Fri, 28 Apr 2023 22:17:41 +0200
Message-Id: <20230428201741.2580061-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2220; i=ardb@kernel.org; h=from:subject; bh=CT0pZdXrP9ItjYOPultfMgduSdiHf/p5IKTXXaSUy/I=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIcVH84nP/ii2pXPf1LpsqHi/f+u3bXsKPq4L+eF6Jdtg2 uwkDqkXHaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAiaUaMDOcs7+16br9+tcRG +9b1J6K1D0+9MCtTbNHqS3cMG54o6+UyMmywK3WwN67IPHxeQFQ/n2V+alTe6cCiz5uKDP4dP9Q swQkA
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Linus,

Not a lot going on this time - details in the tag. Please pull.

-- 
Ard.


The following changes since commit 197b6b60ae7bc51dd0814953c562833143b292aa:

  Linux 6.3-rc4 (2023-03-26 14:40:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.4

for you to fetch changes up to 026b85796ab4d52af56f8a1c60d2613983ecd845:

  efi/zboot: arm64: Grab code size from ELF symbol in payload (2023-04-26 23:06:48 +0200)

----------------------------------------------------------------
EFI updates for v6.4:

- relocate the LoongArch kernel if the preferred address is already
  occupied;

- implement BTI annotations for arm64 EFI stub and zboot images;

- clean up arm64 zboot Kbuild rules for injecting the kernel code size.

----------------------------------------------------------------
Ard Biesheuvel (6):
      efi/pe: Import new BTI/IBT header flags from the spec
      arm64: efi: Enable BTI codegen and add PE/COFF annotation
      efi/zboot: Add BSS padding before compression
      efi/zboot: Set forward edge CFI compat header flag if supported
      efi/zboot: arm64: Inject kernel code size symbol into the zboot payload
      efi/zboot: arm64: Grab code size from ELF symbol in payload

Huacai Chen (1):
      efi/loongarch: Reintroduce efi_relocate_kernel() to relocate kernel

 arch/arm64/boot/Makefile                      |  4 ++
 arch/arm64/kernel/efi-header.S                | 71 ++++++++++++++++-----------
 arch/arm64/kernel/image-vars.h                |  4 ++
 drivers/firmware/efi/libstub/Makefile         |  3 +-
 drivers/firmware/efi/libstub/Makefile.zboot   | 43 ++++++++++------
 drivers/firmware/efi/libstub/arm64.c          | 19 ++++---
 drivers/firmware/efi/libstub/efistub.h        |  3 +-
 drivers/firmware/efi/libstub/loongarch-stub.c | 24 +++------
 drivers/firmware/efi/libstub/zboot-header.S   | 51 ++++++++++++-------
 drivers/firmware/efi/libstub/zboot.c          | 13 ++---
 drivers/firmware/efi/libstub/zboot.lds        |  7 +++
 include/linux/pe.h                            |  4 ++
 12 files changed, 149 insertions(+), 97 deletions(-)
