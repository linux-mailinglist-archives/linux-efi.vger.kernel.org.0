Return-Path: <linux-efi+bounces-163-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BC980C644
	for <lists+linux-efi@lfdr.de>; Mon, 11 Dec 2023 11:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CFE71C20E90
	for <lists+linux-efi@lfdr.de>; Mon, 11 Dec 2023 10:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDF72374F;
	Mon, 11 Dec 2023 10:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTiwD8kz"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A375322319
	for <linux-efi@vger.kernel.org>; Mon, 11 Dec 2023 10:22:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21909C433C8;
	Mon, 11 Dec 2023 10:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702290173;
	bh=YzaJ13323od16h3INhdZ+R72C23XYnelffzcvpy8NM8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gTiwD8kzWVj5v00CPZP0VCg0LRye52bmegegb7ppR/SoNGKLcvGczu2tzkna5ak/J
	 GTBthlIuFPHOcHl8sh0hdE5cWRqB5ENjZ5k3GGCsatCDO1Um4IvBDlQIL6e9ZlNF1f
	 ivVYLidgfO9hjHFYhGts41TOvOGfrncaSB/8XQTrj1mrv7BqOcW7fvi50as5uGgPGm
	 7gpDyXiGKqltrNPKkXmG7h182zMblRJRoEI6Ds2P74TL9ZnPiHZrNKeYU2RTvogwsZ
	 WzJF31l9IY343m5fby0OdK41+RcHGdG5BPLQYFd0Eo6qLqQVlKdMG/MK1tZLvgEn3u
	 82QNn8ICNoOtw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50c0dbaf2baso3994183e87.3;
        Mon, 11 Dec 2023 02:22:53 -0800 (PST)
X-Gm-Message-State: AOJu0Yz2BjqabmGpcHXfSTPx6kIBNLn4H9saDzHYTbLmWSLBkSG6BSiM
	Ulp+vnIgcQrlboNHOLRGpGop6D6rxFxACa2Iyro=
X-Google-Smtp-Source: AGHT+IEs1N2s8A5HoRvz8mUh0qJF3iU7aald+3uZWI16GdTvv7ccCBK4l8GOqAV6wGdK43ciEb9ZfQTpRBVoQbdGtwo=
X-Received: by 2002:a19:7706:0:b0:50b:f82f:6926 with SMTP id
 s6-20020a197706000000b0050bf82f6926mr900862lfc.17.1702290171272; Mon, 11 Dec
 2023 02:22:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000003dd70305e722f605@google.com>
In-Reply-To: <0000000000003dd70305e722f605@google.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 11 Dec 2023 11:22:40 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGsvR1vAfEe=9v4i=OtLpqTGCB8G8jgAvmo8_Zw3TcFnw@mail.gmail.com>
Message-ID: <CAMj1kXGsvR1vAfEe=9v4i=OtLpqTGCB8G8jgAvmo8_Zw3TcFnw@mail.gmail.com>
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

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next

