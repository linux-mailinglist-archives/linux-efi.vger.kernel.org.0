Return-Path: <linux-efi+bounces-1646-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D62C796B00C
	for <lists+linux-efi@lfdr.de>; Wed,  4 Sep 2024 06:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 145391C23A41
	for <lists+linux-efi@lfdr.de>; Wed,  4 Sep 2024 04:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD3281751;
	Wed,  4 Sep 2024 04:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjOF5XbW"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FD55381B;
	Wed,  4 Sep 2024 04:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725425156; cv=none; b=IS1/jf+jaInZIJy003yogWOA/YOseaEpJw0rrLTbJqnlK18Wki6z343wU+394EBmMSlyaSwoL/4RrvgzxjyqhcgGJZq1h0Ka7VqRjaqPlYt7laB95Ozgy6K7GwBNwv1JrbTCMSD2dNF6YUcIDpshJ59ylvVW9/kOZOH1EgLu8E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725425156; c=relaxed/simple;
	bh=wcFLCeYTeyUSTuGP1QzTQIKlExhYG2j5zY/Vdbu+sTw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KpIi27YRk7KigNt7Y9o5+CKolJpPqWeI83WjJOPSmntx+rHfo+8+m+LhNatWoqSlrtNU/VBc2XVHLtZQpr+WlP81dGXsmQG5sZVoqufrEBtCX1+m3kW0pm3SmHNi08Zp4+Eu13romPU/e4PUBortgNE5BPBSd3HV+8Lx9e8GQ1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjOF5XbW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A66FC4CEC2;
	Wed,  4 Sep 2024 04:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725425156;
	bh=wcFLCeYTeyUSTuGP1QzTQIKlExhYG2j5zY/Vdbu+sTw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kjOF5XbW2Z9iBEHjwxMfVB9fe3T5DvQPTECApfctmd08tn55/+pXfKUwFBGkQgtE+
	 WxII98wtnWJ1fv3A3/Eu9tbT+IcxLk6JZ9rTon48BIpfGGHKxm6pAlzxZLs8JeL1UK
	 lF7PVGZEs9DEGusjaLPpuZwjQPjdG6R2kSdY1r61ExOqW/v1xxd/BmWVMDf8lLZIBw
	 XKJFD1m3XuTdBv/yZkqhxpZbqqu3u4lWo01WB5KA4Y56wMsxJ6j2dgHlWV7DWBIDCR
	 uVDdEkRnLgOyRoZPvKiJPHaHNCie6t+13bnZLKGSxVotVRHzhZb+hUtD+Cexv0AHrC
	 WB2FzR2Jrv+yQ==
Date: Wed, 4 Sep 2024 06:45:49 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>, Ard Biesheuvel <ardb@kernel.org>, James
 Morse <james.morse@arm.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Len Brown <lenb@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Shiju Jose <shiju.jose@huawei.com>, Alison
 Schofield <alison.schofield@intel.com>, Dan Williams
 <dan.j.williams@intel.com>, Daniel Ferguson
 <danielf@os.amperecomputing.com>, Dave Jiang <dave.jiang@intel.com>, Ira
 Weiny <ira.weiny@intel.com>, Shuai Xue <xueshuai@linux.alibaba.com>,
 linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] efi/cper: align ARM CPER type with UEFI
 2.9A/2.10 specs
Message-ID: <20240904064549.0bddeaab@foz.lan>
In-Reply-To: <20240902152755.GFZtXZe5FPSfjRa9u3@fat_crate.local>
References: <cover.1720679234.git.mchehab+huawei@kernel.org>
	<1ca1274f57fac69eda2f193de53077e8254a70fe.1720679234.git.mchehab+huawei@kernel.org>
	<20240902152755.GFZtXZe5FPSfjRa9u3@fat_crate.local>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Mon, 2 Sep 2024 17:27:55 +0200
Borislav Petkov <bp@alien8.de> escreveu:

> On Thu, Jul 11, 2024 at 08:28:55AM +0200, Mauro Carvalho Chehab wrote:
> > Up to UEFI spec 2.9, the type byte of CPER struct for ARM processor
> > was defined simply as:
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
> > Spec 2.10 also preserve the same encoding as 2.9A.
> > 
> > Adjust CPER and GHES handling code for both generic and ARM
> > processors to properly handle UEFI 2.9A and 2.10 encoding.
> > 
> > Link: https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#arm-processor-error-information
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  drivers/acpi/apei/ghes.c        | 15 ++++++----
> >  drivers/firmware/efi/cper-arm.c | 50 ++++++++++++++++-----------------
> >  include/linux/cper.h            | 10 +++----
> >  3 files changed, 38 insertions(+), 37 deletions(-)  
> 
> How was this thing ever tested?!?!

It was tested on ARM, together with QEMU error injection code I'm working
there. Currently, only GPIO and SEA notification types are supported, so
no x86 support yet (I'm trying to add SCI too, allowing to test on x86
as well[1]).

It sounds that bitfield.h is indirectly included from
arch/arm64/include/asm/sysreg.h when compiled on such arch.

Anyway, I'll add an include for it there.

[1] https://gitlab.com/mchehab_kernel/qemu/-/commits/TODO_x86_ghes?ref_type=heads
    code is not working yet. I'm stuck with an issue related with EDK2.
    on x86_64, it is failing to create a new fw_cfg file needed to
    store HEST error structures.

Regards,
Mauro

