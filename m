Return-Path: <linux-efi+bounces-3124-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 745ECA7577C
	for <lists+linux-efi@lfdr.de>; Sat, 29 Mar 2025 19:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2352116BBC2
	for <lists+linux-efi@lfdr.de>; Sat, 29 Mar 2025 18:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9B3DDBC;
	Sat, 29 Mar 2025 18:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VO8sTBf0"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6438F6D
	for <linux-efi@vger.kernel.org>; Sat, 29 Mar 2025 18:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743273983; cv=none; b=QcHZO3Pq5bklLRLQ9SAkx3WqBsB5/7oTMNdntg5Gxo+/xT3Smyq9mmde0jhDdzixoaMVNyq6bX12PlQ8XCBKlRANozHWBkr3MzwQB5yEKr7L3FvsBYvvHfWyJNlzD/X+be/2PCHGhWBsZlOoFAkU76JZ+Dcsk/APVm0DEWD/544=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743273983; c=relaxed/simple;
	bh=i5CLfO1/0iS9DdTrGvRRtjil16gzSrlH5JHr5MbrmGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jdyClBJjLKOCapOxXO/S0ehgBrp3m3bKFZj0AqK9Ng4wQq0dCA7eqC2Vz2sAPz3w2a83UQitIBsf706eSE4Yyhi5v5Rj/B7PaLIroMEedcUVQi14EP7TGOOIYUvsXML7aQ3MyFjU812vkRQ8PKFYxBifRn3mZTqAL1f9a5Ov1Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VO8sTBf0; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-abbd96bef64so510622266b.3
        for <linux-efi@vger.kernel.org>; Sat, 29 Mar 2025 11:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743273979; x=1743878779; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2/qA61NZttuMTMsMasQtR1+95HTiG2Rp+53LpR7zRLE=;
        b=VO8sTBf0cj/T0JWbEPwQuOk/QGn/aP9E6gEgl+cVobrDUj3lJVqpg/OvHCduaMqHPy
         JxOKkJzwX7KkSu2uTiFE5ORXyxAU/z3pCaQT5ZYekSZJaKSu3RIvBRenOVues2G1d547
         BUWb4QC7UpygpEvogoO7Ui+btHso0ESDOGEOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743273979; x=1743878779;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2/qA61NZttuMTMsMasQtR1+95HTiG2Rp+53LpR7zRLE=;
        b=DhxlyG9JYw07ab+cxmLIgUHm11kkZBX1VOtB4eXi9mqLQmyU/5vD4VLVUd2uP/wgFi
         llAl1HmvB+rgp8JhmlO48Aljkuh88A2/j9iOobmY+5f4Gj+RN96AYojlle0prTMbh6FI
         LCFywcCnjqK/JwmXdyKzObaM+eccesBjobnLmKzJg2ahpIwx91gojPHWMMUkrKLT77QP
         F7RmrEjb/Fth1xTfQaIaUV9hPXuvbxKG+hAYe/CCj7P4DAQbJjiih+hh3bnz0CSKpBoO
         MeZoTVeLtcOMn49CwURVEzx66/LBT3kYqgPyFyEViY7uJp0IWIe5fTX+/2xRd/+fZpQd
         fsqg==
X-Gm-Message-State: AOJu0YxsUi2mrdMbL/gAGNByfGV9MqGNjF8bWa2m9LJxLcl1Fx7ST+NU
	aOjf3oa+PWH/NXksxKgJwdqBHTB1swLgSrx8Qs88iJ5kdktUrDp9M2HIYvGJLLCjSY+gMxaihGT
	QzRU=
X-Gm-Gg: ASbGnctyaUEyCfL/yDgve/EKB9aWJtuyIvmzAprZNmd3xmI9hOShcojB2X/P0nxh+kb
	RZWl+Vcwsuod2Txck9ptjMkSI9X7vonA2SxyR1N9hde+WZSnHxC1r4wG9Yy1bqYh0NiJvq7Qwtn
	XZA0hCJLdR0TSOdAjXHChXuEzh1MsVVlW8LCKEaJ4+CIVDFlFlhGpc5eohPIp5vxC7gWMqEiq2u
	PAaCXyZ5PrKlx8PakuGF23I+MqmeR+8oMlpxcVvsQHB/iXKEhKgxIRV+A0x+oYoSUdFPHg2TSfk
	03hSxH9rsXOR3pqt+fvqpfXJ4EUCAElS7MHu21sWdfR6LyPePVuxIXtsvm1TAB1FYabXjFLrKGF
	x5XCc3moxLQNi1KFUpz0=
X-Google-Smtp-Source: AGHT+IHc3DKgPXl/fE9AOWhTwKjGbxKVj8RGmLficF8f3+gSom28FkEX51TTeLnsYCnj2aEmJzNEhA==
X-Received: by 2002:a17:907:7da7:b0:ac3:b613:a651 with SMTP id a640c23a62f3a-ac7389e6792mr318691766b.17.1743273978904;
        Sat, 29 Mar 2025 11:46:18 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71922ccc0sm372157966b.26.2025.03.29.11.46.18
        for <linux-efi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Mar 2025 11:46:18 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac339f53df9so578984666b.1
        for <linux-efi@vger.kernel.org>; Sat, 29 Mar 2025 11:46:18 -0700 (PDT)
X-Received: by 2002:a17:907:86a2:b0:ac1:e1a7:9445 with SMTP id
 a640c23a62f3a-ac738975d4emr351958666b.12.1743273977695; Sat, 29 Mar 2025
 11:46:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250328070525.2248563-2-ardb+git@google.com>
In-Reply-To: <20250328070525.2248563-2-ardb+git@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 29 Mar 2025 11:46:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjc-EAEtv02iUFGej6RZs9C7ALAMtuh4rFNYs5VUt+4UA@mail.gmail.com>
X-Gm-Features: AQ5f1JrZMbVkpCilIpYStOc9X05zxRyXGaZ5axmvENFeOBiaNPbaPEHQa0c61AA
Message-ID: <CAHk-=wjc-EAEtv02iUFGej6RZs9C7ALAMtuh4rFNYs5VUt+4UA@mail.gmail.com>
Subject: Re: [GIT PULL] EFI updates for v6.15
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 28 Mar 2025 at 00:05, Ard Biesheuvel <ardb+git@google.com> wrote:
>
>  arch/x86/boot/compressed/efi_mixed.S               | 341 ---------------------
>  drivers/firmware/efi/libstub/x86-mixed.S           | 253 +++++++++++++++

I've pulled this, but I'm not super-happy about it.

We have been pretty successful in keeping assembler files in the arch/
directory, and I really think we should strive to continue that.

Do we have a few drivers that have arch-specific assembly code? Yes.
But it certainly isn't something to make more common.

And did we already do that zboot-header.S thing earlier? Also yes, but
that one is afaik actually architecture-neutral and doesn't have any
architecture *instructions* in it, it's just data layout afaik (and
no, I don't know why it was done as a '*.S' file)

IOW, I really wish you would move this back to arch/x86 somewhere. Please?

               Linus

