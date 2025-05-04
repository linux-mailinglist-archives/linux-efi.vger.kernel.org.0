Return-Path: <linux-efi+bounces-3586-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E7AAA871D
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 16:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 209EA3A8FA4
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 14:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6F41EA73;
	Sun,  4 May 2025 14:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fvECSJYt"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742193595B
	for <linux-efi@vger.kernel.org>; Sun,  4 May 2025 14:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746370725; cv=none; b=iposHP4o8IQ8xoqR1gv1ckWAmukqhz++uU1pVpWh9XjToCjs8kSlYZX7M3VRVzP04QN7iJw0Uszs1BMQ170LGtmScLYwr42QMKv2htflOzULxU4Bf9nnziNrlkECIy8li4VNbwNu4Rkx3cbEVCSBUdJ6YrwW7lIBRQEdpJQxZhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746370725; c=relaxed/simple;
	bh=YCQOkxAmAoKniJqGEMFaMB2obnpR1GeEVIGPxOrMFeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YqwFDwvyt7vHVgvVYuLFZ1BbZU89MFiURoGyWKil+o2Fe9RZFQC6TxZMMZjD+Bi3Cu9G3KEd/sqVBLdIDQIhfKTsFBRj7N/eh7V06z3RW2R937OdRUZYkHyNV7b9YqhsOOPXUKZ3IXsJ50nU03czOTY5JbIbBO40sMV8C6i9/H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fvECSJYt; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5f4d28d9fd8so4919448a12.3
        for <linux-efi@vger.kernel.org>; Sun, 04 May 2025 07:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1746370721; x=1746975521; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lJQWmC9QIR1GqAn7EuHVBw4D7Vmqv6rbT+SYCA2GeCo=;
        b=fvECSJYtqr2GnJNZEo1EGWL9+FZuVH3gfNIDKlD6lkCIvpsbvcjvwnfFQnClS0djGE
         afFhj3kXQcNb4u7vb2FL1Lg2v8teaTf9KGOkAev73eWK2LhwCsmMk2C5Qty/vdTKqLwy
         DUj5SPuOE4e4slkX7cm3cmVy9e2kkRkGKlVco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746370721; x=1746975521;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lJQWmC9QIR1GqAn7EuHVBw4D7Vmqv6rbT+SYCA2GeCo=;
        b=Nij9Ttxbe+QAD9rzkYLJNpfwFlWfhcux9UuJwao5hlj0V8WDvbXjeT0XkU8ghAjLW8
         f4TKhsZbazfiS+Y9S4slHE6OjE80wEqvjmI9T75lef09TMgAeJjdfa2NIUPUZzIt/uE6
         6sJDF3UNTtB3jsEHeiikMRFXSR58PqFnrsWTAZ9/wUIJljminbWXueh0hQPhSLk8qVnp
         814kzMZKrTA+HzvpdKYsPmb9YURbA/S73K0LtY368xFBizJ84rUUopzafZBMOBkm++ux
         KU+S1j+/B3kN7Y7A3yZ4j0FSNGHgcD50NR4qnrtdeqS15KFTspKMWGup9yPAXKTgPVV3
         l9mA==
X-Forwarded-Encrypted: i=1; AJvYcCXoE43zzH97tV7JanuIbfx9AEREXpfnK71qN9QSfQpYcNTLI6dB1qpnLPWC3v28NbXrpiynFZDmyl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFaeE1P/BEn6Ta9Cmj8/K/kfAKQlf7cwwcxziCqhgwrekQB50e
	pX0wDgGEYi/CfcPSrEuGa65NTptG5gbm/0Z4EYbJPUKjpz2u5BC5/ORkDeUDnO2fqrCbryqk1FR
	GIgw=
