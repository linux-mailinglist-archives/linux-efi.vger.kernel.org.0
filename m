Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA97132E81
	for <lists+linux-efi@lfdr.de>; Tue,  7 Jan 2020 19:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgAGSc1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Jan 2020 13:32:27 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46050 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727925AbgAGSc1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Jan 2020 13:32:27 -0500
Received: by mail-qk1-f195.google.com with SMTP id x1so236510qkl.12
        for <linux-efi@vger.kernel.org>; Tue, 07 Jan 2020 10:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XlBBChjpaAjcs1OzK6BeH3YHT6wuYosL5A1VMqAvPRY=;
        b=LDv/RUuUD28LCuclAizlBoXX/juq6+uCE2uTp4PmnlB3EVfj1hM2B6VJu5xZXSl6pt
         9P65RWQ/KT9GJe0fNxaHLq0UEslX3DZ5CyqRVd9YqD97fB1lH+JkKAFnH37esAdqgm72
         43Q/Gq1oP//yl9v98KzQr8hbgzPZanHk1aNNiqVE7mY/xtXvIIsVfDWVpzOebwERvBH7
         g0qVp1qOto+yB68yt3UrTY71sOHeCZtnBj81/+QzFYkjhGzna97D8/8y+U/v5uLc0SZ/
         Pl62Fk6WtsMkRIhBFvPie6SnT/8duJceNtztp1wneW8i+92a0g0FSXoOBf7tEJdnro7p
         kZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=XlBBChjpaAjcs1OzK6BeH3YHT6wuYosL5A1VMqAvPRY=;
        b=gi44LzVqE3LdezRw79Rn0PwSEDesQEp/cXi4lNh2o9t+w/vrDJm4KxBlSdAJMpX9yq
         WNxsLE7orbUucJrxIQKdJAFebH7fS22ne1bBBDE7qFwntETUGOpwDlOOgfx4ZQ8KtMLe
         9+Me9nw5eaHeK2gacfBSd19S4lvYwiVbIRJd36ogLwVePp8uOM6PqgyzCi7ox/4cpCJC
         IQSYTQzN+ZZwZZXdfI8EpLDZK/8HdcVfB2IxxaA07pQw5Ne6SWi05e1ApqXtjlmtDgaf
         aZ2tQpfN2eFZYoBu/nGKeEBIQUoQn8+Kg/2ED5QOz5k9u2pcg68W+Jg4kgvGZw5t+JAB
         nwUw==
X-Gm-Message-State: APjAAAULu8aFmnm66Mn+0o9zH83ze0oN3DAMBShUYhaYsB5oXUMEL97f
        zv3Jnjqna940risu/lojudQ=
X-Google-Smtp-Source: APXvYqweQuHubaneArBnTu8dH+db6buKgNDBupv5HPLUOPmeIHAD+v8QlPb5fDLaWuE3Y2u2/UpPhg==
X-Received: by 2002:ae9:ed53:: with SMTP id c80mr606958qkg.445.1578421946698;
        Tue, 07 Jan 2020 10:32:26 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id o9sm211723qko.16.2020.01.07.10.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 10:32:26 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 7 Jan 2020 13:32:24 -0500
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH 0/3] Relocate GOT before calling EFI stub
Message-ID: <20200107183224.GB1642410@rani.riverdale.lan>
References: <CAKv+Gu8HE-QJBpo=S_uUbqkO8BfbKyrp2+nCTxWhPVNMU1E37g@mail.gmail.com>
 <CAKv+Gu_+a4igmTHhMgg17B2oH5f=KRM2g2CBGy+LnF5wYsarng@mail.gmail.com>
 <20200107142125.GA652888@rani.riverdale.lan>
 <CAKv+Gu-xDaTBVKJ=9ya74giBZ=LdX2r-8-LiFJWzcUofthGv7w@mail.gmail.com>
 <20200107142732.GB652888@rani.riverdale.lan>
 <CAKv+Gu8v-5DXWh5ZaY0omrVNh46TEourpcf2Hv3TrsbCUtLFng@mail.gmail.com>
 <20200107175829.GA1599060@rani.riverdale.lan>
 <CAKv+Gu-PU=LqT7MEbSH-0GnJOdakDeaC=ANdmag6JptcfJEJtA@mail.gmail.com>
 <20200107180807.GA1642410@rani.riverdale.lan>
 <CAKv+Gu8Jsen-oAvUYrrTXnLRog+iHsLf0s6EMJ9smgUXpzncZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8Jsen-oAvUYrrTXnLRog+iHsLf0s6EMJ9smgUXpzncZw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jan 07, 2020 at 07:10:34PM +0100, Ard Biesheuvel wrote:
> On Tue, 7 Jan 2020 at 19:08, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Tue, Jan 07, 2020 at 06:59:57PM +0100, Ard Biesheuvel wrote:
> > > On Tue, 7 Jan 2020 at 18:58, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > >
> > > > On Tue, Jan 07, 2020 at 03:28:31PM +0100, Ard Biesheuvel wrote:
> > > > >
> > > > > Unfortunately, the command line option implements a weaker form of
> > > > > visibility than the pragma, so it probably comes down to setting the
> > > > > pragma in a .h file that gets -include'd via the command line so it is
> > > > > guaranteed to be seen first.
> > > >
> > > > Tried hacking that in and it works, tested with gcc 4.6.4.
> > >
> > > Excellent. But in my testing locally, I don't get any GOT entries in
> > > the first place, strangely enough. So what changes in the output for
> > > you with visibility hidden compared to before?
> >
> > Works with 32-bit as well.
> >
> > Are you checking libstub or boot/compressed? Below is with gcc 4.6 (but
> > latest binutils). With gcc 9, there's only one left -- trampoline_32bit_src
> > in pgtable_64.
> >
> 
> I am looking at the size of the .got section in
> boot/compressed/vmlinux, and it is 0x0 on 64-bit, and 0xc (i.e., only
> the .got.plt fixup code) on 32-bit.
> 
> Could you please check whether passing -Bsymbolic to the linker gives
> the same result btw?
> 

With new ld all those GOTPCRELX's get eliminated. If you add --no-relax
you'll get them in the .got. I don't have an old version of binutils so
I can't check, but I think they will be assembled as GOTPCREL and remain
in the .got section after linking.

A linker option can't help I'd think, because once these relocations are
there in the object files, you need the new binutils to get rid of them.
I didn't get any difference with -Bsymbolic -- also that seems to be for
shared libraries, with executables the references should already be
bound within the executable, shared libraries can't override them.
