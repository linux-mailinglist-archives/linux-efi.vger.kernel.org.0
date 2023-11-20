Return-Path: <linux-efi+bounces-54-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C427F12CE
	for <lists+linux-efi@lfdr.de>; Mon, 20 Nov 2023 13:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F4A21C2182B
	for <lists+linux-efi@lfdr.de>; Mon, 20 Nov 2023 12:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D78E18E1C;
	Mon, 20 Nov 2023 12:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B1iz5Ukj"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEBEB8;
	Mon, 20 Nov 2023 04:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700482144; x=1732018144;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=vkKEZYR1JQ2LvJYNE9fzcULsL9BK72aBp+vTKNFQKvk=;
  b=B1iz5UkjXDwEa8/UYKwt1OymeZS/ABVIOAby1SDCXxcEynrwyownkitZ
   vgdJEkXBhylfj5NLMfnQ7NS+B+TzZ0xk6/9hnjVLAZe5elZ9xAYqLpC6T
   ug2zzoLBulTiDemdnA4PTOUCwf9vh/UM44DrcfA5xP04Dej/Ls1A/PHET
   QG+sbymJFBe+zic379ofxHJQpslT+YKVz2ehKl65dhCUUn6P/wDk8jkwa
   Gxy0LtRDH7zpvlOK5mPEBwXVHMpF/zea42eO2PwG5Y86Q/Cyyjxf5B/En
   UypVouAXGIxO+FmboiG2CaytrT0ijHsXAFRzhFrJTgbHX7zAdFGEdKYU0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="394455651"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="394455651"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 04:08:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="769878583"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="769878583"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmsmga007.fm.intel.com with ESMTP; 20 Nov 2023 04:08:50 -0800
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
Subject: [PATCH v1 1/6] compiler.h: Introduce helpers for identifying array and pointer types
Date: Mon, 20 Nov 2023 17:38:32 +0530
Message-Id: <20231120120837.3002-2-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231120120837.3002-1-raag.jadav@intel.com>
References: <20231120120837.3002-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

Introduce is_array_type() and is_pointer_type() helpers, which compare the
data type of provided argument against the enumeration values defined in
typeclass.h using __builtin_classify_type() function and identify array
and pointer types respectively.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 include/linux/compiler.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index bb1339c7057b..b4f656002c0f 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -242,6 +242,11 @@ static inline void *offset_to_ptr(const int *off)
 #define is_signed_type(type) (((type)(-1)) < (__force type)1)
 #define is_unsigned_type(type) (!is_signed_type(type))
 
+/* Classify data type based on enum values in typeclass.h */
+#define is_array_type(x)		(__builtin_classify_type(x) == 14)
+#define is_pointer_type(x)		(__builtin_classify_type(x) == 5)
+#define is_array_or_pointer_type(x)	(is_array_type(x) || is_pointer_type(x))
+
 /*
  * This is needed in functions which generate the stack canary, see
  * arch/x86/kernel/smpboot.c::start_secondary() for an example.
-- 
2.17.1


