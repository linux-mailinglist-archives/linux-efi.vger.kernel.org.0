Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3263847FC94
	for <lists+linux-efi@lfdr.de>; Mon, 27 Dec 2021 13:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbhL0MXv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 27 Dec 2021 07:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233723AbhL0MXv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 27 Dec 2021 07:23:51 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D318AC06173E
        for <linux-efi@vger.kernel.org>; Mon, 27 Dec 2021 04:23:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 991EFCE0FAF
        for <linux-efi@vger.kernel.org>; Mon, 27 Dec 2021 12:23:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31EF8C36AE7;
        Mon, 27 Dec 2021 12:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640607827;
        bh=3w0+5c6U+uPoGlH1LOGjqePC6JxuW9B79lkhNLC9dpw=;
        h=From:To:Cc:Subject:Date:From;
        b=jWBxM4LyCUv9JoJNzAAx2klChyQSzZeAHFm+czu8QCwCV5qiak6cw1cSCBkjVfX8a
         ItloszKsN2dQvZODqEJv+0Esz9AaPFEGVA0iCUo5Wf0ngrkSXO5jhBx+ZboiZJ5z8f
         1jiQmFniJEyN/HMHTnzr2MMijfk46/Bi/yuv4k1xeutVQRqybHAJg5Q8IqEC4Yx5ze
         aFRxl2/Na82Y37vPUhKjdLpSmzq7cMbIn/4rhN5bK4MHVCJl71xzlk4Y8KdBK6fMJo
         qbqtCnJAn/9Fg+HGmNA857KpD6Q5dzdQivPIh25Fbm4YLy10Fl9MlJES9roHqdg7TX
         lP08++RYZFhZA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [GIT PULL] EFI fix for 5.16 (#2)
Date:   Mon, 27 Dec 2021 13:23:33 +0100
Message-Id: <20211227122333.2425727-1-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1067; h=from:subject; bh=3w0+5c6U+uPoGlH1LOGjqePC6JxuW9B79lkhNLC9dpw=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBhybBEAItdhiWiPCvQ3Uu2IY8wvvHmOkn9yezrIsf1 BGSlVTKJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYcmwRAAKCRDDTyI5ktmPJO2qDA Ctr1D7u/EboRQEnfwbbaHM2CRWh8gVgg3JRGlafNFn7fT9YICBb/BKT4ZLLlBdTbyIUJKvYXvMecpu cHkH7mbeOy6vX8q/nTYfcEmJNs2t/TbahmEyqxdkYlldxscEqXQbjUkz3NnhX6iiK75M1Hm/IFyZZe MKM5IJ9OjR70SLtrtONP5bNrrHLivZtBo9Tmoemr8FFpwgocpeRxP5iW60hztpcxKQWcZSn4pKRow3 J79aUPYToVAkQp/VzfKIRRJDsvYJYYMzSQ9STZN+z9/4EP0T/+BsrgnaitKLcGERVaroafB3AJjB5v J/Zf1K01Y4+htKnMpe67qY49UzCRcJtyecuaH5Hv3E+2tLvzPWJkasOF2CX6Q2jdsuihKDgSSCSV8B 8/dLRUMcR6neye+AsaYVp5qd4G6g9XnxXUewTnj5efpMuMgceCgFN73ByobI+zMbcktxQ5gPlyt0sf fYweFJAPihLB8sk2otFObPvKsgz3kMlo9aYl1YBnz66p0=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following changes since commit 1ff2fc02862d52e18fd3daabcfe840ec27e920a8:

  x86/sme: Explicitly map new EFI memmap table as encrypted (2021-12-05 16:44:52 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v5.16-2

for you to fetch changes up to 4bc5e64e6cf37007e436970024e5998ee0935651:

  efi: Move efifb_setup_from_dmi() prototype from arch headers (2021-12-13 15:07:16 +0100)

----------------------------------------------------------------
Another EFI fix for v5.16

- Prevent missing prototype warning from breaking the build under
  CONFIG_WERROR=y

----------------------------------------------------------------
Javier Martinez Canillas (1):
      efi: Move efifb_setup_from_dmi() prototype from arch headers

 arch/arm/include/asm/efi.h   | 1 -
 arch/arm64/include/asm/efi.h | 1 -
 arch/riscv/include/asm/efi.h | 1 -
 arch/x86/include/asm/efi.h   | 2 --
 include/linux/efi.h          | 6 ++++++
 5 files changed, 6 insertions(+), 5 deletions(-)
