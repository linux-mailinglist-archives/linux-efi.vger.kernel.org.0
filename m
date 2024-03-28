Return-Path: <linux-efi+bounces-889-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7B088FAD9
	for <lists+linux-efi@lfdr.de>; Thu, 28 Mar 2024 10:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 739C528180E
	for <lists+linux-efi@lfdr.de>; Thu, 28 Mar 2024 09:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B8C54664;
	Thu, 28 Mar 2024 09:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QgwksVP2"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1251F36AF2
	for <linux-efi@vger.kernel.org>; Thu, 28 Mar 2024 09:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711617201; cv=none; b=JxVlvO7oDMvWIihchXJpC/Fj3+EfkpO4qb6/ceKnJoDuOD+sI1t8ZNxdVhthXAPgowl7Zvlz72UaHbpDXhO1DiK75MfUPMYYCZUFP8sZCb1qoDh6KorNiLGBBQv4bmww3j7n77u8wpbbLLZKt/VzeT2hmTskHYW9vo3x3vZg0zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711617201; c=relaxed/simple;
	bh=7haYTbi2PFefNxiwsw2Qn2/r5Kwwv2dNiDTTl0EndDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I6U6KL9TnhbnfUTFhIeblv7QF5UdzQ+e8vza3KgE3gNLlGtxQ9Fnvp7fMNWeK7rm+A+A7JSTG3ZCZ+sxBgiYAr/vaONlnw+5SXhGokyvs0BFlU6vbOzDk5kpGoG4ZVNjxSUyz7kl5QrUM+h8h2FmqpugIiFf35BBb3wvq/zC+f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QgwksVP2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94220C433C7
	for <linux-efi@vger.kernel.org>; Thu, 28 Mar 2024 09:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711617200;
	bh=7haYTbi2PFefNxiwsw2Qn2/r5Kwwv2dNiDTTl0EndDE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QgwksVP2EaS04bQapWOTrFC/P7/pj5L3NlqwzZptM7D1QAb9TeCzlp7nDiC47E+pu
	 jsfenIjdwC7uwlj2lpEq9bVGAPdHQ590WuiPsVK086RStD4tI5sVr1kM8rfFE6MgIV
	 dWMDg1AZwkeFp1uQ24oOKYpdJKl8xaMXdzcdfzKTNwGCnwhWSNOxpD/tblPxKATF/0
	 sFdYDtaLeF7MrTJQ5Im4JleghGnc89POIjRVmRBc3KDuKcu0jr6NG3G+a0RyGqOj12
	 zl6J3uwQczSx5ovQ80DhahpGxAIECeas8xBITGVKm9DHX3qEnuSDOzSZKELfoFDbvK
	 49lmeOC2SBZaw==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d687da75c4so6987601fa.0
        for <linux-efi@vger.kernel.org>; Thu, 28 Mar 2024 02:13:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU7u8tWovM8ODUsSgjDmWzi8oeZ48ocrTzZxLixx8P53gQUMhR2kiR9nsEprKxKWuQzW08b86CwIT1FsksGFSi3snEW9jNXIG2w
X-Gm-Message-State: AOJu0YxBRSuxP24whAAT+v/+5BQqSVxYiC3lQZtGtniYXGG+gXUpVtLI
	OF2i9WCT1C77Mw7UkcJJOJ9QoL0YoyFUWsKamwqcCPosJdhmFLYm16h6s8H67/8632G1qtfM+Mp
	BQH0UB36cXpco9p+Ju/nij+OUoC0=
X-Google-Smtp-Source: AGHT+IFbxXqzc2yOM24Y4OC5ks/+xct6HGaLdTNgSjGQE4cjKDeuMbRHIsSLHN2vDwZV9fAPNILi0RBLCVMHJvijHZ0=
X-Received: by 2002:a05:651c:4ce:b0:2d6:f3fa:c6cc with SMTP id
 e14-20020a05651c04ce00b002d6f3fac6ccmr1854295lji.1.1711617198965; Thu, 28 Mar
 2024 02:13:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326101850.914032-2-ardb+git@google.com> <ZgUollgbjAkTR0CD@wunner.de>
In-Reply-To: <ZgUollgbjAkTR0CD@wunner.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 28 Mar 2024 11:13:07 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE8pFxr3Ym5K7pHEJEti=+BahyaZKuACiEz57wyQ4C0Sg@mail.gmail.com>
Message-ID: <CAMj1kXE8pFxr3Ym5K7pHEJEti=+BahyaZKuACiEz57wyQ4C0Sg@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: Cast away type warning in use of max()
To: Lukas Wunner <lukas@wunner.de>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, kazuma-kondo@nec.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Mar 2024 at 10:21, Lukas Wunner <lukas@wunner.de> wrote:
>
> On Tue, Mar 26, 2024 at 11:18:51AM +0100, Ard Biesheuvel wrote:
> > Add a missing (u64) cast to alloc_min, which is passed into
> > efi_random_alloc() as unsigned long, while efi_physical_addr_t is u64.
> [...]
> > --- a/drivers/firmware/efi/libstub/randomalloc.c
> > +++ b/drivers/firmware/efi/libstub/randomalloc.c
> > @@ -120,7 +120,7 @@ efi_status_t efi_random_alloc(unsigned long size,
> >                       continue;
> >               }
> >
> > -             target = round_up(max(md->phys_addr, alloc_min), align) + target_slot * align;
> > +             target = round_up(max(md->phys_addr, (u64)alloc_min), align) + target_slot * align;
>
> Why not
>
>     max_t(u64, md->phys_addr, alloc_min)
>

Why is that better?

