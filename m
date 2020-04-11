Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31BA31A5393
	for <lists+linux-efi@lfdr.de>; Sat, 11 Apr 2020 21:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgDKToq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 11 Apr 2020 15:44:46 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57761 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726167AbgDKTop (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 11 Apr 2020 15:44:45 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 03BJhp5B029461
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Apr 2020 15:43:52 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 9189742013D; Sat, 11 Apr 2020 15:43:51 -0400 (EDT)
Date:   Sat, 11 Apr 2020 15:43:51 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Dave Young <dyoung@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>,
        Colin Ian King <colin.king@canonical.com>,
        Gary Lin <glin@suse.com>, Jiri Slaby <jslaby@suse.cz>,
        Sergey Shatunov <me@prok.pw>, Takashi Iwai <tiwai@suse.de>
Subject: Re: [GIT PULL 0/9] EFI fixes for v5.7-rc
Message-ID: <20200411194351.GQ45598@mit.edu>
References: <20200409130434.6736-1-ardb@kernel.org>
 <20200409190109.GB45598@mit.edu>
 <CAMj1kXGiA3PAybR7r9tatL7WV5iU7B1OQxQok3d-JmRnhX1TnA@mail.gmail.com>
 <20200409201632.GC45598@mit.edu>
 <CAMj1kXFqKGSqm_y+ht4mmmu10TrhSyiTG8V3PxRYGodpZ=xNFQ@mail.gmail.com>
 <20200409235716.GF45598@mit.edu>
 <CAMj1kXH4VtNcJugpG_UR10ewGiOApTiw=C3FsuyAQQyg67Q8Aw@mail.gmail.com>
 <20200410135442.GA6772@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410135442.GA6772@dhcp-128-65.nay.redhat.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Apr 10, 2020 at 09:54:42PM +0800, Dave Young wrote:
> 
> The runtime cleanup looks a very good one, but I also missed that,
> userspace kexec-tools will break with the efi setup_data changes. But
> kexec_file_load will just work with the cleanup applied.

Hmmm, I wonder if there could be some kselftest or kunit tests that
would make it easier to pick up these sorts of regressions earlier?

      	      	     	     	      	    - Ted
