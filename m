Return-Path: <linux-efi+bounces-3815-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A32AACF8E1
	for <lists+linux-efi@lfdr.de>; Thu,  5 Jun 2025 22:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8C293AFE4E
	for <lists+linux-efi@lfdr.de>; Thu,  5 Jun 2025 20:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767C827EC73;
	Thu,  5 Jun 2025 20:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9gooNpb"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D69E1E5B9F;
	Thu,  5 Jun 2025 20:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749156190; cv=none; b=ePwt/EUypGnaReTMsrhLslBZFhn7bAlUBeUxTavtwV7ALK56Z+wZqErphze+Gx9/QDMCy6mxEuRPyoSqsocU+wr1NnZCAgPMMQDER56YlOaJp0yvmKWtLVsKcKanpAqy1Tw20ByDmORPToscoY+jDZHWCTEq5axviWhxnVDi2Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749156190; c=relaxed/simple;
	bh=5eFNb1/nop/S08gZqHhfQekf0Ums8/hC+AE2r+AET5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PeYsiGhWad/hh9MJ0bBJM6qjE2C0+Ec3T8XjBkweJvjrnwa1MEZHNLU/BxwSuI1vg8M0s6aOFi2HLvjD0jEYsbXbELtIrGG2pMxuB9QEYwrj6Aavcri0FcudGdFH7ecn9A0agpOPHBdu3yJdX7EnNMQ48pIlXpPA5EQ4XWZb1TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9gooNpb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB0CC4CEE7;
	Thu,  5 Jun 2025 20:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749156190;
	bh=5eFNb1/nop/S08gZqHhfQekf0Ums8/hC+AE2r+AET5U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=J9gooNpbJHQt8C+A0FcQNtvWS9jxWvqBwymsLI2NkWqUPm80/2G1qsrAdOlhyXTyC
	 ApR8C1HQ3JXksLCMtB3jCkXas388cpTEBmqb/Kz7taxovcZrk1txK41rXzqz4Ea+cI
	 fqysv1Qq9IE5ynuv55vl0cy+OrNuaXpbV+i80tJ/XpnJUvUqIAqvqPRfIJGyVYZDy/
	 MoXXKkOoo0+Y/UbX0385+qd/RZS0UautceixqE/YXIoz9umnueHD5grmkYDAzphvqb
	 21mQSmlU2UDjqt58DUjtsVx5jxVsTbCweKkoe9KBjHbMns/GkV5LFBEFeNxZ3fNffe
	 xeXQhIl3/Lf7Q==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-553241d30b3so1318798e87.3;
        Thu, 05 Jun 2025 13:43:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVp5BAAFuHi3cSh5MFH4ZSTqnXwlmEgD7zzbLIqeqwH0F9V3QdMHLQxVHI2LqxapAfu2vMzFf66ak8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYnpYalh0KpCBgFNHCJr4ExD+6tYTR4nI43WZ4bV/APDc/I/97
	dlr9aqo3LBc9GJPkw2NidRRtk1ZjEuWglOoDjVSSpm0raPD11j4bVbSdkbtCk9vTZjRdN24ikmi
	YO30ube13oDnK3ltSnnaYlfk5qIl4Brc=
X-Google-Smtp-Source: AGHT+IEvEvBVRfbjs/tzzHFWRRUcCCYsu5rap09rMlM/pTCpFFZ936JCFm0qzEHVbVd3ZNY2779F5fEgRmc6frJ4gXs=
X-Received: by 2002:a05:6512:104b:b0:553:24bb:daa1 with SMTP id
 2adb3069b0e04-55366bd3b13mr153292e87.11.1749156188809; Thu, 05 Jun 2025
 13:43:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602181143.528789-1-masahiroy@kernel.org> <CAMj1kXHEkHMPMJwsMc8WAmsMhJn3ynHqJku=jeKQOT0T_aNqNA@mail.gmail.com>
In-Reply-To: <CAMj1kXHEkHMPMJwsMc8WAmsMhJn3ynHqJku=jeKQOT0T_aNqNA@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 6 Jun 2025 05:42:32 +0900
X-Gmail-Original-Message-ID: <CAK7LNATff5-eY-y9XKNqcHtTT32GPu5P=X4geZxb2Ur83ekbqQ@mail.gmail.com>
X-Gm-Features: AX0GCFtZ06wQ5FyNvazMlSTJ3GaxZfal8mErvewBgz54UC5zlBCfgBC4Tqy0yJw
Message-ID: <CAK7LNATff5-eY-y9XKNqcHtTT32GPu5P=X4geZxb2Ur83ekbqQ@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: use 'targets' instead of extra-y in Makefile
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 3:13=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wro=
te:
>
> On Mon, 2 Jun 2025 at 20:11, Masahiro Yamada <masahiroy@kernel.org> wrote=
:
> >
> > These objects are built as prerequisites of %.stub.o files.
> > There is no need to use extra-y, which is planned for deprecation.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
>
> I misunderstood what extra-y was for - note that
> arch/arm64/kernel/pi/Makefile has the same issue.

Applied to linux-kbuild.


A patch exists for arm64 too

https://lore.kernel.org/lkml/20250602180937.528459-1-masahiroy@kernel.org/



--=20
Best Regards
Masahiro Yamada

