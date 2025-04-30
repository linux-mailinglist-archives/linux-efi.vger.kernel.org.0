Return-Path: <linux-efi+bounces-3499-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E55AA49D6
	for <lists+linux-efi@lfdr.de>; Wed, 30 Apr 2025 13:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E70121B601EB
	for <lists+linux-efi@lfdr.de>; Wed, 30 Apr 2025 11:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95E125A2AF;
	Wed, 30 Apr 2025 11:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kf2Oa9Fk"
X-Original-To: linux-efi@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8A723C4F0;
	Wed, 30 Apr 2025 11:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746012409; cv=none; b=HNlfjX1U1loqj01jqHTfKVC7r3cOt0KQQTLF+3FTwwSrwpeGXDC+VuetNDTtbeov5STw9/1mbx107d4Gogr5TJDP4J0Yqo8nG8HW1rjaT9IZi4KWD9G1KSDzstq9LpBJnKCjbeUbavLAI36UrmXCrJSbuJL585wO43dP/zoblh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746012409; c=relaxed/simple;
	bh=eQzveos7V6YekhCNUJfmy5Uijw7pmb96pIGn739anLw=;
	h=Message-ID:Date:From:To:Cc:Subject; b=j6NS93PTWIxj8AIuGG166DrRzCzgLlnmstgKJyoKPN/XNd/3Z1mlK0eTQV+tZ1SUg7RG55y4BhjhIhKZqEld9UQzaxNFv2XMXiAjkkgUQ6kaHrEyFZeZtFlSFQKNdY5PtjjpT4kqkzZcBSO9UDogE4cAPWBoSKnp0TrO3vcLK9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kf2Oa9Fk; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=2AJlI4hzJH/YytxNxCOspektBE6YxRuMLZiq6cwSDVg=; b=kf2Oa9FkSEyPf7OHxa3qWIYnYu
	OtU+aaa4qwZFCpkv6BTN+P6kY6sYG0CLTWu85Bswwe8UO3U9qV3RCCDRTkvkTDuVyCX5IHgZxibjO
	TdCi8zE85z33z8I6Oiy0h7yK5iDCoHE0Fbblz8smDRcK7CAcZiEtNNBCd8NPs2zMvYMvPP/OZ9AP/
	lD7I4N/5SlB4Tp1rV2H2pSXnP8JpCG0zCK1ClMFFVG8b7S/Ke/NGIC9ZoGNQgL9Mqq68vTWv1gP/H
	wOzINGON7MGnM59SffHiB71LhutClbLqXrfa00qsj4s3tAITI7jpGT906EmVV029i8DOd2N509sqc
	siTJixtw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uA5aG-0000000Dm7m-17XA;
	Wed, 30 Apr 2025 11:26:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id C62F4300642; Wed, 30 Apr 2025 13:26:35 +0200 (CEST)
Message-ID: <20250430110734.392235199@infradead.org>
User-Agent: quilt/0.66
Date: Wed, 30 Apr 2025 13:07:34 +0200
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
Subject: [PATCH v2 00/13] objtool: Detect and warn about indirect calls in __nocfi functions
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

Notably the KVM fastop emulation stuff -- which I've completely rewritten for
this version -- the generated code doesn't look horrific, but is slightly more
verbose. I'm running on the assumption that instruction emulation is not super
performance critical these days of zero VM-exit VMs etc.

KVM has another; the VMX interrupt injection stuff calls the IDT handler
directly.  Is there an alternative? Can we keep a table of Linux functions
slighly higher up the call stack (asm_\cfunc ?) and add CFI to those?

HyperV hypercall page stuff, which I've previously suggested use direct calls,
and which I've now converted (after getting properly annoyed with that code).

Also available at:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/core

Changes since v1:

 - complete rewrite of the fastop stuff
 - HyperV tweaks (Michael)
 - objtool changes (Josh)


[1] https://lkml.kernel.org/r/20250410154556.GB9003@noisy.programming.kicks-ass.net
[2] https://lkml.kernel.org/r/20250410194334.GA3248459@google.com


