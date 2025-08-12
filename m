Return-Path: <linux-efi+bounces-4542-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF19B229FC
	for <lists+linux-efi@lfdr.de>; Tue, 12 Aug 2025 16:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7A663B976B
	for <lists+linux-efi@lfdr.de>; Tue, 12 Aug 2025 14:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86752D5412;
	Tue, 12 Aug 2025 14:06:09 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB8E2D4B7C;
	Tue, 12 Aug 2025 14:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755007569; cv=none; b=Z3lxptI/+oPWYEJ/+1AIrb/Zaeahr6fPJ4XI0kU7FJwSsmi79qcWU9jBAzJQSiypCBi7jAytLMO+dn3aqX71UBD0sAVVQFjRqEMyRHwX3HDgs0v+X+Zd25km3U1eg633rsmadjOZ0k2aZXWmOKIC8AQIDboc6W6UT4jKIdtmbF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755007569; c=relaxed/simple;
	bh=XIoZ8vIH2KQrNtvMxY+WpKLxz+TVhrwXofBF0C71u78=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZJehghwp6RbD+rWxAn3ToMGHdUiIMIHKNjr0iemYjAeOdgEvGkAHFiMY8VU50w30H+13avbNbWlqay2pnzw7P9kkR+MavJiol93RuAn8MvqYyERJLPQ00ystpkZu9iU4xMWwj6b28Zc1qitrTU5gqQs7vonYlETebNTZQzpcYNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c1Y7m0KyHz6L56K;
	Tue, 12 Aug 2025 22:01:08 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id ED7A014033C;
	Tue, 12 Aug 2025 22:05:57 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 12 Aug
 2025 16:05:57 +0200
Date: Tue, 12 Aug 2025 15:05:55 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Daniel Ferguson <danielf@os.amperecomputing.com>
CC: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Ard Biesheuvel
	<ardb@kernel.org>, Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>, James Morse
	<james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, Borislav Petkov
	<bp@alien8.de>, <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, Jason Tian <jason@os.amperecomputing.com>,
	Shengwei Luo <luoshengwei@huawei.com>, Shiju Jose <shiju.jose@huawei.com>
Subject: Re: [PATCH v4 1/5] RAS: Report all ARM processor CPER information
 to userspace
Message-ID: <20250812150555.000067f7@huawei.com>
In-Reply-To: <a302543c-7a99-4ea4-9559-e4cf4ea79b5e@os.amperecomputing.com>
References: <20250805-mauro_v3-v6-16-rev2-v4-0-ea538759841c@os.amperecomputing.com>
	<20250805-mauro_v3-v6-16-rev2-v4-1-ea538759841c@os.amperecomputing.com>
	<20250808162209.000068f5@huawei.com>
	<20250809175519.74b08ea9@foz.lan>
	<20250811115238.0000272b@huawei.com>
	<a302543c-7a99-4ea4-9559-e4cf4ea79b5e@os.amperecomputing.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 11 Aug 2025 15:37:18 -0700
Daniel Ferguson <danielf@os.amperecomputing.com> wrote:

