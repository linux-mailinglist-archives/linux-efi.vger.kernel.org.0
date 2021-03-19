Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFA0341D94
	for <lists+linux-efi@lfdr.de>; Fri, 19 Mar 2021 13:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhCSM6x (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 19 Mar 2021 08:58:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:42050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230042AbhCSM6f (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 19 Mar 2021 08:58:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D18E764F69;
        Fri, 19 Mar 2021 12:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616158715;
        bh=BF2M8cH0GcADn4zloMtNmgTT5Y9yhJkKqoDOM5ZIomo=;
        h=From:To:Cc:Subject:Date:From;
        b=XDJbpqu0gEzk/8p1DYUNU/ritHMHkyAut0f8jI9039s8x4SH7pIaot17Xpt+OPgei
         L5yPjmljHBb6v6zUHtzagCWAGAjVo2PS0SWBC4E1aY9YL5oeFS24ECdDgKaYcXuw6G
         Yr2DIkaR6fSiPwyT7nZLxQAsY7vupyNJDHHwxgDJ7G70Q45/N847/P0AnoXCTovw4s
         CV99R2KiGklDucNbZ9cspMP5sVkQyBcNr+FBkJIzFyEcXV8bP70S9eLpsIGkmO5+gG
         cgvKgnq/xTXfRivclqmKOGv1/qdD3JSvFnDqcgnWTStKGWQAI9fCmESHoZgaGGlQcc
         T7bDWlf5OVnug==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Subject: [GIT PULL] More EFI fixes for v5.12-rc
Date:   Fri, 19 Mar 2021 13:58:10 +0100
Message-Id: <20210319125810.230557-1-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following changes since commit 9e9888a0fe97b9501a40f717225d2bef7100a2c1:

  efi: stub: omit SetVirtualAddressMap() if marked unsupported in RT_PROP table (2021-03-07 09:31:02 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v5.12-rc3

for you to fetch changes up to fb98cc0b3af2ba4d87301dff2b381b12eee35d7d:

  efi: use 32-bit alignment for efi_guid_t literals (2021-03-19 07:44:28 +0100)

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>

----------------------------------------------------------------
Another couple of EFI fixes for v5.12-rc:

- anothing missing RT_PROP table related fix, to ensure that the efivarfs
  pseudo filesystem fails gracefully if variable services are unsupported
- use the correct alignment for literal EFI GUIDs
- fix a use after unmap issue in the memreserve code

----------------------------------------------------------------
Ard Biesheuvel (1):
      efi: use 32-bit alignment for efi_guid_t literals

Lv Yunlong (1):
      firmware/efi: Fix a use after bug in efi_mem_reserve_persistent

Shawn Guo (1):
      efivars: respect EFI_UNSUPPORTED return from firmware

 drivers/firmware/efi/efi.c  | 3 ++-
 drivers/firmware/efi/vars.c | 4 ++++
 include/linux/efi.h         | 6 ++++--
 3 files changed, 10 insertions(+), 3 deletions(-)
