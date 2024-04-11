Return-Path: <linux-efi+bounces-937-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5A18A04E7
	for <lists+linux-efi@lfdr.de>; Thu, 11 Apr 2024 02:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F6211F251ED
	for <lists+linux-efi@lfdr.de>; Thu, 11 Apr 2024 00:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA6679DC;
	Thu, 11 Apr 2024 00:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R/7AIIZt"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1491C01;
	Thu, 11 Apr 2024 00:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712796641; cv=none; b=DSvbzFf5t0XkYwwR2px4aUzK+HQ8Cogjt7KZI9AKcdBrokOe04wSLpYYhUhHYnjAlf8OKVKbYoxUt/Byeo3+ucf7mTOZMsJFBkzP1FY2obc7wQ+K/I7CYMawv3Zez7lRFjbCUj7f9nZlzHRLtBLsjTX01xd2+DzWLLwiTNjfvkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712796641; c=relaxed/simple;
	bh=FPPB/GdxEEL3sFWdyaY02Mi0zFPSitnZc7eAqagFJUs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F88PcK7QqfivVF9IQSUTCy4prq29RjlfPAZLnS9DGAcHwE6vW3RI9D02MSJYoZUk7PUNLHJf58/zkqBnKXNucdXQ70RrY5rkMeDF4zsGyCEqA39IBIQqtLoNI62t87kh8nmwdlu8aUMNZ5QaszAdtqy8aFoWfr6B+YIY8mXL4oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R/7AIIZt; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712796638; x=1744332638;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FPPB/GdxEEL3sFWdyaY02Mi0zFPSitnZc7eAqagFJUs=;
  b=R/7AIIZtwVadlRJIbcA+aV3bc6ELu6JKvuhclgCDPiKjRRTpew967kfY
   /pAQuZOEjxGEZoPKOtk+mwSWxDORfwK6vqr+oAz6u3a5+/H7frgVt4x0d
   ncW6htVrZArVr6GF4uOhp25y9MXzo9f0vv7pQ333wRR94CrAHJusCCDhu
   YzXp2tPeRzEuwFW030RIFWYUeXw0bNvUptK6ybcNtwY7EGwltfz8OO5yR
   XZ2hAERV5fvm8ZT/ISxYEepx82yoIn3iWIYMOpxNQVhAVAFWYeDTzTtrX
   9vz95Ei6FF6Ze3YYkuiRfNNlTuo3CsRYc9+wJcGu9ovyB+7lQjXHzh01Y
   A==;
X-CSE-ConnectionGUID: JWJFjwrQS0qWpKsNUTyrZw==
X-CSE-MsgGUID: pyM2VbntSdKpC1VWfRZRRA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11153368"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="11153368"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 17:50:38 -0700
X-CSE-ConnectionGUID: 0nDhENRFSsyzdp/Iq5n1ZQ==
X-CSE-MsgGUID: /TIn2SV0TeuafMNRs7dNjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="20737058"
Received: from unknown (HELO chenyu-dev.sh.intel.com) ([10.239.62.107])
  by fmviesa006.fm.intel.com with ESMTP; 10 Apr 2024 17:50:36 -0700
From: Chen Yu <yu.c.chen@intel.com>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Chao Gao <chao.gao@intel.com>,
	linux-kernel@vger.kernel.org,
	Chen Yu <yu.c.chen@intel.com>,
	"Hossain, Md Iqbal" <md.iqbal.hossain@intel.com>
Subject: [PATCH v2] efi/unaccepted: touch soft lockup during memory accept
Date: Thu, 11 Apr 2024 08:49:07 +0800
Message-Id: <20240411004907.649394-1-yu.c.chen@intel.com>
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
to 1 second.

The symptom is:
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

Fixes: 50e782a86c98 ("efi/unaccepted: Fix soft lockups caused by parallel memory acceptance")
Reported-by: "Hossain, Md Iqbal" <md.iqbal.hossain@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v1 -> v2:
	 Refine the commit log and add fixes tag/reviewed-by tag from Kirill.
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


