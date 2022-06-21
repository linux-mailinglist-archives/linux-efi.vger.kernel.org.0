Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA44555362E
	for <lists+linux-efi@lfdr.de>; Tue, 21 Jun 2022 17:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351868AbiFUPgh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 21 Jun 2022 11:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351806AbiFUPgf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 21 Jun 2022 11:36:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196D415A04;
        Tue, 21 Jun 2022 08:36:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 666E8B81A65;
        Tue, 21 Jun 2022 15:36:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C22C3411C;
        Tue, 21 Jun 2022 15:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655825791;
        bh=uD0eZMoByns/eKleOGZqOtUhpN1XGZHzZG92SeFcNHU=;
        h=From:To:Cc:Subject:Date:From;
        b=f5kHRLPaF91f9kmtnYKIp8M9cipRJbFKDz278Q0B4WKzewJ+oFuD+p589jXMyiM4a
         xtS8J4f5/EDSxHorxqGNYhR3+gZw3aZz8KaUtSpZaZoYXNGXhr668TOXdcF155PkJO
         9jadaAfaU5buWCCkjmuWJ1OGSjTqa4Tyz4qoikOP6wbIf5QAOchU+rrgaI+jvote4W
         nRHnuga6DxlvZpPr1OJdEMSwk23dCwnPf/beNCVvwkhm59hd6/qkh6rH3TYle9LIpv
         VHOZAvA/ZdPO3Dv8EOHIfwuhMNNoxNa3/aSux3kvL0KlOMYLUh2JGR0CMPAVK773Aq
         /DuTVJQ2qWYCA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v2 0/9] efi: Restructure EFI varstore driver
Date:   Tue, 21 Jun 2022 17:36:14 +0200
Message-Id: <20220621153623.3786960-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5182; h=from:subject; bh=uD0eZMoByns/eKleOGZqOtUhpN1XGZHzZG92SeFcNHU=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiseVmS93RMxuSv+p9kvjnBYHicMEUGcU74E7RDDkS HeS2QlaJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYrHlZgAKCRDDTyI5ktmPJIItC/ 4hW++c4DNpNu4z7YDpK4Ui4ztuLNLTOF4qhs+UqHGdDMgBsioTrdrjjHDeB0Oi/HY8r8GDyG8sN7x/ SHeSEHs2O02mpcfEpdTYkxY4/Ba3UyB91UTn3FPwuvM3NIXRIC0UzHkGzh7TGnjNf0ti1jIFF7BrGS RbPkcBzVdVBwGqZrQBbxJ9vbgi+abilhAlahK6vI4DnX1FJckBRt1uFD3URDTOpc4AVMhdKsCcQLtb g1VtdJA3E1iv0/DQtF/h/02ada5d1DDtu5HYMUmlf2EuW3e3m1583VoT35KLnDozXFJEn5GqzCmNss QTo0dxWc5Gi46B0UJ/Erdu+75p2esaKQDfwvIhXR9pn6Q4N+cFNr8yR5tRP3EZn2q80qyUPu8/60A5 LhgwhOXXpVhF24wnXWBbCYev3TELliByTxumpzUeC4NyF2Yz0IatDjFjHZnGXJI/P98/SXX5tOCUgv THtUAyvJMrHOxXFbWVxtpadVjw+ZhnKr2Z6wx/88xhNSY=
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

This is marked as a v2 given that it is a followup to a RFC patch I sent
last week [0]. Since nobody commented that removing the old sysfs
efivars interface is a bad idea, I went ahead and performed the cleanup
that this enables.

Some of the prerequisites of this work have been posted separately and
have been queued up in efi/next already, mainly to move other users away
from the efivar API which they were using in the wrong way, or without a
good reason. [1]

The current state of things is that efi-pstore, efivarfs and the efivars
sysfs interface all share a common support layer which manages a linked
list containing efivar_entry items describing each EFI variable that
this support layer assumes to be present in the EFI variable store
managed by the firmware.

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
semaphore to mediate access to the individual linked lists as well as
the ops pointer.

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

[0] https://lore.kernel.org/linux-efi/20220616124740.580708-1-ardb@kernel.org/T/#t
[1] https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/log/

Cc: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Peter Jones <pjones@redhat.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>

Ard Biesheuvel (9):
  pstore: Don't expose ECC metadata via pstore file system
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
 drivers/firmware/efi/Kconfig             |   12 -
 drivers/firmware/efi/Makefile            |    1 -
 drivers/firmware/efi/efi-pstore.c        |  389 ++-----
 drivers/firmware/efi/efi.c               |    1 +
 drivers/firmware/efi/efivars.c           |  671 -----------
 drivers/firmware/efi/vars.c              | 1219 +++-----------------
 fs/efivarfs/Makefile                     |    2 +-
 fs/efivarfs/internal.h                   |   40 +
 fs/efivarfs/super.c                      |   15 +-
 fs/efivarfs/vars.c                       |  742 ++++++++++++
 fs/pstore/inode.c                        |    2 +-
 include/linux/efi.h                      |   80 +-
 21 files changed, 1058 insertions(+), 2126 deletions(-)
 delete mode 100644 drivers/firmware/efi/efivars.c
 create mode 100644 fs/efivarfs/vars.c

-- 
2.35.1

