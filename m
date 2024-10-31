Return-Path: <linux-efi+bounces-2076-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B979B7705
	for <lists+linux-efi@lfdr.de>; Thu, 31 Oct 2024 10:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A966A1C20CA2
	for <lists+linux-efi@lfdr.de>; Thu, 31 Oct 2024 09:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E142A156967;
	Thu, 31 Oct 2024 09:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tvpcFSCh"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03FA1BD9ED;
	Thu, 31 Oct 2024 09:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730365458; cv=none; b=i4KW4A0VzPNZdEcY82tTvuKJmqqm+ZEVbIHQrkFeLce/KFW5jyf+wnx6IoEvJUHom45jo+mC+nVNnzBl+Fx0fcGlaEMeXaPaXm4jhJCUr2rYdNnjkPKE6RJmQBdH31MAfjPuaklxaf1Aw7BphfHWXHH+hI6qAffuzu84JngsAsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730365458; c=relaxed/simple;
	bh=rMmsPAoNj0T1N+l/5gpxXVO0BT9K5uhQHYV8kE0cJ70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fK02IernB/9gmY2LgeJmb3R86XZiS6QREiwFmSIMEXpmJDaEy+5ulz9X7LoXdF4OHFkRULmud4gswq2BFUl2IK6lO4erJqS4o0oZxQaOGJAgmZdunlsN5yRdvwi32HW9z9CoqP1+/LvNB+dMd5lf3ZFEjbmQApuCaRNO9DW3WyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tvpcFSCh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C61C4CED0;
	Thu, 31 Oct 2024 09:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730365458;
	bh=rMmsPAoNj0T1N+l/5gpxXVO0BT9K5uhQHYV8kE0cJ70=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tvpcFSCh5n5OBqS4K8WTCFRIZwHV5YAAIXEg6BW7CRnS5as2PKEMei03IRBtvwD0e
	 EIwm/VknrJ+rP5g58Ffhr3Ik/CMgigmF8IqC9vFHNiEbYnOi96kJsIcRshXqX0gbq7
	 pCDzJHJoipkVae+1cP0YkSZJvYKn45qRLdYMFxd4bpM8Nun7OSKg52EJbHQ0rjVnFX
	 zE8M4MpVoM1CtIVaMbL1+AjSrCVuDc2PIN9ieNKWDJawMu/pB5JF5TtFqKyXNZj7hY
	 CVEuO+zhEZrGf27xqWDSWcnWDNDAlEofTM7kitqjDP2EmwOWJ/Xh6qxD+Ie0gMcMMQ
	 R18MkltOchLyA==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fb57f97d75so6169781fa.2;
        Thu, 31 Oct 2024 02:04:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUIwrmscWqdKkzXmlAI5EL3QyyC0fQCzJqRzaFU0O7QSgcf8UqxQC1kP2Ik/AfTUpECnNpxws2xu7s=@vger.kernel.org, AJvYcCXx9odxyPMG2zumITmRZchlhdWfz5+6CzfvbMLqdD/1MPMnlBB9chnd0Wjpb3AjR6DjKAKXM7RZ@vger.kernel.org
X-Gm-Message-State: AOJu0YylXSey/T/z2CtyW6ChxPt+P9+Zr1lGj8kYRGtndPSDRSW3XCUi
	kFK+hb3bZrEE9dbdyfHqgUkOzCD5LOdOnQ/MUfrUCCI+JkoAjPE6nCQ9jP6Kd24MUsw/B9OpEaK
	L9WFiDlgfiPUx2tkX7qbYbXxDWMU=
X-Google-Smtp-Source: AGHT+IG7QBQVAG1QN+7HH/QUvI9Uk9k85ubl7PpKZYwi+Mf+MpFSDbMXLt2gTL++cPavCYwF/up0DfB2hjKRe82iSic=
X-Received: by 2002:a05:651c:554:b0:2fa:c0df:3d7b with SMTP id
 38308e7fff4ca-2fcbdfbb31cmr79419021fa.22.1730365456646; Thu, 31 Oct 2024
 02:04:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912155159.1951792-2-ardb+git@google.com> <ec7db629-61b0-49aa-a67d-df663f004cd0@kernel.org>
 <29b39388-5848-4de0-9fcf-71427d10c3e8@kernel.org> <58da4824-523c-4368-9da1-05984693c811@kernel.org>
 <CAMj1kXHqgZ-fD=oSAr7E0h9kTj_yzDv=_o2ifCCD0cYNgXv9RQ@mail.gmail.com> <9ce8eef8-592b-4170-adf9-a1906e008c5c@kernel.org>
In-Reply-To: <9ce8eef8-592b-4170-adf9-a1906e008c5c@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 31 Oct 2024 10:04:05 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEKK2asZ8iT9+n6wz1yve2JY8U5Dd5+TriStuVssrG3UQ@mail.gmail.com>
Message-ID: <CAMj1kXEKK2asZ8iT9+n6wz1yve2JY8U5Dd5+TriStuVssrG3UQ@mail.gmail.com>
Subject: Re: [PATCH] efistub/tpm: Use ACPI reclaim memory for event log to
 avoid corruption
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, stable@vger.kernel.org, 
	Breno Leitao <leitao@debian.org>, Usama Arif <usamaarif642@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 31 Oct 2024 at 08:55, Jiri Slaby <jirislaby@kernel.org> wrote:
>
> On 25. 10. 24, 9:30, Ard Biesheuvel wrote:
> > To me, it seems like the use of EFI_ACPI_RECLAIM_MEMORY in this case
> > simply tickles a bug in the firmware that causes it to corrupt the
> > memory attributes table. The fact that cold boot behaves differently
> > is a strong indicator here.
> >
> > I didn't see the results of the memory attribute table dumps on the
> > bugzilla thread, but dumping this table from EFI is not very useful
> > because it will get regenerated/updated at ExitBootServices() time.
> > Unfortunately, that also takes away the console so capturing the state
> > of that table before the EFI stub boots the kernel is not an easy
> > thing to do.
> >
> > Is the memattr table completely corrupted? It also has a version
> > field, and only versions 1 and 2 are defined so we might use that to
> > detect corruption.
>
> So from a today test:
> https://bugzilla.suse.com/attachment.cgi?id=878296
>
>  > efi: memattr: efi_memattr_init: tab=0x7752f018 ver=1
> size=16+2*1705287680=0x00000000cb494010
>
> version is NOT corrupted :).
>

OK, so the struct looks like this

typedef struct {
        u32 version;
        u32 num_entries;
        u32 desc_size;
        u32 flags;
        efi_memory_desc_t entry[];
} efi_memory_attributes_table_t;

and in the correct case, num_entries == 45 and desc_size == 48.

It is quite easy to sanity check this structure: desc_size should be
equal to the desc_size in the memory map, and num_entries can never
exceed 2x the number of entries in the EFI memory map.

I'll go and implement something that performs the check right after
ExitBootServices(), and just drops the table if it is bogus (it isn't
that important anyway)

