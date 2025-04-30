Return-Path: <linux-efi+bounces-3497-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7365AA49C9
	for <lists+linux-efi@lfdr.de>; Wed, 30 Apr 2025 13:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4967B4E31C3
	for <lists+linux-efi@lfdr.de>; Wed, 30 Apr 2025 11:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAF82580FD;
	Wed, 30 Apr 2025 11:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ziwuczlz"
X-Original-To: linux-efi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5033C1F0984;
	Wed, 30 Apr 2025 11:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746012408; cv=none; b=aEg2hhOJvknablymrZPnMNFvxMl3hN1da/MEMDNE7+MlNPl71AIdhrfOrn5WyGaPZZCAaKIWOl3s7qtjZYV8vBr5j3hgemKgzIG1rXfsliWziTP51O9CiuwA/Bz+1TQpgJ488CzRIbNos9xg69YtGzkuUDVHxaBCoFlxvqoSExc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746012408; c=relaxed/simple;
	bh=iBm8Y1E/7H3HGUJT6kN14OnT4mmu+SMHRsgTsBGWXGI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=iofAHF2fsOiSk/oHHPURrj4i6g0OextXsJgfRMYPLH3iH46ayRp6xevmK00tLQ1R8dBqh5lK5fLJylrRydN/d2c/8/pIgmb/p5qlStpTQJRFD9DaYn2JtzjcgcxTkW5N1HqgyAcmqA8db7HKg0e0c39b2ZpRY+Rjf6QdTRJl2y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ziwuczlz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=mF7wwCYZMtUCn0kF704+nA6en6Dcv2ccdZkU2OGjtIw=; b=ZiwuczlzmaUS2jCJiINL7wkt+j
	T8oC8iZuM7E15F3Q7BbYcRsSQOZVN9XCoAHw5I+0Vg7CbmcOyfxBP5718fLqNqqumv2xF+jP+aQXZ
	pnDMhk8LXWgB2GDGYWLrdlAkkl3JP9SalFfAk8/1dHfm0FeKrMnLlKv96cfVmP3Qvo2lE+22yAGl9
	olAUt4oIG9Yfv2ThgRGPljwOh8gn3IF8C94ZSj1y8ku/D3lB/YTVJbUH6g/yBdOtDxSo2lui01dv8
	+R4ucnQ+ZCeB3LPw60gTOSwHilwR+qPJOkmFDcPapdTrNHYdTAUliQeQid+hrQM1RF88AjFOKyOn7
	lbb2TYIw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uA5aG-0000000C6Zv-12aF;
	Wed, 30 Apr 2025 11:26:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id D5CD7301150; Wed, 30 Apr 2025 13:26:35 +0200 (CEST)
Message-ID: <20250430112349.419161890@infradead.org>
User-Agent: quilt/0.66
Date: Wed, 30 Apr 2025 13:07:38 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org
Cc: kys@microsoft.com,
 haiyangz@microsoft.com,
 wei.liu@kernel.org,
 decui@microsoft.com,
 tglx@linutronix.de,
 mingo@redhat.com,
 bp@alien8.de,
 dave.hansen@linux.intel.com,
 hpa@zytor.com,
 seanjc@google.com,
 pbonzini@redhat.com,
 ardb@kernel.org,
 kees@kernel.org,
 Arnd Bergmann <arnd@arndb.de>,
 gregkh@linuxfoundation.org,
 jpoimboe@kernel.org,
 peterz@infradead.org,
 linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org,
 linux-efi@vger.kernel.org,
 samitolvanen@google.com,
 ojeda@kernel.org
Subject: [PATCH v2 04/13] x86/kvm/emulate: Introduce COP2R
References: <20250430110734.392235199@infradead.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Replace the FASTOP2R instruction.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kvm/emulate.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -326,6 +326,15 @@ static int em_##op(struct x86_emulate_ct
 	ON64(case 8: COP_ASM2(op##q, rax, rdx); break;) \
 	COP_END
 
+/* 2-operand, reversed */
+#define COP2R(op, name) \
+	COP_START(name) \
+	case 1: COP_ASM2(op##b, dl, al); break; \
+	case 2: COP_ASM2(op##w, dx, ax); break; \
+	case 4: COP_ASM2(op##l, edx, eax); break; \
+	ON64(case 8: COP_ASM2(op##q, rdx, rax); break;) \
+	COP_END
+
 /*
  * fastop functions have a special calling convention:
  *
@@ -1077,8 +1086,7 @@ FASTOP2W(bts);
 FASTOP2W(btr);
 FASTOP2W(btc);
 
-
-FASTOP2R(cmp, cmp_r);
+COP2R(cmp, cmp_r);
 
 static int em_bsf_c(struct x86_emulate_ctxt *ctxt)
 {
@@ -4336,12 +4344,12 @@ static const struct opcode opcode_table[
 	I2bv(DstAcc | SrcMem | Mov | MemAbs, em_mov),
 	I2bv(DstMem | SrcAcc | Mov | MemAbs | PageTable, em_mov),
 	I2bv(SrcSI | DstDI | Mov | String | TwoMemOp, em_mov),
-	F2bv(SrcSI | DstDI | String | NoWrite | TwoMemOp, em_cmp_r),
+	I2bv(SrcSI | DstDI | String | NoWrite | TwoMemOp, em_cmp_r),
 	/* 0xA8 - 0xAF */
 	I2bv(DstAcc | SrcImm | NoWrite, em_test),
 	I2bv(SrcAcc | DstDI | Mov | String, em_mov),
 	I2bv(SrcSI | DstAcc | Mov | String, em_mov),
-	F2bv(SrcAcc | DstDI | String | NoWrite, em_cmp_r),
+	I2bv(SrcAcc | DstDI | String | NoWrite, em_cmp_r),
 	/* 0xB0 - 0xB7 */
 	X8(I(ByteOp | DstReg | SrcImm | Mov, em_mov)),
 	/* 0xB8 - 0xBF */



