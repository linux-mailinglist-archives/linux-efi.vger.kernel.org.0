Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FE3597155
	for <lists+linux-efi@lfdr.de>; Wed, 17 Aug 2022 16:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236892AbiHQOfW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 Aug 2022 10:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234267AbiHQOfV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 17 Aug 2022 10:35:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CBB64205D1;
        Wed, 17 Aug 2022 07:35:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66929152B;
        Wed, 17 Aug 2022 07:35:20 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.212.212])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9A5EA3F70D;
        Wed, 17 Aug 2022 07:35:13 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, devel@acpica.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-efi@vger.kernel.org,
        toshi.kani@hpe.com, nd@arm.com, Jia He <justin.he@arm.com>
Subject: [PATCH v2 0/7] Modularize ghes_edac driver
Date:   Wed, 17 Aug 2022 14:34:51 +0000
Message-Id: <20220817143458.335938-1-justin.he@arm.com>
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

The solution is modularizing the ghes_edac driver.

Changelog:
v2:
 - add acked-by tag of Patch 1 from Ard
 - split the notifier patch
 - add 2 patch to get regular drivers selected when ghes edac is not loaded
 - fix an errno in igen6 driver
 - add a patch to fix the sparse warning of ghes
 - refine the commit logs

Jia He (7):
  efi/cper: export several helpers for ghes edac to use
  EDAC/ghes: Add notifier to report ghes_edac mem error
  EDAC/ghes: Modularize ghes_edac driver to remove the dependency on
    ghes
  EDAC: Get chipset-specific edac drivers selected only when ghes_edac
    is not enabled
  EDAC/ghes: Prevent chipset-specific edac from loading after ghes_edac
    is registered
  apei/ghes: Use unrcu_pointer for cmpxchg
  EDAC/igen6: Keep returned errno consistent when edac mc has been
    enabled

 drivers/acpi/apei/ghes.c    | 72 ++++++++++++++++++++++++++++++++---
 drivers/edac/Kconfig        |  4 +-
 drivers/edac/amd64_edac.c   |  3 ++
 drivers/edac/ghes_edac.c    | 76 ++++++++++++++++++++++++++-----------
 drivers/edac/igen6_edac.c   |  2 +-
 drivers/edac/pnd2_edac.c    |  3 ++
 drivers/edac/sb_edac.c      |  3 ++
 drivers/edac/skx_base.c     |  3 ++
 drivers/firmware/efi/cper.c |  3 ++
 include/acpi/ghes.h         | 37 ++++++------------
 10 files changed, 150 insertions(+), 56 deletions(-)

-- 
2.25.1

