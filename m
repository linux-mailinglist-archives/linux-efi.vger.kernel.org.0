Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D5B586C25
	for <lists+linux-efi@lfdr.de>; Mon,  1 Aug 2022 15:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbiHANlc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 1 Aug 2022 09:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbiHANlc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 1 Aug 2022 09:41:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597A695BB
        for <linux-efi@vger.kernel.org>; Mon,  1 Aug 2022 06:41:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F273F612E3
        for <linux-efi@vger.kernel.org>; Mon,  1 Aug 2022 13:41:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63DCAC433D7;
        Mon,  1 Aug 2022 13:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659361290;
        bh=2aH7X7A1MFp1C9HVxeTZfn4lcgpxepTOSPqE8efY1/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eKRV/z0d05lKRyp9QdXV/mDJx4n9oNX+3tMALyhm5glvEEY1SMQfvSK32aEvpSMaB
         NkCBeHupFapVqHnQ73yhV5cEKzAqw1optED8Lf2f+N3LtaTezYZPA0ac/CE1prRXkR
         /awsYf5fRF5I5lM5fe2wTW1+wngxHTDGhCUcmkIB15NTuHS4Du7E+IUxQXOp5lh8GI
         IeLav+E85ETs7D5yPpydipreQSPzahifw1ZaDtD6fYCrHZf1XECFzuQLsdb2fQ7PHX
         s4DA24W0H4fevUPU11lBhCqrDdpF8Tvf5qBkyT306Zrde8FaDLT4n49KaNxSzKWs8u
         q82urldgyI/3g==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-efi@vger.kernel.org, keescook@chromium.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [GIT PULL 2/2] EFI removal of efivars sysfs driver
Date:   Mon,  1 Aug 2022 15:41:17 +0200
Message-Id: <20220801134117.1605678-3-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220801134117.1605678-1-ardb@kernel.org>
References: <20220801134117.1605678-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2482; i=ardb@kernel.org; h=from:subject; bh=2aH7X7A1MFp1C9HVxeTZfn4lcgpxepTOSPqE8efY1/A=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBi59f7aTcNM3+9s76PpQaLA68ISG4l4xeEzp8TWtr1 blHLO+aJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYufX+wAKCRDDTyI5ktmPJPzKC/ 9I+AOzKycwuQDfch7Cb8/IktLd1EpWbV1c0T44khRlM/L41cMU+zBXDYZhmwno/ElF/pfYU5H3ST+m qGtZlu4iw/ZL6rEKsc1z2ezZ5mPaKnKDhx7XMqGstlMAW4keIYChUNQkXUQMJ+k+NCFHf9p+5hBb82 BC7OFwDf0YQ3opE0So+07N1HV6PPUdoBApBO1H85lYI8mt7X+qgkupGEcspCS8R+8OBxoaCBWhlg+P k7w4Lnj5CEmLpE8l6+W0eLDktFIhB5BqqNq7c+dAhxdJSHUKJt+Oofa7WT6EC4Fp1EX98eXiPD7lkG hIG87A8OGLQFYTah6f/LnzQnP8oD8tngOhHot2HYUasg1ll+VU84cQyf61D/LwPakt/2S9HkJEc+Hj 4Fi4WgI/Ok7W9TN05BiYjKf2LSuMUWfyyUGVfdjhpZttNEx/8t3dk5q3OAfXCQYwoB4rhM07FeDbDp gHmQ1Zf6vovYEyUFvrSGndt5wu0y44A6j71M8Dl0gGctU=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following changes since commit 5ac941367a6f85777ef34ec15d60e17ea8e446d4:

  efi: vars: Drop __efivar_entry_iter() helper which is no longer used (2022-06-24 20:40:19 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-efivars-removal-for-v5.20

for you to fetch changes up to 2d82e6227ea189c0589e7383a36616ac2a2d248c:

  efi: vars: Move efivar caching layer into efivarfs (2022-06-24 20:40:19 +0200)

----------------------------------------------------------------
EFI efivars sysfs interface removal

Remove the obsolete 'efivars' sysfs based interface to the EFI variable
store, now that all users have moved to the efivarfs pseudo file system,
which was created ~10 years ago to address some fundamental shortcomings
in the sysfs based driver.

Move the 'business logic' related to which EFI variables are important
and may affect the boot flow from the efivars support layer into the
efivarfs pseudo file system, so it is no longer exposed to other parts
of the kernel.

----------------------------------------------------------------
Ard Biesheuvel (3):
      efi: vars: Remove deprecated 'efivars' sysfs interface
      efi: vars: Switch to new wrapper layer
      efi: vars: Move efivar caching layer into efivarfs

 Documentation/x86/x86_64/uefi.rst        |    2 +-
 arch/arm/configs/milbeaut_m10v_defconfig |    1 -
 arch/ia64/configs/bigsur_defconfig       |    1 -
 arch/ia64/configs/generic_defconfig      |    1 -
 arch/ia64/configs/gensparse_defconfig    |    1 -
 arch/ia64/configs/tiger_defconfig        |    1 -
 arch/ia64/configs/zx1_defconfig          |    1 -
 arch/x86/configs/i386_defconfig          |    1 -
 arch/x86/configs/x86_64_defconfig        |    1 -
 drivers/firmware/efi/Kconfig             |   12 -
 drivers/firmware/efi/Makefile            |    1 -
 drivers/firmware/efi/efi.c               |    1 +
 drivers/firmware/efi/efivars.c           |  660 -------------------
 drivers/firmware/efi/vars.c              | 1023 ------------------------------
 fs/efivarfs/Makefile                     |    2 +-
 fs/efivarfs/internal.h                   |   40 ++
 fs/efivarfs/vars.c                       |  738 +++++++++++++++++++++
 include/linux/efi.h                      |   56 --
 18 files changed, 781 insertions(+), 1762 deletions(-)
 delete mode 100644 drivers/firmware/efi/efivars.c
 create mode 100644 fs/efivarfs/vars.c
