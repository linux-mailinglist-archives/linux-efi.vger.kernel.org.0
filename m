Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3DF7176079
	for <lists+linux-efi@lfdr.de>; Mon,  2 Mar 2020 17:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgCBQyV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 Mar 2020 11:54:21 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38790 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbgCBQyV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 2 Mar 2020 11:54:21 -0500
Received: by mail-qt1-f193.google.com with SMTP id e20so453728qto.5;
        Mon, 02 Mar 2020 08:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5Er//MGifVyaYeTMJqwNXPSSyalhUWucIS7ZB5vkA+Y=;
        b=iUqLGPeNxhFiovwOSVPRTmLnahvGI3uCtaZVQPaB9dZTy3CNorMPrDeeyasbSTAdn3
         d6NLuvRDEsHcLpLWRVBx6C46BqJtJQ8nQ6ies53CMIYz3AUbHaocETRKg9S17geaM9Wi
         ROzHDug+gJGhVycaS0WmGR3YQEHTz+xUL07C7Taw5DRftc2DtiVqGlO/qkP6jXtRryXg
         PuIWHSjbqHQEp4EWztDF3joTqEazGHHocGyKRxmaMjSxHqRyEQd6u/IqGehvdwQDhpt6
         y6Qf1JYujjmk7Pe1zI4/vOY1+IdgEecY//XTVJNu5UC/tvTqvkK262pFMX2YmTXNOMq+
         kZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5Er//MGifVyaYeTMJqwNXPSSyalhUWucIS7ZB5vkA+Y=;
        b=F5IPWbUBXD1tfVPbTfqrezNrBAQ8gVIB79zZQ6F1alNGNFPNiIy0/DdgrqhdVuzXEj
         IY+z2PnA4Ysbsn+k31dqfvS/4jUEm/kKiTnt3K28oMvzZ40oFOFG6/+Ybu1tFncSjPbu
         rnRh/l2QPF+7HsWtbyFXKBUwpCKxEHX4d975CYRL2LF2bNxwbo7nGsQ7c92eG0Zw0viz
         qs/w67rmEqhdiDeRNdWvOtvfk6ZVwNHxh5x0l5qEtvKqO/JdZuWPPB6qbPaGoNklm1Py
         nhUQY5yUSDjWYt1CQGHpkz7YBs52YfjKq+NiNJQWIZuIyPh60iPkrRawE2eAdZTEMOh6
         01oQ==
X-Gm-Message-State: ANhLgQ2OCsMKRV1UFMM1gOmggQ4iYiJo4NvRQnMj+RCcrnnL9xaCgaHd
        sDntoeHAW60WLpk5PrMwUps=
X-Google-Smtp-Source: ADFU+vvHA1ynAXRGcX+6ZpxeHP5uAZ4A9yzsOaq8OGAG42LZ/ltBJ8i2vFhWosTzewEZkmXOaUl5OQ==
X-Received: by 2002:ac8:6b99:: with SMTP id z25mr612217qts.256.1583168059478;
        Mon, 02 Mar 2020 08:54:19 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id h13sm10582440qtu.23.2020.03.02.08.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 08:54:19 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 2 Mar 2020 11:54:17 -0500
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] efi/x86: Make efi32_pe_entry more readable
Message-ID: <20200302165359.GA2599505@rani.riverdale.lan>
References: <20200301230436.2246909-1-nivedita@alum.mit.edu>
 <20200301230436.2246909-4-nivedita@alum.mit.edu>
 <CAKv+Gu9RRDidiJ8WAnSta1kZoioFU_ZLxwGPQuhepd9N23HUJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9RRDidiJ8WAnSta1kZoioFU_ZLxwGPQuhepd9N23HUJw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Mar 02, 2020 at 08:49:17AM +0100, Ard Biesheuvel wrote:
> On Mon, 2 Mar 2020 at 00:04, Arvind Sankar <nivedita@alum.mit.edu> wrote:
...
> >         call    1f
> > -1:     pop     %ebp
> > -       subl    $1b, %ebp
> > +1:     pop     %ebx
> > +       subl    $1b, %ebx
...
> >
> > +       movl    %ebx, %ebp                      // startup_32 for efi32_pe_stub_entry
> 
> The code that follows efi32_pe_stub_entry still expects the runtime
> displacement in %ebp, so we'll need to pass that in another way here.
> 
> >         jmp     efi32_pe_stub_entry

Didn't follow -- what do you mean by runtime displacement?

efi32_pe_stub_entry expects the runtime address of startup_32 to be in
%ebp, but with the changes for keeping the frame pointer in %ebp, I
changed the runtime address to be in %ebx instead. Hence I added that
movl %ebx, %ebp to put it in %ebp just before calling efi32_pe_stub_entry.
That should be fine, no?
