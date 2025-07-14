Return-Path: <linux-efi+bounces-4322-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 326BCB03C3A
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 12:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FC79189F2F4
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 10:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED95E248867;
	Mon, 14 Jul 2025 10:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RWhND9nE"
X-Original-To: linux-efi@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F591EF38F;
	Mon, 14 Jul 2025 10:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752489908; cv=none; b=W3My2BGpepvGawReLrRTqnJU/iU9WVMLZdVX3Sutj6eLcoL3WcLFSzqoW6o83idHQONmPvrEUND4jYr+crGdJg2NpCBkVMi+3d7H7zAQktOavoq1wo8wj3Znk54Djan24hsasucV5a6WOF8V/NaM8g2744h5jz8cCI2w2vrIhwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752489908; c=relaxed/simple;
	bh=stTTWQ2PrnQ5pWJsZvXWpLEwFy8R389SiRh7T6dqJ9M=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=mbip/gVHumabJbd8nc6dDgBLKRrJW1rBv5M053VVeRPODEqkofG8fLo1QrS1y0d7gaqwu61stQvlAYCHj8zDmQwGyTLvSxmMBu9379whxJAun7y4ScL+TqlkGIskPYdLAHpE8pZu3Gps0WpJvLbyISXsdjdJ/JGPwXNpsyf75zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RWhND9nE; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=16Q2GjdSSsv4jMqrK08IswOlebpDVF3OJKCNgU2VGgI=; b=RWhND9nEVSv7C0Zf9o/T0zY6uM
	XgxZnIWWTix00DPc/6ZdQG8WelG9tLmHM8HvUU5Ia7TqEZctrdgqDzGyaX7r1FU1VbQ7Bus6J0eri
	hDncwt6VhrLBLI2jhgWF0dpOieev2fNc3dHpj2AnypKp8vE6B0K9UtyCq+TbKmBsKQTEmDBsAAYae
	NhpAH4Socj5jp7VcSLyt4sZCKZMHhHVvNuk0bRwJ6r1MiywZSM3AWyNkLDTmbFgH6WtgcbdgEWHxx
	OHBiyUB4lSa73pU5CQNcEcCHiwrOE2J4LDwcllRgS0d64v02TyECKn4KUb5WNU0ABu46xnNVFza06
	TjHsAgQA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubGg0-00000009kci-27YT;
	Mon, 14 Jul 2025 10:44:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id E60A9302D3E; Mon, 14 Jul 2025 12:44:50 +0200 (CEST)
Message-ID: <20250714103440.394654786@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 14 Jul 2025 12:20:18 +0200
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
Subject: [PATCH v3 07/16] x86/kvm/emulate: Introduce EM_ASM_1SRC2
References: <20250714102011.758008629@infradead.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Replace the FASTOP1SRC2*() instructions.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kvm/emulate.c |   34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -317,6 +317,24 @@ static int em_##op(struct x86_emulate_ct
 	ON64(case 8: __EM_ASM_1(op##q, rax); break;) \
 	EM_ASM_END
 
+/* 1-operand, using "c" (src2) */
+#define EM_ASM_1SRC2(op, name) \
+	EM_ASM_START(name) \
+	case 1: __EM_ASM_1(op##b, cl); break; \
+	case 2: __EM_ASM_1(op##w, cx); break; \
+	case 4: __EM_ASM_1(op##l, ecx); break; \
+	ON64(case 8: __EM_ASM_1(op##q, rcx); break;) \
+	EM_ASM_END
+
+/* 1-operand, using "c" (src2) with exception */
+#define EM_ASM_1SRC2EX(op, name) \
+	EM_ASM_START(name) \
+	case 1: __EM_ASM_1_EX(op##b, cl); break; \
+	case 2: __EM_ASM_1_EX(op##w, cx); break; \
+	case 4: __EM_ASM_1_EX(op##l, ecx); break; \
+	ON64(case 8: __EM_ASM_1(op##q, rcx); break;) \
+	EM_ASM_END
+
 /* 2-operand, using "a" (dst), "d" (src) */
 #define EM_ASM_2(op) \
 	EM_ASM_START(op) \
@@ -1074,10 +1092,10 @@ EM_ASM_2(cmp);
 EM_ASM_2(test);
 EM_ASM_2(xadd);
 
-FASTOP1SRC2(mul, mul_ex);
-FASTOP1SRC2(imul, imul_ex);
-FASTOP1SRC2EX(div, div_ex);
-FASTOP1SRC2EX(idiv, idiv_ex);
+EM_ASM_1SRC2(mul, mul_ex);
+EM_ASM_1SRC2(imul, imul_ex);
+EM_ASM_1SRC2EX(div, div_ex);
+EM_ASM_1SRC2EX(idiv, idiv_ex);
 
 FASTOP3WCL(shld);
 FASTOP3WCL(shrd);
@@ -4103,10 +4121,10 @@ static const struct opcode group3[] = {
 	I(DstMem | SrcImm | NoWrite, em_test),
 	I(DstMem | SrcNone | Lock, em_not),
 	I(DstMem | SrcNone | Lock, em_neg),
-	F(DstXacc | Src2Mem, em_mul_ex),
-	F(DstXacc | Src2Mem, em_imul_ex),
-	F(DstXacc | Src2Mem, em_div_ex),
-	F(DstXacc | Src2Mem, em_idiv_ex),
+	I(DstXacc | Src2Mem, em_mul_ex),
+	I(DstXacc | Src2Mem, em_imul_ex),
+	I(DstXacc | Src2Mem, em_div_ex),
+	I(DstXacc | Src2Mem, em_idiv_ex),
 };
 
 static const struct opcode group4[] = {



