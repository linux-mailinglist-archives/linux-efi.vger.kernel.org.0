Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6845B1EFB
	for <lists+linux-efi@lfdr.de>; Thu,  8 Sep 2022 15:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbiIHN3b (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 8 Sep 2022 09:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbiIHN3H (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 8 Sep 2022 09:29:07 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A59129526;
        Thu,  8 Sep 2022 06:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662643744; x=1694179744;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cb/38D5XgcJUt79hNwgcMMzRjj8ed28v6JTWv2P9Fig=;
  b=ffm5Ke5mTn4foac7NX99JA/F6oZ1MVEWVQQ2eztpYs5my0LPLbocS4R4
   9sBHSVuvRTF1jVoZd3nf6TpVhjDEdJWbn+0KzNZRmMAQeT4utvRHLqKUI
   taJT3I6+UbIOj5oSnL0Wu+Y94t4Fi3rN+7r/1+YIPQQcxxf1HQh6qHISK
   5QOLm3K57SdApa7Jb45FFtc4XVsl2yl9AbpLenKhQejfSCuvGWzqivZn2
   O5/SYLFv3tt5Vh4ukwVUqoItSf7EE56ojdKsxxOVzqnKl44Is7n5aTduW
   yB2Lru7rKB9hTISFMBvRaUaiwCxzA+RVU6xzywuwFm+sNjBvJU+Kxz70u
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="361130140"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="361130140"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 06:29:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="740671478"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 08 Sep 2022 06:28:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A4E43235; Thu,  8 Sep 2022 16:29:12 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
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
        Robert Moore <robert.moore@intel.com>,
        Wolfram Sang <wsa@kernel.org>
Subject: [PATCH v2 0/8] ACPI: unify _UID handling as integer
Date:   Thu,  8 Sep 2022 16:29:02 +0300
Message-Id: <20220908132910.62122-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Mailer: git-send-email 2.35.1
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
maintainers separately (currently all depends on Wolfram, other
patches have got the tags from the maintainers).

Partially compile-tested (x86-64).

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

 drivers/acpi/acpi_lpss.c               | 15 ++++++-----
 drivers/acpi/utils.c                   | 24 ++++++++++++++++++
 drivers/acpi/x86/utils.c               | 14 ++++++++---
 drivers/firmware/efi/dev-path-parser.c | 10 +++++---
 drivers/i2c/busses/i2c-amd-mp2-plat.c  | 27 +++++++-------------
 drivers/i2c/busses/i2c-mlxbf.c         | 20 +++++----------
 drivers/perf/qcom_l2_pmu.c             |  8 +++---
 drivers/spi/spi-pxa2xx.c               | 35 +++++++-------------------
 include/acpi/acpi_bus.h                |  1 +
 include/linux/acpi.h                   |  5 ++++
 10 files changed, 81 insertions(+), 78 deletions(-)

-- 
2.35.1

