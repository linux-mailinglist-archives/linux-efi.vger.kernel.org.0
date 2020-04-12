Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFD01A5C68
	for <lists+linux-efi@lfdr.de>; Sun, 12 Apr 2020 05:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgDLDv2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 11 Apr 2020 23:51:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38658 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726633AbgDLDv2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 11 Apr 2020 23:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586663487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RMwbDDi8hNBOcv1tz+d1jrwNOMd0TGdpILpc5QVi8wc=;
        b=itfp4CcmFOr4wWXg8dTdE17b1eahFJY+G0+RBI9LqEng/TaFl0Sc3WY28If2poAlqdj5L1
        uZ7DD99+CWMkvVeyBhJUwC3P9UO2xCb31vi7lujaLg/EEUmiCMGVHQB//a+WKuPNLW8kWZ
        T0VF+BD6lmsRDIq1QAVyjeNU357ZxAo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-mEBUeA-zP26Vpyef_LPECQ-1; Sat, 11 Apr 2020 23:51:25 -0400
X-MC-Unique: mEBUeA-zP26Vpyef_LPECQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 205E5107ACC7;
        Sun, 12 Apr 2020 03:51:23 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-101.pek2.redhat.com [10.72.12.101])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 81A855D9C9;
        Sun, 12 Apr 2020 03:51:16 +0000 (UTC)
Date:   Sun, 12 Apr 2020 11:51:11 +0800
From:   Dave Young <dyoung@redhat.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
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
Message-ID: <20200412035111.GA10163@dhcp-128-65.nay.redhat.com>
References: <20200409130434.6736-1-ardb@kernel.org>
 <20200409190109.GB45598@mit.edu>
 <CAMj1kXGiA3PAybR7r9tatL7WV5iU7B1OQxQok3d-JmRnhX1TnA@mail.gmail.com>
 <20200409201632.GC45598@mit.edu>
 <CAMj1kXFqKGSqm_y+ht4mmmu10TrhSyiTG8V3PxRYGodpZ=xNFQ@mail.gmail.com>
 <20200409235716.GF45598@mit.edu>
 <CAMj1kXH4VtNcJugpG_UR10ewGiOApTiw=C3FsuyAQQyg67Q8Aw@mail.gmail.com>
 <20200410135442.GA6772@dhcp-128-65.nay.redhat.com>
 <20200411194351.GQ45598@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200411194351.GQ45598@mit.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 04/11/20 at 03:43pm, Theodore Y. Ts'o wrote:
> On Fri, Apr 10, 2020 at 09:54:42PM +0800, Dave Young wrote:
> > 
> > The runtime cleanup looks a very good one, but I also missed that,
> > userspace kexec-tools will break with the efi setup_data changes. But
> > kexec_file_load will just work with the cleanup applied.
> 
> Hmmm, I wonder if there could be some kselftest or kunit tests that
> would make it easier to pick up these sorts of regressions earlier?

I thought about that before, but did not go with any actual actions.
kexec test needs a system reboot, Kdump is even harder to test, that is
the reason I hesitated about.

But since the breakage happens here and there frequently, it is time to
try it.  I think I will play with it, but I might be slow because of
other things,  welcome to post patches if anyone is interested :)

Thanks
Dave

