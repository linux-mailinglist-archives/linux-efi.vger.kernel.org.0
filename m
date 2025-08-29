Return-Path: <linux-efi+bounces-4654-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9AFB3C173
	for <lists+linux-efi@lfdr.de>; Fri, 29 Aug 2025 19:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FEAF5A1B3E
	for <lists+linux-efi@lfdr.de>; Fri, 29 Aug 2025 17:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541B3322A18;
	Fri, 29 Aug 2025 17:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPXlDAgL"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C96C340D81;
	Fri, 29 Aug 2025 17:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756486959; cv=none; b=c9R5LxFqQ5RpeXIK6RTqlC4CtrbXXqUp66elu6pzMXA0V6vvFuMiZFKXXCjYWAQ2fLVhwss22+YBGC0KqBBsNESkor9LT93wz1pYfSbFy02BX+8+O21wD2TC5olGap3GcQidKN2WRmszUwkKUR3+dd6jl22Pry5GjpZHo7TxPWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756486959; c=relaxed/simple;
	bh=1p0kyBj4JcvDgO3H94j/rgLos7EnI+2oZFiwLRJSRr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q0BH1fB85GEIx6ObElY2IZD3cj8g7Qo8gRDdAixlm8T/EPqwcNY1YlKnCVLJvEHOqKFFQ6Dlbwgy5M5IL4PebgsJf/r1Q6tS5hI2Da2hMBVsCXJUHly1+u5vymijZ5b4/sW7zK3aTL3xdoDc9m71bFrkyuGCo81DCOCuZj0+m5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPXlDAgL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC029C4AF09;
	Fri, 29 Aug 2025 17:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756486957;
	bh=1p0kyBj4JcvDgO3H94j/rgLos7EnI+2oZFiwLRJSRr4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WPXlDAgLZuKhKXBccXf0fETefa9fHR2Q9K2K48IRQQKZhTQh6tbwUGzFCrazzTY/T
	 gEDtHXpyPdTbx7ETsuddEvfQYoM/b0cXhEdpyKdL504Uxp30CUyckUXY3hoZzQ5eoJ
	 4pnNxG5tOuI8ZCgMATrpktXe6n65pHLXSES+6MgLtDvE8iaoWEyIhATp1xQI4C7UjN
	 oXj7dm8hI4f19YoGk6zq0ngsgEdUn17M95NAC9p3m4jW+1BmXD707iSvP2QxGuxlYM
	 1f7YqwoYwU6p8/j2gSu6ZZV+w9JefRrxg/a0lngcEMYgjLBOf6H5j/bQ84YjIpzhHF
	 /l6YI3Ckr0sUg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55f69e15914so947138e87.2;
        Fri, 29 Aug 2025 10:02:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWfR5DeZollP2El+1ukeOr+x/uln9twaVGcJY81QS8vT9sziprMSdOe31A8EAWHJk/lq/GSqxQU3i+FVdZn@vger.kernel.org, AJvYcCXbLqi8Mtou6ipINMUudTOVvFNhZgeHJSLyJg2hd+Yt6ORQrp3izNKyMwiH/9RHtonfqHG8WZDYpWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YySRUJ8sF6CPn5KLxp/PiWiO4WyGW3viIDlLdGZnDdGEV2Co9+p
	gzq6b8UHVZQZVd+dvQsgsP/36qqk3r3NL/axQwMlxEeDClpSt+JvhP8nmZ9Dszg1aN2rqYaNla/
	K+p0tLPo9aBIBlnWJ9wVT2v18n247O9c=
X-Google-Smtp-Source: AGHT+IFPBLGObZSlikI7+GXVwR38Tqk26TdP63k6ql0p3bI9lgI2164z6vnySTq07b2t6V/PZgzsR2rahOMRt7xpUAo=
X-Received: by 2002:a05:6512:651b:b0:55f:6a38:f6c8 with SMTP id
 2adb3069b0e04-55f6a38fac4mr808550e87.4.1756486956142; Fri, 29 Aug 2025
 10:02:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ed9efeafd80e9827bcc028d20a5bb20653af68e7.1755006858.git.geert+renesas@glider.be>
 <udidf2skqwbhx6mg4tmsxuipqqgh4amwcxvbjdrqs5g5vla6xp@7wiyrojpjok4> <aKLNrRzxCOqXcWMq@r1chard>
In-Reply-To: <aKLNrRzxCOqXcWMq@r1chard>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 29 Aug 2025 19:02:24 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEc8KwtC5RZcbLCk4HA22iQrbaY77DbtrBDvzRLX7Hm+g@mail.gmail.com>
X-Gm-Features: Ac12FXzbvkPW0HHwP0LS91vudCicS4bPD2a1MOf-aUfysNtGAFcOHj6P5Iofl00
Message-ID: <CAMj1kXEc8KwtC5RZcbLCk4HA22iQrbaY77DbtrBDvzRLX7Hm+g@mail.gmail.com>
Subject: Re: [PATCH] efi: Explain OVMF acronym in OVMF_DEBUG_LOG help text
To: Richard Lyu <richard.lyu@suse.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Gerd Hoffmann <kraxel@redhat.com>, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Aug 2025 at 08:52, Richard Lyu <richard.lyu@suse.com> wrote:
>
> On 2025/08/13 10:03, Gerd Hoffmann wrote:
> > On Tue, Aug 12, 2025 at 03:54:29PM +0200, Geert Uytterhoeven wrote:
> > > People not very intimate with EFI may not know the meaning of the OVMF
> > > acronym.  Write it in full, to help users with making good decisions
> > > when configuring their kernels.
> > >
> > > Fixes: f393a761763c5427 ("efi: add ovmf debug log driver")
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > > +     Recent versions of the Open Virtual Machine Firmware
> > > +     (edk2-stable202508 + newer) can write their debug log to a memory
> > > +     buffer.  This driver exposes the log content via sysfs
> > > +     (/sys/firmware/efi/ovmf_debug_log).
> >
> > Acked-by: Gerd Hoffmann <kraxel@redhat.com>
>
> Reviewed-by: Richard Lyu <richard.lyu@suse.com>
>

Thanks, I've queued this up now.

