Return-Path: <linux-efi+bounces-4341-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D03B04DC4
	for <lists+linux-efi@lfdr.de>; Tue, 15 Jul 2025 04:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F7B57AD83B
	for <lists+linux-efi@lfdr.de>; Tue, 15 Jul 2025 02:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4E41A83ED;
	Tue, 15 Jul 2025 02:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TU6D8X7D"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAF52747B;
	Tue, 15 Jul 2025 02:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752545864; cv=none; b=Slxr5AUp3fPNrZBWCeUqgzpyEMWDODofj5iUaPZbqGKo1f0Ig877KrGqAOlCuDm0h2YshRrr238Y/PL4otwXurSoYwpRrIM8d9i9bYXEPbm7ZACIXio4gznPKy+qqE1Q7rLZcaz2C5BsqGY72wNsE5nQsiZkOa1ToBUlGgQ2+os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752545864; c=relaxed/simple;
	bh=OEH/pOaNjMlv20nRX3g93zeKIBYnhsfAeJjoh4tPC9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sJlo/d1SoVLhxv9yn7/z3IcRrOjH5LlAM+sHwbYUkUKLtdM9nvfEUVGte2vGGaxU5hWQqpV2ZLPrFfLuObKufzvRncVY0xkhKdIqcuu/RE29lS8NBf/rBpQpfDBZW2f/BiZNkyIk14QZQMgyF4ktFzHZ6S86mpYmOWks5Y0whoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TU6D8X7D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29757C4CEF0;
	Tue, 15 Jul 2025 02:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752545864;
	bh=OEH/pOaNjMlv20nRX3g93zeKIBYnhsfAeJjoh4tPC9I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TU6D8X7D5IJW6LxJRxI6ubz1IYnpnl2JCVwoizNOLCT7JYpF4GNqv4QzUQdEBC1FS
	 HyKyJAwkkPCYfVjaizDoiPvbVtyDsOJ5BLmty3FJzGWaL6hP8Nk6UlsHDTSOPOr0r3
	 1ohuY4vXZJF/6KwXHlvju18HDAes2lin6V3zw5VTEH38N+S58Rz8d/b/F3umkx7mzq
	 +xajHBuujS3gpOTNyyg6EeSsO7UlPDMDssxDRUaLoMwckKD7EnA7ZmkpbqDHdNM/7w
	 B+BUYiC35t6cTSA96pixB4yjAEybBPQq3wCxWWkot4/2UZed+D6klyL9SEzZo2p+RP
	 kAE4CfpFVaKbA==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-32b43c5c04fso49460461fa.0;
        Mon, 14 Jul 2025 19:17:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUH/RzQCkTHvVWh4m9o5oYcyNnwG7OFwszOOM98lJsufaCOjw4+F/hHrJk/4Q+DaMkbqIDW5+6F084R@vger.kernel.org, AJvYcCVPOAj+HbrrLOapW+okUXYrtqLkwO34d5kZa+WmCK2G/te9WuCKRx3fn58yLmPGEA/DtWzVuthWS2FDBi0H@vger.kernel.org, AJvYcCXBjNhDYxDP+CafSK0NKRflMGJU8qOVE5HJ+zQopFhj214+jCmdCcroJnmOmAQmH+SyYi1ts77eoic=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDaJ0CIXzeWwdT1lrESqy6Z6qXKvTUAoB2chWa5DSmU3DfiwmM
	vQICBUggWIKhB9d1NEDEq0/tkMTuCAq9/uVwe4pzW+Pf8+gNO229Qdmbx7hVYMgSkhKArIKSFNI
	WqI6iVHyxdgtygoSPg44EnFPwrkxXQqE=
X-Google-Smtp-Source: AGHT+IHnUaGrF82Tvu5N3zDCPfT0bnx95UrOUAwbV24AreePD4tqnV14//NL5pV6TfMobhdDbrW4I6O2woJOMpleYtE=
X-Received: by 2002:a2e:bc0c:0:b0:32b:3c94:995e with SMTP id
 38308e7fff4ca-3308114409dmr5699151fa.6.1752545862485; Mon, 14 Jul 2025
 19:17:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711054446.1537700-1-kraxel@redhat.com> <CAMj1kXEsERVQgm2PF4npmeKg_tM2-ivFXwFObQzddxMaU5HMyg@mail.gmail.com>
 <87cya2j3mz.fsf@trenco.lwn.net>
In-Reply-To: <87cya2j3mz.fsf@trenco.lwn.net>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 15 Jul 2025 12:17:30 +1000
X-Gmail-Original-Message-ID: <CAMj1kXFe16dw9q_G6DFED2=tjj5tAuy=Z1tG+ORkAKUr0T063g@mail.gmail.com>
X-Gm-Features: Ac12FXwqUPcWtdH4GsWwRNbOMg40Nzw84dtJZnVQ1BM_1llXp5668NeM8K-IxA0
Message-ID: <CAMj1kXFe16dw9q_G6DFED2=tjj5tAuy=Z1tG+ORkAKUr0T063g@mail.gmail.com>
Subject: Re: [PATCH] efi: add API doc entry for ovmf_debug_log
To: Jonathan Corbet <corbet@lwn.net>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, 
	linux-efi@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Jul 2025 at 23:36, Jonathan Corbet <corbet@lwn.net> wrote:
>
> Ard Biesheuvel <ardb@kernel.org> writes:
>
> > (cc Jon and linux-doc)
> >
> > On Fri, 11 Jul 2025 at 17:04, Gerd Hoffmann <kraxel@redhat.com> wrote:
> >>
> >> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> >
> > Thanks. I'll queue this up in the EFI tree unless Jon prefers to take it.
>
> I've not seen it until now ... Fine with me if you just take it.
>
> Acked-by: Jonathan Corbet <corbet@lwn.net>
>

Thanks, queued up now.

