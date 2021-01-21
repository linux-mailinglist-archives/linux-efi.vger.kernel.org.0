Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31EC2FE8F9
	for <lists+linux-efi@lfdr.de>; Thu, 21 Jan 2021 12:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730455AbhAULiY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 21 Jan 2021 06:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729990AbhAULYi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 21 Jan 2021 06:24:38 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D465AC0613C1;
        Thu, 21 Jan 2021 03:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZijhVnCQeRnghlQrj7CxHb8Htl9AaW+rCSGzY/jBZ0E=; b=s9hmxv1NEP9U0dUBEnGwOvs8Wl
        /Y2hWOQFfJoesU7BlKDP66exkGsx44M5X/6Y3EMoy1quUWTRkC6q7J/aI7Oa5ywUCxsiz+heeXVR/
        5GSNm9KWpESYtCI6YK4vtU8/PyPmnMKhslkt+FT6FvgqBzq8dQM5DTXuvRIS7uePTus+d3974o0+W
        7GT2k8xQX8N6CtVrDmmmDfjgrz7Tr5EFSY2Xwf3kEmgRs8XgjFd4c3nhWXeUJTw2y2Ttcq/uDjcu4
        zYvr0IS2tT0xSpPtunw/XzvjTDqWmN5JSAgB2VsS44fCD3gDmPPy9NUBgFSE+M02Za4bcLtdaglAz
        gmewhy+g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l2Y3v-0007FA-Gl; Thu, 21 Jan 2021 11:23:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 83488304D28;
        Thu, 21 Jan 2021 12:23:36 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6932320C86810; Thu, 21 Jan 2021 12:23:36 +0100 (CET)
Date:   Thu, 21 Jan 2021 12:23:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Julien Thierry <jthierry@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [RFC PATCH 00/17] objtool: add base support for arm64
Message-ID: <YAlkOFwkb6/hFm1Q@hirez.programming.kicks-ass.net>
References: <20210120173800.1660730-1-jthierry@redhat.com>
 <CAMj1kXHO0wgcZ4ZDxj1vS9s7Szfpz8Nz=SAW_=Dnnjy+S9AtyQ@mail.gmail.com>
 <186bb660-6e70-6bbf-4e96-1894799c79ce@redhat.com>
 <CAMj1kXHznGnN2UEai1c2UgyKuTFCS5SZ+qGR6VJwyCuccViw_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHznGnN2UEai1c2UgyKuTFCS5SZ+qGR6VJwyCuccViw_A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jan 21, 2021 at 12:08:23PM +0100, Ard Biesheuvel wrote:
> On Thu, 21 Jan 2021 at 11:26, Julien Thierry <jthierry@redhat.com> wrote:

> > I'm not familiar with toolcahin code models, but would this approach be
> > able to validate assembly code (either inline or in assembly files?)
> >
> 
> No, it would not. But those files are part of the code base, and can
> be reviewed and audited.

x86 has a long history if failing at exactly that.
