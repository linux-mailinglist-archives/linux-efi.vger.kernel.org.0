Return-Path: <linux-efi+bounces-3515-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2A7AA5478
	for <lists+linux-efi@lfdr.de>; Wed, 30 Apr 2025 21:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3D3C4E67A8
	for <lists+linux-efi@lfdr.de>; Wed, 30 Apr 2025 19:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BDF266F01;
	Wed, 30 Apr 2025 19:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JJr6Mu0A"
X-Original-To: linux-efi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4BE28399;
	Wed, 30 Apr 2025 19:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746039969; cv=none; b=ViFbOwRD1sn7/4I43On0OfBvlJNF+8xXcVcYZWh16pfsyv3/MElX7iIHSa3VN+t81LiGiIm2P0DFgft0EBHlNiB3iVqhP6/i6keEQgYlnj0iNxEkS5RVgB96CL+lUFkup/0FiKU34KBfY5cMEy56ZTLgevG9QcoV/gXOW7aeoPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746039969; c=relaxed/simple;
	bh=HVTYUGB8B2dodtSKewK0K/BimvYomZ6GlzqFUH6W6GM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHa9KsBrQxRJj5byBIc+OFDYgV9R1jZCChEeZPSfnldgc9aRgpik8bfuF73GwtPvqfagx4MtgI+4fmIsgGo/W3bPxVVUbpgFygDeXRjWLCndAs6vpCkOl0d6eiY9o3tBJdiOdimXV9Vv2/Q3MwxepRdwgvRPxjnhKRnc0vRVmIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JJr6Mu0A; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=shyzb66kCfe6GvSOT0DIWIKrBHWCmjZKqJTICSG4Hak=; b=JJr6Mu0AYxFe5sTs0QnftLDuzw
	/3AP0FWOCAOjotk/UquIqNnaOARlEPZv5vEd2SN1XG4eQfkbSyk6A6F4AvZvJrnCEWBzNqaVJTI4z
	XLm4oI5G16etLhak7enVjJ99O83+pmVTKva8d1I1HxdXbzVZV27udwyFX0WpbLrbWBjpThiqun/Iz
	JkMfA1B2t8oQUhj1eR9qL73Qn8qGxnYMeo/Rm+odclhatt/Z0Q1/OeaXi5XjtDvZnkopW2oNxhFyY
	8FJv5YDLJHoEG3vsHrBXhiFur2eDUI4pE+rOBJ2ZLY1hKVHsMimkth8p+f66XO+QsVxMxwpvkOub5
	EerjtfsQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uACkq-0000000DZ3b-2v21;
	Wed, 30 Apr 2025 19:06:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 579A2300642; Wed, 30 Apr 2025 21:06:00 +0200 (CEST)
Date: Wed, 30 Apr 2025 21:06:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	seanjc@google.com, pbonzini@redhat.com, ardb@kernel.org,
	kees@kernel.org, Arnd Bergmann <arnd@arndb.de>,
	gregkh@linuxfoundation.org, jpoimboe@kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-efi@vger.kernel.org,
	samitolvanen@google.com, ojeda@kernel.org, xin@zytor.com
Subject: Re: [PATCH v2 00/13] objtool: Detect and warn about indirect calls
 in __nocfi functions
Message-ID: <20250430190600.GQ4439@noisy.programming.kicks-ass.net>
References: <20250430110734.392235199@infradead.org>
 <8B86A3AE-A296-438C-A7A7-F844C66D0198@zytor.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8B86A3AE-A296-438C-A7A7-F844C66D0198@zytor.com>

On Wed, Apr 30, 2025 at 07:24:15AM -0700, H. Peter Anvin wrote:

> >KVM has another; the VMX interrupt injection stuff calls the IDT handler
> >directly.  Is there an alternative? Can we keep a table of Linux functions
> >slighly higher up the call stack (asm_\cfunc ?) and add CFI to those?

> We do have a table of handlers higher up in the stack in the form of
> the dispatch tables for FRED. They don't in general even need the
> assembly entry stubs, either.

Oh, right. I'll go have a look at those.

