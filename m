Return-Path: <linux-efi+bounces-4571-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BC4B2CFE2
	for <lists+linux-efi@lfdr.de>; Wed, 20 Aug 2025 01:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB0541897277
	for <lists+linux-efi@lfdr.de>; Tue, 19 Aug 2025 23:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C27222FDE6;
	Tue, 19 Aug 2025 23:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="XsxzScub"
X-Original-To: linux-efi@vger.kernel.org
Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B481221DB6;
	Tue, 19 Aug 2025 23:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.1.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755645827; cv=none; b=mEEaCnmyhfzhsa9fTfv6cO+o0sDolgc4CelANMLE2Xsdm0BswjlOTHHlmJKZNU9P8YRuObFRewh9kLgGsiozUHQRCgEIPwN097DoX3mQOOOP4FvfTVKi9I5HGeQ+JmdOhs5b4zp/9cgyUl5JjOh2OHFCFlwgpHdiMqy8+UCTUI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755645827; c=relaxed/simple;
	bh=XFZ8zLvoaO4Ym4OlI/vg69pUaQKnl/wpQKOys7NVI8o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r/MpZZ3tDIf8dAGsSX/EfcNw6QPpWoZRKpEqbxgxK7hqJ+ni0Af5K+4E5T5GB+dIBT1sg+ImKa9oER6sPuc3++APr4iYIBg3DuheGAKlT5i4zxbIiXi54deJpseZcZrqWvYrOCoZYaZY2UZH5fOIYjJ1InycXWuX/Tmk60yb87A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=XsxzScub; arc=none smtp.client-ip=44.246.1.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1755645825; x=1787181825;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JrfIpk3vI2iEZnlCjBatj++PBwaKwr0n+7Op9hx7NqM=;
  b=XsxzScubOO6PcrQSBN7v5MFhoVYDOK3W9MKN40kkm2BDl8knCcuz27n6
   n4ibqZEX9qFvlkjwCvCQoc4E+GtT4uNIp9V7loniF/XDnS9HVPVg1JM0y
   X4Hgfru9IzJqEe/lU4rUCOc0AMfv0hAKZO3BlLqwJ4AI3S6EmaQJhxQhM
   ZPepp4KUJyIJh8E8wFJIEzW4kxYaAOCqf86FLwkJAqd0VguNNNZa8oPow
   HD357cL0I0z7DIbRwc5ZCTfg0Ovy4TrpA1grX26RZZcqcU/YPXqlYychJ
   NqNHiENwLNphogOFcSWVYXv/vU38YXkpvsyX9GTROLs0ZgVMli1dADVvW
   w==;
X-CSE-ConnectionGUID: A3CnChY0S4G6zO7ySKE+3w==
X-CSE-MsgGUID: rIVmzT6GRpyTTXD+abL8SA==
X-IronPort-AV: E=Sophos;i="6.16,202,1744070400"; 
   d="scan'208";a="1404456"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 23:23:42 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:23645]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.67:2525] with esmtp (Farcaster)
 id 28c909b1-13a1-425e-9469-766521fc37e4; Tue, 19 Aug 2025 23:23:42 +0000 (UTC)
X-Farcaster-Flow-ID: 28c909b1-13a1-425e-9469-766521fc37e4
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 19 Aug 2025 23:23:42 +0000
Received: from dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com
 (10.253.109.105) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17; Tue, 19 Aug 2025
 23:23:40 +0000
From: Evangelos Petrongonas <epetron@amazon.de>
To: Ard Biesheuvel <ardb@kernel.org>, Mike Rapoport <rppt@kernel.org>
CC: Evangelos Petrongonas <epetron@amazon.de>, Alexander Graf
	<graf@amazon.com>, Changyuan Lyu <changyuanl@google.com>, Andrew Morton
	<akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
	<kexec@lists.infradead.org>, <linux-mm@kvack.org>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nh-open-source@amazon.com>
Subject: [PATCH v2 0/2] efi: Fix EFI boot with kexec handover (KHO)
Date: Tue, 19 Aug 2025 23:22:44 +0000
Message-ID: <cover.1755643201.git.epetron@amazon.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D038UWC003.ant.amazon.com (10.13.139.209) To
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

On a side note, I have noticed that `kho_populate()` calls
`memblock_set_kho_scratch_only()`, but the `kho` cmdline option is
not checked until much later. Therefore, memblock will use only the
scratch regions that were passed from the outgoing kernel, even if the
incoming kernel doesn't explicitly want that. I am not sure if this is
done on purpose, but in any case we can discuss this in another patch,
as it is orthogonal to this one.

Main Changes in v2 (smaller changes can be found in individual patches):
    - Introduce is_kho_boot()
    - Replaced manual loop with for_each_mem_region macro

Evangelos Petrongonas (2):
  kexec: introduce is_kho_boot()
  efi: Support booting with kexec handover (KHO)

 drivers/firmware/efi/efi-init.c | 28 ++++++++++++++++++++++++----
 include/linux/kexec_handover.h  |  6 ++++++
 kernel/kexec_handover.c         | 20 ++++++++++++++++++++
 3 files changed, 50 insertions(+), 4 deletions(-)

-- 
2.47.3



Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


