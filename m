Return-Path: <linux-efi+bounces-4527-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E00B1F550
	for <lists+linux-efi@lfdr.de>; Sat,  9 Aug 2025 17:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A8A3561851
	for <lists+linux-efi@lfdr.de>; Sat,  9 Aug 2025 15:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F562BE65B;
	Sat,  9 Aug 2025 15:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGctr69K"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC00185E7F;
	Sat,  9 Aug 2025 15:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754754925; cv=none; b=QLkaTHlR5ATAUZWL3Hpe3m7IsGf8cJktasr45NoXoKEI94yIrL7vQTpAqY+FId21Lrc+6rKdGrqsNuarr9GpQE6zNGqqVFY+Czb6FcfYVQLQLHJQ9sbDScePGqusPtRUG8bPc25ZifAsPP+rnbQBOmQl5GcS887HBpdqG9wwQ+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754754925; c=relaxed/simple;
	bh=I3JJChJc84ho3EVy2i9DnsTUJA4RZsmdL3FpmRJ3X3c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=orl4upu0/mB0coGbjE5L83Q/W83KMfdJf0kGtX8HEnzgGuP9EiY9JBs43UadSyWP0o0+5Dp2gS49U4XGg73W3Hw4RwhgW33MDvr9VLQHojALznEOIX/pghelIHB920Ww/jlt8M6VWJ0Y7HjfTvljE5PaD0GlcdRgTGKhcUkYKjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGctr69K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8EE4C4CEE7;
	Sat,  9 Aug 2025 15:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754754925;
	bh=I3JJChJc84ho3EVy2i9DnsTUJA4RZsmdL3FpmRJ3X3c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kGctr69KbaJjFtgertVGh8BvPSXaSvblRMGYzWaeTRsIMmmNJtBBJSm1ymNw5UQtA
	 ZSwlrZKqdx2OiTCu93y5LjPVcdtpxCTCarasAJGlY7RGKtgDdKHG2gA74LXXbcNMaH
	 Q1zExSn1zeuNxHnrxx4y3AQAP89a1M0yMMeXEO+d8fMbTMuiteJBzG73RUQSMOvmKO
	 WC6IVi7XlRgZf8mSECt/jVzqVRWUr5LHtzeSJMYO8pg7dsYVnhE+vAzgs8KMPlpUft
	 vm0qKfw6LcldjdqjdETMRhgx8QB6lwFqkVOdFp5EcRdsHOxFWPqWbkh76+PwjGl8qy
	 9VPLr9IaHbWVg==
Date: Sat, 9 Aug 2025 17:55:19 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Daniel Ferguson <danielf@os.amperecomputing.com>, Ard Biesheuvel
 <ardb@kernel.org>, Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Len Brown <lenb@kernel.org>, "James Morse"
 <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, "Borislav Petkov"
 <bp@alien8.de>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
 <linux-efi@vger.kernel.org>, <linux-edac@vger.kernel.org>, Jason Tian
 <jason@os.amperecomputing.com>, Shengwei Luo <luoshengwei@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>
Subject: Re: [PATCH v4 1/5] RAS: Report all ARM processor CPER information
 to userspace
Message-ID: <20250809175519.74b08ea9@foz.lan>
In-Reply-To: <20250808162209.000068f5@huawei.com>
References: <20250805-mauro_v3-v6-16-rev2-v4-0-ea538759841c@os.amperecomputing.com>
	<20250805-mauro_v3-v6-16-rev2-v4-1-ea538759841c@os.amperecomputing.com>
	<20250808162209.000068f5@huawei.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 8 Aug 2025 16:22:09 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> escreveu:

