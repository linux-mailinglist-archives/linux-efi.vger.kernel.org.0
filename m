Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE15A600FAC
	for <lists+linux-efi@lfdr.de>; Mon, 17 Oct 2022 15:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiJQNCC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Oct 2022 09:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiJQNCB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 17 Oct 2022 09:02:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C70921A1;
        Mon, 17 Oct 2022 06:01:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18C8D113E;
        Mon, 17 Oct 2022 06:02:04 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.212.212])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2B5633F67D;
        Mon, 17 Oct 2022 06:01:50 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Jan Luebbe <jlu@pengutronix.de>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Kani Toshi <toshi.kani@hpe.com>
Cc:     James Morse <james.morse@arm.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        devel@acpica.org, "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-efi@vger.kernel.org,
        nd@arm.com, Peter Zijlstra <peterz@infradead.org>,
        Jia He <justin.he@arm.com>
Subject: [PATCH v9 0/7] Make ghes_edac a proper module
Date:   Mon, 17 Oct 2022 13:01:33 +0000
Message-Id: <20221017130140.420986-1-justin.he@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Commit dc4e8c07e9e2 ("ACPI: APEI: explicit init of HEST and GHES in
apci_init()") introduced a bug that ghes_edac_register() would be invoked
before edac_init(). Because at that time, the bus "edac" hasn't been even
registered, this created sysfs /devices/mc0 instead of
/sys/devices/system/edac/mc/mc0 on an Ampere eMag server.

The solution is to make ghes_edac a proper module.

Changelog:
v9:
 - drop the unrcu_pointer patch 06 of v8
 - add Ard's xchg_release patch to use a better memory barrier
v8:https://lore.kernel.org/lkml/20221010023559.69655-1-justin.he@arm.com/
 - merge v7 two force_enable and ghes_get_devices() patches into one
 - make force_enable static
v7:https://lore.kernel.org/lkml/20220929023726.73727-1-justin.he@arm.com/
 - remove the ghes_edac_preferred and ghes_present (suggested by Borislav)
 - adjust the patch splitting, no major functional changes
 - remove the r-b tag in those changed patches
v6:https://www.spinics.net/lists/kernel/msg4511453.html
 - no code changes from v5 patches
 - add the reviewed and acked by from Toshi
 - describe the removal of ghes_edac_force_enable checking in Patch 05
v5: https://www.spinics.net/lists/kernel/msg4502787.html
 - add the review-by from Toshi for patch 04 and 06
 - refine the commit msg
 - remove the unconditional set of ghes_edac_force_enable on Arm
v4: https://lore.kernel.org/lkml/20220831074027.13849-6-justin.he@arm.com/
 - move the kernel boot option to ghes module parameter
 - collapse th ghes_present and ghes_edac_preferred into one patch
v3: https://lore.kernel.org/lkml/20220822154048.188253-1-justin.he@arm.com/
 - refine the commit logs
 - introduce ghes preferred and present flag (by Toshi)
 - move force_load to setup parameter
 - add the ghes_edac_preferred() check for x86/Arm edac drivers
v2: https://lore.kernel.org/lkml/20220817143458.335938-1-justin.he@arm.com/
 - add acked-by tag of Patch 1 from Ard
 - split the notifier patch
 - add 2 patch to get regular drivers selected when ghes edac is not loaded
 - fix an errno in igen6 driver
 - add a patch to fix the sparse warning of ghes
 - refine the commit logs
v1: https://lore.kernel.org/lkml/20220811091713.10427-1-justin.he@arm.com/

Ard Biesheuvel (1):
  apei/ghes: Use xchg_release() for updating new cache slot instead of
    cmpxchg()

Jia He (6):
  efi/cper: export several helpers for ghes_edac to use
  EDAC/ghes: Add a notifier for reporting memory errors
  EDAC/ghes: Prepare to make ghes_edac a proper module
  EDAC/ghes: Make ghes_edac a proper module to remove the dependency on
    ghes
  EDAC: Add the ghes_get_devices() check for chipset-specific edac
    drivers
  EDAC/igen6: Return consistent errno when another edac driver is
    enabled

 drivers/acpi/apei/ghes.c       | 109 +++++++++++++++++++++++++--------
 drivers/edac/Kconfig           |   4 +-
 drivers/edac/amd64_edac.c      |   3 +
 drivers/edac/armada_xp_edac.c  |   3 +
 drivers/edac/edac_module.h     |   1 +
 drivers/edac/ghes_edac.c       |  90 ++++++++++++++++-----------
 drivers/edac/i10nm_base.c      |   3 +
 drivers/edac/igen6_edac.c      |   5 +-
 drivers/edac/layerscape_edac.c |   3 +
 drivers/edac/pnd2_edac.c       |   3 +
 drivers/edac/sb_edac.c         |   3 +
 drivers/edac/skx_base.c        |   3 +
 drivers/edac/thunderx_edac.c   |   3 +
 drivers/edac/xgene_edac.c      |   3 +
 drivers/firmware/efi/cper.c    |   3 +
 include/acpi/ghes.h            |  34 +++-------
 16 files changed, 185 insertions(+), 88 deletions(-)

-- 
2.25.1

