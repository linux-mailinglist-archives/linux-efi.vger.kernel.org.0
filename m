Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D06C61A3B30
	for <lists+linux-efi@lfdr.de>; Thu,  9 Apr 2020 22:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgDIUQ4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Apr 2020 16:16:56 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54613 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726796AbgDIUQ4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 9 Apr 2020 16:16:56 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 039KGWaT016170
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Apr 2020 16:16:33 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 9733A42013D; Thu,  9 Apr 2020 16:16:32 -0400 (EDT)
Date:   Thu, 9 Apr 2020 16:16:32 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
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
Subject: Re: [GIT PULL 0/9] EFI fixes for v5.7-rc
Message-ID: <20200409201632.GC45598@mit.edu>
References: <20200409130434.6736-1-ardb@kernel.org>
 <20200409190109.GB45598@mit.edu>
 <CAMj1kXGiA3PAybR7r9tatL7WV5iU7B1OQxQok3d-JmRnhX1TnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGiA3PAybR7r9tatL7WV5iU7B1OQxQok3d-JmRnhX1TnA@mail.gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Apr 09, 2020 at 09:04:42PM +0200, Ard Biesheuvel wrote:
> 
> > I'm currently building Linus's latest branch to see if it's been fixed
> > since v5.6-11114-g9c94b39560c3 (which is where I first noticed it) and
> > while I was waiting for v5.6-12349-g87ebc45d2d32 to finish building so
> > I could test it, I noticed these patches, and so I figured I'd fire
> > off this quick question.
> >
> 
> I think we might be able to downright revert that patch if the
> underlying assumption on my part is inaccurate, which was that the
> fact that the boot code no longer uses the runtime table address
> implies that there is no longer a reason to pass it.

Unfortunately, it doesn't cleanly revert, which is why I started
checking to see if it might be fixed already before trying to figure
out how to do a manual revert.  I just tested and the tip of Linus's
tree still has the failure.

The short description of the failure: I'm using Debian Stable (Buster)
with a 4.19 distro kernel and kexec-tools 2.0.18 to kexec into the
kernel under test.  I'm using a Google Compute Engine VM, and the
actual kexec command is here:

https://github.com/tytso/xfstests-bld/blob/master/kvm-xfstests/test-appliance/files/usr/local/lib/gce-kexec#L146

What happens is that the kexec'ed kernel immediately crashes, at which
point we drop back into the BIOS, and then it boots the Debain 4.19.0
distro kernel instead of the kernel to be tested boot.  Since we lose
the boot command line that was used from the kexec, the gce-xfstests
image retries the kexec, which fails, and the failing kexec repeats
until I manually kill the VM.

The bisect fingred v5.6-rc1-59-g0a67361dcdaa ("efi/x86: Remove runtime
table address from kexec EFI setup data") as the first failing commit.
Its immediate parent commit, v5.6-rc1-58-g06c0bd93434c works just
fine.

Is there any further debugging information that would be useful?

Thanks,

						- Ted
