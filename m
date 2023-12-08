Return-Path: <linux-efi+bounces-144-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B915A80A79B
	for <lists+linux-efi@lfdr.de>; Fri,  8 Dec 2023 16:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60C281F20F91
	for <lists+linux-efi@lfdr.de>; Fri,  8 Dec 2023 15:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A31131A74;
	Fri,  8 Dec 2023 15:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VY5BGAL3"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDF11079D
	for <linux-efi@vger.kernel.org>; Fri,  8 Dec 2023 15:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6405C433C7;
	Fri,  8 Dec 2023 15:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702050013;
	bh=ieVNX3t8OHlTPk0YVyjDeXt4NaL02vWfuoHRriWFMQs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VY5BGAL3r0QbzWRb5Eszy5EVO0efv6muA+409Qox0aDL07fC+R/tulhSd+NIh0VKW
	 B2XXfyGuIG5dYNd7vwskPqfAUJZiWliVfU6wMPGfYnE2r5pFU8IcM1qt9jz3QSpCQh
	 0XdY6c+vJ35iWrP5uKh8D0Mg6CxG13byZ8+GMdnleqSCWY3KWVB0wJQ1vPvYceMLYh
	 VP7CEGM9CaNcF/J0jIek78BAORDLAYfQin0TZgg4+KYyqnlPPG53Nj5cNWk7+XI5VC
	 2RN4LDwp0AW+okMbirlRkvGgFduw+S40rLF9yJ+uo/TD7n/LEs6PnX3ZmDJihMvY+M
	 beZTPFdpJ8XZA==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ca09601127so27890081fa.1;
        Fri, 08 Dec 2023 07:40:13 -0800 (PST)
X-Gm-Message-State: AOJu0Yxru6R0BD0wFqzQMwtYaSUL+mO4pNus8mNh27Z0YYycXOV++XFx
	MA8G+DUBVxSNZFh6Abk0sXxZR/8kZP6bjQUgB7s=
X-Google-Smtp-Source: AGHT+IHKpsCoFUwtx0uJ5yciTMXMsGyA+ko6Y6KeazE2iy2abDkzUd5ub7GLATGs7gDzfPSbVQPLUjIZU1LSnW71hi0=
X-Received: by 2002:a2e:948c:0:b0:2c9:ffcf:ec98 with SMTP id
 c12-20020a2e948c000000b002c9ffcfec98mr59130ljh.27.1702050012031; Fri, 08 Dec
 2023 07:40:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMj1kXFrexNBSDGGRaQQh=6_O=nm2NET_unZ4Qy618461H6maw@mail.gmail.com>
 <00000000000010057c060c012e63@google.com> <CANp29Y4bxQzV-=rSQOBPfi2Rxrob_GTHZrsGAgvemvnXgC5a3g@mail.gmail.com>
In-Reply-To: <CANp29Y4bxQzV-=rSQOBPfi2Rxrob_GTHZrsGAgvemvnXgC5a3g@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 8 Dec 2023 16:40:01 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGdLTsDnvqb3pe--eW3p480kbDRfyydMCUOW1m-3Bf9cg@mail.gmail.com>
Message-ID: <CAMj1kXGdLTsDnvqb3pe--eW3p480kbDRfyydMCUOW1m-3Bf9cg@mail.gmail.com>
Subject: Re: [syzbot] BUG: corrupted list in efivar_entry_remove
To: Aleksandr Nogikh <nogikh@google.com>
Cc: syzbot <syzbot+1902c359bfcaf39c46f2@syzkaller.appspotmail.com>, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Dec 2023 at 16:38, Aleksandr Nogikh <nogikh@google.com> wrote:
>
> If a command spans over two lines, syzbot expects a colon.
>
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
> efivarfs-list-corruption-fix
>

It is Gmail that is breaking the line here


#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git:
efivarfs-list-corruption-fix

