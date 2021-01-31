Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1CA309C82
	for <lists+linux-efi@lfdr.de>; Sun, 31 Jan 2021 15:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbhAaN5v (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 31 Jan 2021 08:57:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:52576 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231336AbhAaLDa (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 31 Jan 2021 06:03:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D12D4AC4F;
        Sun, 31 Jan 2021 11:00:54 +0000 (UTC)
Date:   Sun, 31 Jan 2021 12:00:57 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] efi/urgent for v5.11-rc6
Message-ID: <20210131110057.GB4432@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Linus,

please pull a (forwarded) single EFI urgent fix for v5.11-rc6.

Thx.

---

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/efi-urgent-for-v5.11

for you to fetch changes up to 355845b738e76445c8522802552146d96cb4afa7:

  efi/apple-properties: Reinstate support for boolean properties (2020-12-31 10:28:53 +0100)

----------------------------------------------------------------
A single EFI fix from Lukas:

- handle boolean device properties imported from Apple firmware
  correctly.

----------------------------------------------------------------
Lukas Wunner (1):
      efi/apple-properties: Reinstate support for boolean properties

 drivers/firmware/efi/apple-properties.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
