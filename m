Return-Path: <linux-efi+bounces-2228-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E829DB636
	for <lists+linux-efi@lfdr.de>; Thu, 28 Nov 2024 12:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C48BB22893
	for <lists+linux-efi@lfdr.de>; Thu, 28 Nov 2024 11:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0581925B3;
	Thu, 28 Nov 2024 11:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgadpRYk"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A63E1494A3;
	Thu, 28 Nov 2024 11:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732791922; cv=none; b=GhRrnxreOJsZupLVqEWasXwU5jSys0uxy0RGxhgz0b4e0l3db+2GC9CFAtvBpAK17e/L+aewupnBq0eKzj95J99AlLmcdKwc2Q8Dorhq/PnPzvmEWCfOb5E4j7CKJxBY933bwjdDBHVOcMFPGlqsKTIPBFkubxCx3sOxuBBb2+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732791922; c=relaxed/simple;
	bh=Tk3SgBmzxf75v8mpHFOojCa1eU5RK95fb1ARplAvCr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dhrv8+MgC6XrUOfhzs3k1ue5fsGN2Fpw2CA3S+dMLJgL0vGbZ6WiDSOrPXqPUIRbzCXFB4mZHFlrwZGXZsKhQBIbiOARJNZ1lgowmnEdj1fKynnB7zZ8hjQTTS51VnZ8pCciGo3JOnZRs0kIaMMfH9vhsGQNIkr5cr5KaqbK9gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sgadpRYk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06343C4CECE;
	Thu, 28 Nov 2024 11:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732791922;
	bh=Tk3SgBmzxf75v8mpHFOojCa1eU5RK95fb1ARplAvCr8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sgadpRYkuUXFkpjw24NWlB9pvIl8IEIcSrCdtE5h4/Cz8ycnW82hdweipurtpcoeG
	 u1eS8gWZ8oKiDO9M9Nx8k5YsKx0hzTFL/sdclt+pdjqjfCyk08lG+FPgI+k34C/pjF
	 dL5WYpQmFoEsLJ5q8+vTFdGKyrCR3HZ1zrRhVSQOukrKFqc11yXU2bUkRhtBNLkqXW
	 U+kqunmAlnqI4wV+AYmOb2muUQWTjySJLk//zpB0DxGOcfi5SRSL8RS67OO0nQKeaf
	 38H7M0Twjhn+fim4YzHOrHXLiYD+WtyPdgPlV/zEuJIznC4lwChKKVkvNmyLRzLtEZ
	 Yzj11q9xJ+e+Q==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ffbfee94d7so6049601fa.3;
        Thu, 28 Nov 2024 03:05:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUt3WT9luNfmNelNRa0hqLhRGEHAUUGN+WIOvlosnqkj/kEibm67xpPqyWSaZjeJoGfDX/DjqRfh8QN@vger.kernel.org, AJvYcCVrw43qur+723jvHh4i/bTmCHnpZw26XQ8sYCfxXRcXztc8ze29BIhBH2aD7hO/PsXDgU0hC3hWigMKnqfl@vger.kernel.org, AJvYcCW8SON0fBJ4Y129WlcfZTVnp59+hM3Ro1XxZ6EpbAjyCrO0ab7gaYNQCHcDhPNDtieN4M443gDlDRjeCmh+@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt+FnrxqSikEU+qfQzjTJEtuwhrOcOpx/3S21LCj4Z+i//rwZy
	lFvg45Kp3wxTRnpH3wYP6iHIaKNqojOcXONahB/0vJ5k7KhqTKpd9kfNDUw2LrG2SSzSdGsdXmT
	e/p6Zh3YqZNJMXOB/aYD/fi5S62E=
X-Google-Smtp-Source: AGHT+IGfCryE9/9cOqbIgjCEMT/F26Kog+spNc3XbOBLC67DHHd+EO0spiyPdSSyrDsU90ykUHitPdH7fxi0sBZnjRk=
X-Received: by 2002:a05:651c:545:b0:2ff:a89b:4348 with SMTP id
 38308e7fff4ca-2ffd5fcc351mr23066001fa.1.1732791920303; Thu, 28 Nov 2024
 03:05:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z0gn1N3IsP8r3gTA@hovoldconsulting.com> <CAMj1kXGjiA1HydMaY82MQsYvkchpN7v7CMOB5i3NEdqcYGn19Q@mail.gmail.com>
 <Z0g_HL01eqXu4cwQ@hovoldconsulting.com> <CAMj1kXFtr7ejEjjSRj9dcRa7YbO0SR5OR3pm+K6OvbX2=RfhAQ@mail.gmail.com>
In-Reply-To: <CAMj1kXFtr7ejEjjSRj9dcRa7YbO0SR5OR3pm+K6OvbX2=RfhAQ@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 28 Nov 2024 12:05:09 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHS_TY=jfBT=dqUQSXf2pBXbt12uaLsMw-FLX3uU_X6uA@mail.gmail.com>
Message-ID: <CAMj1kXHS_TY=jfBT=dqUQSXf2pBXbt12uaLsMw-FLX3uU_X6uA@mail.gmail.com>
Subject: Re: UEFI EBS() failures on Lenovo T14s
To: Johan Hovold <johan@kernel.org>
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, 
	Ricardo Salveti <ricardo@foundries.io>, Marc Zyngier <maz@kernel.org>, linux-efi@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Nov 2024 at 11:21, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 28 Nov 2024 at 11:00, Johan Hovold <johan@kernel.org> wrote:
> >
> > On Thu, Nov 28, 2024 at 09:52:33AM +0100, Ard Biesheuvel wrote:
> >
> ...
> > > In upstream EDK2, the map key is just a monotonic counter that gets
> > > incremented on every memory map update, so one experiment worth
> > > conducting is to repeat the second call to ExitBootServices() a couple
> > > of times, increasing the map key each time.
> >
> > I had already tried repeating the second call (GMM + EBS) by running it
> > in a loop, and I do see the map_key increasing for each iteration (e.g.
> > by 0x1a).
> >
> > > Or use GetMemoryMap() to
> > > just grab the map key without the actual memory map, and printing it
> > > to the console (although the timer is disabled on the first call so
> > > anything that relies on that will be shut down at this point)
> >
> > I just tried adding another inner loop just calling GetMemoryMap() a few
> > times and I see the map_key increasing there too for each iteration
> > (e.g. by 0x6).
> >
> > (The map size remains constant.)
> >
> > I do get the feeling that efi_printk() contributes to the memory map
> > updates, and I can indeed get the reference design fw to similarly fail
> > if I try to print the map_key after each call to GetMemoryMap() in a
> > retry loop.
>
> Per the spec, the only thing you are permitted to call if
> ExitBootServices() fails is GetMemoryMap(), and so this is not a spec
> violation.
>
> If GetMemoryMap() itself causes the map key to assume a different
> value than the one it returns, or if ExitBootServices() invokes event
> callbacks on the second call that may cause the map key to get updated
> before it manages to check it, there is obviously something wrong in
> the firmware implementation.

If you're happy to experiment more, you could try and register a
notification for EFI_EVENT_GROUP_BEFORE_EXIT_BOOT_SERVICES using
CreateEventEx(), and see if it gets called when ExitBootServices() is
called. That would at least help narrow it down.

