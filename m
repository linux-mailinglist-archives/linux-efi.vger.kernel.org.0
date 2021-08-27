Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D03CB3F9AE3
	for <lists+linux-efi@lfdr.de>; Fri, 27 Aug 2021 16:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbhH0Obr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Aug 2021 10:31:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:53474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232641AbhH0Obq (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 27 Aug 2021 10:31:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C25F760295;
        Fri, 27 Aug 2021 14:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630074657;
        bh=Cj3OmkIQR4lyaAE452uRdJUYWlU9ivuPHdmh03YVBUA=;
        h=From:To:Cc:Subject:Date:From;
        b=qa2KGGJoCXS3U4wLZlLJ5UUaNz0fF1o2cHbzxY2v28SWN7tlSHeJJaOu+hnOTCxgN
         l4hvUumtSsugitad2PwlTTX6AtyTDq/b1XLqSozPYrzpQ/EjDRbRbcbLCrV3RUBBVK
         XhSie4Fn7ujgsffZMYDxPNxfPAKPL1nECxkvYvSkCxAbdYOsB+DqkTZXpta2kWznlf
         1pKXbm4uoCLl081yASddcDOBEserXhDlJK4l0CYZTaT1cr4YCMqqp6VLVBNuXmri4W
         Syi8Deb/0koLHT9hLk3BeXMYJZjbb0YUFyu9ENDWT0G1g5bju9qjHr5RonikRcAqf4
         X93bz3DHAoOMA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Subject: [GIT PULL] EFI updates for v5.15
Date:   Fri, 27 Aug 2021 16:30:43 +0200
Message-Id: <20210827143043.221575-1-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Dear tib,

Apologies for sending this out late. Please apply it where and when it is most
convenient.

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v5.15

for you to fetch changes up to 1be72c8e0786727df375f11c8178ce7e65eea20e:

  efi: cper: check section header more appropriately (2021-08-27 16:03:01 +0200)

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>

----------------------------------------------------------------
EFI updates for v5.15

A couple of fixlets that could equally be merged as fixes, but due to
the low priority and where we are in the cycle, I am sending them as
updates for v5.15 instead.

- Some EFI CPER parsing improvements
- Don't take the address of efi_guid_t internal fields

----------------------------------------------------------------
Andy Shevchenko (1):
      efi: Don't use knowledge about efi_guid_t internals

Rasmus Villemoes (1):
      efi: cper: fix scnprintf() use in cper_mem_err_location()

Shuai Xue (1):
      efi: cper: check section header more appropriately

 drivers/firmware/efi/cper.c                    | 13 ++++++-------
 security/integrity/platform_certs/efi_parser.c |  2 +-
 2 files changed, 7 insertions(+), 8 deletions(-)
