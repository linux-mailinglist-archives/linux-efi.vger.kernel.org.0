Return-Path: <linux-efi+bounces-87-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A347F5BE7
	for <lists+linux-efi@lfdr.de>; Thu, 23 Nov 2023 11:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C3551C20C6E
	for <lists+linux-efi@lfdr.de>; Thu, 23 Nov 2023 10:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE06B2233C;
	Thu, 23 Nov 2023 10:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DqPTqpN5"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEDB10F2;
	Thu, 23 Nov 2023 02:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700734028; x=1732270028;
  h=from:to:cc:subject:date:message-id;
  bh=E/GNlBnsRoIGgHD6OlYnLt2vW4tbci5Zhdk7KhH8jlc=;
  b=DqPTqpN51taxpHBWLAjn5Q5xdMcAmbohYBp/IgpQkPc59q4b3lTERgBR
   vtyTdDmBJIY0ndMnydDKLX04vdJJ17+Ymgt4OExv4uBDKMSvyHHJ8SJxp
   xHAQCsdjMpscYAS+aQiCxp/0CtWbm1WradtlLH2hFHEAs4/zAbn6bgYcX
   b2XmdGPuFl89kqK90BZ1EtT6g113XYLua8Ybmt1LEtETH2zYRbFK+wV/k
   8GsV92RYn8KgqLrg/xu9y0cL2KJVC0ct6WJTA0Boj3xOYVRc/OnKp6HPV
   RIPd9yzrhE50IyLK4kHMjWpGllKtktl+5ROJCKS2kG447FWGdqS8nyE/u
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="456576372"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="456576372"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 02:07:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="767160407"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="767160407"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orsmga002.jf.intel.com with ESMTP; 23 Nov 2023 02:07:02 -0800
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
Subject: [PATCH v3 0/5] Support _UID matching for integer types
Date: Thu, 23 Nov 2023 15:36:12 +0530
Message-Id: <20231123100617.28020-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

This series updates the standard ACPI helpers to support _UID matching
for both integer and string types, and uses them in a couple of places.

Changes since v2:
- Drop __builtin functions to reduce complexity (Rafael)
- Update tags

Changes since v1:
- Fix build errors

Raag Jadav (5):
  ACPI: bus: update acpi_dev_uid_match() to support multiple types
  ACPI: bus: update acpi_dev_hid_uid_match() to support multiple types
  ACPI: LPSS: use acpi_dev_uid_match() for matching _UID
  efi: dev-path-parser: use acpi_dev_uid_match() for matching _UID
  perf: arm_cspmu: drop redundant acpi_dev_uid_to_integer()

 drivers/acpi/acpi_lpss.c               | 16 ++-----
 drivers/acpi/utils.c                   | 48 -------------------
 drivers/firmware/efi/dev-path-parser.c |  7 +--
 drivers/perf/arm_cspmu/arm_cspmu.c     |  4 +-
 include/acpi/acpi_bus.h                | 65 +++++++++++++++++++++++++-
 include/linux/acpi.h                   | 15 ++----
 6 files changed, 74 insertions(+), 81 deletions(-)


base-commit: accf6bb711d6819cce89a122ccde4811c58c160e
-- 
2.17.1


