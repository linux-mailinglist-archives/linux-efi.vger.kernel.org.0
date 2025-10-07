Return-Path: <linux-efi+bounces-4967-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 89ADDBC06C8
	for <lists+linux-efi@lfdr.de>; Tue, 07 Oct 2025 08:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B72264F45C0
	for <lists+linux-efi@lfdr.de>; Tue,  7 Oct 2025 06:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D66023D7F5;
	Tue,  7 Oct 2025 06:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ffnAY8Vh"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF1F238150;
	Tue,  7 Oct 2025 06:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759820043; cv=none; b=Ywq/H11/XiRjaM5U9VBJocPgwBVToxBXbDhJZEda2yyU2A5H/VBgVUS7TllYc8PRKIArdKPC2LKHlKCInYO70exv9MkSuZdE4zJbAXCgzRZhI5ieGPHq67kULpX9yidfOkBNasllmS7KBueHxrZgvfoeMFsRrxPS70jgKwAZFmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759820043; c=relaxed/simple;
	bh=2tLYylj3DF/5PX3moQnEXwNy+fnzilsriKy0eTjLYT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hTaIfgS8grnrE2Du60RR4603ubo+VOz0IJDYScM1hxlzBR+5Oh/sJkFce9Fd0eIkNMI/bOF3ln2WWMxU2B78roKoFY3mifeO1HanQ9btDj8Tu3zOlzih4r8HPPOP3h+CiUCg6UoOIjKpG3H1hs4hCcXzwFf01SBMb9srVndSvPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ffnAY8Vh; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759820041; x=1791356041;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2tLYylj3DF/5PX3moQnEXwNy+fnzilsriKy0eTjLYT0=;
  b=ffnAY8Vhq1wpyd6QRBJCbUR37NHMed9I/NaD4LN0OfUSMLUK7QNyT3pC
   ruR3X6YlQ1K2CtlU5ihvxrtjw+m2GeLOb4mKXCvREyT6SsYzufx7mqbuV
   1qEKRwe7RhL42l9JGtTpTkEHv9GxQwfp0SbxEnjVoMjzP4/4xljy6ughS
   T/onDGw9pOBl4MuN+uvcto0SACJWXBmp+Y7b0EgAe/sgTTHBjNP1+jrI2
   RGxEWFTT5/Pa3sEscaNAmSY1q2mHEpchsMzlKK+POCPw9Ic27aT263FRi
   pSw4hs4YDZqf3LoF9MC/l1V1pAYMOUSLzzO1H6j+uc6UJiMZTFStbS1AL
   Q==;
X-CSE-ConnectionGUID: ogkJhTNkQd6e8htZnZPbmg==
X-CSE-MsgGUID: UEuiXXqBSqCCr6SEJ7OwXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11574"; a="72254463"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="72254463"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 23:54:00 -0700
X-CSE-ConnectionGUID: Y7LmAJOSQYWVnMRl+LGvvw==
X-CSE-MsgGUID: FD6aC6ifTD6sHu3HIhWdbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="184354483"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa004.jf.intel.com with ESMTP; 06 Oct 2025 23:54:00 -0700
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
Subject: [PATCH v10 06/15] x86/efi: Disable LASS while mapping the EFI runtime services
Date: Mon,  6 Oct 2025 23:51:10 -0700
Message-ID: <20251007065119.148605-7-sohil.mehta@intel.com>
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

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

While mapping EFI runtime services, set_virtual_address_map() is called
at its lower mapping, which LASS prohibits. Wrapping the EFI call with
lass_stac()/clac() is not enough, because the AC flag only gates data
accesses, and not instruction fetches.

Use the big hammer and toggle the CR4.LASS bit to make this work.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v10:
 - Reword code comments
---
 arch/x86/platform/efi/efi.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 463b784499a8..cc00a7e6599e 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -786,8 +786,8 @@ static void __init __efi_enter_virtual_mode(void)
 {
 	int count = 0, pg_shift = 0;
 	void *new_memmap = NULL;
+	unsigned long pa, lass;
 	efi_status_t status;
-	unsigned long pa;
 
 	if (efi_alloc_page_tables()) {
 		pr_err("Failed to allocate EFI page tables\n");
@@ -825,11 +825,23 @@ static void __init __efi_enter_virtual_mode(void)
 
 	efi_sync_low_kernel_mappings();
 
+	/*
+	 * LASS complains because set_virtual_address_map() is located
+	 * at a lower address. To pause enforcement, flipping RFLAGS.AC
+	 * is not sufficient here, as it only permits data access and
+	 * not instruction fetch. Disable the entire LASS mechanism.
+	 */
+	lass = cr4_read_shadow() & X86_CR4_LASS;
+	cr4_clear_bits(lass);
+
 	status = efi_set_virtual_address_map(efi.memmap.desc_size * count,
 					     efi.memmap.desc_size,
 					     efi.memmap.desc_version,
 					     (efi_memory_desc_t *)pa,
 					     efi_systab_phys);
+
+	cr4_set_bits(lass);
+
 	if (status != EFI_SUCCESS) {
 		pr_err("Unable to switch EFI into virtual mode (status=%lx)!\n",
 		       status);
-- 
2.43.0


