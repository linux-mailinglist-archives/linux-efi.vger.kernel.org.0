Return-Path: <linux-efi+bounces-587-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B5485B039
	for <lists+linux-efi@lfdr.de>; Tue, 20 Feb 2024 02:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4260284AE2
	for <lists+linux-efi@lfdr.de>; Tue, 20 Feb 2024 01:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968F4D2F5;
	Tue, 20 Feb 2024 01:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="EpYZifso"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87804171A0
	for <linux-efi@vger.kernel.org>; Tue, 20 Feb 2024 01:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708391032; cv=none; b=DbNAD2VTxE5Pa4aeDhqgky73LZnAdJ3OOhVZZjtkgL/irdzG0sy3omDaOuk8HGaadLqlh1IdxeaqS0zNtOlXnArIT1yWF50L4k/UsGrTfyik2TOwneZC5qZzL8zDmswtJZw5W4E77fLiJyEyj2fScyZ1M6wDGfpPKWiVtWbdyK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708391032; c=relaxed/simple;
	bh=ln+OWu0AE8bzSNGwR8vgNlRELBvGt8fUywdq1XVwYNE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=HkVcM/lIwqgBOpfCjKazj9Pu3tZdp2bWnumoQc4mFc/3ItHPiuPwVrdJZ+nj1StkLo8SE+k8n2sj2ZqeTr784tJ+oF4FNmFz2TeTg0YTr6KxLhzLOk89xPsy6l4eNYPQgsjsaeJqioyxeGwV7HYlJLbC9OdRoG+yLkACtBr9Ye0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=EpYZifso; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5D81940CBE
	for <linux-efi@vger.kernel.org>; Tue, 20 Feb 2024 01:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1708391015;
	bh=+zS6MFOZJh5YuAzFETZLG5u3fWZMDM68zpe8l63E6VI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type;
	b=EpYZifsoRBL3o/602FdmKnXDO0GiyfAef8//qRP7RcQmKl8ZWBLe5qIlxkOMEopek
	 CbM/6NrUR37NCDy1qdpnqerKMFhqOxF7CzZlT0AaS3iONs+5nu4GxWIc7st2xqy4Cd
	 pzgzUjfaw0g6UhzdcRZzRdi1k2rqbfhjRss29nXlpVQyTKmhzAea0F7XP4YFH9b6BT
	 l57LMnufMQYwjPWC2qJQRl8+5X4/osRnSJlyieSE++JXNdk+5zrM9ztphH5NJYsYkV
	 36HWk5DH1/yBbeikC7jejdC4VMq6Jjc7V9nhWDmwSSnTm+YfumIamcseokOgchqiLT
	 jveEEvJUVm1QA==
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33d567ff9baso476636f8f.1
        for <linux-efi@vger.kernel.org>; Mon, 19 Feb 2024 17:03:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708391015; x=1708995815;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+zS6MFOZJh5YuAzFETZLG5u3fWZMDM68zpe8l63E6VI=;
        b=cpe4Bmp5yl0HOSAOznB8AggFlQu9IeXI3dzSBen5SkLVl9LxKQnFENg76b14kuWdW/
         nLd0t3AAfwkN6aiGMrTBZp1+xKfCe/JuNjKRoTe0ay9mw40FiWBoPMedkBieA9hHzY+F
         2MG1i4SwQW843hSWxEFhojT2e/WnThoOfGJTcoUMDiRmxlJbD2SQNj5F2Lrg9nqE08s0
         qFVO/+bYEslRHrmLq8snQTXSr9h07ivH+z79sxPjBfer2/SAdeQ6lWuMx7hZsobhlNyG
         ILTvO3VjxcrP4ZiO4sy2N/ekq5xuF+eqGBirvtD0Gf2YDnW6HDxXVfGQeYTqpDtIvV0+
         T1IQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrmXnyLh/yVo7qechOEuV0IrM1uulnwgAeSzprTPHG2ZCCV9LExLMRZEwV8V+cl54RWZkwEilF5EoFcUPnh+pm4swsWpDZ4k4z
X-Gm-Message-State: AOJu0YwLZqz6vnAyQTx9ShWuoQu4jNypFCkCPKidlUV+Jp7H5adz8dJy
	dlJUvMa9xQW09f5+qXWlZWWNzKXhmmCEvtjesMLgLrP0drmh9Ce7HKeQB8XlYc9ldEFRWRJ0yA9
	y4T4xK1cFO9esA3yq8iFOjb+fvA3FDENrl299H8ymfUU2B8BBrmVwQA2jJAoFfy3bGf4+OwjAXQ
	==
X-Received: by 2002:adf:e60c:0:b0:33d:3566:b5c5 with SMTP id p12-20020adfe60c000000b0033d3566b5c5mr4573898wrm.7.1708391014906;
        Mon, 19 Feb 2024 17:03:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELLxS/uoyQ39/UQ+Dht7pYV6J8z3L94e41kT2bLLXgbZAiXpy5DVclx7H2HgKQ2ZHHc/RkYg==
X-Received: by 2002:adf:e60c:0:b0:33d:3566:b5c5 with SMTP id p12-20020adfe60c000000b0033d3566b5c5mr4573887wrm.7.1708391014456;
        Mon, 19 Feb 2024 17:03:34 -0800 (PST)
Received: from localhost ([2a01:4b00:85fd:d700:a75:4765:bff:3fc5])
        by smtp.gmail.com with ESMTPSA id n9-20020a056000170900b0033d5fab6781sm2594595wrc.96.2024.02.19.17.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 17:03:34 -0800 (PST)
