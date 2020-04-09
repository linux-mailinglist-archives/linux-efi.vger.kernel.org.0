Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 156A41A3A27
	for <lists+linux-efi@lfdr.de>; Thu,  9 Apr 2020 21:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgDITEy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Apr 2020 15:04:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:51244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726470AbgDITEx (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 9 Apr 2020 15:04:53 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEEB6206F5;
        Thu,  9 Apr 2020 19:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586459093;
        bh=V2Dm74kapwMY5qPqupKzeC2dI0fLAelD9KY+aWD8br4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JXeEWWl4zNy1/xBC3zTHc0IQTWUqNnyvCSUIiKXMwxIAsjERBOUWdkZWELQauCRsv
         jE6ki5qyywpGCH7iSiru07uArXVE0FksESCLLEgEWhEjgCTzSL/6BpkkTuTt60KpUh
         7DZs8/NAOo/OCpiDYw4tOQ0U3oxG3QAl4Gf5ct9M=
Received: by mail-io1-f44.google.com with SMTP id b12so660623ion.8;
        Thu, 09 Apr 2020 12:04:53 -0700 (PDT)
X-Gm-Message-State: AGi0PuamDu0SdoeI9KoAMUzdZKs7mfwoCFkZMju3jDUlgJpoBR228vgu
        UCA6zNswM6XR6ZE6yCzIZnC4ygsH1wjgMLxZOGI=
X-Google-Smtp-Source: APiQypIF+4n8/KNulSddyuMmbaGBCI4is4Gr6JDUPo/ir7NC88cNdQ8GT3wHq3n+3iVN7qUIeQ1lBG/KsJ4l4C2pW6Q=
X-Received: by 2002:a02:7785:: with SMTP id g127mr932207jac.134.1586459093121;
 Thu, 09 Apr 2020 12:04:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200409130434.6736-1-ardb@kernel.org> <20200409190109.GB45598@mit.edu>
In-Reply-To: <20200409190109.GB45598@mit.edu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 9 Apr 2020 21:04:42 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGiA3PAybR7r9tatL7WV5iU7B1OQxQok3d-JmRnhX1TnA@mail.gmail.com>
Message-ID: <CAMj1kXGiA3PAybR7r9tatL7WV5iU7B1OQxQok3d-JmRnhX1TnA@mail.gmail.com>
Subject: Re: [GIT PULL 0/9] EFI fixes for v5.7-rc
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>,
        Colin Ian King <colin.king@canonical.com>,
        Gary Lin <glin@suse.com>, Jiri Slaby <jslaby@suse.cz>,
        Sergey Shatunov <me@prok.pw>, Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 9 Apr 2020 at 21:01, Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Thu, Apr 09, 2020 at 03:04:25PM +0200, Ard Biesheuvel wrote:
> > The following changes since commit 594e576d4b93b8cda3247542366b47e1b2ddc4dc:
> >
> >   efi/libstub/arm: Fix spurious message that an initrd was loaded (2020-03-29 12:08:18 +0200)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent
>
> Hi Ard,
>
> By any chance does this series fix a kexec failure which I bisected
> down to 0a67361dcdaa ("efi/x86: Remove runtime table address from
> kexec EFI setup data")?   Or if it doesn't, is this a known failure?
>

Hi Ted,

I wasn't aware of this issue, and this series will most likely not fix it.

> I'm currently building Linus's latest branch to see if it's been fixed
> since v5.6-11114-g9c94b39560c3 (which is where I first noticed it) and
> while I was waiting for v5.6-12349-g87ebc45d2d32 to finish building so
> I could test it, I noticed these patches, and so I figured I'd fire
> off this quick question.
>

I think we might be able to downright revert that patch if the
underlying assumption on my part is inaccurate, which was that the
fact that the boot code no longer uses the runtime table address
implies that there is no longer a reason to pass it.

Please involve me in the discussions on this issue.
