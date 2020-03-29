Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1E2196BCE
	for <lists+linux-efi@lfdr.de>; Sun, 29 Mar 2020 10:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgC2IF7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 29 Mar 2020 04:05:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:54988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbgC2IF7 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 29 Mar 2020 04:05:59 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9640120714;
        Sun, 29 Mar 2020 08:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585469159;
        bh=XtKxxKStYvAuyHKcLIj+Sw19XKUh1BKFz9RqPo1YXxc=;
        h=From:To:Cc:Subject:Date:From;
        b=tnaNOdfV3yNZp6iQ96Fx4BNewK/leQWezZwhCD9Ju2cb4b1ZqlBF8rN1k14dKToaj
         Kue0PkXrwL9qdIEr7f7rIhrjk2Ram1Gf9dkTuzdd0EWLn1hHwD7s6LCln+Dx3gqkch
         tRjpv7O+RUOqxYw+V21QgH/nvgmG/C5OvH4rz1r0=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [GIT PULL 0/2] EFI touchups for v5.7
Date:   Sun, 29 Mar 2020 10:05:42 +0200
Message-Id: <20200329080544.25715-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Ingo, Thomas,

Please pull the below into tip:efi/core - it is a pair of fixes for the
code that has been queued up for v5.7

Thanks,
Ard.


The following changes since commit d5528d5e91041e68e8eab9792ce627705a0ed273:

  partitions/efi: Fix partition name parsing in GUID partition entry (2020-03-08 10:00:09 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git efi-next

for you to fetch changes up to c6987a415f71352fe1483b09d8b0027ccf3b2175:

  efi/libstub/arm: fix spurious message that an initrd was loaded (2020-03-29 09:48:42 +0200)

----------------------------------------------------------------
Some EFI followup fixes for v5.7:
- fix arm64 boot regression on broken, older versions of GRUB
- suppress spurious 'initrd loaded from command line' print

----------------------------------------------------------------
Ard Biesheuvel (2):
      efi/libstub/arm64: avoid image_base value from efi_loaded_image
      efi/libstub/arm: fix spurious message that an initrd was loaded

 drivers/firmware/efi/libstub/arm-stub.c   | 2 +-
 drivers/firmware/efi/libstub/arm64-stub.c | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)
