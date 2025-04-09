Return-Path: <linux-efi+bounces-3256-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC3CA82D9B
	for <lists+linux-efi@lfdr.de>; Wed,  9 Apr 2025 19:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26CC217FB72
	for <lists+linux-efi@lfdr.de>; Wed,  9 Apr 2025 17:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36A41D798E;
	Wed,  9 Apr 2025 17:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsdimp-com.20230601.gappssmtp.com header.i=@bsdimp-com.20230601.gappssmtp.com header.b="xm0LzeHN"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA3725A349
	for <linux-efi@vger.kernel.org>; Wed,  9 Apr 2025 17:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744219793; cv=none; b=qXHIb7zirvSrcEnquLr9MXPIVlzs+sMqQS5ho+b42m67BLUsGwFne6HSz4nBBuKd+kRwUWkVpmqSr1J5BFsJzoljm2BTj2wsspTQULK++UK05XAj/V3qxXmGBVKMZTpwJFZ35ncerz7QZE9vZjwcafAYgvn4yMxACUCwPglx7dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744219793; c=relaxed/simple;
	bh=+HLlCvdeEuNa+kyC6w1thp9rZt+MH6trwlOzzYF7NHE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=f5fi+DXc1BpV90LICnHgsDHBRBt5U+1tql5g1ObYZGWSnsasofyNBnE8gSeiDlkHpLBmOlKLPo0N4JiSgRZzlaiHtL6gLV1L6UijSmx49cFL7manHK3E4gjraQtpjojU2E9sW3NKHVgpYhX7V93/NWeIY7W0vYUq8Z30AcDSios=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdimp.com; spf=none smtp.mailfrom=bsdimp.com; dkim=pass (2048-bit key) header.d=bsdimp-com.20230601.gappssmtp.com header.i=@bsdimp-com.20230601.gappssmtp.com header.b=xm0LzeHN; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdimp.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bsdimp.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-301d6cbbd5bso6927848a91.3
        for <linux-efi@vger.kernel.org>; Wed, 09 Apr 2025 10:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1744219791; x=1744824591; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+HLlCvdeEuNa+kyC6w1thp9rZt+MH6trwlOzzYF7NHE=;
        b=xm0LzeHNfGTo5Vg32ScRZQur+L2lVTZmB2zLa5PP+V0NWUxQBgtwO/bR8N3Su+shX0
         DEOpTCrbBeJYbGu69tL5OOTNyfqugcXvnTC3oWU63Dwk3EFsihD0LwrRbDAIlOyIY8VT
         cDX71weVPfHnKPtAq10HUtdc1nbnvm8usdWdHLotlPhszZB1OrYBKJ4bUOhBElZ7VaM9
         imA22Hrb8mcrOpjmE/AzmqXRFj8owwaZNRki08z+U2kFxhatnD0EbXJcBtxwB9fNbukI
         kHTXYPHhq3lG4+umN1YM6abwWROX6/LvAXQttMKo7lPecAw+eAWdmuSTXxT8t2P576vo
         WKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744219791; x=1744824591;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+HLlCvdeEuNa+kyC6w1thp9rZt+MH6trwlOzzYF7NHE=;
        b=EU8eSQOK94rXgHHd+2Pwivs22c60buKgq66FK+KE9DNOd8gInirp+SE51WtPJsAA0v
         80qrnPpoqXbmMv7MPGJEUDgH/isr326BNhYcx1sdrfl3Gj1Q9WoeBzY7ewU7vrbp1se6
         LtcBZlVAbcUeEID+AKHjjDresiZsQofDF+r5PQZwp5OHx2aYwvaKkgx0uUWoZDfzxEcs
         sZhLrv1d3B/W4JLy6Qy5uF3CHPXVGU/9njvVfHFAzsleWNcUH1zskgAroOHcW8mPXL9G
         u1XXQTAWwUXKGqj7lOCzpTYBc9c5rDrlGVC2wvJlJOz5vKyIias370Q1oMlhsJh1G7eL
         mQtQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3vAySxTg5M7nsOz9WqU0qCzTngl4QwL20R96SQ+D+FbF5zm0aGde8avRABfs7rUKXFY6NodAyhtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQiuf3Nl3v5lLsXGDFBx1T2nYKh9zYs0/Ma4mOYS+t1iQFneKg
	6Rq+32Unld1XhXWNiYgGO6ZLy7mjPaJI6U5Lhd9sBGeOpUtE9gN81mHh+ORCyFqsJ/ig4rZlMdx
	5pNSBO1LFxfjdIYeoQ+QlC34h+Q6cbLJN6+pGiA==
X-Gm-Gg: ASbGncu93ksj20kbRdEcURUnLr6AiASwBgEIS/Mk1XXfDVRGBR2qWgcdyWUupMOJIpQ
	PpDDrdcd7S46DVUVG4BfJ0nOSaJO6YByORuBOhMFhUNrkUctoRzE106QwP0sHYehZMbiU8f/cOo
	kJBn2KXVplM5JCEUIFZUKbhQ==
