Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83AC73F19EB
	for <lists+linux-efi@lfdr.de>; Thu, 19 Aug 2021 15:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239586AbhHSNDd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Aug 2021 09:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239578AbhHSNDd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Aug 2021 09:03:33 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC0BC061756
        for <linux-efi@vger.kernel.org>; Thu, 19 Aug 2021 06:02:57 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id az7so7012867qkb.5
        for <linux-efi@vger.kernel.org>; Thu, 19 Aug 2021 06:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/uITF9PsXzVGX7hd3I0YUfetvnjHbmqb4UwwTMwonFI=;
        b=MPi0hnE/ra70VrPe/cNO1Ormx0fhJ3InR0Y4lORCcGbpHnwdkrxn1VeXvH+TSBCUTU
         v0oNczhQ45wov/kN+l3jtld33Kte9pDI7LQjdbpJ6VesA3zUtrn7vRlwd08l5CwfMpDU
         GlQPWNOam5K6Fiq2V6Tbbttqwgpactcl62UgdWtN/WPmIXzluJIqO6nt1o0a/sj/A3Kb
         Gxj3Qr4qTluQCE1kJnhok4GHfTTD2AXsJ1YntzkD+POopVeAhimTW2k9AryGeRJHHuhp
         kdJHiN3MnWJN2tX98TIbuatikanJs4miyWRTUopfWqD7Nq7cZCv8w0OJZFNZnDNw+tSN
         yv7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/uITF9PsXzVGX7hd3I0YUfetvnjHbmqb4UwwTMwonFI=;
        b=Dqlm5UPOWODXAjYm4BYzU7rPEcDDeeFmEk+Co7DqLWPLoMnr/kBbDLiGioIPN5cMgn
         +u9mOrT1NYn6JvaEqxp3+z0W+nCBf1V0giOrWmucvMf1cjj8io8fDuGg+vaWpZMFGE6l
         vxB+RmFwUJT7+oQ26msfIVly200Py+kzmu5PsBtUIWDOtZDZAZXrdDktrgsC9lm+77Qr
         AW7ywdHipJDUCEu+ZlnaBlcxozfwqDYJL9E9q95QAJ75qv8bGe9ewVogN0rtpaVneLvF
         o3ZciaWoyVJz+p7ZRFHQB/nTZdJdQxVmhgSjCFdNzLpuNeJNrWyG45IV2qyM5JwUyzqD
         t8Yg==
X-Gm-Message-State: AOAM530uAnGrFqtLpTlbCYBKWWtulDFhKfDzN44/mcblArqJuxkEp8kF
        aCjm54mUUXsDBjpPfJT7HtjHz9SPNa4qJfVskmfmVQ==
X-Google-Smtp-Source: ABdhPJy5I18zBxQ1LGmdihiCjtGWvx+HuJJjQQGxxo70NaOSKWyTzogqPmmLqLM1CdEM2C4vIeoyMMoZ809yk2xCmpI=
X-Received: by 2002:a37:dcc7:: with SMTP id v190mr3652195qki.445.1629378176061;
 Thu, 19 Aug 2021 06:02:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210809190157.279332-1-dovmurik@linux.ibm.com>
 <20210809190157.279332-4-dovmurik@linux.ibm.com> <YRZuIIVIzMfgjtEl@google.com>
 <CAMj1kXFC-cizTw2Tv40uZHdLArKtdMNxdQXWoPWSL-8qexdkLQ@mail.gmail.com>
In-Reply-To: <CAMj1kXFC-cizTw2Tv40uZHdLArKtdMNxdQXWoPWSL-8qexdkLQ@mail.gmail.com>
From:   Andrew Scull <ascull@google.com>
Date:   Thu, 19 Aug 2021 14:02:44 +0100
Message-ID: <CADcWuH0mP+e6GxkUGN3ni_Yu0z8YTn-mo677obH+p-OFCL+wOQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] virt: Add sev_secret module to expose confidential
 computing secrets
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Dov Murik <dovmurik@linux.ibm.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>, linux-coco@lists.linux.dev,
        linux-security-module@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 16 Aug 2021 at 10:57, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Fri, 13 Aug 2021 at 15:05, Andrew Scull <ascull@google.com> wrote:
