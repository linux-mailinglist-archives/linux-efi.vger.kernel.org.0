Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C837175083
	for <lists+linux-efi@lfdr.de>; Sun,  1 Mar 2020 23:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgCAWBa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 1 Mar 2020 17:01:30 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40050 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgCAWBa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 1 Mar 2020 17:01:30 -0500
Received: by mail-qk1-f194.google.com with SMTP id m2so8306639qka.7
        for <linux-efi@vger.kernel.org>; Sun, 01 Mar 2020 14:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Siy902D2GmOtC6vfDLVe87iyBNg6m9FnQYxrKJI0KCg=;
        b=qlHMv6Tr7rVFiKnZ+7/NDX6KDIJ+IPFYopX7EjMY6muyV4qGH+nFaXLHP1N2A6qiRY
         kr49E4K9VFbZcl9UrtsgW9/uNdfo7MhxykmVtBLBdUpxREKbIuQVLSbk0wUM7KkQiJeB
         3jUU6sdjwMm9euGvbQQTr5KEt4cqhNZMRktIL0lZ7mrCeOqy+TrFjHCjy8/0XrKblLlo
         HTMVuEV7fGgBWLfMPCF6hLrtMAqm+9nyCyfP4dO5+AVfpAMMCce08e8UrsFs03wPpGtk
         +ONIFlPdFo+7YSgo3rRTG76KQdDLVj4dbsFgSeb8Wjhb8VC//BDNeqy0oHfHTrKnsAeT
         02BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Siy902D2GmOtC6vfDLVe87iyBNg6m9FnQYxrKJI0KCg=;
        b=R7xQgdFPFACoSE/apldjG3rKgkWnz8OI7NfBbOjMteAw7TVkC/BVx2fuI85tniXAXv
         C51obrLN+EWRoTX+b2g3JLTX8gvpkLiWlMWwK+oZfNoEX/4jJUM7gcR+KUHrNJNFCDlg
         aZD0sBW77jY2Cwy0PFuE9TSdTwSbUPJEkkhy82WZNrqe5WVkKYJBDg2tg8VqencXNfN8
         sjJ4bz2BrQkAuLuw48lSO5uoJ6m6HTPa1H+PvVIU8vB4J2eRBHiteVXmDKuobqwV7T09
         olZGjYVL9GsOhOy0jgzJWyunTtBJMzY50wGaDfr8guPm8DBi2IUnLUfslpU5KsvLrYx3
         aQlw==
X-Gm-Message-State: APjAAAUsSu4RYEgyBr+g/UOYRaWmIYSxHD+zJJxQ9Zw/PX3jPQoZGY3a
        12xqsyN4oj2GJtJyNTKJuxw=
X-Google-Smtp-Source: APXvYqx1x/Tz/FUDx/M9AxxYXUeTLJfMODc9IEhi9qKX3aktbgipAbXpxU7Xvq52b4unAEfHtySmQg==
X-Received: by 2002:a37:4c81:: with SMTP id z123mr13545532qka.320.1583100089154;
        Sun, 01 Mar 2020 14:01:29 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id o10sm8990219qtp.38.2020.03.01.14.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 14:01:28 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sun, 1 Mar 2020 17:01:27 -0500
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH v3 0/6] efi/x86: add support for generic EFI mixed mode
 boot
Message-ID: <20200301220126.GA2204298@rani.riverdale.lan>
References: <20200222155519.23550-1-ardb@kernel.org>
 <20200301171509.GA1845222@rani.riverdale.lan>
 <20200301172248.GA1851857@rani.riverdale.lan>
 <CAKv+Gu_N3vbea79CAQNZn6DmKBsKOhT9ucQYgBf0_8Pnd+vz2g@mail.gmail.com>
 <20200301200035.GA2031375@rani.riverdale.lan>
 <CAKv+Gu_megM4a26r8AxeVEBrDLcY202K6nEcVxQ5bAeCcDBekw@mail.gmail.com>
 <CAKv+Gu9=p8q3adeRVCbsxfoV17-SbKkeOe8Lx0OQYZAsmja+oQ@mail.gmail.com>
 <CAKv+Gu87vexrXoofKdoFNEcr_Zw1dwe6pXz3DHhJ4NGZG=8SiA@mail.gmail.com>
 <20200301205419.GA2116204@rani.riverdale.lan>
 <CAKv+Gu-sqC4_1ry_D1WCqraFR3bnaMegkJv9SHzXuUY7FLYs2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-sqC4_1ry_D1WCqraFR3bnaMegkJv9SHzXuUY7FLYs2g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Mar 01, 2020 at 10:36:05PM +0100, Ard Biesheuvel wrote:
> On Sun, 1 Mar 2020 at 21:54, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > I see this in the memory map
> > >
> > > [    0.000000] efi: mem47: [Conventional Memory|   |  |  |  |  |  |  |
> > >  |   |WB|WT|WC|UC] range=[0x0000000100000000-0x000000013fffffff]
> > > (1024MB)
> > >
> > > so it looks like qemu-system-x86_64 puts the memory in a weird place?
> > > Or is this expected?
> >
> > Mine ended here:
> > [    0.000000] efi: mem45: [Memory Mapped I/O  |RUN|  |  |  |  |  |  |  |   |  |  |  |UC] range=[0x00000000ffc00000-0x00000000ffffffff] (4MB)
> > are you running with -m 3072 or more?
> >
> 
> That is not memory, it's some mmio region
> 

Right, but it's the last (highest) range in my memory map. It was just
to illustrate that I have no addresses above 4Gb, unlike the mapping you
got, although I now see that the MMIO range is the last one printed
regardless of where RAM ends, so that wasn't quite enough. I only get
the 4g-5g mapping range if I run it with -m 4096.

This is the tail end of the mapping I got.

[    0.000000] efi: mem38: [Conventional Memory|   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bfe00000-0x00000000bfe89fff] (0MB)
[    0.000000] efi: mem39: [Boot Data          |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bfe8a000-0x00000000bfea9fff] (0MB)
[    0.000000] efi: mem40: [Boot Code          |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bfeaa000-0x00000000bfeccfff] (0MB)
[    0.000000] efi: mem41: [Boot Data          |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bfecd000-0x00000000bfed5fff] (0MB)
[    0.000000] efi: mem42: [Boot Code          |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bfed6000-0x00000000bfef3fff] (0MB)
[    0.000000] efi: mem43: [Runtime Data       |RUN|  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bfef4000-0x00000000bff77fff] (0MB)
[    0.000000] efi: mem44: [ACPI Memory NVS    |   |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000bff78000-0x00000000bfffffff] (0MB)
[    0.000000] efi: mem45: [Memory Mapped I/O  |RUN|  |  |  |  |  |  |  |   |  |  |  |UC] range=[0x00000000ffc00000-0x00000000ffffffff] (4MB)
