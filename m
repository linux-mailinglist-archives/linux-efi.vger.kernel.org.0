Return-Path: <linux-efi+bounces-139-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 721CE80A747
	for <lists+linux-efi@lfdr.de>; Fri,  8 Dec 2023 16:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A148B1C208EB
	for <lists+linux-efi@lfdr.de>; Fri,  8 Dec 2023 15:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDC730327;
	Fri,  8 Dec 2023 15:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9ErcLbW"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44114208AB
	for <linux-efi@vger.kernel.org>; Fri,  8 Dec 2023 15:24:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 106D8C433CA;
	Fri,  8 Dec 2023 15:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702049066;
	bh=l8nqaBJV6WKjyft6BFOzeRuXp40fNTOvNlDjW6JjKA0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=U9ErcLbWN0mPFHgLxZ1zxX5JdmFeCgxPuASWcJJvKdEkv9FegYso6a4v24cpLa6Vq
	 Pq55N4HNozjLDnnhhZW+uXhh0FbiC8JTgx8QFOv0UarpJse5YmlZG+9hKNiLIFuMh4
	 upihiVn49Qpvr5us/S9yoJEPTmnqdblhNC+X2vf8SkiQjBCK96siZPQE0ZXs3adzWL
	 Pl5YW3C8qO0okIIMCHxGNUSJYjqBjkN6XmQsjNKaqbZo4OS5FSoT1R1LMF43pSA8s3
	 6F4QGL6bgvTtQpAL9JibIRnfFc7OpfJf2TkH/ooeVVlncDoqruGQxn41aUCqmk1Z9y
	 +U/Tf113eoMvA==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2c9efa1ab7fso27026511fa.0;
        Fri, 08 Dec 2023 07:24:25 -0800 (PST)
X-Gm-Message-State: AOJu0YwU0aS0w1Rulx+1iL5zkqNXJQB3DNr3oIm9agJF79gH4q/3cW7E
	og2jswd0K4nTr50TF8tr/NtK4uoZcCTrfiqsQcI=
X-Google-Smtp-Source: AGHT+IHGAJSluBqm87O1oTBi+KPFUFSGRuaj6rIagCHHs1I6Di3ao/RX/79E0bYBgQrqmDbG+z5RESlpf55Sm+TUuiU=
X-Received: by 2002:a2e:8813:0:b0:2c9:faeb:cb5d with SMTP id
 x19-20020a2e8813000000b002c9faebcb5dmr23363ljh.185.1702049064262; Fri, 08 Dec
 2023 07:24:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000003dd70305e722f605@google.com>
In-Reply-To: <0000000000003dd70305e722f605@google.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 8 Dec 2023 16:24:13 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFrexNBSDGGRaQQh=6_O=nm2NET_unZ4Qy618461H6maw@mail.gmail.com>
Message-ID: <CAMj1kXFrexNBSDGGRaQQh=6_O=nm2NET_unZ4Qy618461H6maw@mail.gmail.com>
Subject: Re: [syzbot] BUG: corrupted list in efivar_entry_remove
To: syzbot <syzbot+1902c359bfcaf39c46f2@syzkaller.appspotmail.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Aug 2022 at 13:10, syzbot
<syzbot+1902c359bfcaf39c46f2@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    680fb5b009e8 Merge tag 'arm64-upstream' into for-kernelci
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=126f0865080000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4557ad2600fc45f4
> dashboard link: https://syzkaller.appspot.com/bug?extid=1902c359bfcaf39c46f2
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10039fc3080000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f4ebc3080000
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+1902c359bfcaf39c46f2@syzkaller.appspotmail.com

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
efivarfs-list-corruption-fix