> >
> > On Mon, Aug 09, 2021 at 07:01:57PM +0000, Dov Murik wrote:
> > > The new sev_secret module exposes the confidential computing (coco)
> > > secret area via securityfs interface.
> > >
> > > When the module is loaded (and securityfs is mounted, typically under
> > > /sys/kernel/security), a "coco/sev_secret" directory is created in
> > > securityfs.  In it, a file is created for each secret entry.  The name
> > > of each such file is the GUID of the secret entry, and its content is
> > > the secret data.
> > >
> > > This allows applications running in a confidential computing setting to
> > > read secrets provided by the guest owner via a secure secret injection
> > > mechanism (such as AMD SEV's LAUNCH_SECRET command).
> > >
> > > Removing (unlinking) files in the "coco/sev_secret" directory will zero
> > > out the secret in memory, and remove the filesystem entry.  If the
> > > module is removed and loaded again, that secret will not appear in the
> > > filesystem.
> >
> > We've also been looking into a similar secret mechanism recently in the
> > context of Android and protected KVM [1]. Our secrets would come from a
> > different source, likely described as a reserved-memory node in the DT,
> > but would need to be exposed to userspace in the same way as the SEV
> > secrets. Originally I tried using a character device, but this approach
> > with securityfs feels neater to me.
> >
>
> Agreed. I particularly like how deleting the file wipes the secret from memory.
>
> > We're also looking to pass secrets from the bootloader to Linux, outside
> > of any virtualization or confidential compute context (at least a far as
> > I have understood the meaning of the term). Again, this feels like it
> > would be exposed to userspace in the same way.
> >
>
> Indeed.
>
> > It would be good to be able to share the parts that would be common. I
> > expect that would mean the operations for a secret file and for a
> > directory of secrets at a minimum. But it might also influence the paths
> > in securityfs; I see, looking back, that the "coco" directory was added
> > since the RFC but would a generalized "secret" subsystem make sense? Or
> > would it be preferable for each case to define their own path?
> >
>
> I think we should avoid 'secret', to be honest. Even if protected KVM
> is not riding the SEV/TDX wave, I think confidential computing is
> still an accurate description of its semantics.

I agree that protected KVM fits with the ideas of confidential
computing. It was the non-virtualization context that I was less
certain about. For example, the Open Profile for DICE [2] starts with
a hardware secret and derives, at each boot stage, a secret that is
passed to the next stage. It's a process that applies both to a VM,
matching confidential compute as I understand it, but also the host
Linux, which is the part that I wasn't so clear on.

[2] -- https://pigweed.googlesource.com/open-dice/+/refs/heads/main/docs/specification.md

> > [1] -- https://lwn.net/Articles/836693/
> >
> > > +static int sev_secret_unlink(struct inode *dir, struct dentry *dentry)
> > > +{
> > > +     struct sev_secret *s = sev_secret_get();
> > > +     struct inode *inode = d_inode(dentry);
> > > +     struct secret_entry *e = (struct secret_entry *)inode->i_private;
> > > +     int i;
> > > +
> > > +     if (e) {
> > > +             /* Zero out the secret data */
> > > +             memzero_explicit(e->data, secret_entry_data_len(e));
> >
> > Would there be a benefit in flushing these zeros?
> >
>
> Do you mean cache clean+invalidate? Better to be precise here.

At least a clean, to have the zeros written back to memory from the
cache, in order to overwrite the secret.

>
> > > +             e->guid = NULL_GUID;
> > > +     }
> > > +
> > > +     inode->i_private = NULL;
> > > +
> > > +     for (i = 0; i < SEV_SECRET_NUM_FILES; i++)
> > > +             if (s->fs_files[i] == dentry)
> > > +                     s->fs_files[i] = NULL;
> > > +
> > > +     /*
> > > +      * securityfs_remove tries to lock the directory's inode, but we reach
> > > +      * the unlink callback when it's already locked
> > > +      */
> > > +     inode_unlock(dir);
> > > +     securityfs_remove(dentry);
> > > +     inode_lock(dir);
> > > +
> > > +     return 0;
> > > +}
