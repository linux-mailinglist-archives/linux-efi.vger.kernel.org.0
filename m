Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9E0167895
	for <lists+linux-efi@lfdr.de>; Fri, 21 Feb 2020 09:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgBUItI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Feb 2020 03:49:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:58066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbgBUItH (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 21 Feb 2020 03:49:07 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 421C520722;
        Fri, 21 Feb 2020 08:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582274946;
        bh=vUoHx5b0NGH+KG1C5W/cD75EpwMd7Q8IxzBf8FXvVgM=;
        h=From:To:Cc:Subject:Date:From;
        b=S+rbV3QxSFMhLqddXEi8BSEabnbypAT7ZdrmpA62l3bbkI8s6lY4WGQJBIYKJfTNa
         7V34FbrJdsWkBDdBbujs2qBf5c6vgtw/84QhsHfx0GoA2yFLdp2ocfgezA/dE9jXfJ
         5kgr1PZUSvjSvu73O5td6YiQQRbATxLQn5ogB+FA=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: [GIT PULL 0/4] EFI fixes for v5.6-rc
Date:   Fri, 21 Feb 2020 09:48:45 +0100
Message-Id: <20200221084849.26878-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent

for you to fetch changes up to 4905450b9255089ec1828882e0480831e535ccc5:

  efi: READ_ONCE rng seed size before munmap (2020-02-17 17:46:26 +0100)

----------------------------------------------------------------
EFI fixes for v5.6-rcX:
- some mixed mode fixes that came about after Hans reported issues in
  the VA to PA translation code used by the mixed mode EFI runtime
  service call wrappers.
- use READ_ONCE() to dereference the UEFI rng seed structure, which gets
  mapped, unmapped and remapped without the compiler being aware of it.

----------------------------------------------------------------
Ard Biesheuvel (3):
      efi/x86: align GUIDs to their size in the mixed mode runtime wrapper
      efi/x86: remove support for EFI time and counter services in mixed mode
      efi/x86: Handle by-ref arguments covering multiple pages in mixed mode

Jason A. Donenfeld (1):
      efi: READ_ONCE rng seed size before munmap

 arch/x86/platform/efi/efi_64.c | 151 ++++++++++++++---------------------------
 drivers/firmware/efi/efi.c     |   4 +-
 2 files changed, 54 insertions(+), 101 deletions(-)
