Return-Path: <linux-efi+bounces-547-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FE9855912
	for <lists+linux-efi@lfdr.de>; Thu, 15 Feb 2024 04:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98770285624
	for <lists+linux-efi@lfdr.de>; Thu, 15 Feb 2024 03:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20753FE4;
	Thu, 15 Feb 2024 03:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NC7z5DQh"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB80A1864;
	Thu, 15 Feb 2024 03:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707966127; cv=none; b=rSo0nV9t5prjYZ2X4kFn6DsdEV1cH9k0bTsH+4UipuCTTj+fNMrRmW8YdKJVQNIaOku4uL8mw1WpSlTLy+kmxmMMboZVkI0n4Q8mKT2IBOQfwdmfVca4t/cEY2HvF48jCsdULMcG64i3pEfX0CXB21nV9eWSL1aogbjrqKd7+4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707966127; c=relaxed/simple;
	bh=9cutMbdi58gyhcptcGgn3SBIVIJ8WZRGKaEC+ywx0o4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rrl+vjjUrEJaTJJeKrbka08DUdmc5xn+wXIozpfXa7EPNdSC4zcRnoUsn3xpUSBO7JOCDWRdbiSgAU29b/AFhuDDlZ18SkqYLdbOVpdx8b48fOJQgAvNsZ4m5CjsJjE1LybNTUDO38ipGx3cX6V/9E/g9W9mOzlhJppcMWsDzXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NC7z5DQh; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707966126; x=1739502126;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9cutMbdi58gyhcptcGgn3SBIVIJ8WZRGKaEC+ywx0o4=;
  b=NC7z5DQhJzTAKEYHABoNiWBsxBC9AtSxXn0ntAz3AEkh34+wj/D5ocss
   A9GKGxQy4zP96vb5fiCnC7xXrVg6AiEbfi9PkQAQ5B6qMtgjzlxreUCqW
   N15WAjX8JUbEAVJB7LlqIHd0nQYeiNRrUPdyjbuIuS/vH3h/uhnBjxZCt
   Au0S3Os6Dey+nVPQFxiAJs/tSe/aD73OX6RMV7pIH1INkB+RZwmn8VIVt
   HHAwwEyNEixpzjEffr/gEcREnSU+f4XdTFQOZ1hSAuF5HYf8ynr49pin5
   16KE4fKu5aio1x9HyElMzksBriXOxBt281r2df2DFN0Jsr7Im3P3teXym
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="5007274"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="5007274"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 19:02:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="8010505"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 19:02:04 -0800
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: [PATCH v2 0/2] Add measurement and event log support for CC platforms
Date: Thu, 15 Feb 2024 03:00:00 +0000
Message-Id: <20240215030002.281456-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a Confidential Computing (CC) environment, not all platforms
implement TPM support. Instead, it may support measurement and event
logging based upon the hardware Trusted Execution Environment (TEE)
capability. For such cases, UEFI specification [1] defines an
alternative measurement protocol and interfaces. This patch set
enables this support in EFI bootstub.

https://uefi.org/specs/UEFI/2.10/38_Confidential_Computing.html#efi-cc-measurement-protocol [1]

Changes since v1:

* Add missing tagged event data.
* Add support for get_event_log().

Kuppuswamy Sathyanarayanan (2):
  efi/libstub: Add Confidential Computing (CC) measurement support
  efi/libstub: Add get_event_log() support for CC platforms

 .../firmware/efi/libstub/efi-stub-helper.c    | 127 ++++++++++++++----
 drivers/firmware/efi/libstub/efi-stub.c       |   2 +-
 drivers/firmware/efi/libstub/efistub.h        |  78 ++++++++++-
 drivers/firmware/efi/libstub/tpm.c            |  78 +++++++----
 drivers/firmware/efi/libstub/x86-stub.c       |   2 +-
 include/linux/efi.h                           |   4 +
 6 files changed, 235 insertions(+), 56 deletions(-)

-- 
2.25.1


