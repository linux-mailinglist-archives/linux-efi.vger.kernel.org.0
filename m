Return-Path: <linux-efi+bounces-1640-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BF9967E61
	for <lists+linux-efi@lfdr.de>; Mon,  2 Sep 2024 06:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63279282185
	for <lists+linux-efi@lfdr.de>; Mon,  2 Sep 2024 04:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2433514A0AB;
	Mon,  2 Sep 2024 04:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArKX447D"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0518320E;
	Mon,  2 Sep 2024 04:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725250365; cv=none; b=tIDtYW2jfbFoDngXija4rVufFAyN9wL2zjqB/IPM586fjxm/iFlJjm6XIwqzwRRw8OliNaMYmu5osBVOZQxeswObDgDcdvwieUjHzbRfpkg0eefKYG77RrdmA9Uy1WK1OobCPXt+g9u7i5IvP1xzyX5kF6Igqhj2g2gBjPyRnUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725250365; c=relaxed/simple;
	bh=2Yzl1TCxAvmFEWxCD0hG1tgfKeB5Qtda3UkGw1hGLdM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Am2oFAy+EFyuxJJ4PoQ+Hd9aFm3PDMxuzBOJ2X1E9RicuN17AKJVFWd8fjqjJiWdUz36iPiBIKcVC+Z19+7YMFAVVO8eyxpmutPOMbQadWOIGkZq1qmWf82+voikU6lN0MAc3OgKxh/RiLqUwentx8uSPuUOVMsXgIzV2GF210c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ArKX447D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F93DC4CEC2;
	Mon,  2 Sep 2024 04:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725250364;
	bh=2Yzl1TCxAvmFEWxCD0hG1tgfKeB5Qtda3UkGw1hGLdM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ArKX447DIZlHbpZgEW+XCefFC+aKgwQjSxdrGmu5T0lNo+fL5d0vFpaAWDsbVXWKq
	 xnk1QR1Mu7/j8jktl94zL+lbsL2TH3FnWXbLc3n2FR++uDBZobxmLaOhqxKim1b6zM
	 p7GfLW64xoD0YnE2plga4ZMlq0FX1EvSdbkNy2n+I2UXjVUhW22xzq08LnuiayWE5J
	 yyF1QwW55J1ChjEXMIJM6heDyvNU6r7u+l6ke1nPxHeDRpAfV29/PHST5e6RJZtn5p
	 cYFmvqZNxdt5iEK/CDpyCkWgXC6bewqouFZ7YCkxbhium5f9vIH54A4ybaVXaTNJYv
	 ASd6WFKUiekrA==
Date: Mon, 2 Sep 2024 06:12:36 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>, Daniel Ferguson
 <danielf@os.amperecomputing.com>, Ard Biesheuvel <ardb@kernel.org>, James
 Morse <james.morse@arm.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Len Brown <lenb@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Shiju Jose <shiju.jose@huawei.com>, Dan
 Williams <dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, Ira
 Weiny <ira.weiny@intel.com>, Shuai Xue <xueshuai@linux.alibaba.com>, Steven
 Rostedt <rostedt@goodmis.org>, Tyler Baicar <tbaicar@codeaurora.org>, Will
 Deacon <will@kernel.org>, Xie XiuQi <xiexiuqi@huawei.com>,
 linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, Shengwei Luo
 <luoshengwei@huawei.com>, Jason Tian <jason@os.amperecomputing.com>,
 m.chehab@huawei.com
Subject: Re: [PATCH v2 1/5] RAS: Report all ARM processor CPER information
 to userspace
Message-ID: <20240902061236.7cfc97fd@foz.lan>
In-Reply-To: <20240829143811.GDZtCH07BFEdbbv9wx@fat_crate.local>
References: <cover.1720679234.git.mchehab+huawei@kernel.org>
	<3853853f820a666253ca8ed6c7c724dc3d50044a.1720679234.git.mchehab+huawei@kernel.org>
	<20240829143811.GDZtCH07BFEdbbv9wx@fat_crate.local>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Boris,

Em Thu, 29 Aug 2024 16:38:11 +0200
Borislav Petkov <bp@alien8.de> escreveu:

> On Thu, Jul 11, 2024 at 08:28:52AM +0200, Mauro Carvalho Chehab wrote:
> > In addition to those data, it also exports two fields that are
> > parsed by the GHES driver when firmware reports it, e. g.:
> > 
> > - error severity
> > - cpu logical index  
> 
> s/cpu/CPU/g
> 
> check your whole set pls.

Ok. Will address those at the hole series, sending you later today
a new version. Except for those, are patches 2-5 ok?

Regards,
Mauro

> > Report all of these information to userspace via trace uAPI, So that
> > userspace can properly record the error and take decisions related
> > to cpu core isolation according to error severity and other info.
> > 
> > After this patch, all the data from ARM Processor record from table  
> 
> Avoid having "This patch" or "This commit" in the commit message. It is
> tautologically useless.
> 
> Also, do
> 
> $ git grep 'This patch' Documentation/process
> 
> for more details.

