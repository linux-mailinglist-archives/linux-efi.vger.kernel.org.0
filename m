Return-Path: <linux-efi+bounces-1071-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 800D88CCADA
	for <lists+linux-efi@lfdr.de>; Thu, 23 May 2024 04:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A137E1C2128A
	for <lists+linux-efi@lfdr.de>; Thu, 23 May 2024 02:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18FA38FA8;
	Thu, 23 May 2024 02:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NT0xLTnf"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336FE2AF06;
	Thu, 23 May 2024 02:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716432700; cv=none; b=fJ3n+qjWXFk73ToZprfduZK0fZzIhfFMvJnncmh0zLlcE5DAoi4/mgmAxKaqGLzXEagFwzyzgxCJpEP+kbK4kqUleVIifAWslHHos3QM2Q7vmHSjbCQcp1r6hBz13NdLvKfLZf5LQAmXp4ClLvP+QabRt1UiK8dAFkDwH60gx4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716432700; c=relaxed/simple;
	bh=L4gIo40B47l110xzGHVHr6MNainA3eD8XbSrUjVcopo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMPSkwlmC49z650tDKkiekRK4h2gRXrsL1OwWaGDRZZXWn+zJniEoAsK8MekbrO9aMSZwtncHU06EKs8cMcDqdBXjn78s+nbEmwyPM2Ud1zc6BDMnVXqOEGEPAHA7Wu1nwW7K77gZbacwuFk5WjXcy51EM2aBA0hUJIB0NX4gjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NT0xLTnf; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ba0cb1ea68so1725930a91.0;
        Wed, 22 May 2024 19:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716432698; x=1717037498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2t+NNcAooBs+1uLVQmd6CHKgztQaFCVL8iN2oZTgqXk=;
        b=NT0xLTnftZtmAu+SqQkTLsLe0FbN3NRP++yWJyPE6FAjLhyq2n5lnt4CoaBrtvmENZ
         aQ7CU2Erfojol0oruYd+Czk3tBL6v2yRdZuUJMKi1kXGHHOWoovnbOfiAIGiVr9us0Mo
         ImvZjGYKEuObp4doU5Q5YMoRzN7lJJmEHoInFI3rx+tYb22ZdstVObQGWEmy9x6YFtqM
         7z0UknrdwLI+N7X9X+Mxncfw3AMSDq66KqgwI117Behw9DTGjU/zRDSC0GZFILfZ1IEX
         goc/hKkQ8Q2t69Y6DfjMUdewwC0Y6frPk2ZV/ENBws8qzpaDi0aVmh05CJMswtKKqInV
         cI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716432698; x=1717037498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2t+NNcAooBs+1uLVQmd6CHKgztQaFCVL8iN2oZTgqXk=;
        b=APAZkw0+Rt3/Q9yZrPSCCXzNdFhfQxx/RKLoo68SB7sTnouKoaKkxSCwYKXSE7UzN/
         CAo+xbZibhFAThAUdFvAvqe6d03bAThmY2W/txiO9JJCo/4ypXMXhNJtctSTBE3pw1J5
         WS90ZS1rwQ8hD6js/kB2xE40WahQZonHEfBcxv5G5fV05/UXpLiUoFGYlA3g5BrI5j1j
         N09MmF4yI52lW4DXUdDjS/jGBOMzquzEhVJQCfR4psAAuG4B9Tj77LcElZaeU18HQM/t
         zNRVbxQvCAmO/DHHZjjZMBgAkP6rsJun50Eti3+5yLzkQnfgBoJvQB3t1DsiHtShLrq6
         PJnA==
