Return-Path: <linux-efi+bounces-4849-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C50B81459
	for <lists+linux-efi@lfdr.de>; Wed, 17 Sep 2025 20:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 659531C80BF4
	for <lists+linux-efi@lfdr.de>; Wed, 17 Sep 2025 18:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADFA3002C7;
	Wed, 17 Sep 2025 18:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="g1LtUuBN"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7542FC02D
	for <linux-efi@vger.kernel.org>; Wed, 17 Sep 2025 18:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758132048; cv=none; b=nFQqM29+5Tz9fkLXKdVLWP89frHZDsq5vZF9j63hfHomybm7zsxagC2JMQ+yVbxOXXewgDc6WnccUufebB5MCgtXR9xOyaT8v/fNvC6nmZdttgUqfzeCkkoZELv1Cf7lqrxllI0WbMtybGP5isyq//jEPhJxUYe58dFEkGGxJoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758132048; c=relaxed/simple;
	bh=DLDcGQ3mu3T/MPVKq0NF9V2I5Jn6ILZwFaw9KVQfhOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rbHaR1aCxlXRYIv5IeIA8GWTXmABF61UiJ16qD5JgLW6tY/Gcn+nFqQOl4ojVuRp+VHsFRYMJ5Y8V21eKnFmYssYi47NRnU3JeieC8QIxqPFw1bYHFDz9RtN7W7njoNCZPwURuNZPTUBMT+dX0MaET7iANbw18eouN/ErJj9mhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=g1LtUuBN; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-577232b26a6so101902e87.2
        for <linux-efi@vger.kernel.org>; Wed, 17 Sep 2025 11:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1758132044; x=1758736844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Pv4dFUExNQfPloEDat7jfEF9BkjeLOy7zrinjdnc80=;
        b=g1LtUuBN2lj4qvyQzWAdLKTewMPpvB0BMgAm3EhYmOSEcT379TNMgVSmJk7DCmgjc/
         T0eHokwlFMY3Yd+mXYCz+ekytPn0ndF69T0GJJIC1YMQr15FXnETUToESn8hAOjjN4TJ
         wc+dE3joK8Hj6X0qrUlvmHpmCBRx7/hVESh3NV1/RSPbebawN77L/JxPYbAY8rno5NPR
         h45BlMuQrVS79kOiLhszZHO32mHd/xwXNvhKNiRJJPEEOxGanxAq7D4RvCoxMPnsrP0o
         gtEy+UX8pbw1CA/Tbhp0++SKDmI4SgqYBJ/2EKyXEOwvuyrgRQgYTYLI+VQny1h7rWhV
         /NkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758132044; x=1758736844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Pv4dFUExNQfPloEDat7jfEF9BkjeLOy7zrinjdnc80=;
        b=Z7H0gOVffswLGfj+Qb0gCd8U94UBww4Peuly+c1A/M2qXw5kdviLZkUMlRkvTUuV8I
         zHTVSO8Mo07EfI4u2BjPpPix36dBRGhpX7nZkhiLPbTMqmv0strYW91vt1eksT+XepWi
         oRli/1Jb0iOChIoQm/ZLjwZA5jZvb+qbzu+DmYi/tSSdqdvtl6dP0gAJuoHwyyEkfwp4
         ASq/q65mnplVEERaOG2zIJ3jznhZTuJUEludjnJFnjsutEty+LiV1jIJl6ubn5ytaIOu
         wsSDhe0IvIisnjq8ntYFeO4DGjcB1BDczMfEshW03JNCDW0nZ59GW6N0DvkdgUpdb6D5
         byDg==
X-Forwarded-Encrypted: i=1; AJvYcCW03ymSwWVj7LWQiqOJZuaMoIx+ejjlk2jVoycRn5s3vr2MBsy93aJIBXVaFKiWJV28SkHOhLlPB9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAeICiSGuHq5UtSoYNBHghfrB1Ixrw3/3RbwZR1jk1S+hNeILp
	X9MGWD3OFaGfhabhkTiPZlk6epzSNWdobYOSfrZynoukoSJY3eLvPKGRtHkaFbLqq66g3ha0ytl
	Gde+OoBcglCye7EAXwCHEVg9wYL4+b+IVuqUGD/mK
