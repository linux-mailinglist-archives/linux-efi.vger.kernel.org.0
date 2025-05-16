Return-Path: <linux-efi+bounces-3746-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB85AB9FFC
	for <lists+linux-efi@lfdr.de>; Fri, 16 May 2025 17:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8ED07B7579
	for <lists+linux-efi@lfdr.de>; Fri, 16 May 2025 15:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889BC1C5D5A;
	Fri, 16 May 2025 15:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjOgxn5L"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593961B87EB;
	Fri, 16 May 2025 15:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747409729; cv=none; b=Il/6LyHztwpQZ6jWbpSVy92cuqDakViu1BzeSa6+9GTzP/EG3LqjfnW8oxguuM4QgmfZsSlqwvhHyYcuLbh4Ng6PBD0s3pk55Lbeh0n5iIDnTRbCVKAMIAgjQV+J2HPqsrzGkH1CiiiUKIe2D7cnHIKZwo8RWm/QLT56R0NNGFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747409729; c=relaxed/simple;
	bh=tFBuEkfpTZDqLAksOlNvQnNL7DfHD68oh+9DLHIsuks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAdOwviyIjquJzrUUNbcpITZ2+vrOVXKoKdhkEmn5CBZQ3Sd+OT/1EFJhH3L0dc6OUxkj2zED8QjmqZIqJ/sWsUJWajS3/3MmqIM3p3TqttpMVJWyu6guFq0DWUI0lZNksB0byyxZDIUrcvzngJOo0WBfHFRKBz0UQx5TnEriB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjOgxn5L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C10FFC4CEE4;
	Fri, 16 May 2025 15:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747409728;
	bh=tFBuEkfpTZDqLAksOlNvQnNL7DfHD68oh+9DLHIsuks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GjOgxn5L6HlZB4ZnV59WnZgXYTasRydElhhX/90ByVYGKA645uJNUCcwDN1MkudLW
	 I385G8yrdoUqBTB0XqhZqvllLe2wsxKZjeRnR4KKbO5HXWEfFyqn/4NEX62m0tqr/2
	 aaOKx3eiTkuC/4G20XNhpblZv3nPfyzyk3l18ZDrDVQMEFsB0/RWFkbX3F/v2Jp5Tz
	 //XKYXg7JDq5PbYSI7NgiwkCIInbZ/e9i8+oMQqpKOd9qksPul59oxrToC359hYxXt
	 UPGYCcJgt9BB305oJmHH+WHc/mOTeuaHgmYWMsjUit2gy5ooPaGl9bgUaj6Ya5Pojs
	 Q03v2FKgO1BXg==
Date: Fri, 16 May 2025 17:35:21 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Michael Roth <michael.roth@amd.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Brijesh Singh <brijesh.singh@amd.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Juergen Gross <jgross@suse.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv3 2/4] x86/64/mm: Make SPARSEMEM_VMEMMAP the only memory
 model
Message-ID: <aCdbOeK3EkVUTGD2@gmail.com>
References: <20250516123306.3812286-1-kirill.shutemov@linux.intel.com>
 <20250516123306.3812286-3-kirill.shutemov@linux.intel.com>
 <30570ca0-8da4-4ebc-84d6-0a4badfb7154@intel.com>
 <rqkfqkkli57fbd5zkj3bwko44kmqqwnfdm766snm26y2so52ss@6it24qxv356q>
 <aCdGzpXSVx15gz90@gmail.com>
 <a0ca765c-a506-4c1f-a38c-24a8074988df@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0ca765c-a506-4c1f-a38c-24a8074988df@intel.com>


* Dave Hansen <dave.hansen@intel.com> wrote:

> On 5/16/25 07:08, Ingo Molnar wrote:
> >> And is there any value to support !SPARSEMEM_VMEMMAP?
> > Not really IMHO:
> > 
> >   .config.opensuse.default:    CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
> >   .config.ubuntu.localinstall: CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
> >   .config.fedora.generic:      CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
> >   .config.rhel.generic:        CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
> 
> I look at the distro configs all the time as well.
> 
> But let's also not forget that none of these have lockdep turned on,

Not actually true, quite a few distro debug kernel packages have 
lockdep on, and it's often enabled in internal QA rigs as well.

Not so SPARSEMEM_VMEMMAP...

> [...] and we don't want to toss out lockdep support on x86, for 
> example. ;)

That's an apples to oranges comparison:

 - SPARSEMEM_VMEMMAP is always enabled, in standard and debug kernels 
   as well.

 - lockdep is disabled in standard kernels, enabled in debug kernels 
   and very much relied on.

Thanks,

	Ingo

