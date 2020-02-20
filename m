Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D840166A28
	for <lists+linux-efi@lfdr.de>; Thu, 20 Feb 2020 23:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgBTWEh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Feb 2020 17:04:37 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35079 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbgBTWEh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 20 Feb 2020 17:04:37 -0500
Received: by mail-qt1-f194.google.com with SMTP id n17so4092120qtv.2
        for <linux-efi@vger.kernel.org>; Thu, 20 Feb 2020 14:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iNXHjDtp/CwqbW3AkEsSQuzRoFJpJEzhwVeVfVIu6BA=;
        b=VUguNFCzG/ojcw/xho1zMJKqB5uJTOwG6pbpisVHbtA+PK1VQoGFvZucQZiPlQhPEB
         IsUhVu78apOXoj3cYG2GraFvyB7a/J5onzrLhinkroMLM0Ic+S2QB3hm6isHw1P8EaZX
         GOHs6H3ohLKBHSdeKcObSpHukUMAxyRa0L3NXSdwvkzsJ/qdnWGn0C33DupmnpS7IfZC
         rOzA9ur0UXBs4Hkw2j8xopOo7HiKDY8eUKv1SsehyM/8F2irFExAWegBb+PmeMBWSV1U
         ISrOzymkN9IZpnzIYGT19G9HHkjUKN1YHzWvTF5pNj6o0TxKXh2l9FwXgN7hJvcW0a98
         ZiZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=iNXHjDtp/CwqbW3AkEsSQuzRoFJpJEzhwVeVfVIu6BA=;
        b=FVnCsVoBECCBHMw4xB1YSFdyqz+DwTWexF2dK4pxkBxSMCPTahrujtI5OheyLHeImI
         bYiA6qrcnJaGPTX8KmlcNvP/1nF0bTL9tUJ7RrIZn/TJltITVRH/7Ilu3WkufVixFV0j
         eY7vtGTTVGpkyqtxB/UhWU5tKuWL0offiTFV3kbsnAuXYzjhWZdtO9mG1HibNZOYzuBL
         4C3fjmTEGwux9Mn4QtY20rqoOOhkOLamrAHffy3rbujk378uK0WnIxJRouoo+vB/Q01L
         fs3X+CQZw0KkR00gegmu7h5+YP+YEIZtC8sQ7pgoa972yMdfEbCvBeN1S4dNsBaOtxao
         xsFQ==
X-Gm-Message-State: APjAAAXL/lfFQHa6CjGwufClUWdLnwF7v06Tg8PJJ3c/nMwac9FJWRfA
        v7VOaq94hhKcu9tVtRkAdPc=
X-Google-Smtp-Source: APXvYqxhUmiSGii636ADoWE+MXQavoL1v1CPdEY2qpD+Z9NbZImIOt5Kgz+Q+1//lBcsKI1Z3UWiWQ==
X-Received: by 2002:ac8:75cd:: with SMTP id z13mr9364851qtq.118.1582236276301;
        Thu, 20 Feb 2020 14:04:36 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id r1sm446640qtu.83.2020.02.20.14.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 14:04:35 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 20 Feb 2020 17:04:34 -0500
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>,
        Laszlo Ersek <lersek@redhat.com>,
        Leif Lindholm <leif@nuviainc.com>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Alexander Graf <agraf@csgraf.de>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [RFC PATCH 1/3] efi/x86: Use symbolic constants in PE header
 instead of bare numbers
Message-ID: <20200220220433.GA2550609@rani.riverdale.lan>
References: <20200220110649.1303-1-ardb@kernel.org>
 <20200220110649.1303-2-ardb@kernel.org>
 <20200220172831.GA2417225@rani.riverdale.lan>
 <CAKv+Gu_QiXsJyR0X4au+r75DFoQmSUp38+J7BuD3HAH+rJ9gHQ@mail.gmail.com>
 <20200220195157.GA2483987@rani.riverdale.lan>
 <CAKv+Gu8WkE419HofC3T_EVYDbJyV8k69agz2Jqx-CGaNtgkvZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8WkE419HofC3T_EVYDbJyV8k69agz2Jqx-CGaNtgkvZw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Feb 20, 2020 at 10:22:23PM +0100, Ard Biesheuvel wrote:
> On Thu, 20 Feb 2020 at 20:52, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Thu, Feb 20, 2020 at 06:32:39PM +0100, Ard Biesheuvel wrote:
> > > On Thu, 20 Feb 2020 at 18:28, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > >
> > > > The .text section contains data as well. Shouldn't it be marked
> > > > IMAGE_SCN_MEM_WRITE also?
> > > >
> > >
> > > Another good point. For ARM and arm64, I actually changed this into
> > > split R-X and RW- sections, in case the loader decides to honour these
> > > attributes (which it should imo)
> > >
> > > So yes, we should either add IMAGE_SCN_MEM_WRITE, or add a .data
> > > section (although we probably don't have the space for that).
> > >
> > > Another thing I wondered was whether we really need the .reloc
> > > section. We don't have one on ARM, and it works fine with the existing
> > > EDK2 loader.
> > > Peter: any idea whether the issue with .reloc you pointed out to me
> > > the other day still exists in EDK2 today?
> >
> > Is there any reason we couldn't combine .setup + .text as R-X, then
> > .reloc, then .data + .bss as RW-? That would leave room for the new
> > .compat section then even without removing .reloc.
> >
> > Although if the loader actually honored the non-writable setting,
> > efi_relocate_kernel has to be done unconditionally. It currently happens
> > to be unconditional if you come in via PE loader, since we don't set
> > ImageBase to tell it our preferred address, and even if we did, the
> > existence of .setup means startup32 isn't at that address.
> 
> Shouldn't matter, given that we don't use the same page tables to run
> the startup code.

Ooh right. And for the 32-bit case we turn off paging altogether.
