Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B871469534
	for <lists+linux-efi@lfdr.de>; Mon,  6 Dec 2021 12:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242580AbhLFLsz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Dec 2021 06:48:55 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40740 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237397AbhLFLsz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Dec 2021 06:48:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8EB0BB81085
        for <linux-efi@vger.kernel.org>; Mon,  6 Dec 2021 11:45:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D05AC341C2;
        Mon,  6 Dec 2021 11:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638791124;
        bh=H/Cloj07eqap8zcbGe0b40pt8YrwRJMjG6lQ8fqYEho=;
        h=From:To:Cc:Subject:Date:From;
        b=SoNPOs/JLy51hgYRYU/UVxDOzE0QkIMS3MnsaKh0UwSGsEgXVIbJ3Ik7ysekUPnQS
         8HSmrGGUZ8WAtdN+M0ZAMcmfFDoCCvH8nY8PaA+ZqYgT6+whDK6vbPRJolgNtOP44+
         Lvr2XInyde1ML27X8pMkr//0yyB8R2n8RjXArWIDU+TWfAvuE/fJLKgtssrmRt+9QM
         GRE6szjtMPw8ztIHshfgZaZqjFH/7aDInMK8f8pSY5tBI90sdw+97+MeIa7m66WV5C
         G4qlNqkY62arrA+2ih1D/6Ws3knHbmvvAYZRfzi6w9VyAMdLOwadZKQDCFJ6l1avjx
         0Sy4txPGFzseg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@suse.de>
Subject: [GIT PULL] EFI fix for v5.16
Date:   Mon,  6 Dec 2021 12:45:10 +0100
Message-Id: <20211206114510.561270-1-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1088; h=from:subject; bh=H/Cloj07eqap8zcbGe0b40pt8YrwRJMjG6lQ8fqYEho=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBhrffF1+tnpeQNO4fhVJ0ANpyEHvRNfVblBPEcHDAv 9/P+g8yJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYa33xQAKCRDDTyI5ktmPJERPC/ 9h0uxHWx3SFOR7dFGgA1Ph0EWumIqEASvWxwVrrzvcD8GVP4XLXr7CCJcX6/1S2QngnoNNQz/sIAqK wpbuRdEIFTT0q+5rpjGqcUc7N83zDPJ5Btvspwf4JwyKzp517iQXuGoXQKqQLKkQzR27tTyFyalH8K puXq47XwU7mQOWo+ZVq4bYct30h81NTHPdta7TRNLIknexgy77AWatv9YUFrR3B9X0P2EXi/4KT8Cw ogRnJmhvwtJYzyqGMzYy44OFWXq0EF+4IAjUbYCyI1b9vgX7GOEpTzXfP2s06Ksj0Eo+MiYvI3/WBf nn5VRrO8Vb46dxez5eIJvHAAotJ7T9mxtXRZ9ffjwKJVp71H7oaFr2xsnGNPv8qpMlx/LBRMfJVPiH kfXgO9HC5wZ0aM0pMHdNpBBCajaYCLuXf3FZaMCO9A20Jks9KqKoLcOdoAV5cMDOicgMZBawUkm7/g jkj1M6QHu7/2QU+vecwpW+JJxZXGqZvSugx0saizUceP4=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Linus,

As Boris mentioned in the last EFI pull request, I will be sending EFI stuff
directly from now on.

Please pull the following EFI fix.

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v5.16

for you to fetch changes up to 1ff2fc02862d52e18fd3daabcfe840ec27e920a8:

  x86/sme: Explicitly map new EFI memmap table as encrypted (2021-12-05 16:44:52 +0100)

Cc: Borislav Petkov <bp@suse.de>

----------------------------------------------------------------
EFI fix for v5.16

Ensure that the EFI memory map resides in encrypted memory even after it
has been reallocated.

----------------------------------------------------------------
Tom Lendacky (1):
      x86/sme: Explicitly map new EFI memmap table as encrypted

 arch/x86/Kconfig               | 1 +
 arch/x86/platform/efi/quirks.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)
