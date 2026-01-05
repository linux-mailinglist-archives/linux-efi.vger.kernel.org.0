Return-Path: <linux-efi+bounces-5935-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 876EDCF4055
	for <lists+linux-efi@lfdr.de>; Mon, 05 Jan 2026 15:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C3913043223
	for <lists+linux-efi@lfdr.de>; Mon,  5 Jan 2026 13:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7351531E0FA;
	Mon,  5 Jan 2026 13:59:13 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF622C2356
	for <linux-efi@vger.kernel.org>; Mon,  5 Jan 2026 13:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767621553; cv=none; b=GeUJWuCy5gLuc9UlWnbBlCS6kGtN/xnVTw7P67TCCSUlztUF3Oe2mdDXXCRxVGLjASqM93UOKbhWTkIGhPBoAYZFlDb4ctgjZP4Ti6c9fH0pqg2R/1dqp+g/kmjmsIQSMi3SpIj9FOjyfX/0cI20KCSJs2XBEHEMVxatIPfzGJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767621553; c=relaxed/simple;
	bh=T4NZTrjJD22Vm8zrPwd3SnsG84Y49Vkd1blIPpqgjcc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GPKWS4/ugZb7LyW44hBfr8swOZdL/dNRnpYqb/wjYhIz33RftHjs913HhGEYrEc56zrEDy3wkL34LndovSi5gLddxZ6d6OW79cROZMaYPVN6jj9qfBFZvni6vMbh4Fh3nedXIxCw1OtHXHGos+tcHOtg8B4cup+kLAYNuJNnVcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C44B2339;
	Mon,  5 Jan 2026 05:58:57 -0800 (PST)
Received: from e134344.cambridge.arm.com (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 28C743F6A8;
	Mon,  5 Jan 2026 05:59:03 -0800 (PST)
From: Ben Horgan <ben.horgan@arm.com>
To: ben.horgan@arm.com,
	linux-efi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: ardb@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	YeoReum.Yun@arm.com,
	Mark.Rutland@arm.com
Subject: [PATCH v1] arm64/efi: Don't fail check current_in_efi() if preemptible
Date: Mon,  5 Jan 2026 13:58:47 +0000
Message-ID: <20260105135847.1585034-1-ben.horgan@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As EFI runtime services can now be run without disabling preemption remove
the check for non preemptible in current_in_efi(). Without this change,
firmware errors that were previously recovered from by
__efi_runtime_kernel_fixup_exception() will lead to a kernel oops.

Fixes: a5baf582f4c0 ("arm64/efi: Call EFI runtime services without disabling preemption")
Signed-off-by: Ben Horgan <ben.horgan@arm.com>
---
On the partner platform I was testing on this issue caused the boot to fail.
---
 arch/arm64/include/asm/efi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index aa91165ca140..e8a9783235cb 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -45,7 +45,7 @@ void arch_efi_call_virt_teardown(void);
  * switching to the EFI runtime stack.
  */
 #define current_in_efi()						\
-	(!preemptible() && efi_rt_stack_top != NULL &&			\
+	(efi_rt_stack_top != NULL &&					\
 	 on_task_stack(current, READ_ONCE(efi_rt_stack_top[-1]), 1))
 
 #define ARCH_EFI_IRQ_FLAGS_MASK (PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT)
-- 
2.43.0


