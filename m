Return-Path: <linux-efi+bounces-53-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6508A7F12CF
	for <lists+linux-efi@lfdr.de>; Mon, 20 Nov 2023 13:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06019B21A3E
	for <lists+linux-efi@lfdr.de>; Mon, 20 Nov 2023 12:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF93318E2A;
	Mon, 20 Nov 2023 12:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dNgj9I6t"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4254BA7;
	Mon, 20 Nov 2023 04:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700482143; x=1732018143;
  h=from:to:cc:subject:date:message-id;
  bh=TRYNfwwPipXMDJ9kTAnqqTy+1cQytF2OInesEWup8i4=;
  b=dNgj9I6t7kP3YZS+r9bgyLvTqH9dRH7BwPDPdhIhMf4THCDcziEBdQQE
   nnXpesuZ7AuwQMA8XrIUT/AdyTobeF06W09MNvJikmUubs+snYUusHLw6
   mT5RXz0NBplRe/QKP5ZwdLOgBcr+YW/t+2nX/M+kcNbx4Ekz09rCAejX1
   vhDZBf0u8FHSoMv45lAqnEoNn+U7k4BqW8CBPtsDDfM2ArC7gJUnCGzk/
   00G5agSPMQzCKWS9Wj1JawLBCPYE1SnIq3ibCMuYSWCAc9fsF/GP/T5kL
   7FJo9YuWwfIAmZ7MFN0uI3ALzjlb7KpFJsTcYTaENS0EbasLK1kFaQbyT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="394455638"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="394455638"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 04:08:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="769878561"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="769878561"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmsmga007.fm.intel.com with ESMTP; 20 Nov 2023 04:08:46 -0800
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
Subject: [PATCH v1 0/6] Support integer types for _UID matching
Date: Mon, 20 Nov 2023 17:38:31 +0530
Message-Id: <20231120120837.3002-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

This series updates the standard ACPI helpers to support _UID matching
for both integer and string types, and uses them in a couple of places.

Raag Jadav (6):
  compiler.h: Introduce helpers for identifying array and pointer types
  ACPI: bus: update acpi_dev_uid_match() to support multiple types
  ACPI: bus: update acpi_dev_hid_uid_match() to support multiple types
  ACPI: LPSS: use acpi_dev_uid_match() for matching _UID
  efi: dev-path-parser: use acpi_dev_uid_match() for matching _UID
  perf: arm_cspmu: drop redundant acpi_dev_uid_to_integer()

 drivers/acpi/acpi_lpss.c               |  8 +---
 drivers/acpi/utils.c                   | 48 ---------------------
 drivers/firmware/efi/dev-path-parser.c |  7 +---
 drivers/perf/arm_cspmu/arm_cspmu.c     |  4 +-
 include/acpi/acpi_bus.h                | 58 +++++++++++++++++++++++++-
 include/linux/acpi.h                   | 15 ++-----
 include/linux/compiler.h               |  5 +++
 7 files changed, 70 insertions(+), 75 deletions(-)


base-commit: 5bd262f4820f2d5645d8ff1f251ef8e96715ef84
-- 
2.17.1


