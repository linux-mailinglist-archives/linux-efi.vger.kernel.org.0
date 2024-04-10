Return-Path: <linux-efi+bounces-934-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E654389EFC4
	for <lists+linux-efi@lfdr.de>; Wed, 10 Apr 2024 12:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23BD41C226FD
	for <lists+linux-efi@lfdr.de>; Wed, 10 Apr 2024 10:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DD9158D90;
	Wed, 10 Apr 2024 10:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sc66azfd"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18860158D94;
	Wed, 10 Apr 2024 10:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712744669; cv=none; b=miUk5hoKR6v2NC0NxIoIld7Lx4Fv4UZ1qCWrsnVhKyTONhcFn/qTXpw4jnAwVtfxKrEBu2LXRt/efQDRZuscv42gczVeZICn3jTAWYvfZFYM/T6a/VutyajL4EVGkx230ewL22Vn7uiXUgVMGGXPybojUwKNWCUHM324fk+DnIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712744669; c=relaxed/simple;
	bh=ebbxEm39CjWYFC6IF/Qa9Ng63Zx8Wwaf4wL+lGqTjNw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L3SPyLVI1aWmU771d/jJdN9vtk6A6wtFoMLEqoBPHtKCE9pRo20JOQmtq3BkTB6XCR8GokoaFRthBEDqPnZW8IpspnJnOs8yHrA1PqfldMzzjODqGpD2dk6qs+ymPYfDDtfcRqjYSOF2YY0vvRw+lsPqZHaH+dYNtcgKXg89jpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sc66azfd; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712744668; x=1744280668;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ebbxEm39CjWYFC6IF/Qa9Ng63Zx8Wwaf4wL+lGqTjNw=;
  b=Sc66azfdkVe3zz7jy0TBbV+UCVoHJ3Bt0RUQGHYX4Jx+yWrMo8fstSUN
   JJNK8mgPsQDfSfPrZWXMEiQ/RSL23JFVZVMUEUjEGu4YGZ9091eBPDGsC
   tuGoO7L5c7ykkCNy1n235OYcG5e+UUxDCSAbJsX9sDjDBzAG0jp7AD0nT
   i8Vrbq9HJ4rcW9riTiMjLOO6iOBcju9egzNK1h6vqiDSmTVof2Q9GxmEK
   lNClYTWpiT7jdAuZBr6oDmQdWZjw1NafgWPO2iwJlfdi8X2GHqTaYB1un
   hBXjhdyj7eJj2keRP7qojdmFF26KB4obkNR3ecdgw8A74+pIx7/8FhXJ2
   A==;
X-CSE-ConnectionGUID: nXPEC85WSmmG0RSCrPZ+0A==
X-CSE-MsgGUID: f/H3utzNQlK8JOIgAXaqHw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8224430"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="8224430"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 03:24:28 -0700
X-CSE-ConnectionGUID: Nrqx7/0BSJWJvICVK9O+Qg==
X-CSE-MsgGUID: s3AwXsfhQfq6IXM8QWLN+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="25283031"
Received: from unknown (HELO chenyu-dev.sh.intel.com) ([10.239.62.107])
  by orviesa004.jf.intel.com with ESMTP; 10 Apr 2024 03:24:26 -0700
From: Chen Yu <yu.c.chen@intel.com>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Chao Gao <chao.gao@intel.com>,
	linux-kernel@vger.kernel.org,
	Chen Yu <yu.c.chen@intel.com>,
	"Hossain, Md Iqbal" <md.iqbal.hossain@intel.com>
Subject: [PATCH] efi/unaccepted: touch soft lockup during memory accept
Date: Wed, 10 Apr 2024 18:23:01 +0800
Message-Id: <20240410102301.634677-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 50e782a86c98 ("efi/unaccepted: Fix soft lockups caused
by parallel memory acceptance") has released the spinlock so
other CPUs can do memory acceptance in parallel and not
triggers softlockup on other CPUs.

However the softlock up was intermittent shown up if the memory
of the TD guest is large, and the timeout of softlockup is set
to 1 second:

 RIP: 0010:_raw_spin_unlock_irqrestore
 Call Trace:
 ? __hrtimer_run_queues
 <IRQ>
 ? hrtimer_interrupt
 ? watchdog_timer_fn
 ? __sysvec_apic_timer_interrupt
 ? __pfx_watchdog_timer_fn
 ? sysvec_apic_timer_interrupt
 </IRQ>
 ? __hrtimer_run_queues
 <TASK>
 ? hrtimer_interrupt
 ? asm_sysvec_apic_timer_interrupt
 ? _raw_spin_unlock_irqrestore
 ? __sysvec_apic_timer_interrupt
 ? sysvec_apic_timer_interrupt
 accept_memory
 try_to_accept_memory
 do_huge_pmd_anonymous_page
 get_page_from_freelist
 __handle_mm_fault
 __alloc_pages
 __folio_alloc
 ? __tdx_hypercall
 handle_mm_fault
 vma_alloc_folio
 do_user_addr_fault
 do_huge_pmd_anonymous_page
 exc_page_fault
 ? __do_huge_pmd_anonymous_page
 asm_exc_page_fault
 __handle_mm_fault

When the local irq is enabled at the end of accept_memory(),
the softlockup detects that the watchdog on single CPU has
not been fed for a while. That is to say, even other CPUs
will not be blocked by spinlock, the current CPU might be
stunk with local irq disabled for a while, which hurts not
only nmi watchdog but also softlockup.

Chao Gao pointed out that the memory accept could be time
costly and there was similar report before. Thus to avoid
any softlocup detection during this stage, give the
softlockup a flag to skip the timeout check at the end of
accept_memory(), by invoking touch_softlockup_watchdog().

Reported-by: "Hossain, Md Iqbal" <md.iqbal.hossain@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/firmware/efi/unaccepted_memory.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/firmware/efi/unaccepted_memory.c b/drivers/firmware/efi/unaccepted_memory.c
index 5b439d04079c..50f6503fe49f 100644
--- a/drivers/firmware/efi/unaccepted_memory.c
+++ b/drivers/firmware/efi/unaccepted_memory.c
@@ -4,6 +4,7 @@
 #include <linux/memblock.h>
 #include <linux/spinlock.h>
 #include <linux/crash_dump.h>
+#include <linux/nmi.h>
 #include <asm/unaccepted_memory.h>
 
 /* Protects unaccepted memory bitmap and accepting_list */
@@ -149,6 +150,9 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
 	}
 
 	list_del(&range.list);
+
+	touch_softlockup_watchdog();
+
 	spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
 }
 
-- 
2.25.1


