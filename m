Return-Path: <linux-efi+bounces-3011-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C1AA65A7C
	for <lists+linux-efi@lfdr.de>; Mon, 17 Mar 2025 18:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C58217DE61
	for <lists+linux-efi@lfdr.de>; Mon, 17 Mar 2025 17:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942451953BB;
	Mon, 17 Mar 2025 17:19:26 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2990C18C337;
	Mon, 17 Mar 2025 17:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742231966; cv=none; b=p0oryGuD3MOi0XjPfBg3l+fYEtTM9vJvsxBCQdRAuhHoWMtkilwLFFZEMljq2sQ9Z+zyk5Ve/8VxT9ylHtWIXejJEUHLwtzwmT0y0vlWCaKHXW2FFOaSk7Sz13uh+k39cCaUHX5SHPae+l5zV7bHQChmTIra2lv3zyRC674ORyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742231966; c=relaxed/simple;
	bh=5jmeB7vnHM3vvmb1jjxtClMgR/j7JV3WOaMlfUmP5Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJr1r50491I/hQBld7rJjHhU09dDvMKI3hELagRDcvHCUxvRcBsbrWcXePLvItp/Y7q4dzQLtcG/YxgdZ6+vydC5yCT4bpkth32fTNbND81D+3Zeszi6JSUvJWe633qEKvp9CVVSXv5XytmmRiPGyunD8isYxyqRPtFmbPzg1sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7465F13D5;
	Mon, 17 Mar 2025 10:19:33 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 919983F694;
	Mon, 17 Mar 2025 10:19:23 -0700 (PDT)
Date: Mon, 17 Mar 2025 17:19:20 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH 3/9] efi: Remove redundant creation of the "efivars"
 platform device
Message-ID: <Z9hZmOiVPUqfqqsY@bogus>
References: <20250317-plat2faux_dev-v1-0-5fe67c085ad5@arm.com>
 <20250317-plat2faux_dev-v1-3-5fe67c085ad5@arm.com>
 <CAMj1kXEejZr2RCUJ59HfLwxQ1zFnWqj7vJ_ObrPTztE5s2UUcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEejZr2RCUJ59HfLwxQ1zFnWqj7vJ_ObrPTztE5s2UUcQ@mail.gmail.com>

On Mon, Mar 17, 2025 at 06:06:24PM +0100, Ard Biesheuvel wrote:
> On Mon, 17 Mar 2025 at 11:13, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > The "efivars" platform device is created but never tracked or used,
> > as there is no driver associated with it. Since this device serves
> > no functional purpose, removing its creation without affecting any
> > functionality.
> >
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Cc: linux-efi@vger.kernel.org
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/firmware/efi/efi.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > index 7309394b8fc98cf7a3424af209b752f0251c8c89..eec173cb1f398d3b4f28b42c917e50e1728dc277 100644
> > --- a/drivers/firmware/efi/efi.c
> > +++ b/drivers/firmware/efi/efi.c
> > @@ -446,7 +446,6 @@ static int __init efisubsys_init(void)
> >                 error = efivar_ssdt_load();
> >                 if (error)
> >                         pr_err("efi: failed to load SSDT, error %d.\n", error);
> > -               platform_device_register_simple("efivars", 0, NULL, 0);
> >         }
> >
> >         BLOCKING_INIT_NOTIFIER_HEAD(&efivar_ops_nh);
> >
>
> IIRC the efi-pstore module autoloads based on this platform device

Indeed I see now, thanks. My bad grep skills didn't work well to catch
this. I will update accordingly.

-- 
Regards,
Sudeep

