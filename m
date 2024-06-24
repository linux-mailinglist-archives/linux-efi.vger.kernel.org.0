Return-Path: <linux-efi+bounces-1285-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 198E99143B5
	for <lists+linux-efi@lfdr.de>; Mon, 24 Jun 2024 09:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 988CEB216A5
	for <lists+linux-efi@lfdr.de>; Mon, 24 Jun 2024 07:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2B438FA3;
	Mon, 24 Jun 2024 07:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x0SNrOUF"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F86F31A89
	for <linux-efi@vger.kernel.org>; Mon, 24 Jun 2024 07:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719214215; cv=none; b=V61AJgecpQ9Hu33NboYYDtRJCm98EOXTYx6Xy/bHVyPPdQwV51Z+Aqhvlaq0ps6E7p+eboy/gfsYj7cwzsGXDVv/2ZrFyVKLq3PSoz/IR5zx2K6WWeXkE47jrjPGsP+SdltcX0arTXtwXnjWlbAqEIOZiePU2+g6wTxyxw/nr6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719214215; c=relaxed/simple;
	bh=M8cE6CbrRSk+zbBBYOvmEABXXWGImsiVjoJ15IPiQ9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YUSR/D0qZFB58bZw2/u0Ybx2YwDNNX01FGS9E44RqbGoCFxFPuJ2E996twAVkm8mLYMkpR49YdEovBvy44RuyRpX77BpOyKaBRiFKF22T29rUbotIFPC8XMroEZwImjTSFB8/2kOcHEFxdz6wfFjJoY/TvAHuO5BvnUm8019Uic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x0SNrOUF; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52cdebf9f53so1381922e87.2
        for <linux-efi@vger.kernel.org>; Mon, 24 Jun 2024 00:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719214212; x=1719819012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2wEfoJfSxKz/sP5VFQXU0+BbBfrArIiP6A90WvdI4U=;
        b=x0SNrOUFIhOeee7pnT4+LMKAWKS2XFGoqMp0/gIMBFzHuj7oslGlfZyLt4/vKSMqag
         ig2d9Uxvja/nlq0MlgmejjV5t2/3gFBS9CiMBfCPoZEAX4JUVehKsknZyW7mNpSkO03P
         6sc+jCMs/51y7bw4kWpHsXdIQPGn7mQNZd4zdh58V0U2kQiGuq3HYGCKFH4FE6MLnxHy
         8hDG0a18VzCan5rKW3qGkKzy5Z7JJFdYFfCNpWZwbLjfSBaQSWY6MkvC7o3CiLnJzHOK
         2b0T34famoVkHZ6Q8NBWnPSBdaCNQ/k4SLRzbCSgduZsyq8ZY9LAgrzz5Br6ql4BabYw
         g5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719214212; x=1719819012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c2wEfoJfSxKz/sP5VFQXU0+BbBfrArIiP6A90WvdI4U=;
        b=FDm472rngcOiEp2uERdLDUiVQa1HZcyLlvuP/t0THS3789+4fzAg53EXVQHpW1EVFD
         HckF6EzSWRUNSOrEKKTt5SQFG9w32NLC14ERAsngrTTLqu+tmq5o0eTzclDAG+fyEI36
         cH2wRVGrnOb8iBGWzb3QgYqzBtSH1ESxvpiDRcVOr03hVkU4zm9p+jGtOvaWb4ftwBiX
         NPR2MlI9yb1S3RgVaKQoErp63EMRyfiqzGsGSZ+SBDoSnfZlhBkw/SG92Mqi34nMkgTF
         jSujqcA0sqdVbGHem7qRsLN2AcOTtu4M0LsvAiWfYuqyeGr87sq//f2rO+9sK2VEyEHQ
         qpdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLbqbB8+5q1hZ3IoRcOjnJPnNyn3VVWn6+shj1NV3iIX6Ssi53YWW4bFWOrF8KJP2rHA4AJsbMhYKqvKFzrIDz+8sYWv/jaEkP
X-Gm-Message-State: AOJu0YyeL8TlHflZ/yxHtlKUqcAZMJshvnfNVLm5UpZe9o0jjMJnEaG5
	LErm3BNH12DRwxfSpRibYKAUjEaTGePXnCvX0GhfqoBScQfLSCjieI6zaA/fAf3eHlGgz0bqG3B
	iFHW+FwKnbP5Th63xXK8g2064RTqw7/stc3yfmQ==
X-Google-Smtp-Source: AGHT+IF3tAjzNOGGkT0tQNH/0umUeC6Wa2jKs0yWwYAUPb4y9n4wxhkW/20v+RSive8xdIdFYTIgYUauHnzqgbb41co=
X-Received: by 2002:a05:6512:715:b0:52c:b008:3db8 with SMTP id
 2adb3069b0e04-52ce064f483mr1977415e87.38.1719214212126; Mon, 24 Jun 2024
 00:30:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624023612.2134144-1-ruanjinjie@huawei.com>
In-Reply-To: <20240624023612.2134144-1-ruanjinjie@huawei.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 24 Jun 2024 09:30:00 +0200
Message-ID: <CACRpkda-FZmyEyMJrKTdic4t8Zq_VSW8AVrvw6t=B25fiUZNKw@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: Add support for STACKLEAK gcc plugin
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: linux@armlinux.org.uk, ardb@kernel.org, arnd@arndb.de, afd@ti.com, 
	akpm@linux-foundation.org, rmk+kernel@armlinux.org.uk, 
	eric.devolder@oracle.com, robh@kernel.org, kees@kernel.org, 
	masahiroy@kernel.org, palmer@rivosinc.com, samitolvanen@google.com, 
	xiao.w.wang@intel.com, alexghiti@rivosinc.com, nathan@kernel.org, 
	jan.kiszka@siemens.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 4:33=E2=80=AFAM Jinjie Ruan <ruanjinjie@huawei.com>=
 wrote:

> Add the STACKLEAK gcc plugin to arm32 by adding the helper used by
> stackleak common code: on_thread_stack(). It initialize the stack with th=
e
> poison value before returning from system calls which improves the kernel
> security. Additionally, this disables the plugin in EFI stub code and
> decompress code, which are out of scope for the protection.
>
> Before the test on Qemu versatilepb board:
>         # echo STACKLEAK_ERASING  > /sys/kernel/debug/provoke-crash/DIREC=
T
>         lkdtm: Performing direct entry STACKLEAK_ERASING
>         lkdtm: XFAIL: stackleak is not supported on this arch (HAVE_ARCH_=
STACKLEAK=3Dn)
>
> After:
>         # echo STACKLEAK_ERASING  > /sys/kernel/debug/provoke-crash/DIREC=
T
>         lkdtm: Performing direct entry STACKLEAK_ERASING
>         lkdtm: stackleak stack usage:
>           high offset: 80 bytes
>           current:     280 bytes
>           lowest:      696 bytes
>           tracked:     696 bytes
>           untracked:   192 bytes
>           poisoned:    7220 bytes
>           low offset:  4 bytes
>         lkdtm: OK: the rest of the thread stack is properly erased
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I was digging around to see if this would interfere with BPF
trampolines, but the
BPF code seems so generic that I assume it already takes stackleak into acc=
ount.

Yours,
Linus Walleij

