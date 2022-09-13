Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4B35B7865
	for <lists+linux-efi@lfdr.de>; Tue, 13 Sep 2022 19:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbiIMRkg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 13 Sep 2022 13:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233224AbiIMRjr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 13 Sep 2022 13:39:47 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3FC7D1E3;
        Tue, 13 Sep 2022 09:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663086759; x=1694622759;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=T6hLpT6GDZln8QErQ0cD0GdLt6XnCw+4fkOxlmQr2N8=;
  b=UOCWMeVhFbsSp/0z9WaW9DSRPjqx1yD5OvyOpC5g4N938Cigt+aqAHcj
   TwtP6ntRp0pC49rky5cvvcSD58iOWQwPn/3dXYk8Hf7UoaULNGXOD90/Y
   sBaSSOMZtGj8L3X+D1MlzaMLNQSWAQpwffIvFHoPHkQ6vW8PzRvo3zkcs
   LQjV8R4bAYKXz4cYKk0bheSskV7Byoj7Iuh+V3LXWb73l+fyylByfiofr
   BFsJxHVLhe9KfrZEfX1qBDSQXCsTnSNjL1tJHXJmk/pXgoK3VJ7jpPdZP
   yIdvZKzKSKAN4jcj7/owJ4t+7R2wkeYlJ6Hr53L7Fy1ZtC5J9OVRrNjx2
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="359909478"
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="359909478"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 09:31:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="684928193"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 13 Sep 2022 09:31:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2F0EF7C; Tue, 13 Sep 2022 19:31:48 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Mark Brown <broonie@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devel@acpica.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Elie Morisse <syniurge@gmail.com>,
        Nehal Shah <nehal-bakulchandra.shah@amd.com>,
        Shyam Sundar S K <shyam-sundar.s-k@amd.com>,
        Khalil Blaiech <kblaiech@nvidia.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Robert Moore <robert.moore@intel.com>
Subject: [PATCH v3 0/8] ACPI: unify _UID handling as integer
Date:   Tue, 13 Sep 2022 19:31:39 +0300
Message-Id: <20220913163147.24258-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This series is about unification on how we handle ACPI _UID when
it's known to be an integer-in-the-string.

The idea of merging either all via ACPI tree, or taking ACPI stuff
for the v6.1 while the rest may be picked up later on by respective
maintainers separately (currently only perf patch is not tagged).

Partially compile-tested (x86-64).

Changelog v3:
- fixed dev_dbg() specifier to be in align with the variable type (LKP)
- made use of temporary dev variable beyond the ACPI scope (LKP)
- added tags to I²C patches (Wolfram)

Changelog v2:
- rebased pxa2xx patch to be applied against current Linux kernel code
- fixed uninitialized variable adev in use (mlxbf)
- dropped unneeded temporary variable adev (qcom_l2_pmu)
- changed type for ret in patch 8 (Hans)
- swapped conditions to check ret == 0 first (Ard)
- added tags (Mark, Ard, Hans)

Andy Shevchenko (8):
  ACPI: utils: Add acpi_dev_uid_to_integer() helper to get _UID as
    integer
  ACPI: LPSS: Refactor _UID handling to use acpi_dev_uid_to_integer()
  ACPI: x86: Refactor _UID handling to use acpi_dev_uid_to_integer()
  i2c: amd-mp2-plat: Refactor _UID handling to use
    acpi_dev_uid_to_integer()
  i2c: mlxbf: Refactor _UID handling to use acpi_dev_uid_to_integer()
  perf: qcom_l2_pmu: Refactor _UID handling to use
    acpi_dev_uid_to_integer()
  spi: pxa2xx: Refactor _UID handling to use acpi_dev_uid_to_integer()
  efi/dev-path-parser: Refactor _UID handling to use
    acpi_dev_uid_to_integer()

 drivers/acpi/acpi_lpss.c               | 15 +++++------
 drivers/acpi/utils.c                   | 24 +++++++++++++++++
 drivers/acpi/x86/utils.c               | 14 +++++++---
 drivers/firmware/efi/dev-path-parser.c | 10 ++++---
 drivers/i2c/busses/i2c-amd-mp2-plat.c  | 27 +++++++------------
 drivers/i2c/busses/i2c-mlxbf.c         | 20 +++++---------
 drivers/perf/qcom_l2_pmu.c             | 10 +++----
 drivers/spi/spi-pxa2xx.c               | 37 +++++++-------------------
 include/acpi/acpi_bus.h                |  1 +
 include/linux/acpi.h                   |  5 ++++
 10 files changed, 83 insertions(+), 80 deletions(-)

-- 
2.35.1

