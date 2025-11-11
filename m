Return-Path: <linux-efi+bounces-5473-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C200C4F60B
	for <lists+linux-efi@lfdr.de>; Tue, 11 Nov 2025 19:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C39163B0D54
	for <lists+linux-efi@lfdr.de>; Tue, 11 Nov 2025 18:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F244314A80;
	Tue, 11 Nov 2025 18:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAkRoWr6"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC69330AAD2
	for <linux-efi@vger.kernel.org>; Tue, 11 Nov 2025 18:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762884568; cv=none; b=rrhBRu/SvN+vtbMZneUAhZ2Nu/KvgnBvI7ZYWIObkerWjUcsjYBhTe4/Bim7/ngS/Butgg+kvUyJTVb8wFz5BcEBoexbZTVe8HbXUbkwtWn/pj5tuxvUjhyj5Yet8hKrTLTnsWL6HWWxkaL9xhNst21cI51qc0bhwo4FdhKFk94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762884568; c=relaxed/simple;
	bh=hRzWuCGpSN7hnP44f5gqzC5UuxA48SBRaJlrsOJokz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=imKrm7JCGOrFdyYtTdpj0hrxuoOgKLHLLyjymKJq9/2PUzGOXaEk8cRt0mQgCz5UHVMa6WAdULr93QuMYGJyhzdbyui7C9p5sx2114xmp5f1QghnuIs5Gd257H69XC83ghj/VzTJDOuItHX1MsO9ifQQuQATIsF6NOMmBMMR92E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAkRoWr6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5061C16AAE
	for <linux-efi@vger.kernel.org>; Tue, 11 Nov 2025 18:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762884567;
	bh=hRzWuCGpSN7hnP44f5gqzC5UuxA48SBRaJlrsOJokz8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dAkRoWr6gKqiTS7nXrIz3+lIhTLF6a3iYlCpB8vfg+36WUESohxTaBZnMB+I5+Jzo
	 cQyrOZS8UBQHtK3HGVXePJTZwk3aqpsqkie5SRW95J9piZIicScJlhQ1NuIsxI/dvo
	 FTfIgVPX1D4arnnbJeS/K/NiIrNz7cu/wccHlo5xeBu2Qzb+c1p8qeQjM58uX3LR7s
	 PBIdcmQ+IoqLXPYJr7sKsbJATmGOZUnY9RNkjeLLmNLVy1u8iaatZS+39bCV+26+Y4
	 WoWRpeKiyJuFjMia0KwT3tA4NkQN7HR9GmlBxz73ppkWmMPB6vHpX+A1L6oOeGE+1C
	 6+CMN100tfYrg==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3717780ea70so43801541fa.1
        for <linux-efi@vger.kernel.org>; Tue, 11 Nov 2025 10:09:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWWMnU71OspgibZ6T6hwuu0COS/7JnmgvDCgXstV79Y1IJJ54FmI1OLFnuugkQVPkVtJkqzNoXeI8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWDvR/oqnnkC3jTBR26N92+d1x0sLPJa0pbfVHReFYnUp+hs60
	GeTaLshEXjnMajJXLadI/yrBSCE23/1Yz0lBOESn5fBf1ofK5u8iv5J8A4UneDz0DpENfpKftVJ
	Zy9+NrI9Ttxh+VphQsPxYhlRBMg+HyiM=
X-Google-Smtp-Source: AGHT+IH+vlAqWzKbl8RBzatfARjBWPp0/kjkNw96di46YW12EtUe8RsSCT1rqVKGDAn4JpAh8fwnVotjuTCE6BT5zaw=
X-Received: by 2002:a2e:b053:0:b0:37a:3180:472b with SMTP id
 38308e7fff4ca-37b8c3c5050mr572891fa.29.1762884566166; Tue, 11 Nov 2025
 10:09:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111060212.1963608-1-rdunlap@infradead.org> <CAC_iWjKYBgjG=C7NgAFwn6uBSMS0t_WepazvcTQb-gPewL9ckw@mail.gmail.com>
In-Reply-To: <CAC_iWjKYBgjG=C7NgAFwn6uBSMS0t_WepazvcTQb-gPewL9ckw@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 11 Nov 2025 19:09:14 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEe9QfPQaCuw-kBnATGbvsy72twRTzid+uGs5kifD18Rg@mail.gmail.com>
X-Gm-Features: AWmQ_bn6a9xN1rQuUplVLq-mkEskC-N0KOi35QceiDDR7QHvWxSTRYRR9bJQZpY
Message-ID: <CAMj1kXEe9QfPQaCuw-kBnATGbvsy72twRTzid+uGs5kifD18Rg@mail.gmail.com>
Subject: Re: [PATCH] efi: stmm: fix kernel-doc "bad line" warnings
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Nov 2025 at 09:50, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Randy
>
> On Tue, 11 Nov 2025 at 08:02, Randy Dunlap <rdunlap@infradead.org> wrote:
> >
> > Add a beginning " *" to each line to avoid kernel-doc warnings:
> >
> > Warning: drivers/firmware/efi/stmm/mm_communication.h:34 bad line:
> > Warning: drivers/firmware/efi/stmm/mm_communication.h:113 bad line:
> > Warning: drivers/firmware/efi/stmm/mm_communication.h:130 bad line:
> >
> > Fixes: c44b6be62e8d ("efi: Add tee-based EFI variable driver")
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>
> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>

Thanks! Queued up now.

> Is the fixes tag necessary here?

I'll keep it as it doesn't do any harm, and it makes the stable tree
doc build a bit less noisy I guess.

