Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7CB59C307
	for <lists+linux-efi@lfdr.de>; Mon, 22 Aug 2022 17:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236701AbiHVPlS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 22 Aug 2022 11:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236696AbiHVPlL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 22 Aug 2022 11:41:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1D061CFC0;
        Mon, 22 Aug 2022 08:41:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A077BED1;
        Mon, 22 Aug 2022 08:41:11 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.212.212])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DEF6B3F70D;
        Mon, 22 Aug 2022 08:40:59 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jan Luebbe <jlu@pengutronix.de>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Kani Toshi <toshi.kani@hpe.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        devel@acpica.org, "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-efi@vger.kernel.org,
        nd@arm.com, "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Muchun Song <songmuchun@bytedance.com>,
        linux-doc@vger.kernel.org, Jia He <justin.he@arm.com>
Subject: [RESEND PATCH v3 0/9] Make ghes_edac a proper module
Date:   Mon, 22 Aug 2022 15:40:39 +0000
Message-Id: <20220822154048.188253-1-justin.he@arm.com>
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

Changelog:
v3:
 - refine the commit logs
 - introduce ghes preferred and present flag (by Toshi)
 - move force_load to setup parameter
 - add the ghes_edac_preferred() check for x86/Arm edac drivers (incompleted list)
 
v2:
 - add acked-by tag of Patch 1 from Ard
 - split the notifier patch
 - add 2 patch to get regular drivers selected when ghes edac is not loaded
 - fix an errno in igen6 driver
 - add a patch to fix the sparse warning of ghes
 - refine the commit logs

Jia He (9):
  efi/cper: export several helpers for ghes_edac to use
  EDAC/ghes: Add a notifier for reporting memory errors
  EDAC/ghes: Make ghes_edac a proper module to remove the dependency on
    ghes
  EDAC/ghes: Move ghes_edac.force_load to setup parameter
  EDAC: Don't load chipset-specific edac drivers when ghes_edac is
    preferred
  ghes: Introduce a flag ghes_present
  apei/ghes: Use unrcu_pointer for cmpxchg
  EDAC/igen6: Keep returned errno consistent when edac mc has been
    enabled
  edac: Don't load Arm specific edac drivers when ghes_edac is preferred

 .../admin-guide/kernel-parameters.txt         |   5 +
 drivers/acpi/apei/ghes.c                      |  94 ++++++++++++++--
 drivers/edac/Kconfig                          |   4 +-
 drivers/edac/amd64_edac.c                     |   3 +
 drivers/edac/armada_xp_edac.c                 |   3 +
 drivers/edac/edac_module.h                    |   1 +
 drivers/edac/ghes_edac.c                      | 102 +++++++++++-------
 drivers/edac/i10nm_base.c                     |   3 +
 drivers/edac/igen6_edac.c                     |   5 +-
 drivers/edac/layerscape_edac.c                |   3 +
 drivers/edac/pnd2_edac.c                      |   3 +
 drivers/edac/sb_edac.c                        |   3 +
 drivers/edac/skx_base.c                       |   3 +
 drivers/edac/thunderx_edac.c                  |   3 +
 drivers/edac/xgene_edac.c                     |   3 +
 drivers/firmware/efi/cper.c                   |   3 +
 include/acpi/ghes.h                           |  38 +++----
 17 files changed, 204 insertions(+), 75 deletions(-)

-- 
2.25.1

