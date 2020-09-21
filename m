Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1853E272F33
	for <lists+linux-efi@lfdr.de>; Mon, 21 Sep 2020 18:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbgIUQzR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 21 Sep 2020 12:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbgIUQzK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 21 Sep 2020 12:55:10 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7292C061755;
        Mon, 21 Sep 2020 09:55:09 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id cv8so7764256qvb.12;
        Mon, 21 Sep 2020 09:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=szNXVWJGAZwpx75f6+30VLnmCJsuz9HNHCal9KjzTxA=;
        b=VDn64YZD7uGTR5IfNAzvRKx/fUPWDVeJhEkElc4Niv9OxBlyDFFaHR6z+35iqyj3/O
         BliFZbaiZwYEvVGoadb6FBF+Sp/j6RBgiE8DpU8msmpdb7DnAnbKjJAHQa0pNNa9CuAC
         nn4s4tg+qFp5BnNiFfBFeuAR/O1Ddk67uZfSFkp8VzhribC/Sh/YchpFuGySKm7mS8bG
         naQ3A1BijQS8iGjPKaJYuL4uk+gyVIL0rjIN0mrlpuN+CYpKuApqV34JvZ1G8/CHZQrJ
         x4rjWuwXbTLJrXnIk0AVLlUyHu9qs0XvCf/0R874bdGFmG2XBwlpL7eV4KNs0JJHtEsn
         vVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=szNXVWJGAZwpx75f6+30VLnmCJsuz9HNHCal9KjzTxA=;
        b=UU3bqRgZvmjykzefD4Xdl/I0tQs3vL2wGdtZ1VvlnABvn6pSCk2Ar8F0bq8pA2BSPR
         +C9jesk8QfnsZ3FtJAQvc1CHHyrnMEKVK+zWkfMQsRD3W41JAuKELfntdSn77A5o0utn
         Xwtq8lf2Qlww3191qvRoCUxdbIt5sUxFGhxUkVFjpGWPgYLYuAyJTyHtcSjBvzikuvWz
         qsm87vk/+Yqy3d6k9/RllNjkCIbc73YOhsJk3jFjdtNr+y1QhiD7CP/MZXXsjhlrtOHr
         dUi6yUpmD+tmPzMu7eENgr9eOycQpnl3cvala9bqwwUYkJsD+mhkjNncTcreOX/Za7wF
         aXEg==
X-Gm-Message-State: AOAM533hKqzyeb9PDx/rqnd9Z0aSP6rbB7h6hwsW77EEPTTToSy0TDVj
        6DcboMtDZv7t8Fcxlj1tqo3qTm36UCc=
X-Google-Smtp-Source: ABdhPJxWkRsh4KQ3MogZdppcRx9qC7pDE25loMBRP41MENhVQE3NQq8Gg69UfbxYDA2R1s75Y3Xlwg==
X-Received: by 2002:a05:6214:8f2:: with SMTP id dr18mr884106qvb.49.1600707308876;
        Mon, 21 Sep 2020 09:55:08 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 8sm9353802qkc.100.2020.09.21.09.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 09:55:08 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 21 Sep 2020 12:55:06 -0400
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Lenny Szubowicz <lszubowi@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        linux-security-module@vger.kernel.org, andy.shevchenko@gmail.com,
        James Morris <jmorris@namei.org>, serge@hallyn.com,
        Kees Cook <keescook@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Jones <pjones@redhat.com>,
        David Howells <dhowells@redhat.com>, prarit@redhat.com
Subject: Re: [PATCH V2 1/3] efi: Support for MOK variable config table
Message-ID: <20200921165506.GA549786@rani.riverdale.lan>
References: <20200905013107.10457-1-lszubowi@redhat.com>
 <20200905013107.10457-2-lszubowi@redhat.com>
 <20200921161859.GA544292@rani.riverdale.lan>
 <CAMj1kXFV7LqsyHM8iM5yQwJX4tKbY=w9vfjERvjyabVDKcbJpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXFV7LqsyHM8iM5yQwJX4tKbY=w9vfjERvjyabVDKcbJpA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Sep 21, 2020 at 06:27:17PM +0200, Ard Biesheuvel wrote:
> On Mon, 21 Sep 2020 at 18:19, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Fri, Sep 04, 2020 at 09:31:05PM -0400, Lenny Szubowicz wrote:
> > > +     /*
> > > +      * The EFI MOK config table must fit within a single EFI memory
> > > +      * descriptor range.
> > > +      */
> > > +     err = efi_mem_desc_lookup(efi.mokvar_table, &md);
> > > +     if (err) {
> > > +             pr_warn("EFI MOKvar config table is not within the EFI memory map\n");
> > > +             return;
> > > +     }
> > > +     end_pa = efi_mem_desc_end(&md);
> > > +     if (efi.mokvar_table >= end_pa) {
> > > +             pr_err("EFI memory descriptor containing MOKvar config table is invalid\n");
> > > +             return;
> > > +     }
> >
> > efi_mem_desc_lookup() can't return success if efi.mokvar_table >= end_pa,
> > why check it again?
> >
> > > +     offset_limit = end_pa - efi.mokvar_table;
> > > +     /*
> > > +      * Validate the MOK config table. Since there is no table header
> > > +      * from which we could get the total size of the MOK config table,
> > > +      * we compute the total size as we validate each variably sized
> > > +      * entry, remapping as necessary.
> > > +      */
> > > +     while (cur_offset + sizeof(*mokvar_entry) <= offset_limit) {
> > > +             mokvar_entry = va + cur_offset;
> > > +             map_size_needed = cur_offset + sizeof(*mokvar_entry);
> > > +             if (map_size_needed > map_size) {
> > > +                     if (va)
> > > +                             early_memunmap(va, map_size);
> > > +                     /*
> > > +                      * Map a little more than the fixed size entry
> > > +                      * header, anticipating some data. It's safe to
> > > +                      * do so as long as we stay within current memory
> > > +                      * descriptor.
> > > +                      */
> > > +                     map_size = min(map_size_needed + 2*EFI_PAGE_SIZE,
> > > +                                    offset_limit);
> > > +                     va = early_memremap(efi.mokvar_table, map_size);
> >
> > Can't we just map the entire region from efi.mokvar_table to end_pa in
> > one early_memremap call before the loop and avoid all the remapping
> > logic?
> >
> 
> I suppose that depends on whether there is a reasonable upper bound on
> the size which is guaranteed to be mappable using early_memremap()
> (e.g., 128 KB on 32-bit ARM, or 256 KB on other architectures)

Ah, sorry, I thought only the number of early mappings was limited, not
the size as well. We could still just map the maximum possible
(NR_FIX_BTMAPS * PAGE_SIZE), since it will fail anyway if the config
table turns out to be bigger than that?

> 
> 
> > > +     if (va)
> > > +             early_memunmap(va, map_size);
> > > +     if (err) {
> > > +             pr_err("EFI MOKvar config table is not valid\n");
> > > +             return;
> > > +     }
> >
> > err will never be non-zero here: it was cleared when the
> > efi_mem_desc_lookup() was done. I think the initialization of err to
> > -EINVAL needs to be moved just prior to the loop.
> >
> > > +     efi_mem_reserve(efi.mokvar_table, map_size_needed);
> > > +     efi_mokvar_table_size = map_size_needed;
> > > +}
