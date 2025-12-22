Return-Path: <linux-efi+bounces-5916-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D039CCD641B
	for <lists+linux-efi@lfdr.de>; Mon, 22 Dec 2025 14:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6E973042FDA
	for <lists+linux-efi@lfdr.de>; Mon, 22 Dec 2025 13:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF613328263;
	Mon, 22 Dec 2025 13:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBQ/oH5E"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE11031A57A;
	Mon, 22 Dec 2025 13:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766411594; cv=none; b=GgnlhR08qkf7PjJbF7KYngHNlt/kzuHhcIstdg5J6dsUGFuQb8MWZa8qbV0iBNppTN5Bh/YVZbpmV9Tc9RPE1aEH4XDrIk1HgBNKmmiq8OYxVGIWWCmzaeIETx10GjVn4lLnQoASHsPe5hACKhR1grUVtapo5I0X+F682MMiWRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766411594; c=relaxed/simple;
	bh=Lo0+vGN2A0Za7XEhYymIqG5UG7GTuUE8iHoaEu5n4oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=de2pPPnuqGVwV9Ul9yOg/rGSj2xIj78DjsEwcHSH194m4jSJq9w2CIc4oN7rtBtOA5rSNGOWaf21uDm7jSr25ZKlo5vllj/UUPsONE4o8RrH2V2ULuiH9q2Lyg0nQUNM3DfZk2tXYV1jrJ9w9ERS8ULsOXchrPzp14B01TZNZHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBQ/oH5E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E4FC4CEF1;
	Mon, 22 Dec 2025 13:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766411594;
	bh=Lo0+vGN2A0Za7XEhYymIqG5UG7GTuUE8iHoaEu5n4oQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LBQ/oH5ERXHbGZVSxi9frfw93c3eImu1u5VgwuSChndMib8UQ4bNXFTkhrfiXL9Ig
	 8soAAuP4QN3Ot06kjOiOwFMQ3nVD8Yb3wd0bSOi5M0pqv0QAFvukO6ziFmGB1itS3Y
	 G0RTo9IkT9f16lMTtLO8Rugt9A46Tapp99DTuG2W92Fdcy5q+d9SYDy1rRSYMAJ8BT
	 mq7PvisuyIh5XjMtu6v1mI5LJ37vWwutW1RrNT++tG5vIFZMSeTBY5oEDTNctfgyS0
	 j9mGoEDjEGLaQL46WPiG9MgkHfzmG02fDol4TyAVUi0gf8DreBs9PWBr300k1Sl8nd
	 f3W6/8/OyfeTQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.99)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vXgLY-00000002Al6-0KCd;
	Mon, 22 Dec 2025 14:53:12 +0100
Date: Mon, 22 Dec 2025 14:53:12 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Ankit Agrawal <ankita@nvidia.com>, 
	Borislav Petkov <bp@alien8.de>, Breno Leitao <leitao@debian.org>, 
	Hanjun Guo <guohanjun@huawei.com>, Ingo Molnar <mingo@kernel.org>, 
	Jason Tian <jason@os.amperecomputing.com>, Len Brown <lenb@kernel.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>, 
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, Tony Luck <tony.luck@intel.com>, linux-efi@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] apei/ghes: ARM processor Error: don't go past
 allocated memory
Message-ID: <aUlNDaUhl3uLtsCM@foz.lan>
References: <cover.1766140788.git.mchehab+huawei@kernel.org>
 <e80bc4eba43d0211713fe66958ec0c582d9bfda7.1766140788.git.mchehab+huawei@kernel.org>
 <20251222113851.000048f6@huawei.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251222113851.000048f6@huawei.com>
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

