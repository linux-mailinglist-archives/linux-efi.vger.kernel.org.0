Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480C35B5C5F
	for <lists+linux-efi@lfdr.de>; Mon, 12 Sep 2022 16:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiILOlM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 12 Sep 2022 10:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiILOlK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 12 Sep 2022 10:41:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54BEABE06;
        Mon, 12 Sep 2022 07:41:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60317113E;
        Mon, 12 Sep 2022 07:41:14 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.212.212])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 872083F73D;
        Mon, 12 Sep 2022 07:41:01 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
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
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        devel@acpica.org, "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-efi@vger.kernel.org,
        nd@arm.com, Jia He <justin.he@arm.com>
Subject: [PATCH v6 0/8] Make ghes_edac a proper module
Date:   Mon, 12 Sep 2022 14:39:57 +0000
Message-Id: <20220912144005.212624-1-justin.he@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

The proper solution is to make ghes_edac a proper module.

Changelog:
v6:
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

Jia He (8):
  efi/cper: export several helpers for ghes_edac to use
  EDAC/ghes: Add a notifier for reporting memory errors
  EDAC:ghes: Move ghes_edac.force_load to ghes module parameter
  ghes: Introduce a helper ghes_edac_preferred()
  EDAC/ghes: Make ghes_edac a proper module to remove the dependency on
    ghes
  EDAC: Add the ghes_edac_preferred check for chipset-specific edac
    drivers
  apei/ghes: Use unrcu_pointer for cmpxchg
  EDAC/igen6: Return consistent errno when another edac driver is
    enabled

 drivers/acpi/apei/ghes.c       | 82 +++++++++++++++++++++++++++++++---
 drivers/edac/Kconfig           |  4 +-
 drivers/edac/amd64_edac.c      |  3 ++
 drivers/edac/armada_xp_edac.c  |  3 ++
 drivers/edac/edac_module.h     |  1 +
 drivers/edac/ghes_edac.c       | 78 ++++++++++++++++++++------------
 drivers/edac/i10nm_base.c      |  3 ++
 drivers/edac/igen6_edac.c      |  5 ++-
 drivers/edac/layerscape_edac.c |  3 ++
 drivers/edac/pnd2_edac.c       |  3 ++
 drivers/edac/sb_edac.c         |  3 ++
 drivers/edac/skx_base.c        |  3 ++
 drivers/edac/thunderx_edac.c   |  3 ++
 drivers/edac/xgene_edac.c      |  3 ++
 drivers/firmware/efi/cper.c    |  3 ++
 include/acpi/apei.h            |  2 +
 include/acpi/ghes.h            | 36 +++++----------
 17 files changed, 175 insertions(+), 63 deletions(-)

-- 
2.25.1

