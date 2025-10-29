Return-Path: <linux-efi+bounces-5243-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CC0C1D5C9
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 22:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D793834D32A
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 21:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DA931D72A;
	Wed, 29 Oct 2025 21:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A+Q9Dmkr"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA553191D3;
	Wed, 29 Oct 2025 21:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761771976; cv=none; b=JsOAPX2TO/aQ0o20wDyhDKPWf4Z6hfXT4ai62Ep2Aj/1xPPSLhB/D5KRCZuGHt4fEUoMuREJzhW95L09T9/omE3+aqrLYvhh5STpEGqsnUN3ZHCPEutNdYTzsAE3LYhF8sxkckFCcJgbGfTki8OCNapaYZdTqFNC8n3BleBHcZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761771976; c=relaxed/simple;
	bh=HFOpNTSEleSAxxj2SXmcUD5+5b9kLLItHL4d1xcvcZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S4qjpwPHuCpE9THA01yHcxxySgo7G5rOxCn9yx7MO11mRmQ+ZkTZbwqUm1ntydPm2Kh4ybObteo/fXkFwZRS60Km7RAf+0Q3isRftKbnvh465/yrvGUaK61eZ05u4Qt6mvDnulQlH2onPSOzLNj+GM6lSR8AnbUzUSo6YkQznQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A+Q9Dmkr; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761771975; x=1793307975;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HFOpNTSEleSAxxj2SXmcUD5+5b9kLLItHL4d1xcvcZc=;
  b=A+Q9DmkrFvs9DX14O5ob0m/utcgnsjcFLxOWeeWrcpyefqwlyIVq8A6m
   WBqW/vkZUFgWXgcPcwZEWGE/T8adtFRcnhgMijIs+hQRrhEsdvnE31fNp
   DOP9Fvo5O/+enNv9BB4XZLahPKd9Vj7xNy1jzoCB/BCbQTFSNCud26Izy
   dOwHlEQvWqicFeqN0IhqUxF5n0FfqaAnsHc4XZFv78beHlYySKElqiZol
   jPupvb0LqEs0ji+hoo6UaCSykCeNxZZ1Frv8y5Je2O/3DdOPVpelO20tC
   aRCrMcgT5N6dRizTHUXPcFbhIxnph/hm/3M9sp97TU4sjxW25Z2N17yeT
   Q==;
X-CSE-ConnectionGUID: O5NKU0YtSBezzKkionRrcw==
X-CSE-MsgGUID: S9bIbtwJQIK7YhQi8v5VNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="64002741"
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="64002741"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 14:06:14 -0700
X-CSE-ConnectionGUID: MOf5mUcgTuebakYZECCDkQ==
X-CSE-MsgGUID: MFrmOZI+RZWc0A6fWrPvcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="216431994"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa002.jf.intel.com with ESMTP; 29 Oct 2025 14:06:13 -0700
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
	Randy Dunlap <rdunlap@infradead.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: [PATCH v11 5/9] x86/efi: Disable LASS while mapping the EFI runtime services
Date: Wed, 29 Oct 2025 14:03:06 -0700
Message-ID: <20251029210310.1155449-6-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029210310.1155449-1-sohil.mehta@intel.com>
References: <20251029210310.1155449-1-sohil.mehta@intel.com>
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
lass_disable()/_enable() is not enough, because the AC flag only
controls data accesses, and not instruction fetches.

Use the big hammer and toggle the CR4.LASS bit to make this work.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v11:
 - No change.

v10:
 - Reword code comments
---
 arch/x86/platform/efi/efi.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 463b784499a8..ad9f76f90581 100644
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
+	 * is not sufficient, as it only permits data access and not
+	 * instruction fetch. Disable the entire LASS mechanism.
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


