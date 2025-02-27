Return-Path: <linux-efi+bounces-2855-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D28AA48675
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2025 18:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 466A27A7238
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2025 17:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06461D934D;
	Thu, 27 Feb 2025 17:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFs1BkrD"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97CF1A3178;
	Thu, 27 Feb 2025 17:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740676849; cv=none; b=Nyx6nklJe6k78wqp8KNI/BtylTwR7dnRzNxXsXLTjPFCCZ+XqATpviZdcfXcUS4OHFc3LGPEZTGVY+gsMT1ENi2LvriUy6zyg1pinf7MuzBhfQBwPdlSJNIiFnaoVzWrevbXRnMaQ6aRIBzpLOLEzk+EIKNk0YfV7C0HIez6bfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740676849; c=relaxed/simple;
	bh=+5NpXSEO0RcC6jR94JauzNw/dncFkiJpr2YAuAL3w2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H6UalTTK+uHrIgMaBg61P8dw+a6lRTZYHcrslXLjCb/cKIfP97dtap70BHfYgNhhWHDPbs2Ax3ptlio/JJMpcEUuKPYSb3SFHu9c8IWOxZuJc1dLLGmHVJp815A0LTopRCcdG4FYbCLjCkprAmeBjkCq503LqScIGwmmZANu0uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFs1BkrD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27139C4CEE7;
	Thu, 27 Feb 2025 17:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740676849;
	bh=+5NpXSEO0RcC6jR94JauzNw/dncFkiJpr2YAuAL3w2E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZFs1BkrDMUDWP3vMNdzsZr/gf1zy9kW9wFYOSpwUwwuiN+CFj7q1zoQhqzRwCa2T+
	 PksJE4VX50/Pr4uRH1EJMpitgSTzDTUsDwzC0Rppin4N5V5QHk4tY39SYcJDkXLfb4
	 9b46MJPmg73NiOu8K9OJd0nzsdLtxRYcswdFG01Z8hwBRp121KMG9B8MN81erutyP8
	 qa0ho656b6HtKHR3P1GVrc47i/VszCAgTLVI0eJaS5forc5QM+bjhsspLIZ1UDuACp
	 8xb7OtNV1XY/tEeY2DA+5wB+rKVBLQ+dXNBNjGMoJarxuc1+83fRGtJd19HIRh7VYd
	 7XJV6pR8JR2dw==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-54622829175so1069124e87.0;
        Thu, 27 Feb 2025 09:20:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXKXZMxmqo6Zi+hr2nqqbwgDBTYV0HomtmzWPUM1mYJqF0Xd3R5NFSSw4iEDJ/jkbSiNl32v9StPps=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuC9i9N/C3tIurmjoX1Xz2HA/RNvCMqaTpqZWx2LxsUNTM275N
	H2YR/MkjSvd1vRWN2J0Fxev3NP3+LMeLpDgwjrHCjI7BAcpEhVwaTHkD5vUA8xOxaqnOODY4nAM
	+wf4D2AMvb0x0CD5sNZ9g6zHhEoc=
X-Google-Smtp-Source: AGHT+IGbGzCCGdsY/vecuWXXfNluaToVgE9ufROynrfvyU3TJw1ckVMZZGy5OPdmzlHA5TBldfNUFvDNlhVoDH02VWE=
X-Received: by 2002:a05:6512:3d1b:b0:545:bf4:4bcb with SMTP id
 2adb3069b0e04-5494c38ac59mr96031e87.49.1740676847486; Thu, 27 Feb 2025
 09:20:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226201839.2374631-1-pjones@redhat.com> <CAMj1kXGoZ5RB4GWs_YTG7g+vGZokwe3yF-ri5BV4vOBinhqfLQ@mail.gmail.com>
 <8f085931-3e9d-4386-9209-1d6c95616327@uncooperative.org>
In-Reply-To: <8f085931-3e9d-4386-9209-1d6c95616327@uncooperative.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 27 Feb 2025 18:20:35 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHrrQ_39528oEQ8szEBKPQp8+1V7SGsNSp0fbPV=RWFJA@mail.gmail.com>
X-Gm-Features: AQ5f1JrYfDBYUt4rcNjbRvhCX4AHhDyYemGfNEiWij-hg_IC8JGd4otwiXcaXyU
Message-ID: <CAMj1kXHrrQ_39528oEQ8szEBKPQp8+1V7SGsNSp0fbPV=RWFJA@mail.gmail.com>
Subject: Re: [PATCH] efi: don't map the entire mokvar table to determine its size
To: Peter Jones <pjones@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
	Lenny Szubowicz <lszubowi@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Feb 2025 at 18:13, Peter Jones <pjones@redhat.com> wrote:
>
> On Thu, Feb 27, 2025 at 08:50:08AM +0100, Ard Biesheuvel wrote:
> >
> > Should we add something like the below to avoid mapping the same page
> > over and over again? Or is this premature optimization?
> >
>
> I can't honestly say I'm sure either way, but I'm leaning towards
> thinking it's probably worthwhile.  On my development tree the number of
> these we wind up doing in the maximal case is 31, and but in a typical
> case it's more like 20, with a series that looks something like the
> below list of sizes and relative addresses from the first entry.  (I
> generated this with ls and awk, so it's not quite exact but it's
> fairly representative.)  I've marked which ones could be eliminated.
>
> map 264 at 0x0
> unmap 264 at 0x0    <-- gone
> map 264 at 0x146    <-- gone
> unmap 264 at 0x146  <-- gone
> map 264 at 0x2a2    <-- gone
> unmap 264 at 0x2a2  <-- gone
> map 264 at 0x43e    <-- gone
> unmap 264 at 0x43e  <-- gone
> map 264 at 0x548    <-- gone
> unmap 264 at 0x548  <-- gone
> map 264 at 0x660    <-- gone
> unmap 264 at 0x660  <-- gone
> map 264 at 0x84d    <-- gone
> unmap 264 at 0x84d
> map 264 at 0x191f
> unmap 264 at 0x191f <-- gone
> map 264 at 0x1a73   <-- gone
> unmap 264 at 0x1a73 <-- gone
> map 264 at 0x1b7c   <-- gone
> unmap 264 at 0x1b7c <-- gone
> map 264 at 0x1cd0   <-- gone
> unmap 264 at 0x1cd0
> map 264 at 0x21a8
> unmap 264 at 0x21a8 <-- gone
> map 264 at 0x22c2   <-- gone
> unmap 264 at 0x22c2 <-- gone
> map 264 at 0x23cb   <-- gone
> unmap 264 at 0x23cb <-- gone
> map 264 at 0x24d4   <-- gone
> unmap 264 at 0x24d4 <-- gone
> map 264 at 0x263c   <-- gone
> unmap 264 at 0x263c <-- gone
> map 264 at 0x2746   <-- gone
> unmap 264 at 0x2746
> map 264 at 0x4043
> unmap 264 at 0x4043
> map 264 at 0x86f7
> unmap 264 at 0x86f7
>
> So going from 19 map/unmap pairs to 5.  Seems like it can't hurt, but
> it's a small number either way.
>

So this would go from 19 to 3 on a 16k pages kernel. So I'm leaning to
applying it as well.

BTW these results confirm my suspicion that these headers may appear
misaligned, hence the __aligned(1)

> Anyway, I tried your patch and it works for me:
>
> Tested-By: Peter Jones <pjones@redhat.com>
>

Thanks. I'll apply it as a separate patch, and only tag your patch cc:stable

