Return-Path: <linux-efi+bounces-4965-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B5846BC06B3
	for <lists+linux-efi@lfdr.de>; Tue, 07 Oct 2025 08:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D737F4F43C7
	for <lists+linux-efi@lfdr.de>; Tue,  7 Oct 2025 06:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B7E23BCF8;
	Tue,  7 Oct 2025 06:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jFdMTPzv"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C8F235341;
	Tue,  7 Oct 2025 06:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759820042; cv=none; b=sDLfQRBCQvmy8lrqcDz5cRqMSBE6HOZGllm5ZbtVPKnYsf5qO+IPPn3l2VjcVf3ioi0pVMJOtwvzlDK9Dd+MNDIyA0yL5PpU5oVVM65z/hjNmUr4mBYyfvEoQVqyBrHqLz0jIP0meRJTByy+QDrbKJvk2WI/8xBU74KunJgw9jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759820042; c=relaxed/simple;
	bh=r46GE5fcmXJUOsOhFrhC0/yII78h6bGgbcDsW3hMsiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dkVQnYWJauVGIFCvz1FMW7ZoN2sf8Plym/r+z0hhqvP2YWNRYo3xVDqyC0temFrqX3tGcjepVcCWAH6v3llHBXDsuWiqEmZRt5A6Cp2oBECdUWUs7q5jElXxRCt6u0uaLbuDepsEJSjaTkozNwfqgoMFKmfni9KlNKvtsPsxPvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jFdMTPzv; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759820040; x=1791356040;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r46GE5fcmXJUOsOhFrhC0/yII78h6bGgbcDsW3hMsiY=;
  b=jFdMTPzvz+o79YP//gZyUCb6O5uEA+s44a5nI7cO9qoMZ15xom8WHgJa
   ZyqMTheMmx02OtFjbQtadtgQV4JWevy6+JJluwyBkZyoVIgx8iV5I8Uy4
   a0DlINYy4aFNrlBWNhEX8rQnMtTVT6slQvXiz9gBHyTqCxI5jttdlHEZ8
   oH172HNGqmOAFy311HO2AD3XvkJeu35s7I9QqRVrEBRRzhJ3iml2cfh+8
   qniCqYmKoLmwPJrt5h72kD3duNDJkDY5D8LjYzYseKkb+G8XCrhy7poLW
   PwSY78WQ3Zv2eFp8Zr9RySJ6jh0mlNMX03Nqb3vHadKMQE1cnqouo1h5O
   w==;
X-CSE-ConnectionGUID: WyHY2xdlROq+XsVXDEj68Q==
X-CSE-MsgGUID: v/znFtYJTqKcsXf7ecxRYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11574"; a="72254433"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="72254433"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 23:53:58 -0700
X-CSE-ConnectionGUID: l+d5GK6NQFWXa+3JX2RqmA==
X-CSE-MsgGUID: BO7q1UogQ9u/zWbcfFux0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="184354474"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa004.jf.intel.com with ESMTP; 06 Oct 2025 23:53:58 -0700
From: Sohil Mehta <sohil.mehta@intel.com>
To: x86@kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>
Cc: Jonathan Corbet <corbet@lwn.net>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Kirill A . Shutemov" <kas@kernel.org>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Xin Li <xin@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Sean Christopherson <seanjc@google.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	David Laight <david.laight.linux@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: [PATCH v10 04/15] x86/cpu: Set LASS CR4 bit as pinning sensitive
Date: Mon,  6 Oct 2025 23:51:08 -0700
Message-ID: <20251007065119.148605-5-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007065119.148605-1-sohil.mehta@intel.com>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yian Chen <yian.chen@intel.com>

Security features such as LASS are not expected to be disabled once
initialized. Add LASS to the CR4 pinned mask.

Signed-off-by: Yian Chen <yian.chen@intel.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v10:
 - No change.
---
 arch/x86/kernel/cpu/common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index c7d3512914ca..61ab332eaf73 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -403,7 +403,8 @@ static __always_inline void setup_umip(struct cpuinfo_x86 *c)
 
 /* These bits should not change their value after CPU init is finished. */
 static const unsigned long cr4_pinned_mask = X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_UMIP |
-					     X86_CR4_FSGSBASE | X86_CR4_CET | X86_CR4_FRED;
+					     X86_CR4_FSGSBASE | X86_CR4_CET | X86_CR4_FRED |
+					     X86_CR4_LASS;
 static DEFINE_STATIC_KEY_FALSE_RO(cr_pinning);
 static unsigned long cr4_pinned_bits __ro_after_init;
 
-- 
2.43.0


