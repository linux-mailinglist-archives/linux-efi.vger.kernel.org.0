Return-Path: <linux-efi+bounces-3325-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5097A87F5A
	for <lists+linux-efi@lfdr.de>; Mon, 14 Apr 2025 13:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42B16176007
	for <lists+linux-efi@lfdr.de>; Mon, 14 Apr 2025 11:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD98E2BE7DB;
	Mon, 14 Apr 2025 11:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bG92G56O"
X-Original-To: linux-efi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBF529CB4E;
	Mon, 14 Apr 2025 11:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744630782; cv=none; b=oD99ta3U7E14nJO+xUMNES1ar5NAkTjaWbly10rTFbaZfaHyr68k83rSU05i5DHZ6U+3jWXHWbXOm+NBbPZ0jt6SVRgDg9RlqHLOzYpN4WpoiwKsyPJOMfDWkqyqgrV1kGwwaNcr7dC2p1n+3/SrJvYmyis/7/xDzXsX7LyIos4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744630782; c=relaxed/simple;
	bh=6J3jpg6mZS1i6MwpK5znANzetPA7TPZoqiKkCd+kiGs=;
	h=Message-ID:Date:From:To:Cc:Subject; b=Z0HUCFi9UgLQ7CUltVcGTaeR3HtiAigvQeN03a7dleTZOua1VDl94xAesKoNy1YOA9aFhHScg34RftnVgSzfTXAchfEUqDelf0m/1V8cdU7BVazrq9B2rrgU7tCZXrs11D1x889h/9u1sT0gucNRGQfh49a2rAVJh1QeKy9oMyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bG92G56O; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=6J3jpg6mZS1i6MwpK5znANzetPA7TPZoqiKkCd+kiGs=; b=bG92G56OhWUV0ZKtc5qpU+fvvw
	hkUgSGIXatqQm4Oguw2ZlsCnzCRrNU4q0WRuBWdxEqxrgt2cQcag8yPkAhzNbU+f6rHfAmtKdIM0H
	BViuvEFjm+ZkIVYkYydg5RbgUaRQZaoHzkMJxfptl+gL2A+U34EW36N7kto23WaM76f9b/yYcB2RU
	zsXQgG5XcpNzVetyPLw9JN1uvb2zyk/8rvs/msRzAbkhny2t8Z9rC0P08VBEkRDTzUuTzvGdwNWpP
	oc2x5IM5697z1dGNlZ5ye6BJlTKwSfPBANNfZKJY1aLhCkyE7igOctawyqGzYVcb5nCkAF7o9RZ16
	LQHcbSrQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4I9u-000000084Gt-0pkr;
	Mon, 14 Apr 2025 11:39:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 226A8300619; Mon, 14 Apr 2025 13:39:26 +0200 (CEST)
Message-ID: <20250414111140.586315004@infradead.org>
User-Agent: quilt/0.66
Date: Mon, 14 Apr 2025 13:11:40 +0200
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
Subject: [PATCH 0/6] objtool: Detect and warn about indirect calls in __nocfi functions
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

This effort [1] found all existins [2] non-cfi indirect calls in the kernel.

Notably the KVM fastop emulation stuff -- which reminded me I still had pending
patches there. Included here since they reduce the amount of fastop call sites,
and the final patch includes an annotation for that. Although ideally we should
look at means of doing fastops differently.

KVM has another; the interrupt injection stuff calls the IDT handler directly.
Is there an alternative? Can we keep a table of Linux functions slighly higher
up the call stack (asm_\cfunc ?) and add CFI to those?

HyperV hypercall page stuff, which I've previously suggested use direct calls,
and which I've now converted (after getting properly annoyed with that code).


[1] https://lkml.kernel.org/r/20250410154556.GB9003@noisy.programming.kicks-ass.net
[2] https://lkml.kernel.org/r/20250410194334.GA3248459@google.com



