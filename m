Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD3DD48A15B
	for <lists+linux-efi@lfdr.de>; Mon, 10 Jan 2022 22:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343729AbiAJVDX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 10 Jan 2022 16:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239741AbiAJVDW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 10 Jan 2022 16:03:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559C7C06173F
        for <linux-efi@vger.kernel.org>; Mon, 10 Jan 2022 13:03:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB55D6144D
        for <linux-efi@vger.kernel.org>; Mon, 10 Jan 2022 21:03:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FECBC36AE3;
        Mon, 10 Jan 2022 21:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641848601;
        bh=gmbgTpUCma8vqRryUGeA1dcUqoF5o1aJ6+HHNyFUaKE=;
        h=From:To:Cc:Subject:Date:From;
        b=QJEP4BTs6iqBGl/ZgpYHaIOlHDuG76AiugyjnhmJTmBRcTHe50/M6FPef6CtQ0js7
         N7Sn9ue8z37teXs33MI2JC4HZJvAq0XJcY3Yos4ZxHms6lUH4OIH+citu5ufwCXeFD
         2X7GXX8BGiFSPESxQwBvRrM6b5l+Fk8AGVhiDaLvCCfuj7owxEl4/k3uzSQQDMaAW9
         MIJsBvwqQO/mFJkQrGkSbSUJa+nwiGLoR4K6QeFEhkNYYaqKqvhSuCTLaASSG9jU0f
         /401j3CtAHqI573LUfbCILerZHK0Vxwdkn6O5KYHSQvo0E2uKb5RCrVVfyOZG+t0dz
         operXKHzxq4Fg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [GIT PULL] EFI updates for v5.17
Date:   Mon, 10 Jan 2022 22:03:07 +0100
Message-Id: <20220110210307.918857-1-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1939; h=from:subject; bh=gmbgTpUCma8vqRryUGeA1dcUqoF5o1aJ6+HHNyFUaKE=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh3J8Kl+b/qoQNpgv/GQ1D1RNPQTEAdc+rARGOfnwm 6CX7B3SJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYdyfCgAKCRDDTyI5ktmPJAlxDA CSMV2ARIx88dcsfhsnBOSBrY5Yf/kaUQ7DUBxTm1NbZNhtpjfuP7FtCGmVfo60rk9FUCY3OOeciGMX O2uN18vhhQ+CykrZDjY2o/xu6AqLALmhI25ijYc/hxa+TDOUjlaYoNZu8ynLZS5NnB5xMEjuc0BjNx Tw9Eu+G7cQo80IJarNeaqq3WICDpjRr77VRpEpe08x5mlmy/Hx+O/4io2DhneEZdPvqRhhCqXo54s9 kfjmcRUpu+fTTYUdOneL8kQl3LLbuY/wAaxy9oz9AOp4C5LSwOPYsT+bpFyRSiK5wBY16GPL5O9vxT RYgouhItrUx4ttd44KpEmvnb591US9fxbOWC7ljX960Iw5sr7dUPQUacqmPJAKdUAo0aoZ+OVJP4C9 dZ0/Dc3DLq95hFpB/wr1JN/ncpXqyaKAjcPePEukkJDbtgnssaAiqHHfPjCrdbkK08yEi3Cu951v1K mtFhB8ysyHJB+5UjM+xRMde8M+gLlxpbSjZfwYcUHaIcU=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v5.17

for you to fetch changes up to 42f4046bc4ba56c6e4d2af7a9d7f70eaa563daec:

  efi: use default_groups in kobj_type (2022-01-06 21:19:05 +0100)

----------------------------------------------------------------
EFI updates for v5.17

- support taking the measurement of the initrd when loaded via the
  LoadFile2 protocol
- kobject API cleanup from Greg
- some header file whitespace fixes

----------------------------------------------------------------
Ard Biesheuvel (3):
      efi/libstub: add prototype of efi_tcg2_protocol::hash_log_extend_event()
      efi/libstub: x86/mixed: increase supported argument count
      efi/libstub: consolidate initrd handling across architectures

Elyes HAOUAS (1):
      include/linux/efi.h: Remove unneeded whitespaces before tabs

Greg Kroah-Hartman (1):
      efi: use default_groups in kobj_type

Ilias Apalodimas (1):
      efi/libstub: measure loaded initrd info into the TPM

 arch/x86/boot/compressed/efi_thunk_64.S        | 14 +++--
 arch/x86/include/asm/efi.h                     | 14 +++--
 arch/x86/platform/efi/efi_thunk_64.S           | 14 ++++-
 drivers/firmware/efi/efivars.c                 |  3 +-
 drivers/firmware/efi/esrt.c                    |  4 +-
 drivers/firmware/efi/libstub/efi-stub-helper.c | 73 +++++++++++++++++++++-----
 drivers/firmware/efi/libstub/efi-stub.c        | 10 +---
 drivers/firmware/efi/libstub/efistub.h         | 30 ++++++++++-
 drivers/firmware/efi/libstub/x86-stub.c        | 26 ++++-----
 drivers/firmware/efi/runtime-map.c             |  3 +-
 include/linux/efi.h                            |  6 +--
 11 files changed, 144 insertions(+), 53 deletions(-)
