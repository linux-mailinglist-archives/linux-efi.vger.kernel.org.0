Return-Path: <linux-efi+bounces-4566-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A93EB29A31
	for <lists+linux-efi@lfdr.de>; Mon, 18 Aug 2025 08:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43E1D5E2615
	for <lists+linux-efi@lfdr.de>; Mon, 18 Aug 2025 06:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85F4278173;
	Mon, 18 Aug 2025 06:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DpxzcZZM"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE6927876A
	for <linux-efi@vger.kernel.org>; Mon, 18 Aug 2025 06:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755499958; cv=none; b=YdqWwgMcna3jhOU0fYynyOdWkpjlJQhGffqN82fQPH7CSQIZjV0Rxoo4N1TH4W5KPX8jG0jttQlT2bP6UrfYZDNjAtg1NWX1k7LJjFM5CRZmMrTuHX8OKW36ahCriCuUB6wPtDIEJl8vgRkaF1Dkx68JIKAkJK6JM09kB/MC1Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755499958; c=relaxed/simple;
	bh=IN7kYnIID3443ooQB8DzAtrGSGeD4IzBkmmObpX1OWo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sj7HkytXRUg9/XF62HcY4X1MO5sLW6yQ/TnFoVkqbHUOo6MSjO1cXWhg4L4KRcOAoy+MAi5YtPknoMi4Qf4sFZbn/MVj+alsI0DO5Qqu6utGytncw3yVFYhUD7dY4/986+dly5xgyPFzt/hSSobnG+g+f3YyZZA9TNGJY6GGOkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DpxzcZZM; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b9e4148134so1806604f8f.2
        for <linux-efi@vger.kernel.org>; Sun, 17 Aug 2025 23:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755499954; x=1756104754; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:date:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AB2mYWsk8i1r7WgYGZCAEJP8BRkPAULzUmje1GZdi9E=;
        b=DpxzcZZM5GDGlh6oMaqxRpyCINAXGHSyq1eThzLFUFJCIOFfV8RidX9L+IzxAGQAlV
         wY3oU1jfsre0Ljg59skHeD/AeGoIqmMCoYzisqrX+Qlo//cIWbcEQ2XTa78FZzC0GGua
         XxOx+DK2jd91NWPgK/ja/07Od1n3/6eVIxJ+42u4wu80OxY1xDoVFHgDVhl67rQmu84z
         NEb+kmVOjSng0TKOuoP1G3e8t22eeDSpGBL6SuejVm8UE8nYbmaqnkJIcFQmASYdHy2z
         A1x5tEklXY1lJ/mo2TCV1ngLQ6OOmjm5ROvq/QLS+Xu61uZlCu0uPFInLRKyCZrJALXM
         W1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755499954; x=1756104754;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AB2mYWsk8i1r7WgYGZCAEJP8BRkPAULzUmje1GZdi9E=;
        b=MNFkBFmFh40dnMzHxTE12tJ8Ubu44bDzh8N/M2nvPFXPIAC3cMVi/db8Rko1i4bHFI
         Gs2XIN9UBzf4IeNhMCWEX3SkOI/4rleOSqlUSyiDplNgITC4YoRikM8UQN4uJRFC8Ml5
         NW7yRCt/2Ozmz+NrydcXcelKQ1uBC9M7Pr5GdetpFFfXR/0pfF46i4gT2m9PBuomup3z
         NHvYXtHs9PX0uxkQob5wV2eeHpJtCIG8dng+GlySncF0SOHvuhO3E9ui1qhHdTRPWKHb
         SvSHKeMacz7l3El4LUfr6KMeGBvjz3oE/X1Sgv+phU199oiwpkVNfT+49x1j/KhKgHod
         qWzw==
X-Forwarded-Encrypted: i=1; AJvYcCX6AeA2rI3ZXIPsYACtF1hYuAUJAioRL6yH28rbj5g9OalaT7QIU+fQNTnP/8E4gehFZV94j3/828Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGpJs+lqcHpmGIuHVLTcv3NUF1lSZ81eJpgiMsnGNmFBd5GK36
	NnNUuZzJZuh7fVa3NXMYOaTy/2OOiT+Xw7wp9YN/4kj/vw51t7AAvbs5bPtLnt269jU=
X-Gm-Gg: ASbGnctCFUkjEt5Q5XJ1HCDsLh5fzZVSzvSalX3XRnsM64Vm9EuyFDbq+RATAewLmCV
	D4qW+j11RQl3zqW3ds7WVebCGd1hbrPXVimTS3oRC9escZHih6LQ/C6TKQqAkZNzUrY8P99gtAy
	Yta+NMB1hm7Xd2GhH/6DXkydzGs5bFoFHANrRyA29JeOSC3jNXrW6+JD6zPZC3NFXSectH726Ct
	fdVkbClU062VPeHWFvvefrTQY7vVPeF7e8hyFyez9ZubS4bIarDK25WR9yPXLqIegTQARVNEawK
	92yI+bHvDpb9uPgP6VGOYz6dN/ykeL5zHYiN8lROnfPae2PObRXZno1SBIwgnSFI3LsKPyNYaHh
	rk4TEO33StNO3pJb1JcZhqWM0MjjsdvMULguDfjZElwuv
X-Google-Smtp-Source: AGHT+IEeFi+9SxT/8qFVtZnUAEDFzxELnBb+QJjoFAreV6LM14RP2SHQViOexOMNOrwtc7eKLNKieQ==
X-Received: by 2002:a05:6000:2485:b0:3b7:8b2e:cc5a with SMTP id ffacd0b85a97d-3bb68cfa43bmr8155176f8f.40.1755499954559;
        Sun, 17 Aug 2025 23:52:34 -0700 (PDT)
Received: from r1chard (1-164-92-102.dynamic-ip.hinet.net. [1.164.92.102])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e45566f8csm6312933b3a.68.2025.08.17.23.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 23:52:34 -0700 (PDT)
From: Richard Lyu <richard.lyu@suse.com>
X-Google-Original-From: Richard Lyu <r1chard@r1chard>
Date: Mon, 18 Aug 2025 14:52:29 +0800
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Ard Biesheuvel <ardb@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] efi: Explain OVMF acronym in OVMF_DEBUG_LOG help text
Message-ID: <aKLNrRzxCOqXcWMq@r1chard>
References: <ed9efeafd80e9827bcc028d20a5bb20653af68e7.1755006858.git.geert+renesas@glider.be>
 <udidf2skqwbhx6mg4tmsxuipqqgh4amwcxvbjdrqs5g5vla6xp@7wiyrojpjok4>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <udidf2skqwbhx6mg4tmsxuipqqgh4amwcxvbjdrqs5g5vla6xp@7wiyrojpjok4>
User-Agent: Mutt/2.2.13 (2024-03-09)

On 2025/08/13 10:03, Gerd Hoffmann wrote:
> On Tue, Aug 12, 2025 at 03:54:29PM +0200, Geert Uytterhoeven wrote:
> > People not very intimate with EFI may not know the meaning of the OVMF
> > acronym.  Write it in full, to help users with making good decisions
> > when configuring their kernels.
> > 
> > Fixes: f393a761763c5427 ("efi: add ovmf debug log driver")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> > +	  Recent versions of the Open Virtual Machine Firmware
> > +	  (edk2-stable202508 + newer) can write their debug log to a memory
> > +	  buffer.  This driver exposes the log content via sysfs
> > +	  (/sys/firmware/efi/ovmf_debug_log).
> 
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Richard Lyu <richard.lyu@suse.com>



