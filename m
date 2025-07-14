Return-Path: <linux-efi+bounces-4316-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABCBB03C2B
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 12:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18ACA189EE43
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 10:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A797B244688;
	Mon, 14 Jul 2025 10:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KSXuacWx"
X-Original-To: linux-efi@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D134024467E;
	Mon, 14 Jul 2025 10:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752489907; cv=none; b=m7Jawxxl9FC6wuTaROkefdqoxYDdJ2SmB8YGajMtkrhXEgG4At5YuHt5SCCZ+xXxAW/XfwyqmGFIdxYrYhJtoWEBwXnIKakRnqXIxHOW4tRIGspYexc2+CD8VkWFc0XrNWF+nc3rg8qDkNW7yNXQFacLAeQ0Lb+MB4w4OHXAkrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752489907; c=relaxed/simple;
	bh=tuWqoc0GQbR2JTEQ+wVBO1amFPf+D71o88hvLaHFndU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Wc0V1F9Itp/dCeze0mDK0T49KM5pCaxky4bdtVYe5hffXI5Zu/ITiEoBFyp/Q8bajdSuCJ3P6oLdq3SPvWpBUJDbknw/dO4n0Ir9/8ULsyfgCFsCsYj8ZlU58vQ9/Ovwl/Porp8VSGjQ0RXPFGD3oT265VzcYwRDQrtJ2zQkPjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KSXuacWx; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=fy6j2Zut50EkLTl5aAIvm4GTA07w7XyXzsCJhihcPoI=; b=KSXuacWxkXt1D2/owpptiCy8Ys
	D3ujdk+OLSrRw8uTv5iuV6Q13KVK/FGuv2TMYi78KfcPea+tTzBtsf3h/WpQqsZNiYEHx7RQDip07
	ysiEd+8g9PwgS6FwSvna85L5D8bF6SuxTMjZhkjq4Iv5EyrbE0pKlBbmZSJRhfas7Uk4J7mGpKb2N
	TvSFYisclONYICygkzXlatLbgk0MZQKDiIqszYi1OODE7OtYvSmFRz+SLwnuYErnG4pa3llhDxOHl
	+r5nZv2gi7Ytg0H97FL7p/BRxO47lEN8+BZdArzx99vLL0YcPob7kTOC5OJPFb/IE6wyD5wa7Scu9
	mY8nkZhg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubGfz-00000009kcb-38bL;
	Mon, 14 Jul 2025 10:44:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id DA222300F1A; Mon, 14 Jul 2025 12:44:50 +0200 (CEST)
Message-ID: <20250714103440.024933524@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 14 Jul 2025 12:20:15 +0200
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
Subject: [PATCH v3 04/16] x86/kvm/emulate: Introduce EM_ASM_2R
References: <20250714102011.758008629@infradead.org>
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
 	ON64(case 8: __EM_ASM_2(op##q, rax, rdx); break;) \
 	EM_ASM_END
 
+/* 2-operand, reversed */
+#define EM_ASM_2R(op, name) \
+	EM_ASM_START(name) \
+	case 1: __EM_ASM_2(op##b, dl, al); break; \
+	case 2: __EM_ASM_2(op##w, dx, ax); break; \
+	case 4: __EM_ASM_2(op##l, edx, eax); break; \
+	ON64(case 8: __EM_ASM_2(op##q, rdx, rax); break;) \
+	EM_ASM_END
+
 /*
  * fastop functions have a special calling convention:
  *
@@ -1077,8 +1086,7 @@ FASTOP2W(bts);
 FASTOP2W(btr);
 FASTOP2W(btc);
 
-
-FASTOP2R(cmp, cmp_r);
+EM_ASM_2R(cmp, cmp_r);
 
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



