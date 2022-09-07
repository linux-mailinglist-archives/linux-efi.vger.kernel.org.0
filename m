Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AE05B0A8B
	for <lists+linux-efi@lfdr.de>; Wed,  7 Sep 2022 18:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiIGQqs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Sep 2022 12:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiIGQqp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Sep 2022 12:46:45 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7F3BBA4E;
        Wed,  7 Sep 2022 09:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662569201; x=1694105201;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=y3/sBmBbm24o7Nrci6vLh859k+watYKfpLLsWrkIDIU=;
  b=dARaclhQfqIBDY+1WQTgrf+aZqSg+kjASEGh4y746lx0jZ2/9LlLJTmt
   auuGuWsdQV9B9XGdTQVCYgjG/6MeXJ7/D2GppNSgQVv9kOSyOG7Ssqh+7
   SvGsZG3YminloUG7zZFsuVIE2x47X/W487rKxxUATp8BOnGAXE8uVCDnx
   pX+fItIc1cbtnLqrDDejnC4pewbRCBS8pwmXpprMETOM+8IhYYDVwSIdL
   VOmy4dnA3BIsqcZ3Qbp5WcFmEdCOsFo640MfrMisUOUB36JbFEm8sRv8d
   XmYlhW1DrS/MsyBkk4HipfPJLMiRqFvv1tV3gDGEICYC429lYVsHeDeEI
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="276670919"
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="276670919"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 09:46:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="859707324"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 07 Sep 2022 09:45:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C268FF7; Wed,  7 Sep 2022 19:46:11 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devel@acpica.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Elie Morisse <syniurge@gmail.com>,
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
        Mark Brown <broonie@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Wolfram Sang <wsa@kernel.org>
Subject: [PATCH v1 0/8] ACPI: unify _UID handling as integer
Date:   Wed,  7 Sep 2022 19:45:58 +0300
Message-Id: <20220907164606.65742-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This series is about unification on how we handle ACPI _UID when
it's known to be an integer-in-the-string.

The idea of merging either all via ACPI tree, or (which I prefer)
taking ACPI stuff for v6.1 while the rest may be picked up later
on by respective maintainers separately.

Partially compile-tested (x86-64).

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

 drivers/acpi/acpi_lpss.c               | 15 ++++++------
 drivers/acpi/utils.c                   | 24 ++++++++++++++++++
 drivers/acpi/x86/utils.c               | 14 ++++++++---
 drivers/firmware/efi/dev-path-parser.c | 10 +++++---
 drivers/i2c/busses/i2c-amd-mp2-plat.c  | 27 +++++++-------------
 drivers/i2c/busses/i2c-mlxbf.c         | 19 +++++---------
 drivers/perf/qcom_l2_pmu.c             |  7 +++---
 drivers/spi/spi-pxa2xx.c               | 34 +++++++-------------------
 include/acpi/acpi_bus.h                |  1 +
 include/linux/acpi.h                   |  5 ++++
 10 files changed, 81 insertions(+), 75 deletions(-)

-- 
2.35.1