X-Google-Smtp-Source: AGHT+IExugosDNAKVDYpIuA9plJDKEs+BRdattd7CDaGaKEeYg+DcBc7eYoSWHhHd0MJSb7/BlT2gMQtw2bkU6kH/X8=
X-Received: by 2002:a17:90b:5823:b0:306:b593:4557 with SMTP id
 98e67ed59e1d1-306dd31f70emr4723880a91.4.1744219791457; Wed, 09 Apr 2025
 10:29:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 9 Apr 2025 11:29:40 -0600
X-Gm-Features: ATxdqUHK82u4ehDgRrDjMheTR0LW_AsgamCti1AeYcrh4ER_HZzkLwCIjCBFDzI
Message-ID: <CANCZdfpOs6cTSacxzF013AUwOW78oUf5kY11nbTYMrT7W2oP2g@mail.gmail.com>
Subject: Why isn't the EFI memory map published in /sys/firmware/efi?
To: Christian Brauner <brauner@kernel.org>, linux-efi@vger.kernel.org, ardb@kernel.org
Content-Type: text/plain; charset="UTF-8"

Greetings,

I hope this is the right place to send this. Christian Brauner suggested
it to me. If not, please redirect.

I've been working for the past couple of years to add support to FreeBSD's
boot loader to work from a linux environment via kexec_load + reboot(CMD_KEXEC)
on the aarch64 and x86_64 platforms. For the most part, I'm able to live within
the data that linux provides to userland where my loader is running. I am able
to boot FreeBSD/aarch64 and FreeBSD/amd64 today. However, there's two
pieces of data I cannot access from userland that's critical to boot a
new kernel
that's able to use EFI runtime services that I have to get from strange means.

The first one is the EFI system table. On aarch64 I can get it from the DTB
in /sys/firmware/fdt, but it's unpublished that I can find on x86_64. I get it
from boot_params that I read from the kernel with /proc/kcore there. Is there
some reason this isn't published in /sys/firmware/efi/systab or similar? A
number of other, auxiliary tables are published, but not this one that
I could see.

The second one is the memory map for EFI. A subset of it is exported
/sys/firmware/efi/runtime-map, but it is only the runtime services mappings,
not the entire table. FreeBSD populates its memory maps from the EFI Memory
Map that's obtained just before exit boot services is called. So my next
question is why the full map isn't also published? Most of the same data is
available from /proc/iomem, so there's not a data visibility issue that I can
see. BTW, /proc/iomem isn't suitable because it's a processed version of the
efi memory map that loses information. I can use it for the loader to find a
spot to put the kernel, but can't use it as the memory map for the FreeBSD
kernel reliably. The FreeBSD EFI boot loader puts this data into a metadata
region that's passed to the FreeBSD kernel for it to consume, and I need
to retain that functionality.

So, since I can't get the EFI memmap data directly, I have to use indirec
means. For aarch64, I can find the PAs and metadata for the memory map
form FDT. Ditto the EFI system table. I pass my trampoline code the PA and
length for the memory map and the metadata area so it can copy the
needed data for the new kernel.

For x86_64, I open /proc/kcore and read out the boot_params structure.
I can get the PAs and metadata from it. I do a similar trick in the trampoline
to copy the data. This works, but feels very 90s BSD netstat to me (where
all network stats were read directly from kernel variables and had issues
too long to get into here). This is less than idea as well because I have to
rely on the Linux Boot Param structure and it only exists on x86.

On permissively configured systems, I could use /dev/mem or /dev/kmem
to read the actual map so I wouldn't have to do it in the trampoline and
could use the EFI memory map to find where to store the kernel rather
than the /proc/iomem map that I use (it's a subset of the EFI memory map
data, but not enough of one to reconstruct it). But those options aren't
available for some of the environments I have to boot in.

FYI, the Linux kernel gets around this, at least on x86, by cheating a little.
It uses the bzImage kexec handler to copy data from the current boot_params
into the new kernel's boot_params and passes that to the new kernel. It
does this because, I think (I've not traced this out 100%, so be kind on any
corrections), kexec_file is the typical path and the kexec handler can find
the bzImage header in the file. My trampoline doesn't have that header, and
attempts to add it have been unsuccessful, so the path to the new kernel
goes through relocate_kernel in arch/x86/kernel/relocate_kernel_64.S which
clears all the registers and doesn't pass in the boot_params (which is why
I read it from /proc/kcore).

So why isn't there a /sys/firmware/efi/map that I can just read? Why isn't
there a /sys/firmware/efi/systab that I can get the system table address
from? Code for these wouldn't be hard and I could submit that code to
make publishing the data more controlled and regulated. However, I
thought it would be prudent to discuss the reason for the omissions
first to see what the thinking there is.

Thanks for your time and for whatever help and insight you can give me here.

Warner

P.S. I'm using kexec_load rather than kexec_file because the FreeBSD
kernel needs to have a few kb of metadata for the kernel to consume,
plus our at-boot-time loading of modules is done in the loader, plus
passing in parameters to the system is done via the loader, so I don't
have just a single file I can boot from. Supporting these features is required
for our application... I can talk more about the FreeBSD loader structure,
but I don't think it's relevant beyond this short summary and this message
already was too long.