> On Tue, 05 Aug 2025 11:35:38 -0700
> Daniel Ferguson <danielf@os.amperecomputing.com> wrote:
> 
> > From: Jason Tian <jason@os.amperecomputing.com>
> > 
> > The ARM processor CPER record was added in UEFI v2.6 and remained
> > unchanged up to v2.10.
> > 
> > Yet, the original arm_event trace code added by
> > 
> >   e9279e83ad1f ("trace, ras: add ARM processor error trace event")
> > 
> > is incomplete, as it only traces some fields of UAPI 2.6 table N.16, not
> > exporting any information from tables N.17 to N.29 of the record.
> > 
> > This is not enough for the user to be able to figure out what has
> > exactly happened or to take appropriate action.
> > 
> > According to the UEFI v2.9 specification chapter N2.4.4, the ARM
> > processor error section includes:
> > 
> > - several (ERR_INFO_NUM) ARM processor error information structures
> >   (Tables N.17 to N.20);
> > - several (CONTEXT_INFO_NUM) ARM processor context information
> >   structures (Tables N.21 to N.29);
> > - several vendor specific error information structures. The
> >   size is given by Section Length minus the size of the other
> >   fields.
> > 
> > In addition, it also exports two fields that are parsed by the GHES
> > driver when firmware reports it, e.g.:
> > 
> > - error severity
> > - CPU logical index
> > 
> > Report all of these information to userspace via a the ARM tracepoint so
> > that userspace can properly record the error and take decisions related
> > to CPU core isolation according to error severity and other info.
> > 
> > The updated ARM trace event now contains the following fields:
> > 
> > ======================================  =============================
> > UEFI field on table N.16                ARM Processor trace fields
> > ======================================  =============================
> > Validation                              handled when filling data for
> >                                         affinity MPIDR and running
> >                                         state.
> > ERR_INFO_NUM                            pei_len
> > CONTEXT_INFO_NUM                        ctx_len
> > Section Length                          indirectly reported by
> >                                         pei_len, ctx_len and oem_len
> > Error affinity level                    affinity
> > MPIDR_EL1                               mpidr
> > MIDR_EL1                                midr
> > Running State                           running_state
> > PSCI State                              psci_state
> > Processor Error Information Structure   pei_err - count at pei_len
> > Processor Context                       ctx_err- count at ctx_len
> > Vendor Specific Error Info              oem - count at oem_len
> > ======================================  =============================
> > 
> > It should be noted that decoding of tables N.17 to N.29, if needed, will
> > be handled in userspace. That gives more flexibility, as there won't be
> > any need to flood the kernel with micro-architecture specific error
> > decoding.
> > 
> > Also, decoding the other fields require a complex logic, and should be
> > done for each of the several values inside the record field.  So, let
> > userspace daemons like rasdaemon decode them, parsing such tables and
> > having vendor-specific micro-architecture-specific decoders.
> > 
> >   [mchehab: modified description, solved merge conflicts and fixed coding style]
> > 
> > Fixes: e9279e83ad1f ("trace, ras: add ARM processor error trace event")
> >   
> 
> Fixes tag is part of the main tag block so no blank line here.
> There are at least some scripts running on the kernel tree that trip
> up on this (and one that moans at the submitter ;)
> 
> I'd also add something to explain the SoB sequence for the curious.
> 
> > Co-developed-by: Jason Tian <jason@os.amperecomputing.com>  
> 
> Jason's the Author, so shouldn't have a Co-dev tag.
> There is some info on this in
> https://docs.kernel.org/process/submitting-patches.html

My understanding is that all co-authors shall have co-developed-by
and SoB. Anyway, doesn't matter much in practice, I guess.

> 
> > Signed-off-by: Jason Tian <jason@os.amperecomputing.com>
> > Co-developed-by: Shengwei Luo <luoshengwei@huawei.com>
> > Signed-off-by: Shengwei Luo <luoshengwei@huawei.com>
> > Co-developed-by: Daniel Ferguson <danielf@os.amperecomputing.com>
> > Signed-off-by: Daniel Ferguson <danielf@os.amperecomputing.com>  
> 
> As person submitting I'd normally expect your SoB last.
> 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> 
> I guess this is because Mauro posted an earlier version in which
> case this is arguably correct, but likely to confuse.
> For cases like this I add comments.

If the patch is identical, and it is just a resubmission,
I would keep the original order.

Otherwise, if Daniel did some changes at the code (except for a
trivial rebase stuff), better to move his co-developed-by/SoB to
the end, eventually adding:

[Daniel: <did something>] before the custody chain block.

Thanks,
Mauro

