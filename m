Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D702949FBAC
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jan 2022 15:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349118AbiA1ObR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jan 2022 09:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349170AbiA1ObR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 28 Jan 2022 09:31:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DB8C061714
        for <linux-efi@vger.kernel.org>; Fri, 28 Jan 2022 06:31:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 344C8B825DE
        for <linux-efi@vger.kernel.org>; Fri, 28 Jan 2022 14:31:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200E1C340E0;
        Fri, 28 Jan 2022 14:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643380274;
        bh=7UMHsuv7yeD6ORR67xpXPkGIjXp+iV6nzOwq9NhoZ1I=;
        h=From:To:Cc:Subject:Date:From;
        b=EUWtkaYElEoPH5yqQAwJDSSA96qatL9uEM5OmxR3k2vXkIUDSXNN2iYSRBaYqLdJ0
         l5icau/x2+nmpZhTU/hRNQq6XZgeawxTBVONfGLLURF/tfF9T1zHjx04H9t3DWlE+R
         Ks6qMuTrWN6Q/dY4VCj2KoFVC6KSy0qa0CBGk12O4UZjx1giBwycfervYAhnWvc9j6
         CtIxYqFPeKnD2guH3WTbYUIh/H8L4tTX4bj5Fd8gGeZDPtUhh+7FZLjvFXpAml2K9w
         y/DAfMWVxT+sHoUdNC/uk8chGBxB4hpkUtbGzwm06f2zteibIItAsH5pEcTnv3l2qi
         snpH9qNs1sxwA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [GIT PULL] EFI fixes for v5.17
Date:   Fri, 28 Jan 2022 15:30:49 +0100
Message-Id: <20220128143049.3630222-1-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1224; h=from:subject; bh=7UMHsuv7yeD6ORR67xpXPkGIjXp+iV6nzOwq9NhoZ1I=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh8/4YGLJgcqqX/Ky0R5SuC2JFtV+K76OVE2a1x+Ae svIVPVCJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYfP+GAAKCRDDTyI5ktmPJNGpDA COvKjAq2S5QcHzv/hE0n1WAXgy4ATY1Q1r+lmOMxB60FJ2W/ip9pQdXMPc9/ImWkhsiRqh68DTKu+j JciKVatwmb759I3UZkNJ3Zd09aG2neEJWbUa0eKK69z9emesIV/AQKkmk9fNkKBYmQuvXyG6v/1tjF Y4elrhJ/QFRpMrDXRivxdG/d22qB4rtARkPm2zc8Ot7UfhaGYSwRwSyNhoaZ93rsaWqbogJ9AbnOVe dByNpvIc7lL1vlyCIdowpJaC+IpHaaiq9srvH6qIzazK44aNR1R+u9n03Cdk9oshya2PzZ8AaElgoI UxUZ6t21WlldEsssYzbOFM7TRP20+gF1P7S9IwUGiIP7VwuCh4hv7pfRwNUM3w1r+77RDfFeVl6OSF fPPrPP7ysZ4h8I8V/m3eantE7lZmWisLgPCDg94WqFJPCPd+pwb6coyqWrFYTFjC9oaGVOk0Frv61g Xq/KJ59v5R8n0EDTlE9PNRSES/NlIQzNWFgz7+HEkernA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Linus,

Please pull the EFI fixes below.

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v5.17-1

for you to fetch changes up to f5390cd0b43c2e54c7cf5506c7da4a37c5cef746:

  efi: runtime: avoid EFIv2 runtime services on Apple x86 machines (2022-01-23 10:31:27 +0100)

----------------------------------------------------------------
First set of EFI fixes for v5.17

- avoid UEFI v2.00+ runtime services on Apple Mac systems, as they have
  been reported to cause crashes, and most Macs claim to be EFI v1.10
  anyway
- avoid a spurious boot time warning on arm64 systems with 64k pages

----------------------------------------------------------------
Ard Biesheuvel (1):
      efi: runtime: avoid EFIv2 runtime services on Apple x86 machines

Mihai Carabas (1):
      efi/libstub: arm64: Fix image check alignment at entry

 drivers/firmware/efi/efi.c                | 7 +++++++
 drivers/firmware/efi/libstub/arm64-stub.c | 6 +++---
 2 files changed, 10 insertions(+), 3 deletions(-)
