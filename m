Return-Path: <linux-efi+bounces-3950-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E597AE63AF
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 13:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5960F7AD60E
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 11:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809DF28467D;
	Tue, 24 Jun 2025 11:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hpzFJi7d"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC0F280CC8;
	Tue, 24 Jun 2025 11:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750765057; cv=none; b=V6kl55lao8zZTGtYau3yju/BWZpzy09Hhk+U0Dan11gk37IjyIPlWpZqfZsitSWXG8OxliqHP9pR4pjx1o1XyRvNLN5XLLXYF2nYpT+ZDy8K+are8oSSqqtv5Dp7Ix2j6uk/ePc4Eudk8M+ZY8zxNmgKf6td24OefEs6YVMLVrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750765057; c=relaxed/simple;
	bh=1zp6mhXvmMH8trlbOZRktJXmdXnam+2EnOgo74XACPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FwrW7f6gN1ohXj/bFNL9fgEoSsvepY8ntrdWlvnJH6W/jh8uWoSH7nU1kz9GrPmrCSd83S98Lyqu6ZUNSRmzz8mRwS4Ie8Gq23ic9wJPMBNI5x9jQafV8KyXpzyqe8yuXfuYB7kc/gH6rCUH80Zo/PYWLKsYaWwL6YC3WWOZo30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hpzFJi7d; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750765056; x=1782301056;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1zp6mhXvmMH8trlbOZRktJXmdXnam+2EnOgo74XACPI=;
  b=hpzFJi7dCpnBfKkbNFt0OJW/O3V81Ud/NtMbZRPqg/huS9KxDTqNYMm/
   t8uyfMi2nhVYxi8kZtV/2nWgsI0gLxkCX6ZNTYnRgL2uFTQPTChxv3I69
   rqn4iOWkrvOLo6BivplTEaO5C+1DvhlicXOBvhiejGcR7x2Z1GgrewcVy
   PwbDkudyaTb2R0ePKDdgJD6vtjt8CdsfVC4neZcdTEwPhfSe5YppXlq88
   nuVGzpEpG3zEZ5895A6wzyhG/bjWICgw1CmaZ9pLBysQYrLLItqDO/Mrc
   b7bOR7Md/i12PlarKqTUI0yNzkBd++PTY6DvbFku4Q90iEogy1hK7WLON
   A==;
X-CSE-ConnectionGUID: l05Dgq+fSs+S/i68jyQTug==
X-CSE-MsgGUID: rEKdUBuISDmAyKjGMf+Gqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="63693221"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="63693221"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 04:37:34 -0700
X-CSE-ConnectionGUID: E4+6VBWNT/KVds9ubA8IBg==
X-CSE-MsgGUID: Xdm3O+jyTXuRhe76Z3qzAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="152399988"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 24 Jun 2025 04:37:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 48839224; Tue, 24 Jun 2025 14:37:21 +0300 (EEST)
Date: Tue, 24 Jun 2025 14:37:21 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, acme@redhat.com, 
	aik@amd.com, akpm@linux-foundation.org, alexander.shishkin@linux.intel.com, 
	ardb@kernel.org, ast@kernel.org, bp@alien8.de, brijesh.singh@amd.com, 
	changbin.du@huawei.com, christophe.leroy@csgroup.eu, corbet@lwn.net, 
	daniel.sneddon@linux.intel.com, dave.hansen@linux.intel.com, ebiggers@google.com, 
	geert+renesas@glider.be, houtao1@huawei.com, hpa@zytor.com, jgg@ziepe.ca, jgross@suse.com, 
	jpoimboe@kernel.org, kai.huang@intel.com, kees@kernel.org, leitao@debian.org, 
	linux-doc@vger.kernel.org, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux@rasmusvillemoes.dk, luto@kernel.org, mcgrof@kernel.org, 
	mhiramat@kernel.org, michael.roth@amd.com, mingo@kernel.org, mingo@redhat.com, 
	namhyung@kernel.org, paulmck@kernel.org, pawan.kumar.gupta@linux.intel.com, 
	peterz@infradead.org, rick.p.edgecombe@intel.com, rppt@kernel.org, 
	sandipan.das@amd.com, shijie@os.amperecomputing.com, sohil.mehta@intel.com, 
	tglx@linutronix.de, tj@kernel.org, tony.luck@intel.com, vegard.nossum@oracle.com, 
	x86@kernel.org, xin3.li@intel.com, xiongwei.song@windriver.com, 
	ytcoode@gmail.com
Subject: Re: [PATCHv6 07/16] x86/vsyscall: Reorganize the #PF emulation code
Message-ID: <hhbqjpkpdi5oe77lfosjpgyvvhvxgwolb45ll5rmwbzsdt27h5@hgv57r543ryl>
References: <9d351d80-66fe-486f-bdb3-370859dc47cc@intel.com>
 <262c0fd2-ac66-4ce7-903f-4062f1fe1d6e@citrix.com>
 <b6f8a90d-4309-45c5-84cd-32e281d076fb@intel.com>
 <kthmv63jrvrr3shhzhhcib7qrjp7sjkah65kogbfphfr6wg6cb@z5zydz6ov7pv>
 <bd81a98b-f8d4-4304-ac55-d4151a1a77ab@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd81a98b-f8d4-4304-ac55-d4151a1a77ab@intel.com>

On Mon, Jun 23, 2025 at 08:32:53AM -0700, Dave Hansen wrote:
> On 6/23/25 05:41, Kirill A. Shutemov wrote:
> > So, IIUC, that's dependency of vsyscall PF on NX. Do we want to disable
> > vsyscall on boot if NX is not available?
> 
> Well, vsyscall=none can break old userspace, so forcing it on old
> hardware doesn't seem like a great idea.
> 
> But, either way, this doesn't really appear to be a LASS issue. This code:
> 
> >         if (!(error_code & X86_PF_INSTR)) {
> >                 /* Failed vsyscall read */
> >                 if (vsyscall_mode == EMULATE)
> >                         return false;
> 
> Is really asking the question:
> 
> 	Is this #PF from an instruction fetch in the vsyscall page?
> 
> That _should_ be able to be done by comparing CR2 and regs->rip. In
> fact, that's done just below anyway:
> 
> 	WARN_ON_ONCE(address != regs->ip);
> 
> So I think we can fix this up with something like the attached patch
> which just drives the if() from regs->rip and make the warning NX-only.

Looks good to me.

Do you want me to include it into this patchset or will you apply it
separately?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