From: xnox <dimitri.ledkov@canonical.com>
X-Google-Original-From: xnox <xnox@xnox-Inspiron-7400.mail-host-address-is-not-set>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: gregkh@linuxfoundation.org, stable@vger.kernel.org,
 linux-efi@vger.kernel.org, 
	jan.setjeeilers@oracle.com, pjones@redhat.com, 
	steve@einval.com, julian.klode@canonical.com, 
	bluca@debian.org, jejb@linux.ibm.com
Subject: Re: x86 efistub stable backports for v6.6
In-Reply-To: <CAMj1kXG4HpAHYKwz27_Qy9_Wx+O_QJDmA4CBXcMrvVcrOXhBxw@mail.gmail.com>
 (message from Ard Biesheuvel on Thu, 15 Feb 2024 12:29:06 +0100)
Date: Tue, 20 Feb 2024 01:03:24 +0000
Message-ID: <87plwsj6ar.fsf@xnox-Inspiron-7400.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ard Biesheuvel <ardb@kernel.org> writes:

> On Thu, 15 Feb 2024 at 12:12, Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>> On Thu, Feb 15, 2024 at 10:41:57AM +0100, Ard Biesheuvel wrote:
>> > On Thu, 15 Feb 2024 at 10:27, Greg KH <gregkh@linuxfoundation.org> wrote:
>> > >
>> > > On Thu, Feb 15, 2024 at 10:17:20AM +0100, Ard Biesheuvel wrote:
>> > > > (cc stakeholders from various distros - apologies if I missed anyone)
>> > > >
>> > > > Please consider the patches below for backporting to the linux-6.6.y
>> > > > stable tree.
>> > > >
>> > > > These are prerequisites for building a signed x86 efistub kernel image
>> > > > that complies with the tightened UEFI boot requirements imposed by
>> > > > MicroSoft, and this is the condition under which it is willing to sign
>> > > > future Linux secure boot shim builds with its 3rd party CA
>> > > > certificate. (Such builds must enforce a strict separation between
>> > > > executable and writable code, among other things)
>> > > >
> ...
>> > > And is this not an issue for 6.1.y as well?
>> > >
>> >
>> > It is, but there are many more changes that would need to go into v6.1:
>> >
>> >  Documentation/x86/boot.rst                     |   2 +-
>> >  arch/x86/Kconfig                               |  17 +
>> >  arch/x86/boot/Makefile                         |   2 +-
>> >  arch/x86/boot/compressed/Makefile              |  13 +-
>> >  arch/x86/boot/compressed/efi_mixed.S           | 328 ++++++++++++++
>> >  arch/x86/boot/compressed/efi_thunk_64.S        | 195 --------
>> >  arch/x86/boot/compressed/head_32.S             |  38 +-
>> >  arch/x86/boot/compressed/head_64.S             | 593 +++++--------------------
>> >  arch/x86/boot/compressed/mem_encrypt.S         | 152 ++++++-
>> >  arch/x86/boot/compressed/misc.c                |  61 ++-
>> >  arch/x86/boot/compressed/misc.h                |   2 -
>> >  arch/x86/boot/compressed/pgtable.h             |  10 +-
>> >  arch/x86/boot/compressed/pgtable_64.c          |  87 ++--
>> >  arch/x86/boot/compressed/sev.c                 | 112 +++--
>> >  arch/x86/boot/compressed/vmlinux.lds.S         |   6 +-
>> >  arch/x86/boot/header.S                         | 215 ++++-----
>> >  arch/x86/boot/setup.ld                         |  14 +-
>> >  arch/x86/boot/tools/build.c                    | 271 +----------
>> >  arch/x86/include/asm/boot.h                    |   8 +
>> >  arch/x86/include/asm/efi.h                     |  14 +-
>> >  arch/x86/include/asm/sev.h                     |   7 +
>> >  drivers/firmware/efi/libstub/Makefile          |   8 +-
>> >  drivers/firmware/efi/libstub/alignedmem.c      |   5 +-
>> >  drivers/firmware/efi/libstub/arm64-stub.c      |   6 +-
>> >  drivers/firmware/efi/libstub/efi-stub-helper.c |   2 +
>> >  drivers/firmware/efi/libstub/efistub.h         |  28 +-
>> >  drivers/firmware/efi/libstub/mem.c             |   3 +-
>> >  drivers/firmware/efi/libstub/randomalloc.c     |  13 +-
>> >  drivers/firmware/efi/libstub/x86-5lvl.c        |  95 ++++
>> >  drivers/firmware/efi/libstub/x86-stub.c        | 327 +++++++-------
>> >  drivers/firmware/efi/libstub/x86-stub.h        |  17 +
>> >  include/linux/efi.h                            |   1 +
>> >  32 files changed, 1204 insertions(+), 1448 deletions(-)
>> >
> ...
>> > If you're happy to take these too, I can give you the proper list, but
>> > perhaps we should deal with v6.6 first?
>>
>> Yeah, let's deal with 6.6 first :)
>>
>> What distros are going to need/want this for 6.1.y?  Will normal users
>> care as this is only for a new requirement by Microsoft, not for older
>> releases, right?
>>
>
> I will let the distro folks on cc answer this one.

Canonical will want to backport this at least as far back as v4.15 for
Ubuntu and Ubuntu Pro. So yeah, as far back as possible will be
apperiated by everybody involved. Since if/when firmware (VMs or
Hardware) starts to require NX compat, it will be desired to have all
stable supported kernels with this support built-in.

Regards,

Dimitri.

