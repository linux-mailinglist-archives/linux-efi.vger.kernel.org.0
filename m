Return-Path: <linux-efi+bounces-5794-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3581CA2A08
	for <lists+linux-efi@lfdr.de>; Thu, 04 Dec 2025 08:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A4CC3061E9B
	for <lists+linux-efi@lfdr.de>; Thu,  4 Dec 2025 07:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3533093C3;
	Thu,  4 Dec 2025 07:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aG3asMkB"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA342E2F0E;
	Thu,  4 Dec 2025 07:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764833029; cv=none; b=mN3FEdBLX9jxHJTah2QnMJRIg+BMJ2Umt7rq3nefEdruohzJ8xNQedeu2bjvtWmLFVvtNIl9fjaSnqfvOVsOoqiLu5TDgb/uJsMC+rGhLCMuod1LcTl0C37Uvj2t0knsKvAUby8KW/Ne4sor5bDVLOTj07H4RdyIjCqpxyJN5Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764833029; c=relaxed/simple;
	bh=1YwCGwQ1loJ5d92qxwSBPiK3ZN6jGchTytl2iRuN2G0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LxE9Tozu3Gk8F6qu/YUZ544OwzQWmbuyy21c/tEBSCdGp8LX/e77JhSLKJy5TyKjzWBtx39giZvJKhJykVG6+tJBRfrc+Zf9MQ8CqABv7vI3oi8llZLjUWiEApv78GxATq9IAKYb+mx8jEyL0SKLhd/n89bDPvvQMy45jLyM6aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aG3asMkB; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764833028; x=1796369028;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1YwCGwQ1loJ5d92qxwSBPiK3ZN6jGchTytl2iRuN2G0=;
  b=aG3asMkBBaV+DaTp4QX4rL5MuMw+F/lsZDSoWGJZkGfTL9CRS7LejJU8
   Et0r15RQQiGjTmzPpOqcDl3buc97WjQ6vC74Th1g5cORW+f/QGUglH9jB
   3ReDToEWusqqZa9ihmO8Yl3F+viOBxt82M8AJ7AgjqxHRyi6NaB9IXCT6
   4XULEQP4/3zIkFZNx/GId3GG9p/hsDCd1QxieC63831SttmEpulytRIFY
   wTi1XLZgTgA0nY9l2iENdvrTGiYrKCFPnAcjT1bta3GusM4DyUT8D0L9L
   R9WyvWJnH+jpJT4xNLRkX/P/UTrhAi8uSpY5WEyr2WejZ7sq05xcHoHP6
   A==;
X-CSE-ConnectionGUID: kwBpiaPcQzeHfHL7TBI6iw==
X-CSE-MsgGUID: kBVBHTZQTLKwarxJtAiOvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="66804591"
X-IronPort-AV: E=Sophos;i="6.20,248,1758610800"; 
   d="scan'208";a="66804591"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 23:23:45 -0800
X-CSE-ConnectionGUID: SJMrJGd6TJGC2+Mewjrzww==
X-CSE-MsgGUID: wxbjS4EXRqCL4syPFZ/H3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,248,1758610800"; 
   d="scan'208";a="199861636"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa004.fm.intel.com with ESMTP; 03 Dec 2025 23:23:43 -0800
From: Sohil Mehta <sohil.mehta@intel.com>
To: x86@kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>
Cc: "H . Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kiryl Shutsemau <kas@kernel.org>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Tony Luck <tony.luck@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: [PATCH 3/3] x86/cpu: Remove LASS restriction on EFI
Date: Wed,  3 Dec 2025 23:21:43 -0800
Message-ID: <20251204072143.3636863-4-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204072143.3636863-1-sohil.mehta@intel.com>
References: <20251204072143.3636863-1-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The initial LASS enabling has been deferred to much later during boot,
and EFI runtime services now run with LASS temporarily disabled. This
removes LASS from the path of all EFI services.

To make LASS more usable, remove the restriction on EFI, as the two can
now coexist.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
 arch/x86/kernel/cpu/common.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index c6835a04d734..9c60084203b5 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -415,14 +415,9 @@ static __always_inline void setup_lass(struct cpuinfo_x86 *c)
 	 * Legacy vsyscall page access causes a #GP when LASS is active.
 	 * Disable LASS because the #GP handler doesn't support vsyscall
 	 * emulation.
-	 *
-	 * Also disable LASS when running under EFI, as some runtime and
-	 * boot services rely on 1:1 mappings in the lower half.
 	 */
-	if (IS_ENABLED(CONFIG_X86_VSYSCALL_EMULATION) ||
-	    IS_ENABLED(CONFIG_EFI)) {
+	if (IS_ENABLED(CONFIG_X86_VSYSCALL_EMULATION))
 		setup_clear_cpu_cap(X86_FEATURE_LASS);
-	}
 }
 
 static int enable_lass(unsigned int cpu)
-- 
2.43.0


