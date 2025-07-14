Return-Path: <linux-efi+bounces-4327-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F60AB03C50
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 12:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B46CC3AF4FB
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 10:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F25424BD1A;
	Mon, 14 Jul 2025 10:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V/8m7iI2"
X-Original-To: linux-efi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5008246760;
	Mon, 14 Jul 2025 10:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752489910; cv=none; b=REPi3WbKioT8LGljNwui78YzbeiH9yN7/66XxwPp3mnTU9lCaJd33s645/JOTg5ZNftz5I/dH6l0zRjhZb+r5PChMy4HGn1A24VDSZlUGm5/ONzrUyl1kN267UentewuSWLrpKQEJhFRuSVCr4u1qpTAn1nNLswj1RnFb/nFMFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752489910; c=relaxed/simple;
	bh=yKbtX17Gsl+LUp9EplvxwQBzE47/NpOwaHXes4GDf9A=;
	h=Message-ID:Date:From:To:Cc:Subject; b=V6UHOmFBDYpMeeZghdoXUg0rSVvNj3CpcEUhUvMG354EcVi85shA7fe9uxoIxTaplQIE4j8WVECMTuub9xLoE8qHZGdF+8nKURFdFT5ZWo9mGn7f4SvkewUrqEbdZ/K2Yo88q6HC98n2VIRuUtLK5H4ZHEt5CyjYgExLN4VvNNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=V/8m7iI2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=v3sVyfMdYenshEDbJob5zx3C/Ry1yNj+xy9fwrGEZjg=; b=V/8m7iI2wpnO05bW1ntySOTtbz
	ARBNVcXMMYNcBPMnNkzSU0ZxM2WfunuvFNSo6dYA2lJEDbFR+vhq1mcssewhf50EB+OA5NoJuFuWT
	3EuCxQSq9FzzsJoA0QujIyh2tZH1cl5rfIJjo7m4q3xkrqxadQ2x/Ion/HaxuXRLyadexlgILFN8c
	1FU7G67hKHJhy1VjkyjA1DIBl8VRC90cqtKFrwDnUK1/aPk+pm1fVKhlprZIKhfZS497brN+7mFs/
	REdDugwHaDgoe7zL3Tg95eBZIvx3nGA5qw3sx/YaFRR0Sv0kb0od4C7xnRm8QnFLla/OOER04LaY1
	pQHpDztQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubGg0-00000006uK2-01vy;
	Mon, 14 Jul 2025 10:44:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id C80AA3001AA; Mon, 14 Jul 2025 12:44:50 +0200 (CEST)
Message-ID: <20250714102011.758008629@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 14 Jul 2025 12:20:11 +0200
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
Subject: [PATCH v3 00/16] objtool: Detect and warn about indirect calls in __nocfi functions
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>


Hi!

On kCFI (CONFIG_CFI_CLANG=y) builds all indirect calls should have the CFI
check on (with very few exceptions). Not having the CFI checks undermines the
protection provided by CFI and will make these sites candidates for people
wanting to steal your cookies.

Specifically the ABI changes are so that doing indirect calls without the CFI
magic, to a CFI adorned function is not compatible (although it happens to work
for some setups, it very much does not for FineIBT).

Rust people tripped over this the other day, since their 'core' happened to
have some no_sanitize(kcfi) bits in, which promptly exploded when ran with
FineIBT on.

Since this is very much not a supported model -- on purpose, have objtool
detect and warn about such constructs.

This effort [1] found all existing [2] non-cfi indirect calls in the kernel.

Notably the KVM fastop emulation stuff -- which is completely rewritten -- the
generated code doesn't look horrific, but is slightly more verbose. I'm running
on the assumption that instruction emulation is not super performance critical
these days of zero VM-exit VMs etc. Paolo noted that pre-Westmere (2010) cares
about this.

KVM has another; the VMX interrupt injection stuff calls the IDT handler
directly. This is rewritten to to use the FRED dispatch table, which moves it
all into C.

HyperV hypercall page stuff, which I've previously suggested use direct calls,
and which I've now converted (after getting properly annoyed with that code).

Also available at:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/core

Changes since v2:

 - renamed COP to EM_ASM
 - reworked the KVM-IDT stuff (Sean, Josh)

[1] https://lkml.kernel.org/r/20250410154556.GB9003@noisy.programming.kicks-ass.net
[2] https://lkml.kernel.org/r/20250410194334.GA3248459@google.com


