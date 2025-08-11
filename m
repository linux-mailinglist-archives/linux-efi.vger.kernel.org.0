Return-Path: <linux-efi+bounces-4535-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1443DB20664
	for <lists+linux-efi@lfdr.de>; Mon, 11 Aug 2025 12:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1559718952D9
	for <lists+linux-efi@lfdr.de>; Mon, 11 Aug 2025 10:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354711367;
	Mon, 11 Aug 2025 10:52:49 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F776275B0F;
	Mon, 11 Aug 2025 10:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754909569; cv=none; b=ryk5JsiEHCvvTryH1TZwNLVlg5J6jRNWO56wui5iB0H4b1EvNA3/xo9qRBWb24lf4Ym4ZqLRuPQnExjWofelgBlNtKWxwwyis75aWoD7RU2FgL7Vo5JX+QyiBNIBPGdF80Cu1pjNOw1iQNGgNw0aPaLidYKL6/VQcN9+FjOrTr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754909569; c=relaxed/simple;
	bh=Wd35ZKPMzIKq6KqNhzq7CNK0q0T3QY26+Wt3PhA5IiU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UYq24mfmWxtSO+rUjy5z+IC+kT6j9M2A4NrF01nENjqUkVJH7hmeFxkjNAxodzIIT2Zd6OtkG9mrduambf30XhT0QQXw+V52ubCLZ8lbrxY3OzzNFYBA0H48zMe2BkM9l+dek6ss0S8T0tfLbwEBc56jNyfUEq1a5y5gEBL8SRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c0rvG169Pz6L5XV;
	Mon, 11 Aug 2025 18:47:54 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id CBD301402EF;
	Mon, 11 Aug 2025 18:52:40 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 11 Aug
 2025 12:52:40 +0200
Date: Mon, 11 Aug 2025 11:52:38 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Daniel Ferguson <danielf@os.amperecomputing.com>, Ard Biesheuvel
	<ardb@kernel.org>, Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>, James Morse
	<james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, Borislav Petkov
	<bp@alien8.de>, <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, Jason Tian <jason@os.amperecomputing.com>,
	Shengwei Luo <luoshengwei@huawei.com>, Shiju Jose <shiju.jose@huawei.com>
Subject: Re: [PATCH v4 1/5] RAS: Report all ARM processor CPER information
 to userspace
Message-ID: <20250811115238.0000272b@huawei.com>
In-Reply-To: <20250809175519.74b08ea9@foz.lan>
References: <20250805-mauro_v3-v6-16-rev2-v4-0-ea538759841c@os.amperecomputing.com>
	<20250805-mauro_v3-v6-16-rev2-v4-1-ea538759841c@os.amperecomputing.com>
	<20250808162209.000068f5@huawei.com>
	<20250809175519.74b08ea9@foz.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Sat, 9 Aug 2025 17:55:19 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Fri, 8 Aug 2025 16:22:09 +0100
