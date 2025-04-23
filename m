Return-Path: <linux-efi+bounces-3426-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23884A98181
	for <lists+linux-efi@lfdr.de>; Wed, 23 Apr 2025 09:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 933427A6496
	for <lists+linux-efi@lfdr.de>; Wed, 23 Apr 2025 07:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D460D266B71;
	Wed, 23 Apr 2025 07:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qXld7wyZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tQWH0pm4"
X-Original-To: linux-efi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF851F4171;
	Wed, 23 Apr 2025 07:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745394485; cv=none; b=FveWindI8s++jYAB0esx8F4vAg0gu6z8wcXv8iHfmzptQA32Ko2O+nfLNMsW84sYeronyk9uM7xUdsTHp1x9i9iyaP1YR+QZba52sYv/VZLAzLh21f/V/ylMbCf4GqrodSWALbXKGq46l0ii1dBSC5MmOMTKzOFb/RWNPTcxeiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745394485; c=relaxed/simple;
	bh=ZCq9kT5F1hlUKckchQHoUy3rpJpJ6Erjv1VBOGMNspU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=obax4Jj2/VAtQcJZweUpJ+KnnX9mBgTnL+Q1V2rZjFEb3NRQ53A0CUlqcHpntFHCcIUNl9BLvnfcZpMTAtuzZw3Vgzd1bxbbX1N2uw7bOPzOmTvaZ2ptOjjmbq/JDSaycCsEkcE0C/isGAvjaIupKRZRzAt/PRCOjmDr5oNVj3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qXld7wyZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tQWH0pm4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 23 Apr 2025 07:48:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745394482;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EhtksW+UkwY1zWbbWhaQ5zWYA23x0Jq2UsBmThTPVX8=;
	b=qXld7wyZsv28HIyrjqQCTQznKRiR4+qR+XWyT0fTRi69n00VxgwJ3frhkpHEbMzvvOa59z
	fWsPKya0sU2EBzzOhcVP6END6oJ4ncNwu+qm8ceiGJ0QK8YxrC+OcT6Pv1byg/d363ctE0
	ox4K9gW1TRORM0pREmOhWTLY2dpqKKQc2rrh92hzdtRj1xMMyjk1fVsthqfc+/w7H8oQaN
	rJ8ROgXLXxMt98PGmxYggFeXQ7eq15dg4ZMLXE7mkYqcXXXzsTii7flAOenY9bTRPmR4QN
	wpPIUy3mOLJLkiLz3vdWkrTyjXjuwjJEXakuOL7Eb79eK8GcgLxQkzgANLQKsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745394482;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EhtksW+UkwY1zWbbWhaQ5zWYA23x0Jq2UsBmThTPVX8=;
	b=tQWH0pm4n1pLquYm5w/zCe2cOGjcyAA/inr9rO5bZid/UojYnEEtz9r9fvUk1dEH42Dihx
	M8E869xhi5wR4vCQ==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot: Disable jump tables in PIC code
Cc: Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-efi@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250422210510.600354-2-ardb+git@google.com>
References: <20250422210510.600354-2-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174539448176.31282.2929835259793717594.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     121c335b36e02d6aefb72501186e060474fdf33c
Gitweb:        https://git.kernel.org/tip/121c335b36e02d6aefb72501186e060474fdf33c
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Tue, 22 Apr 2025 23:05:11 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 23 Apr 2025 09:30:57 +02:00

x86/boot: Disable jump tables in PIC code

objtool already struggles to identify jump tables correctly in non-PIC
code, where the idiom is something like

  jmpq  *table(,%idx,8)

and the table is a list of absolute addresses of jump targets.

When using -fPIC, both the table reference as well as the jump targets
are emitted in a RIP-relative manner, resulting in something like

  leaq    table(%rip), %tbl
  movslq  (%tbl,%idx,4), %offset
  addq    %offset, %tbl
  jmpq    *%tbl

and the table is a list of offsets of the jump targets relative to the
start of the entire table.

Considering that this sequence of instructions can be interleaved with
other instructions that have nothing to do with the jump table in
question, it is extremely difficult to infer the control flow by
deriving the jump targets from the indirect jump, the location of the
table and the relative offsets it contains.

So let's not bother and disable jump tables for code built with -fPIC
under arch/x86/boot/startup.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-efi@vger.kernel.org
Link: https://lore.kernel.org/r/20250422210510.600354-2-ardb+git@google.com
---
 arch/x86/boot/startup/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
index 21d911b..b514f7e 100644
--- a/arch/x86/boot/startup/Makefile
+++ b/arch/x86/boot/startup/Makefile
@@ -5,6 +5,7 @@ KBUILD_CFLAGS		+= -D__DISABLE_EXPORTS -mcmodel=small -fPIC \
 			   -Os -DDISABLE_BRANCH_PROFILING \
 			   $(DISABLE_STACKLEAK_PLUGIN) \
 			   -fno-stack-protector -D__NO_FORTIFY \
+			   -fno-jump-tables \
 			   -include $(srctree)/include/linux/hidden.h
 
 # disable ftrace hooks and LTO

