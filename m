Return-Path: <linux-efi+bounces-5517-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF11C5D0EE
	for <lists+linux-efi@lfdr.de>; Fri, 14 Nov 2025 13:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A75C235ADEC
	for <lists+linux-efi@lfdr.de>; Fri, 14 Nov 2025 12:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363592264CD;
	Fri, 14 Nov 2025 12:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etOD6sJe"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0B0136358;
	Fri, 14 Nov 2025 12:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763122579; cv=none; b=o9BIVO4ahFivEPmUwTX8BwAz8FFD+WO1jcRBmaQs58wsLBNuNrhsvdUeyccDG5aCRj1FSmOasWkMbEr5d4H2+r9ibzzAHhv9f5l8pGS19EKIdpgo7rl7pylND42GkaihZCz3T05JGuyhlmCUFm+WJKKpqpOvDQD+Ef9PBVNKOZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763122579; c=relaxed/simple;
	bh=5RqXHqHz4UU/Pqj/bZXRU6L0/3Ft4c4j+w400Ub4OMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGIPkzAj+w7KkTfEO/BETvBkwYcTraYmZlmluNHWs979QTOxqtPp22bWr/OAe7MojE6J/t62ON80mzA/mG4xQWCvpzyjhfSW6ilRPdP4pbEg5ZiZ5XFLL5Aq3rfdFb3Yj/0hcA/vQW9x0QBLm3SUJcbYps9TiIxYs0VuaFgy+t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etOD6sJe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C813C4CEF1;
	Fri, 14 Nov 2025 12:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763122578;
	bh=5RqXHqHz4UU/Pqj/bZXRU6L0/3Ft4c4j+w400Ub4OMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=etOD6sJe6gVAOIzkTbbf5u51+gHFETMrpPt26qH77RYIyd9FEeBZshZ9sTzFabFgw
	 Vls5lMsnSXt5n0pUbBKvyaxRM5vYXYKFXZ8dKhrVeWi7WlyKOQvdqBGPybtOZu3vt/
	 K6XGCajFHSpDGMdbVoyS9UzhAc8iSQ2a6TKEssdmOSnZxLZcrOTZ1q81XLiHkjdzYR
	 j0BFXq1SHuT/g5/iccpgag9XV3SUibryAL5sj96NpPwa8gd7gkH0+OCTwSZlstd3im
	 c7+QRSjgPhIrB/dgJb6All7DJB8x/otBsSEs44cC3+iNc9x1VMBLy1J3NuuQu728NS
	 7Q5CtnAj8vQeA==
Date: Fri, 14 Nov 2025 17:46:11 +0530
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
Message-ID: <aRcdiwgM9h_S7rP-@sumit-X1>
References: <20251114085058.2195900-1-sumit.garg@kernel.org>
 <20251114085058.2195900-3-sumit.garg@kernel.org>
 <CAMj1kXE4Fo3i9f3npB0MBSOZP0x7HgF4A0KX_aUSBEBmar=NpA@mail.gmail.com>
 <aRb2_OmkRTD46vnx@sumit-X1>
 <CAMj1kXFpi1fMuAhuaBbMSd57F79E7Z0u4okzkKL+_6eKfGUKXA@mail.gmail.com>
 <CAMj1kXE60LrWi8Au6qQ4EMQDFxQCJt5h6hBLuQHCz3HEp=2o3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXE60LrWi8Au6qQ4EMQDFxQCJt5h6hBLuQHCz3HEp=2o3w@mail.gmail.com>

