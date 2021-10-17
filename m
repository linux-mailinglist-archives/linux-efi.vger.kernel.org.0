Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0474307A7
	for <lists+linux-efi@lfdr.de>; Sun, 17 Oct 2021 12:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235789AbhJQKDl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 17 Oct 2021 06:03:41 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57306 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbhJQKDl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 17 Oct 2021 06:03:41 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A292321970;
        Sun, 17 Oct 2021 10:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634464890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=hEmSZTL6h9K3pFBzmHbHxjmAJKZVNOfltGHmYQwF5VA=;
        b=ZTcaHH/0BiwIGAiveDUabgm6Rvg2nfLx+EtVdFVNnHInGUSa6k1RBXtAEz54uDsx8BFa2n
        YpUZR5Wfa9UHZppc+aVggiRx61SOfVOJ8mgP7n+HcyIBwdvGkFnA8Sy48uzZRm5fI12CSn
        XrAzgZgBEXb5FjNokbUQgmavNqebLoE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634464890;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=hEmSZTL6h9K3pFBzmHbHxjmAJKZVNOfltGHmYQwF5VA=;
        b=Q7kM0BXpNh/FFyF7V5Sexc220EQf66pgAV2uIA0hSKx+0xMtRzL8wZoWQk6XIi61TYhm64
        +htNGVLqsKplZYDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9071613A39;
        Sun, 17 Oct 2021 10:01:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id p4szI3r0a2FiNAAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 17 Oct 2021 10:01:30 +0000
Date:   Sun, 17 Oct 2021 12:01:33 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] efi/urgent for v5.15-rc6
Message-ID: <YWv0fTagC0e4D0Jy@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Linus,

please pull (forwarded) EFI urgent fixes for 5.15.

This is going to be the one before last EFI pull request going through
the tip tree and Ard will send stuff directly to you in the future.

 [ There's one more branch which we'll send to you during the upcoming
   merge window which should be the last one. ]

The reasoning being, EFI work doesn't really have a lot to do (only)
with x86 anymore.

Anyway, JFYI.

Please pull,
thx.

---

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/efi-urgent-for-v5.15

for you to fetch changes up to 38fa3206bf441911258e5001ac8b6738693f8d82:

  efi: Change down_interruptible() in virt_efi_reset_system() to down_trylock() (2021-10-05 13:07:01 +0200)

----------------------------------------------------------------
EFI fixes for v5.15

Low priority fixes but fixes nonetheless:
- update stub diagnostic print that is no longer accurate
- avoid statically allocated buffer for CPER error record decoding
- avoid sleeping on the efi_runtime semaphore when calling the
  ResetSystem EFI runtime service

----------------------------------------------------------------
Ard Biesheuvel (1):
      efi/cper: use stack buffer for error record decoding

Heinrich Schuchardt (1):
      efi/libstub: Simplify "Exiting bootservices" message

Zhang Jianhua (1):
      efi: Change down_interruptible() in virt_efi_reset_system() to down_trylock()

 drivers/firmware/efi/cper.c             | 4 ++--
 drivers/firmware/efi/libstub/fdt.c      | 2 +-
 drivers/firmware/efi/runtime-wrappers.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