X-Forwarded-Encrypted: i=1; AJvYcCUSJWQo66Z4PnWveRbU9o/1UMxa1xEIOAqrRJ4P2LnEB0vqkK3yrA3fE5xrxxIxbYltwTWgHkJR/ds3i7tWQ/5kJDPhYP5RXeMqLGYgmg5m2ANvnR06DnJxJWCp7y+t2J7AkDA+T70MWMeUzeXezusGKVVfu2Rc4XuJEXNG4VapO5tKm+2qdceRwTNGt+p5cYz0HV1eLMwHQWbPdnnPU8KeJtGKLCwwQVtPRF9V9USUaSO1gfoxkM8kOExIfA==
X-Gm-Message-State: AOJu0YxKPnrCsD7GymUrLl46LpPuIKf7ISkW6CokcufcJOAKjvomPRuY
	n0VVdgnH9dYM856ubzjPOmoTF6nT/rA/3/azJRW7AmAInnJjUR4U5M6+Mg==
X-Google-Smtp-Source: AGHT+IFkp6UpIh1AGPSwzeu7PRXoylLdjeBnYEOtYMQKu1m9NKdsV0nftrMR0T4y+aBKEkMG7hxvGw==
X-Received: by 2002:a17:90a:a506:b0:2ad:6294:7112 with SMTP id 98e67ed59e1d1-2bd9f456c77mr4103774a91.14.1716432698305;
        Wed, 22 May 2024 19:51:38 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bdd9f0b3d3sm575494a91.26.2024.05.22.19.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 19:51:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 22 May 2024 19:51:35 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Lukas Wunner <lukas@wunner.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
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
Message-ID: <e12b0027-b199-4de7-b83d-668171447ccc@roeck-us.net>
References: <cover.1712410202.git.lukas@wunner.de>
 <92ee0a0e83a5a3f3474845db6c8575297698933a.1712410202.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92ee0a0e83a5a3f3474845db6c8575297698933a.1712410202.git.lukas@wunner.de>

Hi,

On Sat, Apr 06, 2024 at 03:52:02PM +0200, Lukas Wunner wrote:
> Deduplicate ->read() callbacks of bin_attributes which are backed by a
> simple buffer in memory:
> 
> Use the newly introduced sysfs_bin_attr_simple_read() helper instead,
> either by referencing it directly or by declaring such bin_attributes
> with BIN_ATTR_SIMPLE_RO() or BIN_ATTR_SIMPLE_ADMIN_RO().
> 
> Aside from a reduction of LoC, this shaves off a few bytes from vmlinux
> (304 bytes on an x86_64 allyesconfig).
> 
> No functional change intended.
> 

Not really; see below.

> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
> ---
...
> index da79760..5193fae 100644
> --- a/init/initramfs.c
> +++ b/init/initramfs.c
> @@ -575,15 +575,7 @@ static int __init initramfs_async_setup(char *str)
>  #include <linux/initrd.h>
>  #include <linux/kexec.h>
>  
> -static ssize_t raw_read(struct file *file, struct kobject *kobj,
> -			struct bin_attribute *attr, char *buf,
> -			loff_t pos, size_t count)
> -{
> -	memcpy(buf, attr->private + pos, count);
> -	return count;
> -}
> -
> -static BIN_ATTR(initrd, 0440, raw_read, NULL, 0);
> +static BIN_ATTR(initrd, 0440, sysfs_bin_attr_simple_read, NULL, 0);
>  

sysfs_bin_attr_simple_read is only declared and available if CONFIG_SYSFS=y.
With m68k:m5208evb_defconfig + CONFIG_BLK_DEV_INITRD=y, this results in

/opt/buildbot/slave/qemu-m68k/build/init/initramfs.c:578:31:
	error: 'sysfs_bin_attr_simple_read' undeclared here (not in a function)

This happens because CONFIG_SYSFS=n and there is no dummy function for
sysfs_bin_attr_simple_read(). Presumably the problem will be seen for all
configurations with CONFIG_BLK_DEV_INITRD=y and CONFIG_SYSFS=n.

On a side note, init/initramfs.c does not directly include linux/sysfs.h.
I don't know if that might cause problems with other builds.

Guenter

