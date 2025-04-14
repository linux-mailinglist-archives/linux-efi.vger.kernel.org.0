Return-Path: <linux-efi+bounces-3321-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 723B4A87F47
	for <lists+linux-efi@lfdr.de>; Mon, 14 Apr 2025 13:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D51C17511E
	for <lists+linux-efi@lfdr.de>; Mon, 14 Apr 2025 11:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044DE29AAFE;
	Mon, 14 Apr 2025 11:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YUYVQxaQ"
X-Original-To: linux-efi@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E752980DE;
	Mon, 14 Apr 2025 11:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744630779; cv=none; b=tSIZZkhwXYLpvFlDWDhfYeKKtuTwDHH75vzsBDAcOYwtIVh3rEiSPNWZcpwM4xuWTrKA+prXqFOlUZOHBt/O3QFWLjrc+2cB8u+konhxe9j0QIOl18fWsOn/wx0IN94iCby6BUCdx6SGfaKdR+3RPzJdrdVUFWL7TpwrPq9EmpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744630779; c=relaxed/simple;
	bh=lRCfpEWr6FyeoSTNoSc1ykFd37libaQ5cGVO+AdnIIA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=EHGajNHc+CHvTeT3A+bhlYluXrtE0DqMIoTUfJyDgFcYj76wc6FDaJWDLhqjuDonqmQTwYB/h4kzYm5bXIDUHW8UzXfVtjB2DUXEkHXzSMjI8yXzEGBWSb39kzBKD0ZKAHLkOY0XuOuG/W1Up1WlbFjylgyetpblkIZKgh2obQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YUYVQxaQ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=Dj6T/Jzv/d0QgHw5px9ErimwTM5Cy5tazeBNo6pdwA4=; b=YUYVQxaQ04j2kqhtvYg1juI5/D
	y3iKQut6w32ZCk3jIEKEGy7DwzW/ThMS/5AjFHPPCXOFTc28QKTvickSHBC9gsnyO9EXLN9tfoXoh
	ASJjtyzOVAxkDQdjFUG23eSxpDP9Zv9mMnGL8sGPfLKNu9k+mcNQYcGoCZNjAiuxBRH3bmpxLI8Jk
	vS5zgeTA6bpFWOjAhX5HExz5lBb/TMjMv2dB0RM+Yq363Vpm6CMPPAIR/XHqZAF/i4tY+MCl3M/CL
	c0AzZO0FE+KOjR8m7xGetXJoyFEonJ+OwQvZZpCnkUp500h06K6/EmAH+vUmxwpAUW5SggEZPavXa
	/MAvNkXw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u4I9u-00000009fKh-3UyO;
	Mon, 14 Apr 2025 11:39:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 269973007A4; Mon, 14 Apr 2025 13:39:26 +0200 (CEST)
Message-ID: <20250414113753.951654151@infradead.org>
User-Agent: quilt/0.66
Date: Mon, 14 Apr 2025 13:11:41 +0200
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
 peterz@infradead.org,
 jpoimboe@kernel.org,
 pawan.kumar.gupta@linux.intel.com,
 seanjc@google.com,
 pbonzini@redhat.com,
 ardb@kernel.org,
 kees@kernel.org,
 Arnd Bergmann <arnd@arndb.de>,
 gregkh@linuxfoundation.org,
 linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org,
 linux-efi@vger.kernel.org,
 samitolvanen@google.com,
 ojeda@kernel.org
Subject: [PATCH 1/6] x86/nospec: JMP_NOSPEC
References: <20250414111140.586315004@infradead.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/nospec-branch.h |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -438,6 +438,9 @@ static inline void call_depth_return_thu
 #define CALL_NOSPEC	__CS_PREFIX("%V[thunk_target]")	\
 			"call __x86_indirect_thunk_%V[thunk_target]\n"
 
+#define JMP_NOSPEC	__CS_PREFIX("%V[thunk_target]")	\
+			"jmp __x86_indirect_thunk_%V[thunk_target]\n"
+
 # define THUNK_TARGET(addr) [thunk_target] "r" (addr)
 
 #else /* CONFIG_X86_32 */
@@ -468,10 +471,31 @@ static inline void call_depth_return_thu
 	"call *%[thunk_target]\n",				\
 	X86_FEATURE_RETPOLINE_LFENCE)
 
+# define JMP_NOSPEC						\
+	ALTERNATIVE_2(						\
+	ANNOTATE_RETPOLINE_SAFE					\
+	"jmp *%[thunk_target]\n",				\
+	"       jmp    901f;\n"					\
+	"       .align 16\n"					\
+	"901:	call   903f;\n"					\
+	"902:	pause;\n"					\
+	"       lfence;\n"					\
+	"       jmp    902b;\n"					\
+	"       .align 16\n"					\
+	"903:	lea    4(%%esp), %%esp;\n"			\
+	"       pushl  %[thunk_target];\n"			\
+	"       ret;\n",					\
+	X86_FEATURE_RETPOLINE,					\
+	"lfence;\n"						\
+	ANNOTATE_RETPOLINE_SAFE					\
+	"jmp *%[thunk_target]\n",				\
+	X86_FEATURE_RETPOLINE_LFENCE)
+
 # define THUNK_TARGET(addr) [thunk_target] "rm" (addr)
 #endif
 #else /* No retpoline for C / inline asm */
 # define CALL_NOSPEC "call *%[thunk_target]\n"
+# define JMP_NOSPEC "jmp *%[thunk_target]\n"
 # define THUNK_TARGET(addr) [thunk_target] "rm" (addr)
 #endif
 



