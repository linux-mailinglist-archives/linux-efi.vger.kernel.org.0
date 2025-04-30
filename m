Return-Path: <linux-efi+bounces-3496-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB9FAA49C6
	for <lists+linux-efi@lfdr.de>; Wed, 30 Apr 2025 13:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE5484E32E5
	for <lists+linux-efi@lfdr.de>; Wed, 30 Apr 2025 11:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCA225228B;
	Wed, 30 Apr 2025 11:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tr601hlE"
X-Original-To: linux-efi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC381DE2A4;
	Wed, 30 Apr 2025 11:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746012408; cv=none; b=L8Ky7054r56fd1AFxHXZLXjqI+qUEv048yw7ZVrtT+7SuVOu3LhUObmO/YlvaSyxNeFC041ncJ6l5sFqvXVcFDHZW7obkplwiI5BPfllpiNm2xmzZLvJf2oqdBD35SwYCP0IW7iUK/lzgdBkYb5ogdtCJQbqNX0ic9RXOpSdHFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746012408; c=relaxed/simple;
	bh=vpKuQizapCMKqH9WA11ms5jc5OISD3N0+Dznv7nE1MM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ZZxviFznUF7r3qQJzWz8cpsw9EmUmWPnfBf3rvjwem2/J14rTZHLldFw8UzhZ5Bppqrfm1M2BLvRghTcWJoTBxBzcIj8YlWanel5B4QhkEO0PblxSDcZuoY0fBxOgE18Wodn9iYpn5RVSulCTU6s0FLst0GQZSnx6lUtok99AUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tr601hlE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=e4AF8GQacEV/iOhFocsW7bzZKWyP7FsAsEjPpw7Nh70=; b=tr601hlExqdVHsAm1ZyrbgR4gL
	B6q9+8YRnqXLpJJnvkWNR2kl5t7t4bzp/E8niAF0V9IntOTx1VnA6EQQlfHava3TsTgpa4C96BUaf
	xmV8SpwsinHszs8VV7U7Z/HI79XcTg5NF6H6t8Jl9+0W/CqMLxjIELVSo6R2JN4agQ+kH+28avdHo
	e6CV3p7tY+QjN53YCGAr3kb4B609TuY66KcsC9wsfhXbH09CTDMuRHNuD7nqE3tpXVPyUUVCRaaFl
	oQJLQNZL0pDHHWTHaB/RjDDuCLTmxzeXaBa2/ndwqOeiDV/Hl2fCNZIBVRHeRK1857yIjTGbNqYM1
	s4T1GCUQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uA5aH-0000000C6a7-04pg;
	Wed, 30 Apr 2025 11:26:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id E7BB73080C5; Wed, 30 Apr 2025 13:26:35 +0200 (CEST)
Message-ID: <20250430112349.963740147@infradead.org>
User-Agent: quilt/0.66
Date: Wed, 30 Apr 2025 13:07:43 +0200
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
Subject: [PATCH v2 09/13] x86/kvm/emulate: Convert em_salc() to C
References: <20250430110734.392235199@infradead.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Implement the SALC (Set AL if Carry) instruction in C.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kvm/emulate.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -529,11 +529,14 @@ static int fastop(struct x86_emulate_ctx
 	ON64(FOP3E(op##q, rax, rdx, cl)) \
 	FOP_END
 
-FOP_START(salc)
-FOP_FUNC(salc)
-"pushf; sbb %al, %al; popf \n\t"
-FOP_RET(salc)
-FOP_END;
+static int em_salc(struct x86_emulate_ctxt *ctxt)
+{
+	/*
+	 * Set AL 0xFF if CF is set, or 0x00 when clear.
+	 */
+	ctxt->dst.val = 0xFF * !!(ctxt->eflags & X86_EFLAGS_CF);
+	return X86EMUL_CONTINUE;
+}
 
 /*
  * XXX: inoutclob user must know where the argument is being expanded.
@@ -4423,7 +4426,7 @@ static const struct opcode opcode_table[
 	G(Src2CL | ByteOp, group2), G(Src2CL, group2),
 	I(DstAcc | SrcImmUByte | No64, em_aam),
 	I(DstAcc | SrcImmUByte | No64, em_aad),
-	F(DstAcc | ByteOp | No64, em_salc),
+	I(DstAcc | ByteOp | No64, em_salc),
 	I(DstAcc | SrcXLat | ByteOp, em_mov),
 	/* 0xD8 - 0xDF */
 	N, E(0, &escape_d9), N, E(0, &escape_db), N, E(0, &escape_dd), N, N,



