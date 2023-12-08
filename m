Return-Path: <linux-efi+bounces-141-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B64980A791
	for <lists+linux-efi@lfdr.de>; Fri,  8 Dec 2023 16:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 250332813D3
	for <lists+linux-efi@lfdr.de>; Fri,  8 Dec 2023 15:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD85E31A61;
	Fri,  8 Dec 2023 15:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8GYGqgq"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920DD1079D
	for <linux-efi@vger.kernel.org>; Fri,  8 Dec 2023 15:38:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E480C433C7;
	Fri,  8 Dec 2023 15:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702049914;
	bh=UzwffuBK1Uf1+t2jPlhxP2kBQ7ODitP5Un61cVXZRjw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=e8GYGqgqZupeI+U2efyaCzVFaYwm3TZV8//6IMNDEeTmlmmMPBWIBLFTRDDgE7Qqr
	 n7uxGgW4cInZTj9nAliyHnkUamL3D+QeayelBMJJCsyI9ioq1MxnMlHZ+wjLS/TQKO
	 U6JXmPAF0cjh48Ea3tdx5s7mjoalJjvapRdc27ld7/1VFixpnsCT802Lw4EP+Xm+2S
	 iUNS5IySjrtN17wsi4eKQPIjcw88fKJS5mqzJ9aOw63JmKzrYUK7WfAOE2d9iUft0P
	 A54Tw4UR7t0YA2rm8nkS00+fiw+isXtYQe/dDjwom53KA1EEfDHpT/L8+gJMUCDrPo
	 awBEb2lIeeSQA==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2c9f85eff28so31934621fa.3;
        Fri, 08 Dec 2023 07:38:34 -0800 (PST)
X-Gm-Message-State: AOJu0Yz0JcKeVb3wqnXL6gp6WD0r85n3CfQp6Dd34e5Y/xMa7FL36gps
	OOEKsYhRUKW2eIW0G/JE2P8sI9x+buA4LLtzj+I=
X-Google-Smtp-Source: AGHT+IG+fQumReFmH36mfVgBVk/QaevtEOE1j9zU2uc/l9PPdmnMN4nTRobAKvpukIME/5w4kVwNxx4WZV8N7g4bSBI=
X-Received: by 2002:a2e:3a09:0:b0:2c9:ed9f:9e03 with SMTP id
 h9-20020a2e3a09000000b002c9ed9f9e03mr52284lja.37.1702049912610; Fri, 08 Dec
 2023 07:38:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000003dd70305e722f605@google.com>
In-Reply-To: <0000000000003dd70305e722f605@google.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 8 Dec 2023 16:38:21 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFBa2z3FKaEzRyJ1ugZy7P3VfS18hheDs8-+pZ+Gch4pQ@mail.gmail.com>
Message-ID: <CAMj1kXFBa2z3FKaEzRyJ1ugZy7P3VfS18hheDs8-+pZ+Gch4pQ@mail.gmail.com>
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
>

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
ecbfc830fd039

