Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE4E112ED9
	for <lists+linux-efi@lfdr.de>; Wed,  4 Dec 2019 16:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbfLDPoT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Dec 2019 10:44:19 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42319 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbfLDPoT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Dec 2019 10:44:19 -0500
Received: by mail-qk1-f196.google.com with SMTP id a10so277269qko.9
        for <linux-efi@vger.kernel.org>; Wed, 04 Dec 2019 07:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tmv+101QGI81uq00/PhK82i2O276yU+hZfyzfvaMyuA=;
        b=O7NTH19Xlpt2Q3b0USktSj1fKFdjYEwLiHVhjJj+5hOqdEMCjBGkS+TSwjXKHlrSkd
         D7XsTvreFKl7FrmSKBosSb0Gs2dDa5Lk5ObrHIoMt1vIN1dQ7JUUaQL4W5c17TlYglbU
         xicMV795Kq0gM3dckrQQcW9nUOjtoUJcS2WoMNb00GJqlXxtmk9SdWhKQr5LTSC/6W/s
         mvoucN2FG5i2GNCD0sU8PZK30L2+MLhfzqS5w/zXKvmETzhtNPxigIxKugLbfYStvJlj
         ARYRcKwpI0wObYIQjD7hdaH40F936zGhEIgCywEAP88cwqAH0b+MLWwEodnOpCbI7cWH
         XGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tmv+101QGI81uq00/PhK82i2O276yU+hZfyzfvaMyuA=;
        b=Tl0MDl94nWz8E+cKlKXRG4n5JbCZshZbxGqdN0hbx17KothUK/n3ghW0jwdjtShva5
         d+6otvnfWVFvzAQrs88GytcWAgztj2MFSLsWbISHbLW017ymXW8GuFPYijj9Y4S7s5HI
         BLjx10KNNfoK5NobVMQxqSwH/4CPwbyAAHtWUDWP/0Wg8xCnfMcqE5Kf5VZoh8zDHLjd
         80tJNobQY/sv34xqkOzKXA8r75Ulnq4a8rhFosiR30qKbmLVLuy4+0Syb/6FthGbS4PX
         VBk0+sEnkDhuYZR8BGRAwpaPVLqWvUbFbnr3ZBeig93yIzbnnpo2SdSBXKe5o7ihK8Ow
         pfOQ==
X-Gm-Message-State: APjAAAW0Yu5Tkhs87XeUEMc2vDDExBK1vy05EjCtchOv6S7kIyUCJeU5
        h0GlW1/6Cen+HSp/F7gBo+o=
X-Google-Smtp-Source: APXvYqyX6Vkyz14Zeww7A0KQDOd76FU1v5aOTkjwhQYYEgDKHbrFcnCPxVfm7llxRIvNMawrU9Otrg==
X-Received: by 2002:a05:620a:119c:: with SMTP id b28mr3544527qkk.382.1575474258215;
        Wed, 04 Dec 2019 07:44:18 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id s34sm4074430qtb.73.2019.12.04.07.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 07:44:17 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 4 Dec 2019 10:44:16 -0500
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH 2/2] efi/gop: Fix memory leak in __gop_query32/64
Message-ID: <20191204154415.GC626282@rani.riverdale.lan>
References: <20191203214728.19264-1-nivedita@alum.mit.edu>
 <20191203214728.19264-2-nivedita@alum.mit.edu>
 <CAKv+Gu9tckvD=H4nCbHeNNxEwnK3tHMT59zELf=pYokLS4Nb6g@mail.gmail.com>
 <20191204152744.GB626282@rani.riverdale.lan>
 <CAKv+Gu9ZCvoLn+yoWFq=Q1n2hBz+=BLwSQbgAnjfgSq6hDM6bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9ZCvoLn+yoWFq=Q1n2hBz+=BLwSQbgAnjfgSq6hDM6bg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Dec 04, 2019 at 03:30:22PM +0000, Ard Biesheuvel wrote:
> On Wed, 4 Dec 2019 at 15:27, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Wed, Dec 04, 2019 at 03:11:09PM +0000, Ard Biesheuvel wrote:
> > > On Tue, 3 Dec 2019 at 21:47, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > >
> > > > gop->query_mode returns info in callee-allocated memory which must be
> > > > freed by the caller.
> > > >
> > > > We don't actually need to call it in order to obtain the info for the
> > > > current graphics mode, which is already there in gop->mode->info, so
> > > > just access it directly.
> > > >
> > > > Also nothing uses the size of the info structure, so remove the
> > > > argument.
> > > >
> > > > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > >
> > > Thanks Arvind
> > >
> > > I agree with this patch in principle, but I'd prefer it if we could
> > > get rid of the __gop_queryXX routines altogether, or if we need a
> > > helper, to at least merge them into on, taking gopXX->mode as an input
> > > argument.
> > >
> >
> > I can do that. I'm also planning a few patches later to merge the 32-bit
> > and 64-bit versions together if there are no objections, but that needs
> > a little more work. Right now the query code can't be merged together
> > because mode's layout is different between 32-bit and 64-bit versions,
> > but it can certainly be folded into the main setup routines.
> >
> 
> Fair enough.
> 
> Are you building/testing this on x86 hardware only? That's perfectly
> fine, but it would be good to know.
> 

Yes, I only have 64-bit x86 hardware.
