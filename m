Return-Path: <linux-efi+bounces-5379-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A58C3F108
	for <lists+linux-efi@lfdr.de>; Fri, 07 Nov 2025 10:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ED5A3A16B0
	for <lists+linux-efi@lfdr.de>; Fri,  7 Nov 2025 09:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311163164CB;
	Fri,  7 Nov 2025 09:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E87vVKdr"
X-Original-To: linux-efi@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA592BE652;
	Fri,  7 Nov 2025 09:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762506274; cv=none; b=LfeAabZVVhx5MgE8/pNMbA8jb8Fj0Fk+nlP69XWkqihwTXP2VXhBRbNAh29BURWPagM9kZKkcW1Y1D8t3d/G2e2gY8MHWCRuvAAGbRaXFfUi8Q70Et0eE1c3s20DawyPp+Gz94NCTaCqbIHoBll+VLYkXpoNe25sZee/EUCvSCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762506274; c=relaxed/simple;
	bh=JoSOS0A6PQkdTSpDO8Qbgfxr6q2mH0zIcuM27Bj1RR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oeckx1tSYeotjucufu+W9BJtsPTWkswvz3keVZYLyqp83VZrGTUaGSYmMrEoepWvmfQRepC97q7R3N+0UGR1xAJ85wP/Xg5bEqce8sekZ915SsY3sv4YNHJTDl85gtuPcnHJ9jJPz4fHQCNXUNvfPfsNuuhn3DwkWD8jFQk1MdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=E87vVKdr; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=c5PVEPcg7gvE34/gGpLzE008hmCTzSWOGhLMfbn1AWI=; b=E87vVKdr2aKCQcIoHp77GjRSyG
	RFq0ezCr1uXEm1UVBxhU9ZdYCKH94dOv6mqaFLh2CFOwWXRcWN7mQSDg5bJpBq+rA7sdYI9ZfaNdu
	NZcd6nC8wtYVxYT6aRxi3byBg30kH45DwNCA36lBlZRvT43c8epjY8j9L7dyQOi7QWS6fE652wDxL
	KA79r1L0Bt2LxUggYzDpI2/P/rQ78aW4OLLMuR8uc1a5U4LY1ghfjvcecmbiqT48OanV/q1Sl/Xck
	Nc8TQKtVU1rMMY7wsyK7zINCZj65ghhUVS3/sk8iYxGpACu0+D6wPYHn6kGpjh5fpbsqXLzWxBahJ
	W8JOf6cQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHHWR-0000000619o-0RMa;
	Fri, 07 Nov 2025 08:08:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8D8FA3001D4; Fri, 07 Nov 2025 10:04:06 +0100 (CET)
Date: Fri, 7 Nov 2025 10:04:06 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Sohil Mehta <sohil.mehta@intel.com>, Andy Lutomirski <luto@kernel.org>,
	the arch/x86 maintainers <x86@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Jonathan Corbet <corbet@lwn.net>, "H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Kirill A . Shutemov" <kas@kernel.org>, Xin Li <xin@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Sean Christopherson <seanjc@google.com>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-doc@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH v11 5/9] x86/efi: Disable LASS while mapping the EFI
 runtime services
Message-ID: <20251107090406.GU3245006@noisy.programming.kicks-ass.net>
References: <20251029210310.1155449-1-sohil.mehta@intel.com>
 <20251029210310.1155449-6-sohil.mehta@intel.com>
 <3e9c4fdd-88a8-4597-9405-d865fb837d95@intel.com>
 <cac58a25-eda6-4738-966f-a4e42818aa6c@app.fastmail.com>
 <6dec8398-3f7c-44db-a30d-33593af0217f@intel.com>
 <efd6ec82-5576-41f1-a244-2f80d72e93e4@intel.com>
 <ee2fce64-91ce-4b78-b2f9-33364ea0c52f@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee2fce64-91ce-4b78-b2f9-33364ea0c52f@intel.com>

On Fri, Oct 31, 2025 at 11:12:53AM -0700, Dave Hansen wrote:

> But there's a pretty broad set of things that are for "security" that
> aren't necessary while you're just running trusted ring0 code:
> 
>  * SMAP/SMEP
>  * CR pinning itself
>  * MSR_IA32_SPEC_CTRL
>  * MSR_IA32_TSX_CTRL
> 
> They just haven't mattered until now because they don't have any
> practical effect until you actually have code running on _PAGE_USER
> mappings trying to attack the kernel.

But that's just the thing EFI is *NOT* trusted! We're basically
disabling all security features (not listed above are CET and CFI) to
run this random garbage we have no control over.

How about we just flat out refuse EFI runtime services? What are they
actually needed for? Why are we bending over backwards and subverting
our security for this stuff?

