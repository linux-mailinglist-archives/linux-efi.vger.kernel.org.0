Return-Path: <linux-efi+bounces-3513-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95177AA5462
	for <lists+linux-efi@lfdr.de>; Wed, 30 Apr 2025 21:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 389161BC7F0E
	for <lists+linux-efi@lfdr.de>; Wed, 30 Apr 2025 19:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75111D5CD7;
	Wed, 30 Apr 2025 19:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b6yvpT8q"
X-Original-To: linux-efi@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD171E1E0C;
	Wed, 30 Apr 2025 19:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746039829; cv=none; b=mckWoyLrzDWwL3UzDUuUOT9BoA6MY36XsS2rbWAoDO1dFxGltYQtmnix9shdpANH+/avjTGA3Vq3+H5Yn2wFZqsAvUCzIhaE48crYbPG+/F17jqwVKIBmQs3j323sEMFK2XsEsUJCNwIaODHl1yOPHZ4NvIS4D97X8gD/08frgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746039829; c=relaxed/simple;
	bh=7PlAl5GrsC56vg7MmjldnKQvgVZMamAl/DYAPIwwgdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qcOjSQTGqRrhytjBOHSRXVNitLD17bq8EimyzydqjhfyTlYqvJBLKbQK/+bbsuPbpZhXKVn0YWctAnwRij54cBNNAXGndzBKQ+Pe/TiKA+H2pBFnUgjuVfWzhrE1bGewYOIUxkNunLA7D5bBXvb+DxBqkEnmuTI6Uvgv90MR7ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=b6yvpT8q; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4eoS1/JAdmLl2q5sTbw4/3ulNP/0LFxVs4HLw+j+3nY=; b=b6yvpT8qjSWgIETd+HWyaFKyRU
	GkQfulCHdD95orhMFtJowoz4ejB+4yvZxu2zBb4bVIHhjv9f5nn5i8SzGBJLDwNafuRLu0LSo4blF
	07ul778ewuftqGYQSK8vdZPG1Q+2YqukAPT+MRPAbvjUZkT+Nl7cpsjV8tv7eB7q0VdkQKq2bCAlk
	d2R/TjPnNt6Dhv1/XyvCjWEMPzbYy2U5yq7MzioVwr2XU++22Z4G7qirbegL0HwTtcbfjwGcIap62
	53atdozDyM9o6OiLBpAWvkWHKU7J9yski8Q8v9W831s2oNjSk7GgglmOKHRum1Qg0r0U8F8xwhHoN
	m6mmdaJw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uACiP-0000000DpFF-3wgw;
	Wed, 30 Apr 2025 19:03:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 30285300642; Wed, 30 Apr 2025 21:03:29 +0200 (CEST)
Date: Wed, 30 Apr 2025 21:03:28 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, seanjc@google.com, pbonzini@redhat.com,
	ardb@kernel.org, kees@kernel.org, Arnd Bergmann <arnd@arndb.de>,
	gregkh@linuxfoundation.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-efi@vger.kernel.org, samitolvanen@google.com,
	ojeda@kernel.org
Subject: Re: [PATCH v2 13/13] objtool: Validate kCFI calls
Message-ID: <20250430190328.GO4439@noisy.programming.kicks-ass.net>
References: <20250430110734.392235199@infradead.org>
 <20250430112350.443414861@infradead.org>
 <u4v64j3wgdml5zkij43lcksknhpoaqs3jmrm5udejrg75dl2ny@x4jexlz64amd>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <u4v64j3wgdml5zkij43lcksknhpoaqs3jmrm5udejrg75dl2ny@x4jexlz64amd>

On Wed, Apr 30, 2025 at 08:59:53AM -0700, Josh Poimboeuf wrote:
> On Wed, Apr 30, 2025 at 01:07:47PM +0200, Peter Zijlstra wrote:
> > +	case ANNOTYPE_NOCFI:
> > +		sym = insn->sym;
> > +		if (!sym) {
> > +			ERROR_INSN(insn, "dodgy NOCFI annotation");
> > +			break;
> 
> return -1;

Oh right.

> > +	/*
> > +	 * kCFI call sites look like:
> > +	 *
> > +	 *     movl $(-0x12345678), %r10d
> > +	 *     addl -4(%r11), %r10d
> > +	 *     jz 1f
> > +	 *     ud2
> > +	 *  1: cs call __x86_indirect_thunk_r11
> > +	 *
> > +	 * Verify all indirect calls are kCFI adorned by checking for the
> > +	 * UD2. Notably, doing __nocfi calls to regular (cfi) functions is
> > +	 * broken.
> > +	 */
> > +	list_for_each_entry(insn, &file->retpoline_call_list, call_node) {
> > +		struct symbol *sym = insn->sym;
> > +
> > +		if (sym && sym->type == STT_FUNC && !sym->nocfi) {
> > +			struct instruction *prev =
> > +				prev_insn_same_sym(file, insn);
> > +
> > +			if (!prev || prev->type != INSN_BUG) {
> > +				WARN_INSN(insn, "no-cfi indirect call!");
> > +				warnings++;
> 
> Do we not care about indirect calls from !STT_FUNC?

Let me try, see what happens.

