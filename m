Return-Path: <linux-efi+bounces-1270-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B669121A5
	for <lists+linux-efi@lfdr.de>; Fri, 21 Jun 2024 12:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFB421C21EC7
	for <lists+linux-efi@lfdr.de>; Fri, 21 Jun 2024 10:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013C6171657;
	Fri, 21 Jun 2024 10:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ooct2TjO"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA54217106D;
	Fri, 21 Jun 2024 10:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718964406; cv=none; b=NAtsF1/kDhNAACymeekPqQftQ8SIGxg5OcMF6H/dmJFC+FB4p1+pnHBv4WTRL/JfbJQcgCDaUVRdMh+mIusG0vUccGonxYcNUoz8ByRUmJRR6wYrcqMlgOy0Bm6t7V7TXeqwfI2OqkbPZciU7ytkc4yThYoEU1CCPChQyhkXH00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718964406; c=relaxed/simple;
	bh=L6eYXPIPPhgP0qC3Tjf8Pjxd20/lkYjctHCuQ+kiEmc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yn1HIx56Bsg1362BnKT2vpzPZmGO2jD0TKFlkMtAr+p1LLlePDGOfOD3nQtGAGOlBByGFfhv27edKkMhmJoFY6jRRy0GwmQk+SZ918i2d08eXAlnvcAWcLAzSKfxKGN6uZxuMu/9KYCKSy87KxoSNpq+ualJFpJMqT9LeEqcrSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ooct2TjO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E5CBC4AF08;
	Fri, 21 Jun 2024 10:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718964406;
	bh=L6eYXPIPPhgP0qC3Tjf8Pjxd20/lkYjctHCuQ+kiEmc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ooct2TjOrG7BRZof/lAee0MjE2cqy9jLtv4uwJQKPA1JH98uLHGfl1F4UAYJRZcC6
	 a8pwDXinvB4cx5g42wNY40pJwyNp30IGcbOgfkrRMeRs2j6th0guZhc0goGpDCg1Zt
	 mnPGQ+vgIu3TtvpKYRN9hCyHGolT5zyc/YhLnswYFotXS+iv4UOk0im1z5CeKT1lZi
	 7IOaq0Ig4giQFrvlL/IwkRVuB4Ehd0iG1bYcwckhsc9VAthHq+py0cQ4AJX8RExo34
	 R5vNH21zGBlmCbdlwY6+9osSdIaG1Hwin9YuL0taTy593G8jUmFs/WoNVLeYtRgTe2
	 iTViONJogcH3g==
Date: Fri, 21 Jun 2024 10:47:15 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Shiju Jose
 <shiju.jose@huawei.com>, Tony Luck <tony.luck@intel.com>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>, "Alison
 Schofield" <alison.schofield@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Len Brown <lenb@kernel.org>, Shuai Xue
 <xueshuai@linux.alibaba.com>, <linux-acpi@vger.kernel.org>,
 <linux-edac@vger.kernel.org>, <linux-efi@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] efi/cper: align ARM CPER type with UEFI
 2.9A/2.10 specs
Message-ID: <20240621104706.19063944@sal.lan>
In-Reply-To: <20240621103050.00004ec0@Huawei.com>
References: <cover.1718906288.git.mchehab+huawei@kernel.org>
	<d808b8b76c58054ccd4a8c49dcc2d23fee5ed397.1718906288.git.mchehab+huawei@kernel.org>
	<20240621103050.00004ec0@Huawei.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 21 Jun 2024 10:30:50 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> escreveu:

> On Thu, 20 Jun 2024 20:01:46 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Up to UEFI spec, the type byte of CPER struct for ARM processor was
> > defined simply as:
> > 
> > Type at byte offset 4:
> > 
> > 	- Cache error
> > 	- TLB Error
> > 	- Bus Error
> > 	- Micro-architectural Error
> > 	All other values are reserved
> > 
> > Yet, there was no information about how this would be encoded.
> > 
> > Spec 2.9A errata corrected it by defining:
> > 
> > 	- Bit 1 - Cache Error
> > 	- Bit 2 - TLB Error
> > 	- Bit 3 - Bus Error
> > 	- Bit 4 - Micro-architectural Error
> > 	All other values are reserved
> > 
> > That actually aligns with the values already defined on older
> > versions at N.2.4.1. Generic Processor Error Section.
> > 
> > Spec 2.10 also preserve the same encoding as 2.9A
> > 
> > See: https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#arm-processor-error-information
> > 
> > Adjust CPER and GHES handling code for both generic and ARM
> > processors to properly handle UEFI 2.9A and 2.10 encoding.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> 
> I think you can avoid complexity of your masking solution.
> Cost is we don't have that function print that there were reserved bits
> set, but that could be easily handled at the caller including notifying
> on bits above the defined range which might be helpful.
> 
> > diff --git a/drivers/firmware/efi/cper-arm.c b/drivers/firmware/efi/cper-arm.c
> > index d9bbcea0adf4..4c101a09fd80 100644
> > --- a/drivers/firmware/efi/cper-arm.c
> > +++ b/drivers/firmware/efi/cper-arm.c  
> ...
> 
> >  	if (error_info & CPER_ARM_ERR_VALID_PROC_CONTEXT_CORRUPT) {
> > @@ -241,6 +232,7 @@ void cper_print_proc_arm(const char *pfx,
> >  	struct cper_arm_err_info *err_info;
> >  	struct cper_arm_ctx_info *ctx_info;
> >  	char newpfx[64], infopfx[65];
> > +	char error_type[120];
> >  
> >  	printk("%sMIDR: 0x%016llx\n", pfx, proc->midr);
> >  
> > @@ -289,9 +281,11 @@ void cper_print_proc_arm(const char *pfx,
> >  				       newpfx);
> >  		}
> >  
> > -		printk("%serror_type: %d, %s\n", newpfx, err_info->type,
> > -			err_info->type < ARRAY_SIZE(cper_proc_error_type_strs) ?
> > -			cper_proc_error_type_strs[err_info->type] : "unknown");
> > +		cper_bits_to_str(error_type, sizeof(error_type), err_info->type,
> > +				 cper_proc_error_type_strs,
> > +				 ARRAY_SIZE(cper_proc_error_type_strs),
> > +				 CPER_ARM_ERR_TYPE_MASK);  
> 
> Maybe drop this mask complexity and just use
> FIELD_GET() to extract the relevant field with no shift from 0.

IMO not using the function will make the code here more complex, as the
same code needs to be duplicated on two places: here and at ghes, where
the error bits are printed using pr_warn_ratelimited():

                cper_bits_to_str(error_type, sizeof(error_type), err_info->type,
                                 cper_proc_error_type_strs,
                                 ARRAY_SIZE(cper_proc_error_type_strs),
                                 CPER_ARM_ERR_TYPE_MASK);
 
                pr_warn_ratelimited(FW_WARN GHES_PFX
                                    "Unhandled processor error type: %s\n",


Also, other parts of CPER uses cper_bits_print() for the same reason:
to have the common print code handled inside a function instead of
repeating the same print pattern everywhere.

> > +		printk("%serror_type: %s\n", newpfx, error_type);
> >  		if (err_info->validation_bits & CPER_ARM_INFO_VALID_ERR_INFO) {
> >  			printk("%serror_info: 0x%016llx\n", newpfx,
> >  			       err_info->error_info);  
> 
> 
Regards,
Mauro