X-Gm-Gg: ASbGncsH1RJDF1uozAUmfCUGlGIpaw8gNJNptZHewGlH89xL47DQJNfwArePS7OFi2f
	Z9RonnSd+a/dHLoomMISS+0soL64b07lxAATJDGFZjU25y0AcnEHht+eicgyxb3pkfdVS8fyUoa
	VzlKDgH3E/UsO44z+fvYprxMYPDPch15CqDcfwExlRcE+55M/HYRxDlm5gF1TnCmdHZStE8Tf2z
	jb0Uw==
X-Google-Smtp-Source: AGHT+IGI+xF2OSgRbI6+fabXiqu9Xwuf5bxWYwnja/rNGOUuSmNzhH42MNUAKuR34Ox7ov8nmiujA9clDhMS84oRbmU=
X-Received: by 2002:ac2:4e09:0:b0:576:d217:3f2f with SMTP id
 2adb3069b0e04-57796b5e819mr1028160e87.3.1758132043747; Wed, 17 Sep 2025
 11:00:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912223937.3735076-1-safinaskar@zohomail.com> <0342fbda-9901-4293-afa7-ba6085eb1688@landley.net>
In-Reply-To: <0342fbda-9901-4293-afa7-ba6085eb1688@landley.net>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 17 Sep 2025 11:00:32 -0700
X-Gm-Features: AS18NWAGwakGZ9zjxjq7MnfN8O7ZgOJb6fmKIJ0JIML7P3j0NnlDZ27eNb5S7Es
Message-ID: <CALCETrXHxOkHoS+0zhvc4cfpZqJ0wpfQUDnXW-A-qyQkqur-DQ@mail.gmail.com>
Subject: Re: [PATCH 00/62] initrd: remove classic initrd support
To: Rob Landley <rob@landley.net>
Cc: Askar Safin <safinaskar@zohomail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Julian Stecklina <julian.stecklina@cyberus-technology.de>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, Art Nikpal <email2tema@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Eric Curtin <ecurtin@redhat.com>, 
	Alexander Graf <graf@amazon.com>, Lennart Poettering <mzxreary@0pointer.de>, linux-arch@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, x86@kernel.org, 
	Ingo Molnar <mingo@redhat.com>, linux-block@vger.kernel.org, initramfs@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-ext4@vger.kernel.org, 
	"Theodore Y . Ts'o" <tytso@mit.edu>, linux-acpi@vger.kernel.org, Michal Simek <monstr@monstr.eu>, 
	devicetree@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Heiko Carstens <hca@linux.ibm.com>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 10:09=E2=80=AFAM Rob Landley <rob@landley.net> wrot=
e:

> While you're at it, could you fix static/builtin initramfs so PID 1 has
> a valid stdin/stdout/stderr?
>
> A static initramfs won't create /dev/console if the embedded initramfs
> image doesn't contain it, which a non-root build can't mknod, so the
> kernel plumbing won't see it dev in the directory we point it at unless
> we build with root access.

I have no current insight as to whether there's a kernel issue here,
but why are you trying to put actual device nodes in an actual
filesystem as part of a build process?  It's extremely straightforward
to emit devices nodes in cpio format, and IMO it's far *more*
straightforward to do that than to make a whole directory, try to get
all the modes right, and cpio it up.

I wrote an absolutely trivial tool for this several years ago:

https://github.com/amluto/virtme/blob/master/virtme/cpiowriter.py

it would be barely more complicated to strip the trailer off an cpio
file from some other source, add some device nodes, and stick the
trailer back on.  But it's also really, really, really easy to emit an
entire, functioning cpio-formatted initramfs from plain user code with
no filesystem manipulation at all.  This also makes that portion of
the build reproducible, which is worth quite a bit IMO.

--Andy

