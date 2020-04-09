Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90B6C1A3A1F
	for <lists+linux-efi@lfdr.de>; Thu,  9 Apr 2020 21:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgDITBo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Apr 2020 15:01:44 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40705 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725970AbgDITBo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 9 Apr 2020 15:01:44 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 039J19lw021995
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Apr 2020 15:01:10 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 5B2B242013D; Thu,  9 Apr 2020 15:01:09 -0400 (EDT)
Date:   Thu, 9 Apr 2020 15:01:09 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>,
        Colin Ian King <colin.king@canonical.com>,
        Gary Lin <glin@suse.com>, Jiri Slaby <jslaby@suse.cz>,
        Sergey Shatunov <me@prok.pw>, Takashi Iwai <tiwai@suse.de>
Subject: Re: [GIT PULL 0/9] EFI fixes for v5.7-rc
Message-ID: <20200409190109.GB45598@mit.edu>
References: <20200409130434.6736-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409130434.6736-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Apr 09, 2020 at 03:04:25PM +0200, Ard Biesheuvel wrote:
> The following changes since commit 594e576d4b93b8cda3247542366b47e1b2ddc4dc:
> 
>   efi/libstub/arm: Fix spurious message that an initrd was loaded (2020-03-29 12:08:18 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent

Hi Ard,

By any chance does this series fix a kexec failure which I bisected
down to 0a67361dcdaa ("efi/x86: Remove runtime table address from
kexec EFI setup data")?   Or if it doesn't, is this a known failure?

I'm currently building Linus's latest branch to see if it's been fixed
since v5.6-11114-g9c94b39560c3 (which is where I first noticed it) and
while I was waiting for v5.6-12349-g87ebc45d2d32 to finish building so
I could test it, I noticed these patches, and so I figured I'd fire
off this quick question.

Thanks,

							- Ted
