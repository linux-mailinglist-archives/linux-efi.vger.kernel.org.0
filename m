Return-Path: <linux-efi+bounces-3500-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E5AAA49D2
	for <lists+linux-efi@lfdr.de>; Wed, 30 Apr 2025 13:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16B939C0559
	for <lists+linux-efi@lfdr.de>; Wed, 30 Apr 2025 11:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D41525A2C9;
	Wed, 30 Apr 2025 11:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PdEKVnFT"
X-Original-To: linux-efi@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7918238171;
	Wed, 30 Apr 2025 11:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746012409; cv=none; b=eKyLV6liWDNcWITnG9Emm29DdhLMC2O27jPajmQemzp4PWRhJvZbFMUB7JdKhnz80xgv76d3zRYqsVK+fl2rjyd/89mz6OdCMFYypp/4k5djGGbBHpXlrQSfUsBBGmKFovI697laKxqlAYjpO1ZoSli6VyQtVpweVxFy+4SzZfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746012409; c=relaxed/simple;
	bh=iy74pMiqFQ9A70eRBzWcq+Z/PM5B/ScXQmxmFRSa63k=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=RpRSQ8ROt6uRPtf3XFqB9Iq2fTlQFQ/75908viKv46349n+fsxaTAyCRq/xDsAu1CPFaOKkGsNJfs9ZwrDxn2AqRviARigSA5kAdPPOA+g6XrPua9hItRhe24qujdvBg+V31WZlhyDVAQU0EKu6fxK0D0FMgMHalDLdRvKTJ+cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PdEKVnFT; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=ApnWKpIB65Vl54zlJrOsr0YOMRYeS7E3a7J3fKNYWYk=; b=PdEKVnFTK/FNHyx0opbCC1hBaC
	gvGnfJkFcKFzVfx949iAotfLnfrxwuXKGJdj+/XkHh2y41lIV9pOAMDBvS8X0IRhTkjwKj8QlZtUE
	rS+2wTewuvQMC4TwhQmcFx60lrnUfmEUvEGQRZNSzY2hSn58Xvpfhh5exQnZjVpPQTa0GYwu2ECSn
	5sWTGl8eNDpJQwsBtqSYP/cuUngUnlSvaQlx95vlQ9sPVztQJWIP3Do17z6oOeiukfIsKlJbyCjhk
	3u1FKeb7fzZh8zTv8wviU4cyrYypbVJhmnEjVBo/oG7wRJuSuKDZ4qapxO2LcVWoACTjE9WkiCE+V
	adUcceYA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uA5aH-0000000Dm7x-00KN;
	Wed, 30 Apr 2025 11:26:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id DCD0A301D03; Wed, 30 Apr 2025 13:26:35 +0200 (CEST)
Message-ID: <20250430112349.639363816@infradead.org>
User-Agent: quilt/0.66
Date: Wed, 30 Apr 2025 13:07:40 +0200
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
Subject: [PATCH v2 06/13] x86/kvm/emulate: Introduce COP2CL
References: <20250430110734.392235199@infradead.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Replace the FASTOP2CL instructions.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kvm/emulate.c |   39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -344,6 +344,15 @@ static int em_##op(struct x86_emulate_ct
 	ON64(case 8: COP_ASM2(op##q, rax, rdx); break;) \
 	COP_END
 
+/* 2-operand, using "a" (dst) and CL (src2) */
+#define COP2CL(op) \
+	COP_START(op) \
+	case 1: COP_ASM2(op##b, al, cl); break; \
+	case 2: COP_ASM2(op##w, ax, cl); break; \
+	case 4: COP_ASM2(op##l, eax, cl); break; \
+	ON64(case 8: COP_ASM2(op##q, rax, cl); break;) \
+	COP_END
+
 /*
  * fastop functions have a special calling convention:
  *
@@ -1080,13 +1089,13 @@ COP1(neg);
 COP1(inc);
 COP1(dec);
 
-FASTOP2CL(rol);
-FASTOP2CL(ror);
-FASTOP2CL(rcl);
-FASTOP2CL(rcr);
-FASTOP2CL(shl);
-FASTOP2CL(shr);
-FASTOP2CL(sar);
+COP2CL(rol);
+COP2CL(ror);
+COP2CL(rcl);
+COP2CL(rcr);
+COP2CL(shl);
+COP2CL(shr);
+COP2CL(sar);
 
 COP2W(bsf);
 COP2W(bsr);
@@ -4079,14 +4088,14 @@ static const struct opcode group1A[] = {
 };
 
 static const struct opcode group2[] = {
-	F(DstMem | ModRM, em_rol),
-	F(DstMem | ModRM, em_ror),
-	F(DstMem | ModRM, em_rcl),
-	F(DstMem | ModRM, em_rcr),
-	F(DstMem | ModRM, em_shl),
-	F(DstMem | ModRM, em_shr),
-	F(DstMem | ModRM, em_shl),
-	F(DstMem | ModRM, em_sar),
+	I(DstMem | ModRM, em_rol),
+	I(DstMem | ModRM, em_ror),
+	I(DstMem | ModRM, em_rcl),
+	I(DstMem | ModRM, em_rcr),
+	I(DstMem | ModRM, em_shl),
+	I(DstMem | ModRM, em_shr),
+	I(DstMem | ModRM, em_shl),
+	I(DstMem | ModRM, em_sar),
 };
 
 static const struct opcode group3[] = {



