Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0995595BC
	for <lists+linux-efi@lfdr.de>; Fri, 24 Jun 2022 10:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiFXItn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Jun 2022 04:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiFXItm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 24 Jun 2022 04:49:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5C863631;
        Fri, 24 Jun 2022 01:49:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F19E2B8274C;
        Fri, 24 Jun 2022 08:49:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CEFEC341C8;
        Fri, 24 Jun 2022 08:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656060578;
        bh=hcpK43yfcPU8Fo/wkspzSo2yBD21jEkf+MEbeXQrAJ8=;
        h=From:To:Cc:Subject:Date:From;
        b=ESpVJkgrlIGqVLbgYk3MBLlkpRpCbxm6LNMRjYdyg/GhxgQLYN/A/5hPd8zX8Xdsk
         lVEdp5iVM0dt64wOivVKK+cAJa6o6v+jflJhtEHw94IuDD4yhvucMHY413cKpOimWD
         pQRvfDnFVN6oJOssMrfrwscjwipDvNfqA41+8xH1rvVHq1K/TrA0XhxRPaZ5CGRyW5
         pvGs5JHWfYpjtGeYDtPFp0Dk6r0puDO1ov962eHMdOBNmeeNoX7IJ9UmkvFfHxvhk/
         nrWkCWCjySqEJc8NGCzJsappQ3sZrv9qyEb9SljWGS9R90vv/hWorRDcTNv+eU4LNM
         YPTKI2yJymDTA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>, Jeremy Kerr <jk@ozlabs.org>,
        Tony Luck <tony.luck@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v3 0/9] efi: Restructure EFI varstore driver
Date:   Fri, 24 Jun 2022 10:49:16 +0200
Message-Id: <20220624084925.724516-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5230; h=from:subject; bh=hcpK43yfcPU8Fo/wkspzSo2yBD21jEkf+MEbeXQrAJ8=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBitXqFWZihnXMsXp/Wke3D8PpPy2OqTkiG5crgdZnk uSkP6vaJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYrV6hQAKCRDDTyI5ktmPJGhLC/ 9aJ2qC1JdusDprO/90LQCIdD6gvMqE7uWMrjZoaiJvNaeFXIJIdV5PpJg0yShLGQzgaYZcgmo5q/ye sV4FOQU4Qk8xqa4MV6+1iVoX9qSHhe4eehqOO3z3y99g8ktJdrRVUxX46vXYa85zPpKtFVy8bF7Del 2zu06vKsz6oO87ziZbflLrruXDKPMCsQzigTSGrqbFIfc6gR6xrNIKjPeI44l4wScoSCcgOfAWwW03 XkO6xFVKUawjxW8xaaa/Lv+eC23sTiyIBHLrIppKGu+KDPZmpnR3OKHXtYJWcsupmAU+YIxVJ90MPH okGpNfFtnm/CpGPLoXzN0EN62hs+p/cbSW9IzrAuF/vIAvjTv2+uWfVa3/JQ/RmR3SfNZ36StxMbXR hSMbn+KOyEeXFgId1tdKsghnZdb+RQGMveDn1auzjZRhTei9BRUBD3x/shxr1C6P0cM1RkTFP36L+X 3jaQzZKQcuWB9xoNBHnet4BfXDvu0KwISuAAc/PB/BoYo=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Currently, efi-pstore, efivarfs and the efivars sysfs interface all
share a common support layer which manages a linked list containing
efivar_entry items describing each EFI variable that this support layer
assumes to be present in the EFI variable store managed by the firmware.

This shared layer also contains an efivars_operations pointer, which
carries function pointers that refer to the underlying EFI get/set
variable routines, but can be superseded by other implementations
(currently, this is only implemented for Google x86 systems that
implement the GSMI interface)

Each user of this shared layer has its own linked list, which means they
all have a different view of the underlying variable store, even though
they might operate on the same variables. For EFI pstore related
variables in particular, manipulating these behind the back of the other
drivers is likely to result in fun.

This shared layer as well as its 3 different users all use a single
semaphore to mediate access to the individual linked lists and the ops
pointer.

The shared layer carries a substantial amount of 'business logic'
related to which EFI variables are relevant to the firmware, to limit
whether and how they may be manipulated. This aspect of the code is
only relevant when such variables can be manipulated arbitrarily, e.g.
by user space, but EFI pstore, for example, has no need for this, as it
uses its own GUIDed namespace for EFI variables, and does not permit
other variables to be manipulated.

The two remaining users are efivars sysfs and efivarfs, both of which
provide a cached view of these 'important' variables. Given that the
former has been deprecated for a long time, and given the potential
concerns around using both concurrently, let's get rid of the sysfs
based one.

Then, we can restructure the efivars API so that this business logic
can be incorporated into the efivarfs driver, leaving only a minimal
wrapper around the get/set variable calls, allowing the GSMI replacement
to remain in use, as well as mediate access to the different services
using the existing semaphore. This is mainly useful to ensure that
set_variable() calls do no invalidate an enumeration of the EFI
variables that is in progress using get_next_variable() by another task.

Some of the prerequisites of this work have been posted separately and
have been queued up in efi/next already, mainly to move other users away
from the efivar API which they were using in the wrong way, or without a
good reason.

Changes since v2:
- add a pstore_record::priv field and use it to record the EFI variable
  name exactly as it was used to retrieve the entry;
- drop another pstore patch related to the ECC field that is no longer
  needed;
- drop some remaining EXPORT_SYMBOL()s of the efivar API symbols that
  are now private to efivarfs

Cc: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Peter Jones <pjones@redhat.com>
Cc: Jeremy Kerr <jk@ozlabs.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>

Ard Biesheuvel (9):
  pstore: Add priv field to pstore_record for backend specific use
  efi: vars: Don't drop lock in the middle of efivar_init()
  efi: vars: Add thin wrapper around EFI get/set variable interface
  efi: pstore: Omit efivars caching EFI varstore access layer
  efi: vars: Use locking version to iterate over efivars linked lists
  efi: vars: Drop __efivar_entry_iter() helper which is no longer used
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
 drivers/firmware/efi/Kconfig             |   13 +-
 drivers/firmware/efi/Makefile            |    1 -
 drivers/firmware/efi/efi-pstore.c        |  377 ++----
 drivers/firmware/efi/efi.c               |    1 +
 drivers/firmware/efi/efivars.c           |  671 -----------
 drivers/firmware/efi/vars.c              | 1219 +++-----------------
 fs/efivarfs/Makefile                     |    2 +-
 fs/efivarfs/internal.h                   |   40 +
 fs/efivarfs/super.c                      |   15 +-
 fs/efivarfs/vars.c                       |  738 ++++++++++++
 fs/pstore/inode.c                        |    1 +
 fs/pstore/platform.c                     |    1 +
 include/linux/efi.h                      |   80 +-
 include/linux/pstore.h                   |    4 +
 23 files changed, 1031 insertions(+), 2142 deletions(-)
 delete mode 100644 drivers/firmware/efi/efivars.c
 create mode 100644 fs/efivarfs/vars.c

-- 
2.35.1

