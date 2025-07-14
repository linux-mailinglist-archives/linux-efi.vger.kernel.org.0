Return-Path: <linux-efi+bounces-4319-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62517B03C32
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 12:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF6B07ADD0F
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 10:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8064F2475C8;
	Mon, 14 Jul 2025 10:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vw0v8/Qb"
X-Original-To: linux-efi@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7252845009;
	Mon, 14 Jul 2025 10:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752489908; cv=none; b=LB7ZkVndjYN00Vo0YTUflUvg58lw/Om1VC0EUmcwHFodOggYKptNq1CRcpHUbdRZO01/LdF7b/igm5EoBlfDubeOSm38LqIq+mJuamvHdbcTATKgb6ktcohZnNsMqo2htjHSbXGTQ9RPq8Wh1O4YxeOeVpZq2Q/1/ssR70oBqBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752489908; c=relaxed/simple;
	bh=vpKuQizapCMKqH9WA11ms5jc5OISD3N0+Dznv7nE1MM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=q7juthuc9VQxMnJUMfNGrYMj42hI+8+ue2PvLyASXaZmiG673SbA0JN//yYE9+8xz22dngo8tbZeYtDp+gXNPJB+HJjDyXs4QbW2J427cWPlYmdExoo0u1LzAZwiI0GK/Ss+0CDlp86BQZvyc9F35HTMzdcmzsXKtN/uWetCOJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Vw0v8/Qb; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=e4AF8GQacEV/iOhFocsW7bzZKWyP7FsAsEjPpw7Nh70=; b=Vw0v8/Qbvk3pA+yzNp3T5erRn8
	9U3n7yjcqOcL3jDyxibLBNo3oB35aTiYck29trmgT/TWR7hdFASz6QEtk+W+RI2tqJ4uxUXsukPZU
	zkUgGayQy9jRz7Jxcl1U9WzFIthSal8Uu6BkauxYH7qcet5qJc658oQrmutDfy3CPUv/k8urDsoKq
	nSFl+HUEiexUBhGx/qA3CDGsJuQ7WRIs9Sg8TO8cQvstMeOPSlgvzo6oYGhuMbsMYSAVEpMmcMTrV
	8OonnGIu5MPqfNWeTUdAMeCJBDpAHjFO80SD9Ly8OjhLHqwbKeZseoZuvDJlk/gxu+Vjbgt8BYhKM
	jGGIELkA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubGg1-00000009kck-0hxd;
	Mon, 14 Jul 2025 10:44:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id EDDD7302D50; Mon, 14 Jul 2025 12:44:50 +0200 (CEST)
Message-ID: <20250714103440.634145269@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 14 Jul 2025 12:20:20 +0200
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
Subject: [PATCH v3 09/16] x86/kvm/emulate: Convert em_salc() to C
References: <20250714102011.758008629@infradead.org>
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



