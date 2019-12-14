Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7899711F3D1
	for <lists+linux-efi@lfdr.de>; Sat, 14 Dec 2019 21:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfLNUNh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 14 Dec 2019 15:13:37 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:40457 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfLNUNh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 14 Dec 2019 15:13:37 -0500
Received: by mail-qv1-f68.google.com with SMTP id k10so1127919qve.7;
        Sat, 14 Dec 2019 12:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P7Jagn3JtIFFwo/e+8Nzizx8VjGDf4XsEuN6cyEIbFk=;
        b=Ewiqg11FfGQGM92+2MH1R3nYO2I5hNNgaMcNUE8sYE1m9zVvINm0RtK66OH3D8LfqK
         0O/7A8WS21XjiOMRfP9ZSbZAllVERzCE4NnAbisK/lkPgCXbC2ibK5GdmRx6UEg/PbgQ
         e0MDB+UG5YOYK4Tcc6EbJCjNEj74eScRTtNwEqWu0QTyjRVAbTAHDtBAo2lIc9XXPvfD
         qExDzFrkT/lT7ESuGnDHkgX+x5MycX01yxysizTBmjvqoYKAYtWdv6HQYo37HA85GQnT
         J+diIr5E/GWMKcD8UWHw+R7je6Og/ZKaqOeNC3SZntOMljCKZa4Q/VXyXhVW9BeGHVq/
         cs5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=P7Jagn3JtIFFwo/e+8Nzizx8VjGDf4XsEuN6cyEIbFk=;
        b=OV7yRnJdaA1Sgi9qEcpDKpjsQAZf9o2cfTfYuIKHev0FuxDyBvoCbsr+WEcubeETqx
         gJvQz2bNT9/2FYX2FSnbgzAfmIjlFf6hNU5B9sI6uJklJxgVMbrONQXJyl7tyL05UE1P
         BZknT9gUqdBm0wfCJ+UGb68mezaGG/SlKjzBoIWnXoX50Gfy/EF43ZXxgIfOcA/ziNKW
         23BXNeBygMec3mHlhs6EfZRRSHrTqAQJuBIwgXWgUlmK9ZlYfrmZv4/NB5Mf+UOaFamz
         W6mmZU4qhONXmMlA13xmgdfU0Zy5h6qop6BM2+PhpQXrkrLm/xQiaIYnV8/eeQmjbZBZ
         OScw==
X-Gm-Message-State: APjAAAUS9FlJ2MEC7L6jQzjbvzoFy4LaSc/tusXZ9yOy2Vg+gd/zvRm8
        3illAeHBUZKKMDaKTcK1eJY=
X-Google-Smtp-Source: APXvYqyFl8xMoRHnTKSbt2OQjed14cxAXiGIRNTcvrxcDzJZ3NylgPAvqADYTzVXrPjT6uUJ0wXGtg==
X-Received: by 2002:a05:6214:15cf:: with SMTP id p15mr19433885qvz.140.1576354416304;
        Sat, 14 Dec 2019 12:13:36 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id a36sm1387747qtk.29.2019.12.14.12.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2019 12:13:36 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sat, 14 Dec 2019 15:13:34 -0500
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 05/10] efi/libstub: distinguish between native/mixed not
 32/64 bit
Message-ID: <20191214201334.GC140998@rani.riverdale.lan>
References: <20191214175735.22518-1-ardb@kernel.org>
 <20191214175735.22518-6-ardb@kernel.org>
 <20191214194626.GA140998@rani.riverdale.lan>
 <20191214194936.GB140998@rani.riverdale.lan>
 <CAKv+Gu_JQz=xd_UmqiuZ8TvA+ksT_rY4iXP_j7OdW4F5sfZt9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_JQz=xd_UmqiuZ8TvA+ksT_rY4iXP_j7OdW4F5sfZt9g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Dec 14, 2019 at 07:54:25PM +0000, Ard Biesheuvel wrote:
> On Sat, 14 Dec 2019 at 20:49, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Sat, Dec 14, 2019 at 02:46:27PM -0500, Arvind Sankar wrote:
> > > On Sat, Dec 14, 2019 at 06:57:30PM +0100, Ard Biesheuvel wrote:
> > > > +
> > > > +#define efi_table_attr(table, attr, instance) ({                   \
> > > > +   __typeof__(((table##_t *)0)->attr) __ret;                       \
> > > > +   if (efi_is_native()) {                                          \
> > > > +           __ret = ((table##_t *)instance)->attr;                  \
> > > > +   } else {                                                        \
> > > > +           __typeof__(((table##_32_t *)0)->attr) at;               \
> > > > +           at = (((table##_32_t *)(unsigned long)instance)->attr); \
> > > > +           __ret = (__typeof__(__ret))(unsigned long)at;           \
> > > > +   }                                                               \
> > > > +   __ret;                                                          \
> > > > +})
> > >
> > > The casting of `at' is appropriate if the attr is a pointer type which
> > > needs to be zero-extended to 64-bit, but for other fields it is
> > > unnecessary at best and possibly dangerous.  There are probably no
> > > instances currently where it is called for a non-pointer field, but is
> > > it possible to detect if the type is pointer and avoid the cast if not?
> >
> > To clarify, I mean the casting via `unsigned long' -- casting to type of
> > __ret should be ok. We could also use uintptr_t for cleanliness when the
> > cast is required?
> 
> Could you give an example of how it could break?

eg, if the field is actually a structure. Nobody seems to do this
currently, but say for
	efi_table_attr(efi_boot_services, hdr, instance)
you shouldn't cast hdr to unsigned long.

There's also the case of nested 32/64-bit structures that breaks, but
that might be too hard to try to handle:
	efi_table_attr(efi_pci_io_protocol, io, instance)
where io is a structure of two pointers which would need to be
individually casted. It's properly accessible as io.read/io.write
though.

In general though, everything is either a pointer or a u64, so if it's
too messy to detect pointer type, the cast is still probably safe in
practice.
