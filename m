Return-Path: <linux-efi+bounces-2227-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3761D9DB57B
	for <lists+linux-efi@lfdr.de>; Thu, 28 Nov 2024 11:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96C87B213FE
	for <lists+linux-efi@lfdr.de>; Thu, 28 Nov 2024 10:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2F315D5B7;
	Thu, 28 Nov 2024 10:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8vqW9Jz"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8FF13B7BC;
	Thu, 28 Nov 2024 10:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732789307; cv=none; b=JwlIUg0FdTigvwPBZpz+v4UOVzXX/1P3ldRcX/ha3V9SiJlk/O4/X19KHhDal0e2bJ4UdgMgOGriynuGMMFzmW/PBNZ8voMavGbbSNOf3FBXKauBJ8Fjz42b4ym9n8VtYq0nrzygS7w/vNob4xcNNhRkpcpT1+wSpn2heeML+Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732789307; c=relaxed/simple;
	bh=4EfoEVsFJB6w0A5vmk7+CYyR0KI444JgV0GrVrP34IE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vk9R9/Tk6A7LKSZG9RsrNhX11KM8bAyyMwDu7bpV/+fRlynXAM7ss2SbKvFdcEUKnccX/LWS75FnG6nkGWPAF5XkalQ7rRln5xglA/waGwUE9yyNJ49KHVEhdHGvwdg8IvfopvdBrATrdPttqWMWJ06a2oUOHXDQrQry6SbC1Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8vqW9Jz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EFC3C4CED3;
	Thu, 28 Nov 2024 10:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732789307;
	bh=4EfoEVsFJB6w0A5vmk7+CYyR0KI444JgV0GrVrP34IE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=d8vqW9Jz4QF6Zfqg+EltY46lROgpZFxSLWVFeAkJURcwXn7MvL0FYgbr0ql8gNX54
	 ou3OHBZOigMMxxsQJ9Zq+WHoy8iPFEITbBa9gvBdLNZszvq4LhQYQAEuNFsPLU0HKZ
	 2KYZbzzuRunWlCB3YXi4wma+QF3zSj34lge9bY/0G87/ryqiJwDnFOy9ZgjdC9gNws
	 NPwwraDZ9T9ByDa7C8QfZqXGi4BUMVVo/5MRtzHnPiX3ESnGqcxfJeU9yM92p14O4k
	 RPI4ioh5Tva+hafDgUI/wiDKLyDzel3u2paukQVuNfl6NdFURaBNnymDPQvXVKtDqY
	 AA00ThrOb0LjQ==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53df1e0641fso681302e87.1;
        Thu, 28 Nov 2024 02:21:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUIkwzQUuCOsxzN1VRg2ZdIM9VPbH5pB2XzGInToo+ePAAAnO/Y1dUhTM8toreilhg0QLucSlcWmnMv8c61@vger.kernel.org, AJvYcCUkTGQMmOZzfeqO8/ctpFa/btnSTLuHJ3+Orf3jU3+ywIPWSCu+hc5xb4oVEy0hbEj9sY1n2TqO8Sd2@vger.kernel.org, AJvYcCVks/J5ImTnGNT9WokG7fggrnZ/dC6FGVoblkkKv5nxqATbjMSzMpofv6+tB3CK6VM/8YpUDqANHynfUW2/@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5pKYLic7mnkzYOC23V/A6HrAKyq4hSX7by2E1XafyuODzkL96
	wxMXTUNmxtpMieWHHUsIM7Np5GEwYfgDNEsR768IdO2eIQAwmjYu5hC4eDBc2f7/7LcqPb97EPe
	dduPbjhmLvUEKG7uSMjONaSpkY+s=
X-Google-Smtp-Source: AGHT+IEqWuy/9UWvck/9O/d4DrCd8DvPNnzq5hZHjay2oOo8vuufMsrqxHIFnEcr7UmaD2/pzX9Vmtxwy5hfgMu0K58=
X-Received: by 2002:a05:6512:a94:b0:53d:d3ff:83c0 with SMTP id
 2adb3069b0e04-53df00c607amr3606417e87.12.1732789305585; Thu, 28 Nov 2024
 02:21:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z0gn1N3IsP8r3gTA@hovoldconsulting.com> <CAMj1kXGjiA1HydMaY82MQsYvkchpN7v7CMOB5i3NEdqcYGn19Q@mail.gmail.com>
 <Z0g_HL01eqXu4cwQ@hovoldconsulting.com>
In-Reply-To: <Z0g_HL01eqXu4cwQ@hovoldconsulting.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 28 Nov 2024 11:21:34 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFtr7ejEjjSRj9dcRa7YbO0SR5OR3pm+K6OvbX2=RfhAQ@mail.gmail.com>
Message-ID: <CAMj1kXFtr7ejEjjSRj9dcRa7YbO0SR5OR3pm+K6OvbX2=RfhAQ@mail.gmail.com>
Subject: Re: UEFI EBS() failures on Lenovo T14s
To: Johan Hovold <johan@kernel.org>
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, 
	Ricardo Salveti <ricardo@foundries.io>, Marc Zyngier <maz@kernel.org>, linux-efi@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Nov 2024 at 11:00, Johan Hovold <johan@kernel.org> wrote:
>
> On Thu, Nov 28, 2024 at 09:52:33AM +0100, Ard Biesheuvel wrote:
>
...
> > In upstream EDK2, the map key is just a monotonic counter that gets
> > incremented on every memory map update, so one experiment worth
> > conducting is to repeat the second call to ExitBootServices() a couple
> > of times, increasing the map key each time.
>
> I had already tried repeating the second call (GMM + EBS) by running it
> in a loop, and I do see the map_key increasing for each iteration (e.g.
> by 0x1a).
>
> > Or use GetMemoryMap() to
> > just grab the map key without the actual memory map, and printing it
> > to the console (although the timer is disabled on the first call so
> > anything that relies on that will be shut down at this point)
>
> I just tried adding another inner loop just calling GetMemoryMap() a few
> times and I see the map_key increasing there too for each iteration
> (e.g. by 0x6).
>
> (The map size remains constant.)
>
> I do get the feeling that efi_printk() contributes to the memory map
> updates, and I can indeed get the reference design fw to similarly fail
> if I try to print the map_key after each call to GetMemoryMap() in a
> retry loop.

Per the spec, the only thing you are permitted to call if
ExitBootServices() fails is GetMemoryMap(), and so this is not a spec
violation.

If GetMemoryMap() itself causes the map key to assume a different
value than the one it returns, or if ExitBootServices() invokes event
callbacks on the second call that may cause the map key to get updated
before it manages to check it, there is obviously something wrong in
the firmware implementation.

