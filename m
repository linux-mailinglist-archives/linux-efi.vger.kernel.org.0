Return-Path: <linux-efi+bounces-3925-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9147FAE4D8E
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jun 2025 21:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B4913A5EBC
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jun 2025 19:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F38E1F4628;
	Mon, 23 Jun 2025 19:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZeSXzSg"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C1C1E1DFE;
	Mon, 23 Jun 2025 19:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750706707; cv=none; b=q2Hu+R+GGrlkIxEOlsKNo/4y0r/B9sSGrjOBdSqB7NXelG+xp7ckInHZKuoiop3DgSBS2HIW3500QUjGQGAjgN8OFBblxllxNatgRDz1WJh8oD6+AMBZ0aV6kdTtcQbM7+geR4tWifahpyj5/jWnNpgQFclwcRda85wc2cpmHME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750706707; c=relaxed/simple;
	bh=rOVt0ekDWltweCaLCTF+9Wh1oLMlOw+5K9zPrhbVDr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LjrdszmkQXDFOIjfwZPBF1+2gtu1U2vHtRnn3BKNBTrhSToIV7th9z7oYNyPIfhzMsnq8+wb4OoI1NiguHrUHqUz3GnaIMUwZNVkdJZM1qv3JL7ctNz3RV8CJLS8NkLrI14ckYt9z5LMp+umhMAYhkuQw/h90iUkeYb2AC6dt44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZeSXzSg; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-32b5226e6beso42282541fa.2;
        Mon, 23 Jun 2025 12:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750706703; x=1751311503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1mZHTt0VM9DkazGbD62GtKPk6Iel2GLHMmH+VCvcXL8=;
        b=MZeSXzSgTDvShlCVZPJLHVwoXVl3hb0n8V3UxTjCVe/pjKaoneKsKfGrwlO198XGmS
         FtCLv5PkGXhSJTR7GLPgEaauPKuFZUxMYURuwXLfWlS/I+PrFvQtWuW0+RPw1GAd5n0H
         gCf0W7vaebtrLFRsLCyTZF7hUCiQrX9aR1gBNq4Qg1hhC6czXRf5E/+wJmB/60TAb4aR
         abSGpSv54J4ZDWPldcJSmYZtwZnsn2N8Es9hoY9+RLSa6zL7LXMCw+ELTzgpMyqjDyiX
         Yh3veQt7nW5Jz40+zcnMdZAW3yuTZ/tGPB8/fS+k+LSYegZMC/oLT1gOu5wLGTdBgmyd
         aBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750706703; x=1751311503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1mZHTt0VM9DkazGbD62GtKPk6Iel2GLHMmH+VCvcXL8=;
        b=oBNRGDZ7nH1R/YLFF2GwXy0PI14BBorFRclTsdb9VNX8ixkh3/yDIbn1qdkZ6FbWzO
         Mpd2uiIBF6Y/vs5xRW/dUJ8Uf0bHHYkvkA5IaxJQbuubw7oZdlWSmdVIzx+jUbldieH3
         Z8Z6w0ADrYmjRo3Jpp7LWCnhvDh12Ch2idgVnkd9HBB4CSSZGkp2szKtEp7DphoBjZH0
         VKPdUfMiAwiy7MMh8fgEjBnlgQ87yLgy8AuIanEUAU4XSDeYjjvXKG6jsz/t/iHwRh/K
         Q3BEpL1K634oo4ccEnz4IK1fBsimoaUFIaAhiTwJIHQ7aEpgkfQXDvlnJu9ge8zvnWWw
         H1UA==
X-Forwarded-Encrypted: i=1; AJvYcCURGpH8VW/w1afEYrrGGnYBNk7vmiLcTsYEhnIfrfccKD/ESLgIXX/hDKYBrWk1ToXE/9fXzBs3SJMLkGzO@vger.kernel.org, AJvYcCVljOXxK0zPoRbt22KifmsCq/0341DE99fA8CBMrDlrM2itrTInD32FPLXonRA9KHr4mHGXwcQr+Co=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvFUxf9yj8mQbe3um3xexSAJdF4W6sTPdoORvI5MYVcXMKCJuV
	MBUtORK63Ycp8PQ6xMuJof4Oma+JbWNMRkaMbBVK2FMpupKSgFmRanbfTPGGbD2NUYjwQ/yblCf
	TKZC3rHtc0LJmBZlfbuRNC7eRyOQ/Cf2z
X-Gm-Gg: ASbGncvlKbP+P4USrkTLzTMu+kt93Q8H7sg/oprT5xxz8o04OxjvqdN9soW+MTfTAHY
	ZDcdvaVA2H7yDT+E78jSxaCUn6H8r6HN2h3IAxORVlFvDHR4lbmbCA7U92v5t1OqFI5fZ/KK2pi
	pB9MRuo+3St7uaVEFzdBGnexzAGxhDRNXiZMsyLzkR9nqdJrhPKOlJH/+jqA==
X-Google-Smtp-Source: AGHT+IFu4u+dDHVpx6K5Dqdz4Es5UYLRw4rVmbwNsUoycKCYN/tcUUjEKpxREGNOK9tzL5Mv7yvKdx8FgUcK6Jhmag4=
X-Received: by 2002:a2e:aa26:0:b0:32a:7122:58c9 with SMTP id
 38308e7fff4ca-32b98e90beamr22406861fa.5.1750706703061; Mon, 23 Jun 2025
 12:25:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <860684c8-a985-47bc-af30-3370f203e80d@zytor.com> <20250623183917.13132-1-khaliidcaliy@gmail.com>
In-Reply-To: <20250623183917.13132-1-khaliidcaliy@gmail.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Mon, 23 Jun 2025 15:24:50 -0400
X-Gm-Features: AX0GCFvdbqcIgfbSMyoSfml-UrzHEltzomya8JZlsvay0B7QWNTyIi4zg08_Wb8
Message-ID: <CAMzpN2jP_rtFjvL3NQLcwFCgY8uwbJvqbup-KFHVaaSh-oRCcQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] x86/boot: Supply boot_param in rdi instead of rsi
 from startup_64()
To: Khalid Ali <khaliidcaliy@gmail.com>
Cc: hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, ubizjak@gmail.com, x86@kernel.org, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 2:40=E2=80=AFPM Khalid Ali <khaliidcaliy@gmail.com>=
 wrote:
>
> > This is also invoked by some external bootloaders that boot the ELF
> > image directly, even though this is strongly discouraged.
> >
> > Therefore this patchset is NAKed with extreme prejudice.
>
> Thanks both of you peter and brian,
>
> however, the boot protocol document saying "%rsi must hold the base addre=
ss of the struct boot_params",
> it doesn't mention why. Maybe the document needs update to justify the re=
asons. I wouldn't have known it
> if you didn't tell me, so this shouldn't confuse anyone else.

The use of RSI was inherited from the 32-bit kernel, but the real
reason is lost to history.  It's just always been that way and there
is no compelling reason to change it.


Brian Gerst

