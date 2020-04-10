Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2AA1A4715
	for <lists+linux-efi@lfdr.de>; Fri, 10 Apr 2020 15:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgDJNzE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Apr 2020 09:55:04 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30193 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726145AbgDJNzE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 10 Apr 2020 09:55:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586526903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iz174XEQjo4HdMwcToRtjnHITXXF+QDP8a5ZECFP3Pc=;
        b=P/Id93cTrRAhZS01mimoNV08pgUuQQBhq+OskWK9iNVMg8bS/IQPrxqkpr1qdT2JXQ7W0J
        lkiLUJZMgbxSnbgTqinrqCmSL1zYC/h7lbqU6rycK4CXGoyf72wsbuKtEVYvDr48C91GV+
        w9Bhjbd84Xw0WdHSjcJx90kv7eoYNVc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-0sQfwSBnPamulE2kIkaCUA-1; Fri, 10 Apr 2020 09:54:59 -0400
X-MC-Unique: 0sQfwSBnPamulE2kIkaCUA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 998DB107ACC7;
        Fri, 10 Apr 2020 13:54:55 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-106.pek2.redhat.com [10.72.12.106])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A4ED260C05;
        Fri, 10 Apr 2020 13:54:47 +0000 (UTC)
Date:   Fri, 10 Apr 2020 21:54:42 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
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
Message-ID: <20200410135442.GA6772@dhcp-128-65.nay.redhat.com>
References: <20200409130434.6736-1-ardb@kernel.org>
 <20200409190109.GB45598@mit.edu>
 <CAMj1kXGiA3PAybR7r9tatL7WV5iU7B1OQxQok3d-JmRnhX1TnA@mail.gmail.com>
 <20200409201632.GC45598@mit.edu>
 <CAMj1kXFqKGSqm_y+ht4mmmu10TrhSyiTG8V3PxRYGodpZ=xNFQ@mail.gmail.com>
 <20200409235716.GF45598@mit.edu>
 <CAMj1kXH4VtNcJugpG_UR10ewGiOApTiw=C3FsuyAQQyg67Q8Aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXH4VtNcJugpG_UR10ewGiOApTiw=C3FsuyAQQyg67Q8Aw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Cc kexec list.
On 04/10/20 at 09:08am, Ard Biesheuvel wrote:
> On Fri, 10 Apr 2020 at 01:57, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> >
> > On Thu, Apr 09, 2020 at 11:29:06PM +0200, Ard Biesheuvel wrote:
> > > > What happens is that the kexec'ed kernel immediately crashes, at which
> > > > point we drop back into the BIOS, and then it boots the Debain 4.19.0
> > > > distro kernel instead of the kernel to be tested boot.  Since we lose
> > > > the boot command line that was used from the kexec, the gce-xfstests
> > > > image retries the kexec, which fails, and the failing kexec repeats
> > > > until I manually kill the VM.
> > >
> > > Does this help at all?
> > >
> > > diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
> > > index 781170d36f50..52f8138243df 100644
> > > --- a/arch/x86/include/asm/efi.h
> > > +++ b/arch/x86/include/asm/efi.h
> > > @@ -180,6 +180,7 @@ extern void __init
> > > efi_uv1_memmap_phys_epilog(pgd_t *save_pgd);
> > >
> > >  struct efi_setup_data {
> > >         u64 fw_vendor;
> > > +       u64 __unused;
> > >         u64 tables;
> > >         u64 smbios;
> > >         u64 reserved[8];
> >
> >
> > Tested-by: Theodore Ts'o <tytso@mit.edu>
> >
> 
> OK, I'll spin a proper patch
> 
> > Yep, that fixed it.  Thanks!!
> >
> > I wonder if this structure definition should be moved something like
> > arch/x86/include/uapi/asm/efi.h so it's more obvious that the
> > structure layout is used externally to the kernel?
> >
> 
> Well, 95% of the data structures used by EFI are based on the UEFI
> spec, so the base assumption is really that we cannot make changes
> like these to begin with. But I'll add a DON'T TOUCH comment here in
> any case.
> 

The runtime cleanup looks a very good one, but I also missed that,
userspace kexec-tools will break with the efi setup_data changes. But
kexec_file_load will just work with the cleanup applied.

Ard, could you add kexec list in cc when you send the fix out?

Thanks
Dave