> On 8/11/2025 3:52 AM, Jonathan Cameron wrote:
> > On Sat, 9 Aug 2025 17:55:19 +0200
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >   
> >> Em Fri, 8 Aug 2025 16:22:09 +0100
> >> Jonathan Cameron <Jonathan.Cameron@huawei.com> escreveu:
> >>  
> >>> On Tue, 05 Aug 2025 11:35:38 -0700
> >>> Daniel Ferguson <danielf@os.amperecomputing.com> wrote:
> >>>     
> >>>> From: Jason Tian <jason@os.amperecomputing.com>
> >>>>
> >>>> The ARM processor CPER record was added in UEFI v2.6 and remained
> >>>> unchanged up to v2.10.
> >>>>
> >>>> Yet, the original arm_event trace code added by
> >>>>
> >>>>   e9279e83ad1f ("trace, ras: add ARM processor error trace event")
> >>>>
> >>>> is incomplete, as it only traces some fields of UAPI 2.6 table N.16, not
> >>>> exporting any information from tables N.17 to N.29 of the record.
> >>>>
> >>>> This is not enough for the user to be able to figure out what has
> >>>> exactly happened or to take appropriate action.
> >>>>
> >>>> According to the UEFI v2.9 specification chapter N2.4.4, the ARM
> >>>> processor error section includes:
> >>>>
> >>>> - several (ERR_INFO_NUM) ARM processor error information structures
> >>>>   (Tables N.17 to N.20);
> >>>> - several (CONTEXT_INFO_NUM) ARM processor context information
> >>>>   structures (Tables N.21 to N.29);
> >>>> - several vendor specific error information structures. The
> >>>>   size is given by Section Length minus the size of the other
> >>>>   fields.
> >>>>
> >>>> In addition, it also exports two fields that are parsed by the GHES
> >>>> driver when firmware reports it, e.g.:
> >>>>
> >>>> - error severity
> >>>> - CPU logical index
> >>>>
> >>>> Report all of these information to userspace via a the ARM tracepoint so
> >>>> that userspace can properly record the error and take decisions related
> >>>> to CPU core isolation according to error severity and other info.
> >>>>
> >>>> The updated ARM trace event now contains the following fields:
> >>>>
> >>>> ======================================  =============================
> >>>> UEFI field on table N.16                ARM Processor trace fields
> >>>> ======================================  =============================
> >>>> Validation                              handled when filling data for
> >>>>                                         affinity MPIDR and running
> >>>>                                         state.
> >>>> ERR_INFO_NUM                            pei_len
> >>>> CONTEXT_INFO_NUM                        ctx_len
> >>>> Section Length                          indirectly reported by
> >>>>                                         pei_len, ctx_len and oem_len
> >>>> Error affinity level                    affinity
> >>>> MPIDR_EL1                               mpidr
> >>>> MIDR_EL1                                midr
> >>>> Running State                           running_state
> >>>> PSCI State                              psci_state
> >>>> Processor Error Information Structure   pei_err - count at pei_len
> >>>> Processor Context                       ctx_err- count at ctx_len
> >>>> Vendor Specific Error Info              oem - count at oem_len
> >>>> ======================================  =============================
> >>>>
> >>>> It should be noted that decoding of tables N.17 to N.29, if needed, will
> >>>> be handled in userspace. That gives more flexibility, as there won't be
> >>>> any need to flood the kernel with micro-architecture specific error
> >>>> decoding.
> >>>>
> >>>> Also, decoding the other fields require a complex logic, and should be
> >>>> done for each of the several values inside the record field.  So, let
> >>>> userspace daemons like rasdaemon decode them, parsing such tables and
> >>>> having vendor-specific micro-architecture-specific decoders.
> >>>>
> >>>>   [mchehab: modified description, solved merge conflicts and fixed coding style]
> >>>>
> >>>> Fixes: e9279e83ad1f ("trace, ras: add ARM processor error trace event")
> >>>>       
> >>>
> >>> Fixes tag is part of the main tag block so no blank line here.
> >>> There are at least some scripts running on the kernel tree that trip
> >>> up on this (and one that moans at the submitter ;)
> >>>
> >>> I'd also add something to explain the SoB sequence for the curious.
> >>>     
> >>>> Co-developed-by: Jason Tian <jason@os.amperecomputing.com>      
> >>>
> >>> Jason's the Author, so shouldn't have a Co-dev tag.
> >>> There is some info on this in
> >>> https://docs.kernel.org/process/submitting-patches.html    
> >>
> >> My understanding is that all co-authors shall have co-developed-by
> >> and SoB. Anyway, doesn't matter much in practice, I guess.  
> > 
> > Nope.  In the description the docs say "in addition to the author
> > attribute in the From: tag"  There are also examples where there
> > isn't a Co-dev for the From author including the subtle question of
> > ordering if someone else posts that patch.
> > 
> > I have a vague recollection one of the scripts checking linux-next
> > might moan about this. 
> >   
> >>  
> >>>     
> >>>> Signed-off-by: Jason Tian <jason@os.amperecomputing.com>
> >>>> Co-developed-by: Shengwei Luo <luoshengwei@huawei.com>
> >>>> Signed-off-by: Shengwei Luo <luoshengwei@huawei.com>
> >>>> Co-developed-by: Daniel Ferguson <danielf@os.amperecomputing.com>
> >>>> Signed-off-by: Daniel Ferguson <danielf@os.amperecomputing.com>      
> >>>
> >>> As person submitting I'd normally expect your SoB last.
> >>>     
> >>>> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>      
> >>>
> >>> I guess this is because Mauro posted an earlier version in which
> >>> case this is arguably correct, but likely to confuse.
> >>> For cases like this I add comments.    
> >>
> >> If the patch is identical, and it is just a resubmission,
> >> I would keep the original order.
> >>
> >> Otherwise, if Daniel did some changes at the code (except for a
> >> trivial rebase stuff), better to move his co-developed-by/SoB to
> >> the end, eventually adding:
> >>
> >> [Daniel: <did something>] before the custody chain block.  
> > 
> > Docs are clear that sender of the patch must be last SoB.
> > That's also checked by the some of the tag block check scripts
> > I think.  There's an example of exactly this case in the in the
> > submitting-patches.rst file (last one in the section that talks
> > about Co-developed-by.
> > 
> > For meaning I don't care that much, but keeping to the rigid
> > rules in that doc makes it easier for scripts to check for the
> > more important stuff like whether all necessary SoB are there.
> > 
> > Jonathan
> >   
> 
> Just to make sure I get this right...
> 
> I will move my SoB and my Co-developed-by after any other SoB's in the tag
> block. As a result, I do not need to provide an explanation in this case,
> because there is nothing curious remaining ? Or should I still add comments
> indicating why I rearranged the tag block ?
> 
> Based on your feedback, I'm intending to organize the tag block to look like this:
> 
>  Signed-off-by: Jason Tian <jason@os.amperecomputing.com>
>  Co-developed-by: Shengwei Luo <luoshengwei@huawei.com>
>  Signed-off-by: Shengwei Luo <luoshengwei@huawei.com>
>  Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>  Co-developed-by: Daniel Ferguson <danielf@os.amperecomputing.com>
>  Signed-off-by: Daniel Ferguson <danielf@os.amperecomputing.com>
>  Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>  Tested-by: Shiju Jose <shiju.jose@huawei.com>
>  Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
>  Fixes: e9279e83ad1f ("trace, ras: add ARM processor error trace event")
>  Link:
> https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#arm-processor-error-section
> 
> 
> Is that satisfactory?

The SoB from Mauro is still out of the normal pattern which
tends to happen only when things are bouncing between different submitters.

So I'd still add a comment and keep that after you Codev/SoB.

#1 [mchehab: modified description, solved merge conflicts and fixed coding style
   in version 3.]

Signed-off-by: Jason Tian <jason@os.amperecomputing.com>
Co-developed-by: Shengwei Luo <luoshengwei@huawei.com>
Signed-off-by: Shengwei Luo <luoshengwei@huawei.com>
Co-developed-by: Daniel Ferguson <danielf@os.amperecomputing.com>
Signed-off-by: Daniel Ferguson <danielf@os.amperecomputing.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org> # 1
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Tested-by: Shiju Jose <shiju.jose@huawei.com>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#arm-processor-error-section

Or something along those lines

Jonathan

> 
> Thank you,
> Daniel
> 
> >>
> >> Thanks,
> >> Mauro
> >>  
> >   
> 