On Mon, Dec 22, 2025 at 11:38:51AM +0000, Jonathan Cameron wrote:
> On Fri, 19 Dec 2025 11:49:59 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > If the BIOS generates a very small ARM Processor Error, or
> > an incomplete one, the current logic will fail to deferrence
> > 
> > 	err->section_length
> > and
> > 	ctx_info->size
> > 
> > Add checks to avoid that. With such changes, such GHESv2
> > records won't cause OOPSes like this:
> > 
> > [    1.492129] Internal error: Oops: 0000000096000005 [#1]  SMP
> > [    1.495449] Modules linked in:
> > [    1.495820] CPU: 0 UID: 0 PID: 9 Comm: kworker/0:0 Not tainted 6.18.0-rc1-00017-gabadcc3553dd-dirty #18 PREEMPT
> > [    1.496125] Hardware name: QEMU QEMU Virtual Machine, BIOS unknown 02/02/2022
> > [    1.496433] Workqueue: kacpi_notify acpi_os_execute_deferred
> > [    1.496967] pstate: 814000c5 (Nzcv daIF +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> > [    1.497199] pc : log_arm_hw_error+0x5c/0x200
> > [    1.497380] lr : ghes_handle_arm_hw_error+0x94/0x220
> > 
> > 0xffff8000811c5324 is in log_arm_hw_error (../drivers/ras/ras.c:75).
> > 70		err_info = (struct cper_arm_err_info *)(err + 1);
> > 71		ctx_info = (struct cper_arm_ctx_info *)(err_info + err->err_info_num);
> > 72		ctx_err = (u8 *)ctx_info;
> > 73
> > 74		for (n = 0; n < err->context_info_num; n++) {
> > 75			sz = sizeof(struct cper_arm_ctx_info) + ctx_info->size;
> > 76			ctx_info = (struct cper_arm_ctx_info *)((long)ctx_info + sz);
> > 77			ctx_len += sz;
> > 78		}
> > 79
> > 
> > and similar ones while trying to access section_length on an
> > error dump with too small size.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Hi Mauro,
> 
> This is fiddly stuff to read in the spec but I think you have a double
> counting of the "ARM Processors Error Information Structure" size as
> the length in that this time is the length of the structure itself,
> not a following body.

True. The change below should fix it:

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index d37540ef8c00..aacb8d66a3e1 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -582,8 +582,7 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
 		bool is_cache, has_pa;
 
 		/* Ensure we have enough data for the error info header */
-		length -= sizeof(*err_info);
-		if (length < 0)
+		if (length < sizeof(*err_info))
 			break;
 
 		err_info = (struct cper_arm_err_info *)p;


I'll run some tests here after the change before submitting v4.

Thanks!

Mauro

> 
> Jonathan
> 
> 
> > ---
> >  drivers/acpi/apei/ghes.c | 33 +++++++++++++++++++++++++++++----
> >  drivers/ras/ras.c        |  6 +++++-
> >  2 files changed, 34 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> > index 0dc767392a6c..9bf4ec84f160 100644
> > --- a/drivers/acpi/apei/ghes.c
> > +++ b/drivers/acpi/apei/ghes.c
> > @@ -552,21 +552,46 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
> >  {
> >  	struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
> >  	int flags = sync ? MF_ACTION_REQUIRED : 0;
> > +	int length = gdata->error_data_length;
> >  	char error_type[120];
> >  	bool queued = false;
> >  	int sec_sev, i;
> >  	char *p;
> >  
> >  	sec_sev = ghes_severity(gdata->error_severity);
> > -	log_arm_hw_error(err, sec_sev);
> > +	if (length >= sizeof(*err)) {
> > +		log_arm_hw_error(err, sec_sev);
> > +	} else {
> > +		pr_warn(FW_BUG "arm error length: %d\n", length);
> > +		pr_warn(FW_BUG "length is too small\n");
> > +		pr_warn(FW_BUG "firmware-generated error record is incorrect\n");
> > +		return false;
> > +	}
> > +
> >  	if (sev != GHES_SEV_RECOVERABLE || sec_sev != GHES_SEV_RECOVERABLE)
> >  		return false;
> >  
> >  	p = (char *)(err + 1);
> > +	length -= sizeof(err);
> Hacks off the bit of the section that is fixed size.
> > +
> >  	for (i = 0; i < err->err_info_num; i++) {
> > -		struct cper_arm_err_info *err_info = (struct cper_arm_err_info *)p;
> > -		bool is_cache = err_info->type & CPER_ARM_CACHE_ERROR;
> > -		bool has_pa = (err_info->validation_bits & CPER_ARM_INFO_VALID_PHYSICAL_ADDR);
> > +		struct cper_arm_err_info *err_info;
> > +		bool is_cache, has_pa;
> > +
> > +		/* Ensure we have enough data for the error info header */
> > +		length -= sizeof(*err_info);
> hacks of length of one processor error information structure (fixed 32 bytes)
> 
> > +		if (length < 0)
> > +			break;
> > +
> > +		err_info = (struct cper_arm_err_info *)p;
> > +
> > +		/* Validate the claimed length before using it */
> > +		length -= err_info->length;
> 
> This one confuses me.  err_info->length is the same 32 bytes you removed above.
> 
> So I think this check is wrong.
> 
>  
> > +		if (length < 0)
> > +			break;
> > +
> > +		is_cache = err_info->type & CPER_ARM_CACHE_ERROR;
> > +		has_pa = (err_info->validation_bits & CPER_ARM_INFO_VALID_PHYSICAL_ADDR);
> >  
> >  		/*
> >  		 * The field (err_info->error_info & BIT(26)) is fixed to set to
> > diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
> > index 2a5b5a9fdcb3..03df3db62334 100644
> > --- a/drivers/ras/ras.c
> > +++ b/drivers/ras/ras.c
> > @@ -72,7 +72,11 @@ void log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev)
> >  	ctx_err = (u8 *)ctx_info;
> >  
> >  	for (n = 0; n < err->context_info_num; n++) {
> > -		sz = sizeof(struct cper_arm_ctx_info) + ctx_info->size;
> > +		sz = sizeof(struct cper_arm_ctx_info);
> > +
> > +		if (sz + (long)ctx_info - (long)err >= err->section_length)
> > +			sz += ctx_info->size;
> > +
> >  		ctx_info = (struct cper_arm_ctx_info *)((long)ctx_info + sz);
> >  		ctx_len += sz;
> >  	}
> 

-- 
Thanks,
Mauro

