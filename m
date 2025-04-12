Return-Path: <linux-efi+bounces-3314-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D189A86F5C
	for <lists+linux-efi@lfdr.de>; Sat, 12 Apr 2025 22:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4413219E1776
	for <lists+linux-efi@lfdr.de>; Sat, 12 Apr 2025 20:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C1A1FF1D9;
	Sat, 12 Apr 2025 20:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cl0FcuHk"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC84C19C54F;
	Sat, 12 Apr 2025 20:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744489502; cv=none; b=ZdM85FxQXJxmh0YONeejOrOxgDohkd4FCTrP0kHcAKEH8sdT+3+LqopvnEYEQusqBWbOI3sZniy4ruY0UtSwqqwYLZoJ6Oj5DBaOXqS6drODPmVogoqK2n+xJmobzscTK5+iMHd5HFRUnViE8PWaVt5mC8JVIiQhtdVVk2stW64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744489502; c=relaxed/simple;
	bh=40edMMJ2XODOR7H2VfGkNOhXw51X4x9Rae5/PHyzSHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FZfDwpNS8Sg7w5NA8hQs3zyqsUlEIewL/fPEenE+8rsM9YIEuUDXe2LQ5zctEL2r1zZxa+YlOUStGdL3ImQ4y9aTVhjXUGxSVIyuQGj/Rtl/EWy1KRxivJlDLaGzAQaHgTjCgpdHEgcygY+gUN1d2Q5l2NFAk5lY/tZ0jE/y1MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cl0FcuHk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C267C4AF0B;
	Sat, 12 Apr 2025 20:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744489501;
	bh=40edMMJ2XODOR7H2VfGkNOhXw51X4x9Rae5/PHyzSHk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cl0FcuHk/ljRHzcQg0TKJH/ZeyTDpWzF/xEfEU22gaRCnc1VhfDEkdqWxls26RbNa
	 verYXpeROAvJu2txA1g2FwSPJw5sb9RZLYuHJTJizmrfNaOJVGUTRg73KVOlAhvxto
	 WnV5evT6Jsm49rr8EAvCNs6ARi+wF4eToLYqLMSOO1GY6aWKA9NenuwKbChBLh4zeo
	 riEt+bPper78u3HYMjNf8g5FVhklJ6kWz+b0i5EQ0euqOgjokc5AvMwyzl3TIe/ibu
	 elJmsjySjAn5BzXtN80Rqz15OzLt7fRYZalxHYfFoTlrT/XPKTfSer0CfnWTS5h5Ct
	 kBsVg/yPhh5VA==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54afb5fcebaso3907385e87.3;
        Sat, 12 Apr 2025 13:25:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVGzbzl05hUI+Nbp5PShq0vszB2g6cAViB4krg1VkmjCl9oKsBMqr6jiWRfjd1om36Nuum4kKF9oeg=@vger.kernel.org, AJvYcCXjCMYZY4ysOFL9+vaq+pN+MRLO1ORCO4bIOs9q/iMePagACMcCNxbhiNigyCQjxxOtC4AaoQNbY2mTKeHQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxbiK8yAU/1YJgkFl6nJ9Uo3WkyH8wQCgRVk2h2/5dnJziKDK25
	gGW5vfjIjshbTaiJRUV5LWYsQxVPpha09OklSgVASupvzC2VPGFCRwTZM9yhvm9pMzR8bFxH8Zh
	wEluR8a8V3xEu3sPvQZP6LR2Cdsk=
X-Google-Smtp-Source: AGHT+IF3lEYMMNwwOJMC3mxegwOvCSFxD9fldlnpXeOkFp1VM6xQXYzSoZVICjA7msbr14iR1WzX5025NMQhWKuOOro=
X-Received: by 2002:a05:6512:1307:b0:549:8c86:740d with SMTP id
 2adb3069b0e04-54d4529611bmr2088338e87.18.1744489499487; Sat, 12 Apr 2025
 13:24:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410134117.3713574-13-ardb+git@google.com>
 <20250410134117.3713574-21-ardb+git@google.com> <Z_pbLAw56NIFo7yK@gmail.com>
 <Z_q1RthXIbSXY2Eq@gmail.com> <Z_rIJx_b70rzzERV@gmail.com>
In-Reply-To: <Z_rIJx_b70rzzERV@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 12 Apr 2025 22:24:48 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHAp5mWYTWP33B3JDu9z-+pHczA_pU06zEadgPcyL8ehg@mail.gmail.com>
X-Gm-Features: ATxdqUEZZQvOgAw89glRYWXl4l3zaNghbagskpFgiUzPsERB29J3TsBHX8xGip8
Message-ID: <CAMj1kXHAp5mWYTWP33B3JDu9z-+pHczA_pU06zEadgPcyL8ehg@mail.gmail.com>
Subject: Re: [PATCH v4 08/11] x86/sev: Split off startup code from core code
To: Ingo Molnar <mingo@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 12 Apr 2025 at 22:08, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ingo Molnar <mingo@kernel.org> wrote:
>
> > Ignore that, I have now read the cover letter too, with the patch
> > dependency mentioned there - as kindly pointed out by Ard in a
> > private mail. :-)
>
> But there are other problems during the allmodconfig final link:
>
>   vmlinux.o: warning: objtool: __sev_es_nmi_complete+0x5a: call to __asan_memset() leaves .noinstr.text section

This is an odd one, because noinstr functions should not be
instrumented by kasan afaik.

>   ld: error: unplaced orphan section `.data.rel.local' from `vmlinux.o'

This should have been included in
68f3ea7ee199ef77551e090dfef5a49046ea8443, the commit log has the
details. TL;DR this is .rodata with relocatable quantities, which is
not emitted into .rodata when using -fPIC.

>   make[2]: *** [scripts/Makefile.vmlinux:91: vmlinux.unstripped] Error 1
>
> The objtool warning is caused by:
>
>   x86/sev: Split off startup code from core code
>
> Tte link failure by:
>
>   x86/boot: Move SEV startup code into startup/
>

Thanks for the report - I'll fix these up in the next revision.

