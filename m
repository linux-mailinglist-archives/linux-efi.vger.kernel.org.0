Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDFE275D0D
	for <lists+linux-efi@lfdr.de>; Wed, 23 Sep 2020 18:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgIWQO4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 23 Sep 2020 12:14:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:41820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIWQO4 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 23 Sep 2020 12:14:56 -0400
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22EDE208E4;
        Wed, 23 Sep 2020 16:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600877695;
        bh=dk+QcofUZF2WF6NY96BLfm8no50VorPOSdUmQFbAlGY=;
        h=From:To:Cc:Subject:Date:From;
        b=fQzhw5RcUtCZLZhugKmm75OBE2Plj+0eJac6SezDf5ohfnAyG9s47QKWHlAOPWv+U
         94cAPTPIf0/S4XpHK9kDtrzoyiDaFUhJ3qRtVCW+UoSRlQMD7PDAkIX+sxEbEo0kaL
         c/ggxHbaZixzUaPGQ2kjzCafIEr0PpJbLcsZCrp4=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        Peter Jones <pjones@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH 0/7] efi: deprecate/remove efivars sysfs interface
Date:   Wed, 23 Sep 2020 18:13:57 +0200
Message-Id: <20200923161404.17811-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This series implements the deprecation and ultimate removal of the sysfs
interface that exposes the contents of the EFI variable store.

I am fully aware that removing this sysfs interface entirely may be
premature, and so patch #7 is included for reference only, and not
proposed for inclusion right away.

Instead, patch #6 limits availability of the efivars module to X86
and IA64, which is reasonable, given that the efivars module was
superseded by the efivarfs filesystem interface before EFI support
for ARM architectures was even available in Linux.

Patches #1 to #5 remove all dependencies [true or false] on the efivars.c
code and its CONFIG_EFI_VARS Kconfig symbol, so it can be disabled [or
dropped] cleanly.

Cc: Matthew Garrett <mjg59@google.com>
Cc: Peter Jones <pjones@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Anton Vorontsov <anton@enomsg.org>
Cc: Colin Cross <ccross@android.com>
Cc: Tony Luck <tony.luck@intel.com>

Ard Biesheuvel (7):
  efi: pstore: disentangle from deprecated efivars module
  efi: pstore: move workqueue handling out of efivars
  efi: efivars: un-export efivars_sysfs_init()
  efi: gsmi: fix false dependency on CONFIG_EFI_VARS
  efi: remove some false dependencies on CONFIG_EFI_VARS
  efi: efivars: limit availability to X86 builds
  efi: efivars: remove deprecated sysfs interface

 .../ABI/stable/sysfs-firmware-efi-vars        |  75 --
 Documentation/arm/uefi.rst                    |   2 +-
 drivers/firmware/efi/Kconfig                  |  22 +-
 drivers/firmware/efi/Makefile                 |   1 -
 drivers/firmware/efi/efi-pstore.c             |  83 +-
 drivers/firmware/efi/efivars.c                | 711 ------------------
 drivers/firmware/efi/vars.c                   |  21 -
 drivers/firmware/google/Kconfig               |   2 +-
 drivers/firmware/google/gsmi.c                |   8 +-
 include/linux/efi.h                           |  18 -
 10 files changed, 85 insertions(+), 858 deletions(-)
 delete mode 100644 Documentation/ABI/stable/sysfs-firmware-efi-vars
 delete mode 100644 drivers/firmware/efi/efivars.c

-- 
2.17.1

