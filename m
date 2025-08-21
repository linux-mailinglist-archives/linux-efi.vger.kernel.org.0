Return-Path: <linux-efi+bounces-4586-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 483E0B30197
	for <lists+linux-efi@lfdr.de>; Thu, 21 Aug 2025 20:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B27214E3268
	for <lists+linux-efi@lfdr.de>; Thu, 21 Aug 2025 18:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5D3343203;
	Thu, 21 Aug 2025 18:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="lU75Lnbc"
X-Original-To: linux-efi@vger.kernel.org
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E09D341AA7;
	Thu, 21 Aug 2025 18:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755799226; cv=none; b=UydGOaKwBUxNbayBrHK94osU63w9yUkEc6pKjzwsOWAeF+OR33I+LggVjmBjYsQ0ES0xjHXkDtgbxIRUOEbtS5LRllWwYte+E1OTBvgmeHU9Glx99X9BCdTxptnrZqLMrT4etLPaWshD+accFy8za9H/z1wd+puKzoLNgNRaDd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755799226; c=relaxed/simple;
	bh=uKBuRqek+3J+kI9u8EgkNan2G1ZIvTlDcTJyVSHU+0o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b8LukTH4CAJEieja1CGIuPu9Ytyfu8zzjvd5UiCsKI87ZGzLM7U4VaWqcGSJHxD3Ff8IMnMerjMuZzhlGuCGoj6RWLEIym6tgmo0oHkN7HZCj9m4Uzq7Dj68mKyttGjnvx7C1ifLDaSDE9QZhwHAv6PT+B1ulyHtY/HurY/szr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=lU75Lnbc; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1755799224; x=1787335224;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=S+gS8f64vE5JkLxSnB7ir6Lb0kF6iQE9gWFgqB32eCo=;
  b=lU75Lnbcz2Bdw3+DkwZYvc/0Zk4y+zyYvLgi0+jpjWV9TzFyvHR/Ez6+
   8thHu0h8jql8eWqKMZJbWwC2mrZKKezKK4hkJVl/aUu7/rUV6QS0Z007e
   /9y8GECLz4VtZM88xtz9350Rw9sUalQaZVm/dcK0bosV3dj3MOGSql5HL
   0fDlh8QUkNM3a2Zdzf9ZFlG3ljZEBv+5+eLx9I4LLYV4KxRMoBnihL1vm
   uO0yeoE+Rj1de3t+IjFCicRpuLMC6wrceX+ZbWQgnksgL37MJTtg31P6t
   wKH61gslRfJ58/oi+gZRQs6pdg1iFjfaGl0PBxvCVBHqS66xceM5R6j6D
   g==;
X-CSE-ConnectionGUID: K8Hohe32Qp+Vv4T80IzDyQ==
X-CSE-MsgGUID: xyRxENLgS6O/spnd+SQBkw==
X-IronPort-AV: E=Sophos;i="6.17,309,1747699200"; 
   d="scan'208";a="1570660"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 17:59:14 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:34303]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.45.64:2525] with esmtp (Farcaster)
 id ddd70eb3-6448-4aee-bf33-ff8d888990ad; Thu, 21 Aug 2025 17:59:14 +0000 (UTC)
X-Farcaster-Flow-ID: ddd70eb3-6448-4aee-bf33-ff8d888990ad
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Thu, 21 Aug 2025 17:59:13 +0000
Received: from dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com
 (10.253.109.105) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17; Thu, 21 Aug 2025
 17:59:11 +0000
From: Evangelos Petrongonas <epetron@amazon.de>
To: Ard Biesheuvel <ardb@kernel.org>, Mike Rapoport <rppt@kernel.org>
CC: Evangelos Petrongonas <epetron@amazon.de>, Alexander Graf
	<graf@amazon.com>, Changyuan Lyu <changyuanl@google.com>, Andrew Morton
	<akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
	<kexec@lists.infradead.org>, <linux-mm@kvack.org>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nh-open-source@amazon.com>
Subject: [PATCH v3 0/2] efi: Fix EFI boot with kexec handover (KHO)
Date: Thu, 21 Aug 2025 17:58:58 +0000
Message-ID: <cover.1755721529.git.epetron@amazon.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D043UWC004.ant.amazon.com (10.13.139.206) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch series fixes a kernel panic that occurs when booting with
both EFI and KHO (Kexec HandOver) enabled.

The issue arises because EFI's `reserve_regions()` clears all memory
regions with `memblock_remove(0, PHYS_ADDR_MAX)` before rebuilding them
from EFI data. This destroys KHO scratch regions that were set up early
during device tree scanning, causing a panic as the kernel has no valid
memory regions for early allocations.

The first patch introduces `is_kho_boot()` to allow early boot
components to reliably detect if the kernel was booted via KHO-enabled
kexec. The existing `kho_is_enabled()` only checks the command line and
doesn't verify if an actual KHO FDT was passed.

The second patch modifies EFI's `reserve_regions()` to selectively
remove only non-KHO memory regions when KHO is active, preserving the
critical scratch regions while still allowing EFI to rebuild its memory
map.

The patchset was developed/tested on arm64.

Main Changes in v3 (smaller changes can be found in individual patches):
    - Condition is_kho_boot only on the existence of a KHO FDT
    - Add Reviewed-by/Acked-by

Main Changes in v2:
    - Introduce is_kho_boot()
    - Replace manual loop with for_each_mem_region macro

Evangelos Petrongonas (2):
  kexec: introduce is_kho_boot()
  efi: Support booting with kexec handover (KHO)

 drivers/firmware/efi/efi-init.c | 29 +++++++++++++++++++++++++----
 include/linux/kexec_handover.h  |  6 ++++++
 kernel/kexec_handover.c         | 20 ++++++++++++++++++++
 3 files changed, 51 insertions(+), 4 deletions(-)

-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