> Jonathan Cameron <Jonathan.Cameron@huawei.com> escreveu:
> 
> > On Tue, 05 Aug 2025 11:35:38 -0700
> > Daniel Ferguson <danielf@os.amperecomputing.com> wrote:
> >   
> > > From: Jason Tian <jason@os.amperecomputing.com>
> > > 
> > > The ARM processor CPER record was added in UEFI v2.6 and remained
> > > unchanged up to v2.10.
> > > 
> > > Yet, the original arm_event trace code added by
> > > 
> > >   e9279e83ad1f ("trace, ras: add ARM processor error trace event")
> > > 
> > > is incomplete, as it only traces some fields of UAPI 2.6 table N.16, not
> > > exporting any information from tables N.17 to N.29 of the record.
> > > 
> > > This is not enough for the user to be able to figure out what has
> > > exactly happened or to take appropriate action.
> > > 
> > > According to the UEFI v2.9 specification chapter N2.4.4, the ARM
> > > processor error section includes:
> > > 
> > > - several (ERR_INFO_NUM) ARM processor error information structures
> > >   (Tables N.17 to N.20);
> > > - several (CONTEXT_INFO_NUM) ARM processor context information
> > >   structures (Tables N.21 to N.29);
> > > - several vendor specific error information structures. The
> > >   size is given by Section Length minus the size of the other
> > >   fields.
> > > 
> > > In addition, it also exports two fields that are parsed by the GHES
> > > driver when firmware reports it, e.g.:
> > > 
> > > - error severity
> > > - CPU logical index
> > > 
> > > Report all of these information to userspace via a the ARM tracepoint so
> > > that userspace can properly record the error and take decisions related
> > > to CPU core isolation according to error severity and other info.
> > > 
> > > The updated ARM trace event now contains the following fields:
> > > 
> > > ======================================  =============================
> > > UEFI field on table N.16                ARM Processor trace fields
> > > ======================================  =============================
> > > Validation                              handled when filling data for
> > >                                         affinity MPIDR and running
> > >                                         state.
> > > ERR_INFO_NUM                            pei_len
> > > CONTEXT_INFO_NUM                        ctx_len
> > > Section Length                          indirectly reported by
> > >                                         pei_len, ctx_len and oem_len
> > > Error affinity level                    affinity
> > > MPIDR_EL1                               mpidr
> > > MIDR_EL1                                midr
> > > Running State                           running_state
> > > PSCI State                              psci_state
> > > Processor Error Information Structure   pei_err - count at pei_len
> > > Processor Context                       ctx_err- count at ctx_len
> > > Vendor Specific Error Info              oem - count at oem_len
> > > ======================================  =============================
> > > 
> > > It should be noted that decoding of tables N.17 to N.29, if needed, will
> > > be handled in userspace. That gives more flexibility, as there won't be
> > > any need to flood the kernel with micro-architecture specific error
> > > decoding.
> > > 
> > > Also, decoding the other fields require a complex logic, and should be
> > > done for each of the several values inside the record field.  So, let
> > > userspace daemons like rasdaemon decode them, parsing such tables and
> > > having vendor-specific micro-architecture-specific decoders.
> > > 
> > >   [mchehab: modified description, solved merge conflicts and fixed coding style]
> > > 
> > > Fixes: e9279e83ad1f ("trace, ras: add ARM processor error trace event")
> > >     
> > 
> > Fixes tag is part of the main tag block so no blank line here.
> > There are at least some scripts running on the kernel tree that trip
> > up on this (and one that moans at the submitter ;)
> > 
> > I'd also add something to explain the SoB sequence for the curious.
> >   
> > > Co-developed-by: Jason Tian <jason@os.amperecomputing.com>    
> > 
> > Jason's the Author, so shouldn't have a Co-dev tag.
> > There is some info on this in
> > https://docs.kernel.org/process/submitting-patches.html  
> 
> My understanding is that all co-authors shall have co-developed-by
> and SoB. Anyway, doesn't matter much in practice, I guess.

Nope.  In the description the docs say "in addition to the author
attribute in the From: tag"  There are also examples where there
isn't a Co-dev for the From author including the subtle question of
ordering if someone else posts that patch.

I have a vague recollection one of the scripts checking linux-next
might moan about this. 

> 
> >   
> > > Signed-off-by: Jason Tian <jason@os.amperecomputing.com>
> > > Co-developed-by: Shengwei Luo <luoshengwei@huawei.com>
> > > Signed-off-by: Shengwei Luo <luoshengwei@huawei.com>
> > > Co-developed-by: Daniel Ferguson <danielf@os.amperecomputing.com>
> > > Signed-off-by: Daniel Ferguson <danielf@os.amperecomputing.com>    
> > 
> > As person submitting I'd normally expect your SoB last.
> >   
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>    
> > 
> > I guess this is because Mauro posted an earlier version in which
> > case this is arguably correct, but likely to confuse.
> > For cases like this I add comments.  
> 
> If the patch is identical, and it is just a resubmission,
> I would keep the original order.
> 
> Otherwise, if Daniel did some changes at the code (except for a
> trivial rebase stuff), better to move his co-developed-by/SoB to
> the end, eventually adding:
> 
> [Daniel: <did something>] before the custody chain block.

Docs are clear that sender of the patch must be last SoB.
That's also checked by the some of the tag block check scripts
I think.  There's an example of exactly this case in the in the
submitting-patches.rst file (last one in the section that talks
about Co-developed-by.

For meaning I don't care that much, but keeping to the rigid
rules in that doc makes it easier for scripts to check for the
more important stuff like whether all necessary SoB are there.

Jonathan

> 
> Thanks,
> Mauro
> 


