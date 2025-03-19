Return-Path: <linux-efi+bounces-3040-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 930A2A68F17
	for <lists+linux-efi@lfdr.de>; Wed, 19 Mar 2025 15:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AFBB3A261C
	for <lists+linux-efi@lfdr.de>; Wed, 19 Mar 2025 14:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2D51C9B6C;
	Wed, 19 Mar 2025 14:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m8YxZ4RV"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9271C862A;
	Wed, 19 Mar 2025 14:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742394373; cv=none; b=ac0dNj+0xC51GFxK/u39QD/APCrMyP586OWdilT+MZUQXedvZ0L2pL8ydNlKVJe9vZ9BAcUlU0QZpuVfYX8iSvSG8GdF886aqHIrMeO7PW3o/OKc/thWbb62kSO05RzhEiftfIu77rqVnWdY9uuFh24RnsFGB4vqk6GuxrE3Cv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742394373; c=relaxed/simple;
	bh=anHhSUQfHnLqojw56takRc7tj3TcrdOVFTZnnHcV0zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/bvE3BBSfb98zha/j9lkNXyREFCyOk4FLdk20a+MH2Xw56G6YFWKV3j7foOLuoO1fyctGqEKw0locI3ZsyzairPVpkbQKgFeg2Wjix4mAiUvI4WJf+gFV0lIP3Z0wH8HFUEY8CcRuiEsGUu5vx2h5cbeR4rNrJnCxYAvyVR3gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m8YxZ4RV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67EAC4CEEA;
	Wed, 19 Mar 2025 14:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742394372;
	bh=anHhSUQfHnLqojw56takRc7tj3TcrdOVFTZnnHcV0zw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m8YxZ4RV/VV8Zs698RA9TqoG1eITeBEN8EXPZh4To/bQdllfBPKj+BzqWf/vYZot+
	 vhtwExO3v1FUvcSRExPFH82XJrey+FfOHI9h4TUnQFq7m3Z2+XcXSakD9SVNmP/mHa
	 fFFijxaG/JbXI/S4QRZQv7dCun9ZBXg0lY0Uep4E=
Date: Wed, 19 Mar 2025 07:24:53 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH v2 5/8] virt: efi_secret: Transition to the faux device
 interface
Message-ID: <2025031942-gotten-epidermis-eeee@gregkh>
References: <20250318-plat2faux_dev-v2-0-e6cc73f78478@arm.com>
 <20250318-plat2faux_dev-v2-5-e6cc73f78478@arm.com>
 <CAMj1kXGJkApH73r9qEGABe3M4pXP2gMW3tDXfz2F6WGPZ3nhug@mail.gmail.com>
 <Z9rDely6YxIQZTrK@bogus>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9rDely6YxIQZTrK@bogus>

On Wed, Mar 19, 2025 at 01:15:38PM +0000, Sudeep Holla wrote:
> On Tue, Mar 18, 2025 at 06:10:41PM +0100, Ard Biesheuvel wrote:
> > On Tue, 18 Mar 2025 at 18:02, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > The EFI secret area driver does not require the creation of a platform
> > > device. Originally, this approach was chosen for simplicity when the
> > > driver was first implemented.
> > >
> > > With the introduction of the lightweight faux device interface, we now
> > > have a more appropriate alternative. Migrate the driver to utilize the
> > > faux bus, given that the platform device it previously created was not
> > > a real one anyway. This will simplify the code, reducing its footprint
> > > while maintaining functionality.
> > >
> > > Cc: Ard Biesheuvel <ardb@kernel.org>
> > > Cc: linux-efi@vger.kernel.org
> > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > 
> > So how is module autoload supposed to work with this driver?
> > 
> 
> IIUC, you are right. It doesn't work. I got carried away how efi_pstore was
> autoloaded in Ubuntu even without alias or platform/faux device creation. I
> don't know how yet but that works. This modules doesn't.
> 
> So we may have to retain platform device/driver for autoloading reasons ?

If that's required, yes.

