Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A481DB9BF
	for <lists+linux-efi@lfdr.de>; Wed, 20 May 2020 18:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgETQiM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 May 2020 12:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgETQiM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 20 May 2020 12:38:12 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B547C061A0E
        for <linux-efi@vger.kernel.org>; Wed, 20 May 2020 09:38:12 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id t25so3088881qtc.0
        for <linux-efi@vger.kernel.org>; Wed, 20 May 2020 09:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8wiSAtyJ1h4rWYIgje7ynbZVU2W5eszihr72/87HC6c=;
        b=L6d4pbSstsWbZF9XQu7WfgtmmEA26+pofDdeawh0oVBC0SXJVueMM9bD2EqfGHAuRc
         eYAyAFxEz4EqVVKhEF71acZ5bbHdpN6KVn5nIwTHkf/sdvPXLubUlKSFY74PvpXsj25J
         lfGIBH9S/BGaZvUcLF/rvI44c2MgJDRh6ZuE/lsXLuzOSEJinn7TXxBgLAM3vhXM6wD5
         SOwkMWstsgTCmdSn8yVnH+3poAmcgckvNqVaI8MWCRX0udu1axlWDdxHMA5mAsgKriUb
         qiiQJUcrYFWsV9oiSbXrBFGjwityVOwrF3Snxi3tlPKKl2Uvf0PIGvnpZ9FJNIJNNVOq
         Zu2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=8wiSAtyJ1h4rWYIgje7ynbZVU2W5eszihr72/87HC6c=;
        b=uLjCkR8xGNkyN0poOtinSJB7A1Pr0l4lbCnxkVX6DOHuspVkG6M4TiTu6XWf2oOoKQ
         3zBoDoulrg7dwmXLG5Sh5id+SR8GW1i8wx8dNa20Be8LVxgvRmFBLlWoRR4xsccSIUhC
         AaGfII+XSTbqfyq5UPIm0JSzt0bpeX+ig5qo0VTS8fzYzlksv7yJ1zYQDJsA5WOvaxMg
         uSl37Th9+tZ4dp+U5dPZ3k7IrrEGXXCqGMK7NfLKEmi/fRanlVXTHbDNULLO3MHnBTWz
         U4Fgp8gV/GAiOQXDSRtd+Sa9zAMybCQyEGi4gaopVpPiy9S7sA24eWz5CMy4opHIY939
         3RlQ==
X-Gm-Message-State: AOAM531ac/tuuKA4TISIP4ajFrbLIQemNmV3Js2aX05y814lLaUTJ7Bn
        1dAqPIlFZx83Wsn1PtQc7f0=
X-Google-Smtp-Source: ABdhPJxOIenscr8Tl7x+aT4AfqL2kUkQm8qHoFfzBdmPvUhy0hdyQ6CNI5LteobzsNfOKpZ1HRrIPg==
X-Received: by 2002:ac8:1416:: with SMTP id k22mr6115444qtj.205.1589992691244;
        Wed, 20 May 2020 09:38:11 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id s33sm2820785qtc.95.2020.05.20.09.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 09:38:10 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 20 May 2020 12:38:08 -0400
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH 17/24] efi/libstub: Implement printk-style logging
Message-ID: <20200520163808.GA3274869@rani.riverdale.lan>
References: <20200518190716.751506-1-nivedita@alum.mit.edu>
 <20200518190716.751506-18-nivedita@alum.mit.edu>
 <CAMj1kXE=YowWg2CbqXVhPcXoq3eZdowzTnGxLkpD5xcf29fHhw@mail.gmail.com>
 <20200519150755.GC1526900@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200519150755.GC1526900@rani.riverdale.lan>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, May 19, 2020 at 11:07:55AM -0400, Arvind Sankar wrote:
> On Tue, May 19, 2020 at 10:22:40AM +0200, Ard Biesheuvel wrote:
> > On Mon, 18 May 2020 at 21:07, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > @@ -100,7 +123,9 @@ efi_status_t efi_parse_options(char const *cmdline)
> > >                 if (!strcmp(param, "nokaslr")) {
> > >                         efi_nokaslr = true;
> > >                 } else if (!strcmp(param, "quiet")) {
> > > -                       efi_quiet = true;
> > > +                       efi_loglevel = CONSOLE_LOGLEVEL_QUIET;
> > > +               } else if (!strcmp(param, "debug")) {
> > > +                       efi_loglevel = CONSOLE_LOGLEVEL_DEBUG;
> > 
> > Should we wire this to 'efi=debug' instead?
> > 
> 
> Sure.

Do you prefer it wired up to both or just efi=debug?

THanks.