Usually, I don't use "this patch". In this specific case, I wanted
to bold the new fields that were added to the ARM trace event, making
clear that before the changeset, none of such fields exist; they were
added on such change. On other words, the keyword here is not patch,
but instead "After". Maybe I can replace it with "now", e. g.:

	The updated ARM trace event now contains the following fields:

	======================================	=============================
	UEFI field on table N.16		ARM Processor trace fields
	======================================	=============================
	Validation				handled when filling data for
						affinity MPIDR and running
						state.
	ERR_INFO_NUM				pei_len
	CONTEXT_INFO_NUM			ctx_len
	Section Length				indirectly reported by
						pei_len, ctx_len and oem_len
	Error affinity level			affinity
	MPIDR_EL1				mpidr
	MIDR_EL1				midr
	Running State				running_state
	PSCI State				psci_state
	Processor Error Information Structure	pei_err - count at pei_len
	Processor Context			ctx_err- count at ctx_len
	Vendor Specific Error Info		oem - count at oem_len
	======================================	=============================


> 
> ...
> 
> > [mchehab: modified patch description, solve merge conflicts and fix coding style]
> > Fixes: e9279e83ad1f ("trace, ras: add ARM processor error trace event")
> > Signed-off-by: Shengwei Luo <luoshengwei@huawei.com>
> > Signed-off-by: Jason Tian <jason@os.amperecomputing.com>
> > Signed-off-by: Daniel Ferguson <danielf@os.amperecomputing.com>  
> 
> What is this SOB chain trying to tell me?
> 
> All those folks handled the patch?

They reflect what happened with past attempts of upstreaming this
change at the EDAC mailing list.

See, originally this seems to come from Jason Tian in 2021:
	https://lore.kernel.org/linux-edac/20210205022229.313030-1-jason@os.amperecomputing.com/
	https://lore.kernel.org/linux-edac/20210422084944.3718-1-jason@os.amperecomputing.com/
	https://lore.kernel.org/linux-edac/20210802135929.5283-1-shijie@os.amperecomputing.com/

In 2022, it came a new version from Shengwei Luo:
	https://lore.kernel.org/lkml/20220126030906.56765-1-lostway@zju.edu.cn/
	https://lore.kernel.org/linux-edac/20220214030813.135766-1-lostway@zju.edu.cn/

A new version from Daniel Ferguson arrived in 2023:
	https://lore.kernel.org/linux-edac/20231214232330.306526-2-danielf@os.amperecomputing.com/

Hard to reconstruct the entire history of this changeset, as there were
several attempts to fix it, and patches got renamed on some of such
attempts.

Anyway, it sounds that the custody chan can better be written as:

	Co-authored-by: Jason Tian <jason@os.amperecomputing.com>
	Co-authored-by: Signed-off-by: Shengwei Luo <luoshengwei@huawei.com>
	Co-authored-by: Daniel Ferguson <danielf@os.amperecomputing.com>  
	Signed-off-by: Jason Tian <jason@os.amperecomputing.com>
	Signed-off-by: Shengwei Luo <luoshengwei@huawei.com>
	Signed-off-by: Daniel Ferguson <danielf@os.amperecomputing.com>  

It probably makes sense to also indicate the original author of
it by change the "From" metadata to:

	From: Jason Tian <jason@os.amperecomputing.com>

> 
> > Tested-by: Shiju Jose <shiju.jose@huawei.com>
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Link: https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#arm-processor-error-section
> > ---
> >  drivers/acpi/apei/ghes.c | 11 ++++-----
> >  drivers/ras/ras.c        | 45 +++++++++++++++++++++++++++++++++++--
> >  include/linux/ras.h      | 16 +++++++++++---
> >  include/ras/ras_event.h  | 48 +++++++++++++++++++++++++++++++++++-----
> >  4 files changed, 103 insertions(+), 17 deletions(-)  
> 
> ...
> 
> > -void log_arm_hw_error(struct cper_sec_proc_arm *err)
> > +void log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev)
> >  {
> > -	trace_arm_event(err);
> > +	struct cper_arm_err_info *err_info;
> > +	struct cper_arm_ctx_info *ctx_info;
> > +	u8 *ven_err_data;
> > +	u32 ctx_len = 0;
> > +	int n, sz, cpu;
> > +	s32 vsei_len;
> > +	u32 pei_len;
> > +	u8 *pei_err;
> > +	u8 *ctx_err;
> > +
> > +	pei_len = sizeof(struct cper_arm_err_info) * err->err_info_num;
> > +	pei_err = (u8 *)err + sizeof(struct cper_sec_proc_arm);
> > +
> > +	err_info = (struct cper_arm_err_info *)(err + 1);
> > +	ctx_info = (struct cper_arm_ctx_info *)(err_info + err->err_info_num);
> > +	ctx_err = (u8 *)ctx_info;
> > +	for (n = 0; n < err->context_info_num; n++) {
> > +		sz = sizeof(struct cper_arm_ctx_info) + ctx_info->size;
> > +		ctx_info = (struct cper_arm_ctx_info *)((long)ctx_info + sz);
> > +		ctx_len += sz;
> > +	}
> > +
> > +	vsei_len = err->section_length - (sizeof(struct cper_sec_proc_arm) +
> > +					  pei_len + ctx_len);
> > +	if (vsei_len < 0) {
> > +		pr_warn(FW_BUG
> > +			"section length: %d\n", err->section_length);
> > +		pr_warn(FW_BUG
> > +			"section length is too small\n");
> > +		pr_warn(FW_BUG
> > +			"firmware-generated error record is incorrect\n");  
> 
> No need to break those lines.
> 
> > +		vsei_len = 0;
> > +	}
> > +	ven_err_data = (u8 *)ctx_info;
> > +
> > +	cpu = GET_LOGICAL_INDEX(err->mpidr);
> > +	/* when return value is invalid, set cpu index to -1 */  
> 
> Obvious comment - no need for it.
> 

Will address at the next review.

Thanks,
Mauro