X-Gm-Gg: ASbGncuckA9FsoeJDzEblHWWue0spD6eAUemKvfX0ze/8Pn2omdLSKe6i+A3GbGoZX3
	WsshEe+KPsPC7NAQW1i/LhIRjsJamKNSQZJk2qaYub4S9CbcA8NdjZLocIAfyFsS7Rg04++K8gj
	zIx2++gk7ibqUbL7ud4/tYsz4c0gDRQSjV846jvihDra9ywnZGi61coRfOxsu50GsDf0pKvJd7y
	2Vu50O7sJD8+/qA9Vv66iRE+P9gr1P2FGfJzwKayQBVjaaxSRkQppAKjs45cenMzwSronSX08um
	oSKqb95GGc/3UTHu4fPduLD6dp5k8Ib7ldROf5kcvnDC2uST09IB2Wkxcvg6OPLYuVxTzjsOO2a
	Rt6Cg7WSezMaiqPo=
X-Google-Smtp-Source: AGHT+IH5XBMlgI3TBxOQ2cLgbShiPNVlxX1GjRavXW9ROhQA7cUNJGvfHF+X4hG39sIjiDrhc6kmUA==
X-Received: by 2002:a05:6402:350f:b0:5f8:eaa7:793e with SMTP id 4fb4d7f45d1cf-5fab05ce99emr3675472a12.25.1746370721476;
        Sun, 04 May 2025 07:58:41 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fa77c04411sm3927030a12.67.2025.05.04.07.58.40
        for <linux-efi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 May 2025 07:58:40 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e5e8274a74so5425028a12.1
        for <linux-efi@vger.kernel.org>; Sun, 04 May 2025 07:58:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUacK4rNKMQweqvlfCPSsOxx9tF1Val0I7RyfhqzV7kq0oIbBCOMBMxcQTvApp8f+NNPT4jcvUY6yI=@vger.kernel.org
X-Received: by 2002:a05:6402:1e8c:b0:5f4:d4a7:dab1 with SMTP id
 4fb4d7f45d1cf-5fab057e228mr3829067a12.18.1746370720194; Sun, 04 May 2025
 07:58:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250504095230.2932860-25-ardb+git@google.com>
 <20250504095230.2932860-28-ardb+git@google.com> <aBdwwR52hI37bW9a@gmail.com>
In-Reply-To: <aBdwwR52hI37bW9a@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 4 May 2025 07:58:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiaEzS_7CBVTz3RYnDt5zJus_GsPtfSjojkqiiMU-vSHQ@mail.gmail.com>
X-Gm-Features: ATxdqUGrQFb-vV5qF8DsS24Prd3WnIbHufOoMJqqrYQlYx-uXMmu1ORPeNjPfro
Message-ID: <CAHk-=wiaEzS_7CBVTz3RYnDt5zJus_GsPtfSjojkqiiMU-vSHQ@mail.gmail.com>
Subject: Re: [RFT PATCH v2 03/23] x86/boot: Drop global variables keeping
 track of LA57 state
To: Ingo Molnar <mingo@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Dionna Amalie Glaze <dionnaglaze@google.com>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 4 May 2025 at 06:51, Ingo Molnar <mingo@kernel.org> wrote:
>
> Cannot pgtable_l5_enabled() be a single, simple percpu flag or so?

Isn't this logically something that should just be a static key? For
some reason I thought we did that already, but looking around, that
was only in the critical user access routines (and got replaced by the
'runtime-const' stuff)

But I guess that what Ard wants to get rid of is the variable itself,
and for early boot using static keys sounds like a bad idea.

Honestly, looking at this, I think we should fix the *users* of
pgtable_l5_enabled().

Because I think there are two distinct classes:

 - the stuff in <asm/pgtable.h> is exposed as the generic page table
accessor macros to "real" code, and should probably use a static key
(ie things like pgd_clear() / pgd_none() and friends)

 - but in code like __kernel_physical_mapping_init() feels to me like
using the value in %cr4 actually makes sense

but that looks like a much bigger and fundamental patch than Ard's.

                 Linus

