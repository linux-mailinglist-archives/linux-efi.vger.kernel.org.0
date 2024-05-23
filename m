Return-Path: <linux-efi+bounces-1073-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 057E28CCC88
	for <lists+linux-efi@lfdr.de>; Thu, 23 May 2024 08:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A848D1F217F1
	for <lists+linux-efi@lfdr.de>; Thu, 23 May 2024 06:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0717B13C8FF;
	Thu, 23 May 2024 06:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fCKm2ZqA"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07A113C8F2;
	Thu, 23 May 2024 06:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716447112; cv=none; b=Xvd+77JDLi6cJKMaO1jp3T7KT/GCYC+97lIXRc0J0qLoHoZEOqWwV8d1BNQXmEO74kvz7gkfamHg8OKNzRhy2xrIuLkYQtcZ2td8TFJcT2G5LgwCtb8GwRofTgiVe6QeEFJcKQ111AgbWktqPEoYnNASt8VKrf3AVVsTj/OsdbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716447112; c=relaxed/simple;
	bh=vxr2mkzYP8mbnwy26aQJbbvOzWaMQB/nx4kIMYC3W1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=naNIdBjZ4yCzP5Rt4fkmQnliJKrcdXD4YrcYoWrDgwVt+fjfHfaGVXmk9WsMndufH2vUb9TX8NQLdaBuOqF+JIdcEjxs8T7iq0h1oPIi5UTlhOyXrFbsH4zeF1Edhv+YEIWTdL82DcXo8ZqRmOM14GQqo2ogQ468Rp3j9r4Ro9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fCKm2ZqA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01670C2BD10;
	Thu, 23 May 2024 06:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716447112;
	bh=vxr2mkzYP8mbnwy26aQJbbvOzWaMQB/nx4kIMYC3W1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fCKm2ZqAe71lxfgsC1I+obtVtvkM6KQ988dCXcZSItgRCne5xkpE9HqIVIHKcURGn
	 OWi/X6qgvW381+OQ/PkhE0Gztw5g2taRrf+tH/4CpccMpg/oFdYXTYk3bx4mTg2JQF
	 If/tlvTZPws+h4VEuXiCei21esZR+7aawIwmlyDM=
Date: Thu, 23 May 2024 08:51:49 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Lukas Wunner <lukas@wunner.de>, "Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
	Jean Delvare <jdelvare@suse.com>, Ard Biesheuvel <ardb@kernel.org>,
	linux-efi@vger.kernel.org, Zhenyu Wang <zhenyuw@linux.intel.com>,
	Zhi Wang <zhi.wang.linux@gmail.com>,
	intel-gvt-dev@lists.freedesktop.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
	linux-modules@vger.kernel.org
Subject: Re: [PATCH 2/2] treewide: Use sysfs_bin_attr_simple_read() helper
Message-ID: <2024052334-nape-wanting-0a2a@gregkh>
References: <cover.1712410202.git.lukas@wunner.de>
 <92ee0a0e83a5a3f3474845db6c8575297698933a.1712410202.git.lukas@wunner.de>
 <e12b0027-b199-4de7-b83d-668171447ccc@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e12b0027-b199-4de7-b83d-668171447ccc@roeck-us.net>

On Wed, May 22, 2024 at 07:51:35PM -0700, Guenter Roeck wrote:
> Hi,
> 
> On Sat, Apr 06, 2024 at 03:52:02PM +0200, Lukas Wunner wrote:
> > Deduplicate ->read() callbacks of bin_attributes which are backed by a
> > simple buffer in memory:
> > 
> > Use the newly introduced sysfs_bin_attr_simple_read() helper instead,
> > either by referencing it directly or by declaring such bin_attributes
> > with BIN_ATTR_SIMPLE_RO() or BIN_ATTR_SIMPLE_ADMIN_RO().
> > 
> > Aside from a reduction of LoC, this shaves off a few bytes from vmlinux
> > (304 bytes on an x86_64 allyesconfig).
> > 
> > No functional change intended.
> > 
> 
> Not really; see below.
> 
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
> > ---
> ...
> > index da79760..5193fae 100644
> > --- a/init/initramfs.c
> > +++ b/init/initramfs.c
> > @@ -575,15 +575,7 @@ static int __init initramfs_async_setup(char *str)
> >  #include <linux/initrd.h>
> >  #include <linux/kexec.h>
> >  
> > -static ssize_t raw_read(struct file *file, struct kobject *kobj,
> > -			struct bin_attribute *attr, char *buf,
> > -			loff_t pos, size_t count)
> > -{
> > -	memcpy(buf, attr->private + pos, count);
> > -	return count;
> > -}
> > -
> > -static BIN_ATTR(initrd, 0440, raw_read, NULL, 0);
> > +static BIN_ATTR(initrd, 0440, sysfs_bin_attr_simple_read, NULL, 0);
> >  
> 
> sysfs_bin_attr_simple_read is only declared and available if CONFIG_SYSFS=y.
> With m68k:m5208evb_defconfig + CONFIG_BLK_DEV_INITRD=y, this results in
> 
> /opt/buildbot/slave/qemu-m68k/build/init/initramfs.c:578:31:
> 	error: 'sysfs_bin_attr_simple_read' undeclared here (not in a function)
> 
> This happens because CONFIG_SYSFS=n and there is no dummy function for
> sysfs_bin_attr_simple_read(). Presumably the problem will be seen for all
> configurations with CONFIG_BLK_DEV_INITRD=y and CONFIG_SYSFS=n.

Lukas, can you send a patch adding a dummy function?

thanks,

greg k-h

