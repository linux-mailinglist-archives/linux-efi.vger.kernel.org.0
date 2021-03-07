Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7570432FFC5
	for <lists+linux-efi@lfdr.de>; Sun,  7 Mar 2021 10:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhCGJAe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 7 Mar 2021 04:00:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:36484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229872AbhCGJAY (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 7 Mar 2021 04:00:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B3B7E6512D;
        Sun,  7 Mar 2021 09:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615107624;
        bh=2mJuN6pBgJ/Z+RcyKXHugODoyU6nX+wT0GsNevDHWy4=;
        h=From:To:Cc:Subject:Date:From;
        b=MLBJsFWHM9zuy9/DwSIgMFUix7mMpoD45yDjQew3P7dB+Ec4LmoyedUiyj/3DV+id
         5oHUasxu/p3f2NBa0kyJXeBvhXwNs/c+du90xZO1I/sCLOWTto0ewKNEo3X7gnvVDT
         1ktJ+uWK0DH074B9YUnuK33nHQ+9IFsEYkCj/JnQKQTkMu4f14To1kM+SWSK8F0gEa
         HjLcaM4XNpQufyrk+ugcpclt+43Q9qswDnlCYAJJJzUhUTviyCT3Dmy08F9OgGvmdh
         LcfOfq/ps8XOmnZxBkOze6SrpHA3nimwzw/pPj157zM//PprA3nNQnuRAN1fsOpufN
         e1S1EBYxa4OKg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Subject: [GIT PULL] EFI fix for v5.12-rc2
Date:   Sun,  7 Mar 2021 10:00:14 +0100
Message-Id: <20210307090014.65474-1-ardb@kernel.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v5.12-rc2

for you to fetch changes up to 9e9888a0fe97b9501a40f717225d2bef7100a2c1:

  efi: stub: omit SetVirtualAddressMap() if marked unsupported in RT_PROP table (2021-03-07 09:31:02 +0100)

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>

----------------------------------------------------------------
EFI fix for 5.12-rc2

Fix an oversight in the handling of the UEFI 2.8 EFI_RT_PROPERTIES_TABLE,
which was added v5.10, but failed to take the SetVirtualAddressMap() RT
service into account.

----------------------------------------------------------------
Ard Biesheuvel (1):
      efi: stub: omit SetVirtualAddressMap() if marked unsupported in RT_PROP table

 drivers/firmware/efi/libstub/efi-stub.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