On Fri, Nov 14, 2025 at 10:35:33AM +0100, Ard Biesheuvel wrote:
> On Fri, 14 Nov 2025 at 10:33, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Fri, 14 Nov 2025 at 10:31, Sumit Garg <sumit.garg@kernel.org> wrote:
> > >
> > > On Fri, Nov 14, 2025 at 10:26:03AM +0100, Ard Biesheuvel wrote:
> > > > On Fri, 14 Nov 2025 at 09:51, Sumit Garg <sumit.garg@kernel.org> wrote:
> > > > >
> > > > > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > > > >
> > > > > EFI ResetSystem runtime service allows for platform specific reset type
> > > > > allowing the OS to pass reset data for the UEFI implementation to take
> > > > > corresponding action. So lets pass the reboot cmd parameter for the EFI
> > > > > driver to determine whether it's a platform specific reset requested or
> > > > > not.
> > > > >
> > > > > Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > > > > ---
> > > > >  arch/arm64/kernel/process.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> > > > > index fba7ca102a8c..51784986c568 100644
> > > > > --- a/arch/arm64/kernel/process.c
> > > > > +++ b/arch/arm64/kernel/process.c
> > > > > @@ -136,7 +136,7 @@ void machine_restart(char *cmd)
> > > > >          * ResetSystem().
> > > > >          */
> > > > >         if (efi_enabled(EFI_RUNTIME_SERVICES))
> > > > > -               efi_reboot(reboot_mode, NULL);
> > > > > +               efi_reboot(reboot_mode, cmd);
> > > > >
> > > >
> > > > I agree with the general principle. However, there are already
> > > > existing callers of kernel_restart() that would end up passing a
> > > > random string to efi_reboot(), resulting in platform specific reset
> > > > with undefined result.
> > >
> > > Yeah true but the UEFI spec says:
> > >
> > > "If the platform does not recognize the EFI_GUID in ResetData the platform
> > > must pick a supported reset type to perform. The platform may optionally
> > > log the parameters from any non-normal reset that occurs."
> > >
> > > So, in these cases the UEFI implementation can fallback to normal reset
> > > optionally logging the reset data being passed. Does that sounds
> > > reasonable to you?
> > >
> >
> > What the UEFI spec says might deviate from how real platforms in the
> > field will behave when being passed a reset type that nobody ever
> > tried passing before.

I suppose from OS point of view, we need to follow the UEFI
specification. However, there will be scope for quirks later if the real
world problems occur. Currently, in case of EFI reboot we are just
ignoring the reboot cmd parameter.

If you have in mind any sanity checks we should do here then feel free
to propose and I can try to implement them.

> 
> Also, the GUID is expected to follow an unbounded NULL terminated
> UTF-16 string in memory, so we could easily cause a crash by doing
> this if \0\0 doesn't appear in the memory following the string.

Okay I see, would following change on top of this patchset address this
concern?

--- a/drivers/firmware/efi/reboot.c
+++ b/drivers/firmware/efi/reboot.c
@@ -5,6 +5,7 @@
  */
 #include <linux/efi.h>
 #include <linux/reboot.h>
+#include <linux/ucs2_string.h>

 static struct sys_off_handler *efi_sys_off_handler;

@@ -14,11 +15,18 @@ void efi_reboot(enum reboot_mode reboot_mode, const char *data)
 {
        const char *str[] = { "cold", "warm", "shutdown", "platform" };
        int efi_mode, cap_reset_mode;
+       unsigned long reset_data_sz = 0;
+       efi_char16_t *reset_data = NULL;

        if (!efi_rt_services_supported(EFI_RT_SUPPORTED_RESET_SYSTEM))
                return;

        if (data) {
+               reset_data_sz = ucs2_strlen(data) * sizeof(efi_char16_t);
+               reset_data = kzalloc(reset_data_sz + 2, GFP_KERNEL);
+               memcpy(reset_data, data, reset_data_sz);
+               reset_data_sz += 2;
+
                efi_mode = EFI_RESET_PLATFORM_SPECIFIC;
        } else {
                switch (reboot_mode) {
@@ -47,8 +55,7 @@ void efi_reboot(enum reboot_mode reboot_mode, const char *data)
                efi_mode = cap_reset_mode;
        }

-       efi.reset_system(efi_mode, EFI_SUCCESS, sizeof(data),
-                        (efi_char16_t *)data);
+       efi.reset_system(efi_mode, EFI_SUCCESS, reset_data_sz, reset_data);
 }

 bool __weak efi_poweroff_required(void)

-Sumit

