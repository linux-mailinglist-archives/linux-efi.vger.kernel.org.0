Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE1471F422
	for <lists+linux-efi@lfdr.de>; Thu,  1 Jun 2023 22:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjFAUrp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 1 Jun 2023 16:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbjFAUro (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 1 Jun 2023 16:47:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBA91A2
        for <linux-efi@vger.kernel.org>; Thu,  1 Jun 2023 13:47:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B785A649B0
        for <linux-efi@vger.kernel.org>; Thu,  1 Jun 2023 20:47:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D6AC433D2;
        Thu,  1 Jun 2023 20:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685652455;
        bh=y4fG1Fq12ofevVd8ulrOJv3XYMKXMliRAsK+yTjrx1I=;
        h=From:To:Cc:Subject:Date:From;
        b=HL1hDtFLurTtaSlQjAociYEyKMB2KRXNtU9Vee+4Q9NoHnS/9adBgZk/HpU3jpoCQ
         asxvaV/wGAH8CzmQaUHlGCRYrXrTBHe1RJZmKVM5xl6SRqrU7Wh8d1VQyESGFkXQSW
         AJMvek+tFdvErPLrUnZE7zF3sNV4g+rU/JrHqFgCen1jKZrloAw1BD1cJcj6OqNGZc
         8Liaho87Yzt+V2ilfzpaC9yjzBWNOC9eLhogQTGL4YV3mb9dnMM+i0h/kwkrEuLhdv
         wyFgQORt7LXW6loALy5i0UPJJV6BcvaXIae93972YiG0/p1WMC91ndIIf9YVu0oLsN
         uZJNxT+BHt88w==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [GIT PULL] EFI fixes for v6.4 #1
Date:   Thu,  1 Jun 2023 22:47:15 +0200
Message-Id: <20230601204715.3368380-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1678; i=ardb@kernel.org; h=from:subject; bh=y4fG1Fq12ofevVd8ulrOJv3XYMKXMliRAsK+yTjrx1I=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIaWS+dLr7WEXt/LHhOaxhng/bL5p8+lUDdeet48u3K3eY fZ9/TnWjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCRVTwM/1TYWmdwKE+5EuKU dTPB9qTkzIlGdl1KcxJdFZJ7th/3WMTw3yt+y+bo9MLX99/NNNRT2MGevzZ1ufKLaZdPuCRF+85 gZwIA
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Linus,

A few minor fixes for EFI, one of which fixes the reported boot regression when
booting x86 kernels using the BIOS based loader built into the hypervisor
framework on macOS.

Please pull.


The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.4-1

for you to fetch changes up to 36e4fc57fc1619f462e669e939209c45763bc8f5:

  efi: Bump stub image version for macOS HVF compatibility (2023-05-28 20:45:46 +0200)

----------------------------------------------------------------
First batch of EFI fixes for v6.4:

- fix harmless warning in zboot code on 'make clean'
- add some missing prototypes
- fix boot regressions triggered by PE/COFF header image minor version
  bump

----------------------------------------------------------------
Akihiro Suda (1):
      efi: Bump stub image version for macOS HVF compatibility

Ard Biesheuvel (1):
      efi/libstub: zboot: Avoid eager evaluation of objcopy flags

Arnd Bergmann (1):
      efi: fix missing prototype warnings

 drivers/acpi/apei/apei-internal.h           |  6 ------
 drivers/acpi/apei/bert.c                    |  1 +
 drivers/firmware/efi/libstub/Makefile.zboot |  3 ++-
 drivers/firmware/efi/libstub/efistub.h      |  3 +++
 include/linux/cper.h                        |  6 ++++++
 include/linux/efi.h                         |  2 ++
 include/linux/pe.h                          | 25 +++++++++++++------------
 7 files changed, 27 insertions(+), 19 deletions(-)
