Return-Path: <linux-efi+bounces-4471-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00956B10AD0
	for <lists+linux-efi@lfdr.de>; Thu, 24 Jul 2025 15:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02A29AC3ADA
	for <lists+linux-efi@lfdr.de>; Thu, 24 Jul 2025 12:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A44E2D46DF;
	Thu, 24 Jul 2025 12:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="eA0TL8wd"
X-Original-To: linux-efi@vger.kernel.org
Received: from pf-012.whm.fr-par.scw.cloud (pf-012.whm.fr-par.scw.cloud [51.159.173.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220C42D4B6E;
	Thu, 24 Jul 2025 12:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.173.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753361993; cv=none; b=oGERiacL12q6jnw8EG/2bzfODr/LQ0eUym17oqWUxORMiA11SLBw7hLiyYqAWENEjZ5wfFQaLSBNjDe9Lt08zEowPqtWyCBNVILSwsdyMf7Gi1udY6b0UEYaHQ6YJ+cviDEvD5/q/aFsqBYGuIZ/HiHkt9FhXaUhwPSTDJL2j8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753361993; c=relaxed/simple;
	bh=NesxOpaVLIXe2tLn2aFWrHA3FbsXQq8dtDyRFQH8OUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k26/Zo6jdq45I2LfP4es9sn3rmnwXCQGbtMYxTb0+PtaSLu0Vw38hgsWne75mj3DV3n0UutxmB5kAo2AOkiz/6JCmxfP938R6/2vOH2r73hcy0BHDQT5FvIazT6W77tSR4bFEOJsAqaTRf83qQH8T4ENiqXqjbtlpYrKnyzsx4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=eA0TL8wd; arc=none smtp.client-ip=51.159.173.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NqWnKvywWYv7stEIvhc7qFZWUlwqo5/NVMaYKbrw5bo=; b=eA0TL8wddzqRfMF0QLIq04iIUi
	oEVh8KnTYMoyhTCLFcQlip8DDG/tDWVp35+NoCny9oaUKcpxmCxjVoMZWpOmHsdYelUCT7sLScUoa
	zp1SjZwxAhRNnCOx93wJFkWI3mhNjelXrIJ9ODXqhD0KpgGg2rjNY5lXSuJVvO5YM3GLVePjZaPJ6
	oHoigANY3OjNXHoXrmV5yf/jdLI3neesocca82PZ3pu9ijHhE+NFOAOJ2lXc1OFun9146XYltc1Bp
	+dCF1NUWGhhrQq6eEcXeBBy2KsJzA/LhvvbsbaTbzTwEsq16t2CyIPv6V0eUrXiJjH50E4MKnZaWI
	YDiVzdBg==;
Received: from laubervilliers-658-1-215-187.w90-63.abo.wanadoo.fr ([90.63.246.187]:29701 helo=archlinux)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <nicolas.bouchinet@oss.cyber.gouv.fr>)
	id 1uevY0-0000000Cioq-0vwt;
	Thu, 24 Jul 2025 14:59:42 +0200
Date: Thu, 24 Jul 2025 14:59:39 +0200
From: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
To: Paul Moore <paul@paul-moore.com>
Cc: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>, 
	Xiu Jianfeng <xiujianfeng@huawei.com>, linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Yue Haibing <yuehaibing@huawei.com>, Tanya Agarwal <tanyaagarwal25699@gmail.com>, 
	Kees Cook <kees@kernel.org>, linux-efi@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 0/2] Secure Boot lock down
Message-ID: <xfabe3wvdsfkch3yhxmswhootf5vj6suyow5s3ffumcnjkojjz@e7ojgu3s7ion>
References: <1750975839-32463-1-git-send-email-hamzamahfooz@linux.microsoft.com>
 <20250716212925.GA14322@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <CAHC9VhS3qY=+DVYqzkgbHLETUo4KgQ17qr_BC3pn9TeG+cr8Mg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhS3qY=+DVYqzkgbHLETUo4KgQ17qr_BC3pn9TeG+cr8Mg@mail.gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: nicolas.bouchinet@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: nicolas.bouchinet@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi Hamza, thanks for your patch.

Thanks, Paul, for the forward. 

Sorry for the delay, we took a bit of time to do some lore archaeology
and discuss it with Xiu. 

As you might know, this has already been through debates in 2017 [1]. At
that time, the decision was not to merge this behavior. 

Distros have indeed carried downstream patches reflecting this behavior
for a long time and have been affected by vulnerabilities like
CVE-2025-1272 [2], which is caused by the magic sprinkled in
setup_arch(). 

While your implementation looks cleaner to me. One of the points in
previous debates was to have a Lockdown side Kconfig knob to enable or
not this behavior. It would gate the registration of the Lockdown LSM to
the security_lock_kernel_down() hook. 

However, what bothers me is that with this patch, if UEFI Secure Boot is
activated and a user wants to disable Lockdown, they need to go through
disabling Secure Boot. I'm really not fond of that. A user shouldn't
have to be forced to disable security firmware settings because of a
kernel feature. 

We thus might want to add a way to disable Lockdown through kernel
cmdline. However, letting a user disable Lockdown through kernel cmdline
would allow easy Lockdown bypasses, especially since the kernel cmdline
as well as the initramfs are not integrity protected on most distros. A
root user would be able to tamper with kernel cmdline and change its
behavior across reboot. 

IMHO, if someone wants to enable Lockdown, the easy and correct way is
to set the kernel cmdline and integrity protect it using an UKI for
example. If the chain of trust is respected, no Lockdown bypasses should
be possible. 

I'm still open to hearing new arguments about this patch. 

[1]: https://lore.kernel.org/all/29447.1509035858@warthog.procyon.org.uk/
[2]: https://access.redhat.com/security/cve/cve-2025-1272

Best regards,

Nicolas

---

On Thu, Jul 17, 2025 at 02:22:04PM -0400, Paul Moore wrote:
> On Wed, Jul 16, 2025 at 5:29 PM Hamza Mahfooz
> <hamzamahfooz@linux.microsoft.com> wrote:
> >
> > Ping?
> 
> Adding the new Lockdown maintainers to the To/CC line for review in
> case they missed it earlier.  For reference, the patchset can be found
> at the lore link below:
> 
> https://lore.kernel.org/linux-security-module/1750975839-32463-1-git-send-email-hamzamahfooz@linux.microsoft.com/
> 
> > On Thu, Jun 26, 2025 at 03:10:37PM -0700, Hamza Mahfooz wrote:
> > > All major distros have had carried a version of this patch-set
> > > out of tree for sometime now, but with a bunch of magic (typically
> > > sprinkled in setup_arch()). Though we can avoid those architecture
> > > specific quirks if we call efi_get_secureboot_mode() from
> > > efisubsys_init() and that allows us to have a generic solution.
> > >
> > > Hamza Mahfooz (2):
> > >   security: introduce security_lock_kernel_down()
> > >   efi: introduce EFI_KERNEL_LOCK_DOWN_IN_SECURE_BOOT
> > >
> > >  drivers/firmware/efi/Kconfig  | 10 ++++++++++
> > >  drivers/firmware/efi/efi.c    |  9 +++++++++
> > >  include/linux/lsm_hook_defs.h |  1 +
> > >  include/linux/security.h      |  8 ++++++++
> > >  security/lockdown/lockdown.c  |  1 +
> > >  security/security.c           | 15 +++++++++++++++
> > >  6 files changed, 44 insertions(+)
> 
> -- 
> paul-moore.com

