Return-Path: <linux-efi+bounces-5513-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 118B2C5C56E
	for <lists+linux-efi@lfdr.de>; Fri, 14 Nov 2025 10:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 77F0F35C8C1
	for <lists+linux-efi@lfdr.de>; Fri, 14 Nov 2025 09:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A89307489;
	Fri, 14 Nov 2025 09:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ag4GOtcb"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56C53054E3;
	Fri, 14 Nov 2025 09:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763112708; cv=none; b=b9VmKcBAJgkPlNLiUfuJtKlAr6L6aPamzBuh668EiZmLFdKEpQWbc4WC3vHLUIcxki4Y//Vm19VDLfILYGLZHNTldjlFjq2s9UkUqxvBobalJ+vmzEKo0mSKLiBThmeUOrDNAmimFPBO0hW0klH+uquB2Duoz9bKSC6rvQAAjP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763112708; c=relaxed/simple;
	bh=9SLKXDXDcKYx8CAlptpWCul6CGP4978X3L5355PI5M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpnRkce85qn++tlR+kd/DEPqKbtg0Ytafn8tSZmxu2hVO8Iv84WCTS+bp5p/pPNKJeK61DPb99ikdIQWEhHr+0cb0anOhlyt+oGS8pBu5aHwrw5C2FHRMgSpzFmQjO61oCwK5DBSY0vtbuc76jCmNBWgipU8w3tLuPo8An+mqgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ag4GOtcb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5523C4CEF8;
	Fri, 14 Nov 2025 09:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763112708;
	bh=9SLKXDXDcKYx8CAlptpWCul6CGP4978X3L5355PI5M8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ag4GOtcboNo4bILaEKrxayTQPTvsdBl5wBVf5GkH3q6dlPXzueh6y5fNuZDVLUtht
	 QtJWuQ1HG06LJdQpeKercDqWSF5njGVKcd8umY/ScnGZJM97OmJQaXPGumDUbUsCiT
	 ks9H42BaoMevwsNdi+oOpT7TiWXrJp7pQW9X5BfmRL36TJz67Q64gTlysM1mfNEN2l
	 KW1Scdj9EpB7dkj7/5iq+q3hjSFKkOzw64SGHsMVmPC1bUPcy+GHlii8XE46fZEIju
	 c2FKPYLO0yM4JKjDUiMAWGxDdBBFE4vJWEkcJxn0nlBZeELM6ocqpWL7txsfp/NFei
	 exSzj8u/CkyYA==
Date: Fri, 14 Nov 2025 15:01:40 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, catalin.marinas@arm.com,
	will@kernel.org, mark.rutland@arm.com, andersson@kernel.org,
	konradybcio@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
	shivendra.pratap@oss.qualcomm.com, leif.lindholm@oss.qualcomm.com,
	linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] arm64: efi: Pass reboot cmd parameter to efi_reboot()
Message-ID: <aRb2_OmkRTD46vnx@sumit-X1>
References: <20251114085058.2195900-1-sumit.garg@kernel.org>
 <20251114085058.2195900-3-sumit.garg@kernel.org>
 <CAMj1kXE4Fo3i9f3npB0MBSOZP0x7HgF4A0KX_aUSBEBmar=NpA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXE4Fo3i9f3npB0MBSOZP0x7HgF4A0KX_aUSBEBmar=NpA@mail.gmail.com>

On Fri, Nov 14, 2025 at 10:26:03AM +0100, Ard Biesheuvel wrote:
> On Fri, 14 Nov 2025 at 09:51, Sumit Garg <sumit.garg@kernel.org> wrote:
> >
> > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> >
> > EFI ResetSystem runtime service allows for platform specific reset type
> > allowing the OS to pass reset data for the UEFI implementation to take
> > corresponding action. So lets pass the reboot cmd parameter for the EFI
> > driver to determine whether it's a platform specific reset requested or
> > not.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > ---
> >  arch/arm64/kernel/process.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> > index fba7ca102a8c..51784986c568 100644
> > --- a/arch/arm64/kernel/process.c
> > +++ b/arch/arm64/kernel/process.c
> > @@ -136,7 +136,7 @@ void machine_restart(char *cmd)
> >          * ResetSystem().
> >          */
> >         if (efi_enabled(EFI_RUNTIME_SERVICES))
> > -               efi_reboot(reboot_mode, NULL);
> > +               efi_reboot(reboot_mode, cmd);
> >
> 
> I agree with the general principle. However, there are already
> existing callers of kernel_restart() that would end up passing a
> random string to efi_reboot(), resulting in platform specific reset
> with undefined result.

Yeah true but the UEFI spec says:

"If the platform does not recognize the EFI_GUID in ResetData the platform
must pick a supported reset type to perform. The platform may optionally
log the parameters from any non-normal reset that occurs."

So, in these cases the UEFI implementation can fallback to normal reset
optionally logging the reset data being passed. Does that sounds
reasonable to you?

-Sumit

> 
> E.g.,
> 
> $ git grep kernel_restart\(\"
> drivers/md/dm-verity-target.c:          kernel_restart("dm-verity
> device corrupted");
> drivers/md/dm-verity-target.c:  kernel_restart("dm-verity device has
> I/O error");
> drivers/memory/emif.c:                  kernel_restart("SDRAM
> Over-temp Emergency restart");
> 
> 
> >         /* Now call the architecture specific reboot code. */
> >         do_kernel_restart(cmd);
> > --
> > 2.48.1
> >

