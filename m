Return-Path: <linux-efi+bounces-4231-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA91AFE34A
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 10:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56DB53B974B
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 08:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC0C280CEA;
	Wed,  9 Jul 2025 08:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWcV2WSP"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D96D280335
	for <linux-efi@vger.kernel.org>; Wed,  9 Jul 2025 08:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752051300; cv=none; b=XE+loGjBcLW4vc6+djje/g0cAgthsalIEyayNN8EVBtwBw0TyNjXy7p9lRhCLD7mJP2KTCjcJ2Q86OZqLVadUd83tdtO/j2C1Zk8iPPY0YWZeROeW/M/O0hZmjWJY5fRLsWw3vPRdj576hDQ8JuQTGUQtwoN6fCEepnaJX+E1ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752051300; c=relaxed/simple;
	bh=r9a9tU7sBhO/BeSPTFzQsM69PpwQvXom3NTPc4bEsn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hORBrNh003fCYBYxfRX7DE3iugZzNO77LrKLND8u8vTjhcsQESVvYD/3sQqHxC8kvCG/tpUyDILeOSWjFMPGuleDtuOM3P24jIBj+HYPvAKIzXvIxrIfrtb3SFLR7rp3AWCbs9u0r5425tHryJfP89fXKPh1uhJdOoUcgRkWO0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWcV2WSP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0BFC4CEF5
	for <linux-efi@vger.kernel.org>; Wed,  9 Jul 2025 08:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752051299;
	bh=r9a9tU7sBhO/BeSPTFzQsM69PpwQvXom3NTPc4bEsn0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nWcV2WSPMwOUKKsEpaePqMI4Hnli4ZWs3HmdhlApEsebg+wP/wuV77F77Z983YFpR
	 /4+P2DljklpYEZsGHXuMIU1UB0QuzKt+u6iCrJwwgwgnSn2EG5t2VZiST9cQs0VHHm
	 kYgPUTixjI6CCIL1vBfwpVRsgkUeoUbGHoEXH/9T4mHjrWdvNSXHA0/QW+QpksBiH5
	 j4cizyLXKl2IHkDRNUTgBez48sGRXxSHKXjl3pj6W7qTQE4bsZLQEoYd4RhAJXmNLX
	 kWcyevUavoVgXRlCMdt/nfHMu6nDVjsXJvtG7bsupBZf8Lru+Zkm9PFVnNr4xwkr17
	 /MWLS+A647sbw==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-32b78b5aa39so49215841fa.1
        for <linux-efi@vger.kernel.org>; Wed, 09 Jul 2025 01:54:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXQEMyNgK9KySMt2F5JO/XEqmTQYXc83PcuRg2M8jDKDmCiszy16hOJwkOCHGfXrqrxhjSHlNIDcdo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrxj2d4NuSY48YZ8UuQ8azkjh8nSz4kxZNh4V6pmSNXIgnIcco
	hqWDuCnrjuzqStKYi/ghSZZUCEAcPtKm6LAK326yZHJYrybOjkKEt0cyY1rxYCZToJ9xpu+DCXc
	6HkFDN3V1FJh2XLP3Lx00PQMVO6ftjWI=
X-Google-Smtp-Source: AGHT+IEoFnOdEzuiDuwobZrRiL7ZQ9O/s5DNJf5QfCEKZFSUga+Jd5+1/4LuaaSnlMrfGSdYA99H3vm6IdXg88wUvGU=
X-Received: by 2002:a05:651c:31c5:b0:32c:a097:4141 with SMTP id
 38308e7fff4ca-32f4849f23dmr4993021fa.13.1752051298252; Wed, 09 Jul 2025
 01:54:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202507091432.rbbrjGoU-lkp@intel.com> <5ykr26mowvsliuuyj5gvlw4wl5pginnk2y6zj3nm2f3roxhqxk@l7yelfo2nbm6>
In-Reply-To: <5ykr26mowvsliuuyj5gvlw4wl5pginnk2y6zj3nm2f3roxhqxk@l7yelfo2nbm6>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 9 Jul 2025 18:54:46 +1000
X-Gmail-Original-Message-ID: <CAMj1kXHEJeeaQbh92wOUOMWwXZfTzvTnGuS0AUPL+O3yHeO40g@mail.gmail.com>
X-Gm-Features: Ac12FXxaEuahB3z_ixC54YtDIIsbOgaE7TDuHY4aNyOPCtEvB4mTCOZt7iL3QTo
Message-ID: <CAMj1kXHEJeeaQbh92wOUOMWwXZfTzvTnGuS0AUPL+O3yHeO40g@mail.gmail.com>
Subject: Re: [efi:next 1/1] ERROR: modpost: "efi_kobj" [drivers/firmware/efi/ovmf-debug-log.ko]
 undefined!
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: kernel test robot <lkp@intel.com>, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Jul 2025 at 18:43, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Wed, Jul 09, 2025 at 02:10:09PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
> > head:   42c68c6e354f71498f9e3e31aa5b0f9243bc1618
> > commit: 42c68c6e354f71498f9e3e31aa5b0f9243bc1618 [1/1] efi: add ovmf debug log driver
> > config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20250709/202507091432.rbbrjGoU-lkp@intel.com/config)
> > compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250709/202507091432.rbbrjGoU-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202507091432.rbbrjGoU-lkp@intel.com/
> >
> > All errors (new ones prefixed by >>, old ones prefixed by <<):
> >
> > >> ERROR: modpost: "efi_kobj" [drivers/firmware/efi/ovmf-debug-log.ko] undefined!
>
> I think this is because ovmf-debug-log is the first /modular/ user of
> efi_kobj.

Indeed.

> So the options are to (a) export the symbol, or (b) switch
> the driver from tristate to bool.
>
> Ard, any preference?
>

I'd lean towards the latter, as it would allow us to remove all the
platform device/driver code too, and just have a call from
efisubsys_init() to the probe function (which can be made __init),
conditional on IS_ENABLED(CONFIG_OVMF_DEBUG_LOG). That way, the actual
runtime code that gets retained after boot is only ovmf_log_read() and
nothing else, which means the overhead of having it as a builtin in
negligible.

