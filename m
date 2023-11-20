Return-Path: <linux-efi+bounces-59-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBDC7F12D9
	for <lists+linux-efi@lfdr.de>; Mon, 20 Nov 2023 13:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 562942825DE
	for <lists+linux-efi@lfdr.de>; Mon, 20 Nov 2023 12:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE5818E2E;
	Mon, 20 Nov 2023 12:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TxcBEPd0"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D32D4F;
	Mon, 20 Nov 2023 04:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700482194; x=1732018194;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=cyTTkzopgowEchiu4ldonlKqhiUOPUU0HwEqAMqzgPA=;
  b=TxcBEPd0DxpXlnh43pMaoR5x3+dZdIOMYwriSfy1AzeJdhdowHLFY9hd
   naFwxOK/A8PUIMSrO94LIW1f8tBmYZa8aVl4G87Zvz8IlTCtV0fDq59MP
   Y7No2tCprXEVnyuQAlAvZZY+mYLrgNrlNubn1ik+EozQMi/+9WEPuV1X3
   /0TCwap0bMLAEU5vVBEMM0sHTuaCIbwi+QfMycKNgQ6MX59oM94GmefPb
   LVTIXzCVQH/S6TrBGMIZMx1vGCKzNtbn2K2yyFgBItPjqKWcx6vH2P59z
   +Qo9mTb/44gLhlicRo2o1cpcXp5uEc7vQ0RSdEsncKeDR6b069egmu0fF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="394455812"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="394455812"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 04:09:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="769878708"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="769878708"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmsmga007.fm.intel.com with ESMTP; 20 Nov 2023 04:09:13 -0800
From: Raag Jadav <raag.jadav@intel.com>
To: mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	rafael@kernel.org,
	lenb@kernel.org,
	robert.moore@intel.com,
	ardb@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linuxfoundation.org,
	linux-efi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	mallikarjunappa.sangannavar@intel.com,
	bala.senthil@intel.com,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 6/6] perf: arm_cspmu: drop redundant acpi_dev_uid_to_integer()
Date: Mon, 20 Nov 2023 17:38:37 +0530
Message-Id: <20231120120837.3002-7-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231120120837.3002-1-raag.jadav@intel.com>
References: <20231120120837.3002-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

Now that we have _UID matching support for integer types, we can use
acpi_dev_hid_uid_match() for it.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/perf/arm_cspmu/arm_cspmu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index 42b72042f6b3..9642e703ccd3 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -1105,7 +1105,6 @@ static int arm_cspmu_request_irq(struct arm_cspmu *cspmu)
 
 static inline int arm_cspmu_find_cpu_container(int cpu, u32 container_uid)
 {
-	u64 acpi_uid;
 	struct device *cpu_dev;
 	struct acpi_device *acpi_dev;
 
@@ -1115,8 +1114,7 @@ static inline int arm_cspmu_find_cpu_container(int cpu, u32 container_uid)
 
 	acpi_dev = ACPI_COMPANION(cpu_dev);
 	while (acpi_dev) {
-		if (acpi_dev_hid_uid_match(acpi_dev, ACPI_PROCESSOR_CONTAINER_HID, NULL) &&
-		    !acpi_dev_uid_to_integer(acpi_dev, &acpi_uid) && acpi_uid == container_uid)
+		if (acpi_dev_hid_uid_match(acpi_dev, ACPI_PROCESSOR_CONTAINER_HID, container_uid))
 			return 0;
 
 		acpi_dev = acpi_dev_parent(acpi_dev);
-- 
2.17.1


