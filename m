Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0890C33A4BB
	for <lists+linux-efi@lfdr.de>; Sun, 14 Mar 2021 13:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235436AbhCNMWV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 14 Mar 2021 08:22:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:38496 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235327AbhCNMVu (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 14 Mar 2021 08:21:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F1F74ABD7;
        Sun, 14 Mar 2021 12:21:48 +0000 (UTC)
Date:   Sun, 14 Mar 2021 13:21:47 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] efi/urgent for v5.12-rc3
Message-ID: <20210314122134.GB27191@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Linus,

please pull a single (forwarded) EFI urgent fix for v5.12-rc3.

Thx.

---

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/efi-urgent-for-v5.12-rc2

for you to fetch changes up to 9e9888a0fe97b9501a40f717225d2bef7100a2c1:

  efi: stub: omit SetVirtualAddressMap() if marked unsupported in RT_PROP table (2021-03-07 09:31:02 +0100)

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

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
